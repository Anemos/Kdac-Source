/*
	File Name	: sp_piss270u_03.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss270u_03
	Description	: 출고전표취소
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss270u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss270u_03]
GO
/*
exec sp_piss270u_03 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'S',          -- 공장코드
                    @ps_truckno      = '123456789012',       -- 차량번호
	            @ps_shipdate     = '2002.11.08'  -- 출하일
*/
CREATE PROCEDURE sp_piss270u_03
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_truckno	 varchar(15),        -- 차량번호
	@ps_shipdate	 Char(10)         -- 출하일
AS

BEGIN

Select	 divisioncode   = E.divisioncode,
	 ShipQty	= E.ShipQty,
	 itemCode	= B.itemcode,
	 ItemName	= D.ItemName,
         kbno           = ''
   From	tsrorder B,
	tmstitem D,
        tshipsheet E
  Where	B.itemcode     = D.itemcode
    and	E.shipdate     = @ps_shipdate
    and E.areacode     = @ps_areacode
    and E.divisioncode = @ps_divisioncode
    and E.truckno      = @ps_truckno
    and e.srno         = b.srno
    and e.confirmflag  = 'N'
    and e.confirmdate  is not null
end 


GO
