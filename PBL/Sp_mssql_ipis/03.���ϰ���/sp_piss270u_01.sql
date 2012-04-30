/*
	File Name	: sp_piss270u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss300i_01
	Description	: 출고전표취소
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss270u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss270u_01]
GO


/*
exec sp_piss270u_01 @ps_areacode     = 'D',                  -- 지역구분
                    @ps_divisioncode = 'S',                  -- 공장코드
                    @ps_truckno      = '123456789012',       -- 차량번호
	            @ps_shipdate     = '2002.11.08',         -- 출하일
	            @ps_shipsheetno  = '11111'               -- 전표번호
*/
CREATE PROCEDURE sp_piss270u_01
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_truckno	 varchar(15),     -- 차량번호
	@ps_shipdate	 Char(10),        -- 출하일
	@ps_shipsheetno Char(10)         -- 전표번호
AS

BEGIN

Select	 divisioncode   = E.divisioncode,
         ShipSheetNo	= E.ShipSheetNo,
	 SRNO	        = E.SRNo,
	 ShipQty	= E.ShipQty,
	 CustCode	= B.CustCode,
      	 CustName	= C.custname,
	 Cancelflag	= 0,
	 itemCode	= B.itemcode,
	 ItemName	= D.ItemName,
	 SRGubun	= b.shipgubun,
	 Truckorder	= E.Truckorder,
         shipdate       = E.Shipdate,
         requiredate    = B.applyfrom,
         kitgubun       = b.kitgubun,
         pcgubun     = b.pcgubun
   From	tsrorder B,
	tmstcustomer C,
	tmstitem D,
        tshipsheet E
  Where	E.SRNo 	       = B.SRNo
    and B.CustCode     *= C.CustCode
    and	B.itemcode     *= D.itemcode
    and	E.shipdate     = @ps_shipdate
    and E.areacode     = @ps_areacode
    and E.divisioncode = @ps_divisioncode
    and E.truckno      = @ps_truckno
    and e.confirmflag  = 'N'
    and e.confirmdate  is not null
    and e.shipsheetno  = @ps_shipsheetno
end 

GO
