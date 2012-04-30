/*
	File Name	: sp_piss400u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss400u_01
	Description	: 영업현장확인
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss400u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss400u_01]
GO
/*
exec sp_piss400u_01 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'A',          -- 공장코드
                    @ps_truckno      = '1234'        -- 차량번호
*/
CREATE PROCEDURE sp_piss400u_01
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_truckno	 varchar(15)        -- 차량번호

AS

BEGIN

Select	distinct divisioncode   = A.divisioncode,
        truckorder     = a.truckorder,
        ShipSheetNo    = A.ShipSheetNo,
	CustCode       = A.CustCode,
      	CustName       = B.custname,
        shipdate       = a.shipdate
   From	tshipsheet A,
        tmstcustomer B
  Where	A.CustCode     *= B.CustCode
--    and	A.shipdate     = @ps_shipdate
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode
    and A.truckno      like @ps_truckno
    and A.confirmflag  = 'Y'
    and A.saleconfirmflag = 'N'
    and substring(a.shipsheetno,3,1) not in ('M','O','P','Q','R','S','T','U','V','W')
end 


GO
