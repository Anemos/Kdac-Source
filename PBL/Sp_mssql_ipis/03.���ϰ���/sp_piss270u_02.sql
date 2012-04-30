/*
	File Name	: sp_piss270u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss270u_02
	Description	: 출고전표취소
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss270u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss270u_02]
GO

/*
exec sp_piss270u_02 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'A',          -- 공장코드
                    @ps_truckno      = '1234',       -- 차량번호
	            @ps_shipdate     = '2002.10.15'  -- 출하일
*/
CREATE PROCEDURE sp_piss270u_02
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_truckno	 VARchar(12),        -- 차량번호
	@ps_shipdate	 Char(10)         -- 출하일
AS

BEGIN

Select	distinct divisioncode   = A.divisioncode,
        ShipSheetNo    = A.ShipSheetNo,
	CustCode       = A.CustCode,
      	CustName       = B.custname,
        truckorder     = a.truckorder,
        cancelflag     = 0
   From	tshipsheet A,
        tmstcustomer B
  Where	A.CustCode     *= B.CustCode
    and	A.shipdate     = @ps_shipdate
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode
    and A.truckno      = @ps_truckno
    and A.confirmflag  = 'N'
    and A.confirmdate  is not null
end 


GO
