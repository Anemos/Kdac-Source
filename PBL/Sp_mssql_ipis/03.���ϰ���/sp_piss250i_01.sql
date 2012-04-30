/*
	File Name	: sp_piss250i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss250i_01
	Description	: 통제부서확인현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss250i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss250i_01]
GO
/*
exec sp_piss250i_01  @ps_shipdate     = '2002.11.18', -- 출하일자
                     @ps_areacode     = 'D'          -- 지역구분

*/
CREATE PROCEDURE sp_piss250i_01
        @ps_shipdate     char(10),        -- 출하일자
        @ps_shipdate1    char(10),        -- 출하일자
	@ps_areacode     char(01),        -- 지역
        @ps_divisioncode char(01)         -- 공장
AS

BEGIN

Select	 distinct truckno        = A.truckno,
         shipsheetno	= A.ShipSheetNo,
	 custcode       = A.custcode,
	 custname	= C.custname,
         confirmflag    = a.confirmflag,
         divisioncode   = a.divisioncode,
         divisionname   = d.divisionname,
         confirmdate    = a.confirmdate,
         lastemp        = a.lastemp 
   From	tshipsheet_tong A,
	tmstcustomer C,
        tmstdivision D
  Where	A.CustCode     *= C.CustCode
    and A.areacode     = @ps_areacode
    and A.divisioncode like @ps_divisioncode
    and a.shipdate     >= @ps_shipdate
    and a.shipdate     <= @ps_shipdate1
    and a.divisioncode = D.divisioncode
    and a.areacode     = D.areacode
end 


GO
