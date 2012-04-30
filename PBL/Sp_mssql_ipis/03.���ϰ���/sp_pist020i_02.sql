/*
	File Name	: sp_pist010i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pist010i_02
	Description	: LOT관리대장
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pist020i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pist020i_02]
GO

/*
exec sp_pist020i_02
        @ps_areacode    = 'D',
        @ps_divisioncode  = 'S',
        @ps_itemcode    = '511513',
	@ps_fromdate	= '2002.01.01',
	@ps_todate	= '2002.12.31'
*/


Create Procedure sp_pist020i_02
        @ps_areacode    char(01),       -- 지역
        @ps_divisioncode char(01),      -- 공장
        @ps_itemcode    varchar(12),    -- 품번
        @ps_fromdate    Char(10),        -- From date
        @ps_todate     Char(10)         -- end date
As
Begin
  select a.divisioncode,a.lotno,a.gubun,a.stockdate,a.stockqty
   from
  (select divisioncode = a.divisioncode,
          gubun = 1,
         stockdate = a.tracedate,
         lotno     = a.lotno,
         stockqty  = sum(a.stockqty)
    from tlotno a
   where a.tracedate >= @ps_fromdate
     and a.tracedate <= @ps_todate
     and a.areacode  = @ps_areacode
     and a.divisioncode like @ps_divisioncode
     and a.stockqty > 0
     and itemcode = @ps_itemcode
     and lotno is not null
     and rtrim(lotno) <> ''
    group by a.divisioncode,a.tracedate,a.lotno
union all
  select divisioncode = a.divisioncode,
         gubun = 2,
         stockdate = a.tracedate,
         lotno     = a.lotno,
         stockqty  = sum(a.shipqty)
    from tlotno a
   where a.tracedate >= @ps_fromdate
     and a.tracedate <= @ps_todate
     and a.areacode  = @ps_areacode
     and a.divisioncode like @ps_divisioncode
     and a.shipqty <> 0
     and itemcode = @ps_itemcode
     and lotno is not null
     and rtrim(lotno) <> ''
    group by a.tracedate,a.lotno,a.divisioncode) a
order by divisioncode,lotno,stockdate,gubun
End

GO
