/*
	File Name	: sp_piss460u_04.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss460u_04
	Description	: 생관SR확정(수출출하요청서)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss460u_04]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss460u_04]
GO


/*
exec sp_piss460u_04 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'A',          -- 공장코드
                    @ps_custcode     = 'E31100',        -- 거래처
                    @ps_checksrno    = 'AO1205602'

*/
CREATE PROCEDURE sp_piss460u_04
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
	@ps_custcode	 Char(06),        -- 거래처
        @ps_checksrno    varchar(11)      -- SR번호
AS
declare
        @ls_seller       varchar(50),
        @ls_consig       varchar(50),
        @ls_buyer        varchar(50),
        @ls_trans        varchar(50),
        @ls_dstn         varchar(50),
        @ls_trdl         varchar(50),
        @ls_seller_desc1 varchar(100),
        @ls_seller_desc2 varchar(100),
        @ls_seller_desc3 varchar(100),
        @ls_seller_desc4 varchar(100),
        @ls_consig_desc1 varchar(100),
        @ls_consig_desc2 varchar(100),
        @ls_consig_desc3 varchar(100),
        @ls_consig_desc4 varchar(100),
        @ls_buyer_desc1 varchar(100),
        @ls_buyer_desc2 varchar(100),
        @ls_buyer_desc3 varchar(100),
        @ls_buyer_desc4 varchar(100),
        @ls_trans_desc1 varchar(100),
        @ls_trans_desc2 varchar(100),
        @ls_trans_desc3 varchar(100),
        @ls_trans_desc4 varchar(100),
        @ls_dstn_desc1 varchar(100),
        @ls_dstn_desc2 varchar(100),
        @ls_dstn_desc3 varchar(100),
        @ls_dstn_desc4 varchar(100),
        @ls_trdl_desc1 varchar(100),
        @ls_trdl_desc2 varchar(100),
        @ls_trdl_desc3 varchar(100),
        @ls_trdl_desc4 varchar(100),
        @ls_comment    varchar(200)
BEGIN


select @ls_seller    = a.seller,
       @ls_consig    = a.consig,
       @ls_buyer     = a.buyer,
       @ls_trans     = a.trans,
       @ls_dstn      = a.dstn,
       @ls_trdl      = a.trdl
  from tsrheader a
 where a.checksrno     = @ps_checksrno

select @ls_seller_desc1 = a.desc1,
       @ls_seller_desc2 = a.desc2,
       @ls_seller_desc3 = a.desc3,
       @ls_seller_desc4 = a.desc4
  from tsalescode a
 where a.cogubun = '174'
   and a.cocode  = @ls_seller

select @ls_consig_desc1 = a.desc1,
       @ls_consig_desc2 = a.desc2,
       @ls_consig_desc3 = a.desc3,
       @ls_consig_desc4 = a.desc4
  from tsalescode a
 where a.cogubun = '175'
   and a.cocode  = @ls_consig

select @ls_buyer_desc1 = a.desc1,
       @ls_buyer_desc2 = a.desc2,
       @ls_buyer_desc3 = a.desc3,
       @ls_buyer_desc4 = a.desc4
  from tsalescode a
 where a.cogubun = '177'
   and a.cocode  = @ls_buyer

select @ls_trans_desc1 = a.desc1,
       @ls_trans_desc2 = a.desc2,
       @ls_trans_desc3 = a.desc3,
       @ls_trans_desc4 = a.desc4
  from tsalescode a
 where a.cogubun = '185'
   and a.cocode  = @ls_trans

select @ls_dstn_desc1 = a.desc1,
       @ls_dstn_desc2 = a.desc2,
       @ls_dstn_desc3 = a.desc3,
       @ls_dstn_desc4 = a.desc4
  from tsalescode a
 where a.cogubun = '168'
   and a.cocode  = @ls_dstn

select @ls_trdl_desc1 = a.desc1,
       @ls_trdl_desc2 = a.desc2,
       @ls_trdl_desc3 = a.desc3,
       @ls_trdl_desc4 = a.desc4
  from tsalescode a
 where a.cogubun = '167'
   and a.cocode  = @ls_trdl

select @ls_comment    = a.srcomment
  from tsrcomment a
 where a.checksrno = @ps_checksrno
   and a.gubun     = '5'

select checksrno     = b.checksrno,
       INPUTDATE     = d.srconfirmdate,
       custcode      = b.custcode,
       custname      = e.custname,
       seller_desc1  = @ls_seller_desc1,
       seller_desc2  = @ls_seller_desc2,
       seller_desc3  = @ls_seller_desc3,
       seller_desc4  = @ls_seller_desc4,
       invoiceno     = d.invoiceno,
       invoicedate   = d.invoicedate,
       locallcno     = d.locallcno,
       elno1         = elno1,
       consig_desc1  = @ls_consig_desc1,
       consig_desc2  = @ls_consig_desc2,
       consig_desc3  = @ls_consig_desc3,
       consig_desc4  = @ls_consig_desc4,
       buyer_desc1  = @ls_buyer_desc1,
       buyer_desc2  = @ls_buyer_desc2,
       buyer_desc3  = @ls_buyer_desc3,
       buyer_desc4  = @ls_buyer_desc4,

       shipdate      = d.shipdate,
       trans_desc1  = @ls_trans_desc1,
       trans_desc2  = @ls_trans_desc2,
       trans_desc3  = @ls_trans_desc3,
       trans_desc4  = @ls_trans_desc4,

       dstn_desc1  = @ls_dstn_desc1,
       dstn_desc2  = @ls_dstn_desc2,
       dstn_desc3  = @ls_dstn_desc3,
       dstn_desc4  = @ls_dstn_desc4,

       trdl_desc1  = @ls_trdl_desc1,
       trdl_desc2  = @ls_trdl_desc2,
       trdl_desc3  = @ls_trdl_desc3,
       trdl_desc4  = @ls_trdl_desc4,
       srno          = b.srno,
       productgroup  = b.productgroup,
       custitemno    = b.customeritemno,
       itemcode      = b.itemcode,
       itemname      = isnull(c.itemname,b.itemcode),
       applyfrom     = b.applyfrom,
       shipoderqty   = b.shiporderqty,
       luprc         = b.luprc,
       luamt         = b.luamt,
       kitgubun      = b.kitgubun,
       comment1      = @ls_comment
  from tsrorder b,tmstitem c,tsrheader d,tmstcustomer e
 where b.srareacode     = @ps_areacode
   and b.srdivisioncode = @ps_divisioncode
   and b.custcode       = @ps_custcode
   and b.checksrno      = @ps_checksrno
   and b.custcode       *= e.custcode
   and b.itemcode       *= c.itemcode
--   and b.srcancelgubun  = 'N'
--   and b.shipendgubun   = 'N'
   and (b.kitgubun = 'N' or (b.kitgubun = 'Y' and pcgubun = 'P'))
--   and (b.shiporderqty  = b.shipremainqty)
   and (b.checksrno     *= d.checksrno)
 order by b.applyfrom,b.srno

end 


GO
