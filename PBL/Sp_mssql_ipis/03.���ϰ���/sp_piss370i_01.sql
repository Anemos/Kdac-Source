/*
	File Name	: sp_piss370i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss370i_01
	Description	: 입고현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss370i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss370i_01]
GO
/*
exec sp_piss370i_01 @ps_areacode         = 'D',               -- 지역구분        
                    @ps_divisioncode	 = '%',               -- 공장코드  
                    @ps_fromdate         = '2001.01.01',      -- from입고일자
                    @ps_todate           = '2003.01.01'       -- to입고일자
                    @ps_workcenter       = '%',
                    @ps_linecode         = '%'
*/

Create Procedure sp_piss370i_01                 @ps_areacode         char(01),
                 @ps_divisioncode     char(01),
                 @ps_fromdate         char(10),
                 @ps_todate           char(10),
                 @ps_workcenter       varchar(05),
                 @ps_linecode         varchar(02)

As
Begin
SELECT   divisioncode = a.DivisionCode,   
         stockdate    = convert(char(20),a.kbStocktime,120),   
         kbno         = a.KBNo,   
         workcenter   = a.WorkCenter,   
         linecode     = a.LineCode,   
         itemcode     = a.ItemCode,   
         itemname     = case isnull(b.itemname,'')
                             when '' then (select itemname from tmstitem  where a.itemcode = itemcode)
                             else b.itemname
                        end,
         modelid      = b.modelid,
         tempgubun    = case a.TempGubun when 'N' then '정규'
                                         else case substring(a.kbno,3,1) when 'Z' then '현품표'
                                                   else '임시'
                                              end
                        end,
         stockqty     = a.StockQty  
    FROM TKBHIS a,vmstmodel b
   where a.areacode = @ps_areacode
     and a.divisioncode like @ps_divisioncode
     and a.stockdate >= @ps_fromdate
     and a.stockdate <= @ps_todate  
     and a.areacode *= b.areacode
     and a.divisioncode *= b.divisioncode
     and a.itemcode *= b.itemcode
     and a.kbstatuscode >= 'D'
     and a.workcenter  like @ps_workcenter
     and a.linecode    like @ps_linecode
order by a.workcenter,a.linecode,a.kbstocktime,a.itemcode
end


GO
