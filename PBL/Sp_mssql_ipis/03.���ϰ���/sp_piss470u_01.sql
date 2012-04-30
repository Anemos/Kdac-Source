/*
	File Name	: sp_piss470u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss470u_01
	Description	: 출고간판수정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss470u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss470u_01]
GO

/*
exec sp_piss470u_01 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'M',          -- 공장코드
	            @ps_shipdate     = '2003.01.20'  -- 출하일
*/
CREATE PROCEDURE sp_piss470u_01
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
	@ps_shipdate	 Char(10)         -- 출하일
AS

BEGIN

Select	 truckorder     = e.truckorder,
         truckno        = e.truckno,
         ShipSheetNo	= e.ShipSheetNo,
	 itemCode	= B.itemcode,
	 ItemName	= D.ItemName,
         customeritemno = b.customeritemno,
	 SRNO	        = B.SRNo,
         shipusage    = b.shipusage,
	 ShipQty	= e.ShipQty,
         checksrno      = b.checksrno,
	 CustCode	= B.CustCode,
      	 CustName	= C.custname,
	 Cancelqty	= e.ShipQty,
	 SRGubun	= b.shipgubun,
         shipdate       = e.Shipdate,
         requiredate    = B.shipdate,
         kitgubun       = b.kitgubun,
         psrno          = b.psrno,
         divisioncode   = b.divisioncode,
         deliveryflag   = isnull(e.deliveryflag,'N'),
         pcgubun      = b.pcgubun
   From	tsrorder B,
	tmstcustomer C,
	tmstitem D,
              tshipsheet e
  Where	e.SRNo 	       = B.SRNo
    and B.CustCode     *= C.CustCode
    and	B.itemcode    *= D.itemcode
    and	e.shipdate     = @ps_shipdate
    and e.areacode     = @ps_areacode
    and e.divisioncode = @ps_divisioncode
    and e.areacode     = b.areacode
    and e.divisioncode = b.divisioncode
order by e.truckorder,e.shipsheetno,b.psrno,b.pcgubun desc
end 

GO
