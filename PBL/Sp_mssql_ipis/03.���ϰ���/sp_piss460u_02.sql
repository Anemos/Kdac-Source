/*
	File Name	: sp_piss460u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss460u_02
	Description	: 생관SR확정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss460u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss460u_02]
GO


/*
exec sp_piss460u_02 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'S',          -- 공장코드
                    @ps_custcode     = 'L10500',        -- 거래처
                    @ps_checksrno    = ''

*/
CREATE PROCEDURE sp_piss460u_02
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
	@ps_custcode	 Char(06),        -- 거래처
        @ps_checksrno    varchar(11)      -- SR번호
AS

BEGIN

select checksrno     = b.checksrno,
       srno          = b.srno,
       itemcode      = b.itemcode,
       itemname      = isnull(c.itemname,b.itemcode),
       shiporderqty  = b.shiporderqty,
       srcancelgubun = b.srcancelgubun,
       pcgubun       = b.pcgubun,
       kitgubun      = b.kitgubun
  from tsrorder b,tmstitem c
 where b.srareacode     = @ps_areacode
   and b.srdivisioncode = @ps_divisioncode
   and b.custcode       = @ps_custcode
   and b.itemcode       *= c.itemcode
--   and b.srcancelgubun  = 'N'
--   and b.shipendgubun   = 'N'
   and (b.kitgubun      = 'N' or (b.kitgubun = 'Y' and pcgubun = 'P'))
--   and (b.shiporderqty  = b.shipremainqty)
   and (b.checksrno     = @ps_checksrno)
 order by b.checksrno

end 


GO
