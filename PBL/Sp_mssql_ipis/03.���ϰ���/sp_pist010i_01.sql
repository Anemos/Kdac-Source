/*
	File Name	: sp_pist010i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pist010i_01
	Description	: 제품이력조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pist010i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pist010i_01]
GO
/*
Exec sp_pist010i_01 @ps_areacode = 'D',               --지역
                    @ps_divisioncode = '%',           --공장
                    @ps_workcenter = '%',             --조
                    @ps_linecode ='%',                 --라인코드
                    @ps_fromdate = '2000.01.01',      --생산일
	            @ps_todate	 = '2002.12.01'      --생산일
*/

CREATE PROCEDURE sp_pist010i_01
              @ps_areacode            char(01),       --지역
              @ps_divisioncode        char(01),       --공장
              @ps_workcenter          varchar(05),    --조
              @ps_linecode            char(01),       --라인코드
              @ps_fromdate            char(10),
              @ps_todate              char(10)        
AS

BEGIN
  SELECT divisioncode = a.divisioncode,
         lotno = A.LotNo,
         itemcode = a.itemcode,
         itemname = case isnull(b.itemname,'') when '' then (select itemcode from tmstitem where itemcode = a.itemcode)
                                               else b.itemname
                    end,
	 modelid = b.ModelID,
	 sortorder = B.SortOrder,
         kbno = A.KBNo,
         rackqty = A.rackQty,
	 StatusCode	= A.kbStatusCode,
	 KBStatuscode = Case When A.kbStatusCode = 'D' Then '창고재고'
			     When A.kbStatusCode = 'E' Then '출하'
			     When A.kbStatusCode = 'F' Then '회수'
			     Else Space(8)
			End
    FROM tkbhis A,   
         vmstmodel B
   WHERE (a.areacode = @ps_areacode)
     and (a.divisioncode like @ps_divisioncode)
     and (a.workcenter like @ps_workcenter)
     and (a.linecode   like @ps_linecode)
     and (a.areacode = b.areacode )
     and (a.divisioncode *= b.divisioncode)
     and (a.itemcode     *= b.itemcode)
     and (a.areacode     *= b.areacode)
     and (a.kbreleasedate >= @ps_fromdate)
     and (a.kbreleasedate <= @ps_todate)
     and (A.kbStockTime is Not Null)
     and (a.lotno is not null)
   
END 


GO
