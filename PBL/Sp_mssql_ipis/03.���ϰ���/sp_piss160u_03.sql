/*
	File Name	: sp_piss160u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss160i_02
	Description	: 출고간판취소
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss160u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss160u_03]
GO

/*
exec sp_piss160u_03 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'S',          -- 공장코드
                    @ps_shipsheetno  = 'DSA2110002',   -- 발행번호
	            @ps_shipdate     = '2002.11.08'  -- 출하일
*/
CREATE PROCEDURE sp_piss160u_03
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_shipsheetno	 Char(10),        -- 전표번호
	@ps_shipdate	 Char(10)         -- 출하일
AS

BEGIN

Select	 ShipSheetNo	= A.ShipSheetNo,
	 SRNO	        = A.SRNo,
	 ShipQty	= sum(A.ShipQty),
	 remainQty	= sum(A.ShipQty)
   From	tshipsheet A
  Where	A.shipsheetno  = @ps_shipsheetno
    and	A.shipdate     = @ps_shipdate
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode
group by a.shipsheetno,a.srno
end 


GO
