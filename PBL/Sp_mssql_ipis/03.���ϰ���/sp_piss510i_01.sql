/*
	File Name	: sp_piss510u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss400u_01
	Description	: 영업현장확인현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss510i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss510i_01]
GO
/*
exec sp_piss510i_01 @ps_areacode         = 'D',          -- 지역구분
                    @ps_divisioncode     = '%',          -- 공장코드
	            @ps_shipdate         = '2002.10.30', -- from출하일
	            @ps_shipdate1        = '2002.12.30', -- to출하일
                    @ps_saleconfirmflag  = '%'           -- 확인구분
*/
CREATE PROCEDURE sp_piss510i_01
	@ps_areacode        char(01),        -- 지역구분
        @ps_divisioncode    char(01),        -- 공장코드
	@ps_shipdate	    Char(10),        -- 출하일
	@ps_shipdate1       Char(10),        -- 출하일
        @ps_saleconfirmflag char(01)         -- 확인구분
AS

BEGIN

Select	distinct divisioncode = A.divisioncode,
        shipdate              = a.shipdate,
        sheetprintdate        = convert(char(10),a.sheetprintdate,102),
        confirmdate           = convert(char(10),a.confirmdate,102),
        truckno               = a.truckno,
        saleconfirmflag       = case a.saleconfirmflag when 'Y' then '확인완료'
                                     else '미확인' end,
        saleconfirmdate       = convert(char(10),a.saleconfirmdate,102),                
        ShipSheetNo    = A.ShipSheetNo
   From	tshipsheet A
  Where	A.shipdate        >= @ps_shipdate
    and A.shipdate        <= @ps_shipdate1
    and A.areacode        = @ps_areacode
    and A.divisioncode    like @ps_divisioncode
    and A.saleconfirmflag like @ps_saleconfirmflag
    and a.confirmflag    = 'Y'
end 


GO
