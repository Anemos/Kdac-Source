/*
	File Name	: sp_piss420u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss420u_02
	Description	: 취소SR확정(출하취소요청서)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss420u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss420u_02]
GO

/*
exec sp_piss420u_02 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'M',          -- 공장코드
                    @ps_checksrno    = 'DMD21200146'   -- sr번호

*/
CREATE PROCEDURE sp_piss420u_02
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
--	@ps_custcode	 Char(06),        -- 거래처
        @ps_checksrno    varchar(11)     -- SR번호
--        @ps_srno         varchar(11)      -- SR전산번호
AS

BEGIN

select checksrno     = b.checksrno,
       INPUTDATE     = d.inputdate + ' '+ d.inputtime,
       applyfrom     = b.applyfrom,
       shipeditno    = b.shipeditno,
       custcode      = b.custcode,
       custname      = e.custname,
       productgroup  = b.productgroup,
       srno          = b.srno,
       itemcode      = b.itemcode,
       custitemno    = b.customeritemno,
       itemname      = isnull(c.itemname,b.itemcode),
       shipuage      = b.shipusage,
       shipoderqty   = b.shiporderqty,
       shipyard      = d.shipyard,       
       orderno       = b.orderno,
       kitgubun      = b.kitgubun,
       comment1      = f.srcomment,
       shipremainqty = b.CANCELQTY
  from tsrorder b,tmstitem c,tsrheader d,tmstcustomer e,tsrcomment f
 where b.srareacode     = @ps_areacode
   and b.srdivisioncode = @ps_divisioncode
--   and b.custcode       = @ps_custcode
     and b.checksrno      = @ps_checksrno
--   and b.srno           = @ps_srno
     and b.custcode       *= e.custcode
   and b.itemcode         *= c.itemcode
   and b.srcancelgubun    = 'Y'
--   and b.shipendgubun   = 'N'
   and (b.kitgubun = 'N' or (b.kitgubun = 'Y' and pcgubun = 'P'))
--   and (b.shiporderqty  = b.shipremainqty)
   and (b.checksrno     *= d.checksrno)
   and (b.checksrno     *= f.checksrno)
 order by b.checksrno,b.itemcode

end 


GO
