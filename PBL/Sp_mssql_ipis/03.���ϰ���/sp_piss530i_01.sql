drop procedure sp_piss530i_01
go
/*
exec sp_piss530i_01 @ps_areacode      = 'J',         -- 지역구분
                    @ps_divisioncode  = 'S',         -- 공장코드
	            @ps_applyfrom     = '2003.01.01',-- 출하요구일
	            @ps_applyto       = '2003.01.31',-- 출하요구일
                    @ps_custcode      = '%',         -- 거래처
                    @ps_shipgubun     = '%'          -- 출하구분

*/
CREATE PROCEDURE sp_piss530i_01
	@ps_areacode       char(01),     -- 지역구분
        @ps_divisioncode   char(01),     -- 공장코드
	@ps_applyfrom	   char(10),     -- 출하일
	@ps_applyto	   char(10),     -- 출하일
        @ps_custcode       varchar(06),  -- 거래처코드 
        @ps_shipgubun      char(01)      -- 출하구분,

AS

BEGIN

 SELECT distinct divisioncode = A.DivisionCode,
        checksrno      = a.checksrno,   
        srno           = a.srno,
        applyfrom      = a.applyfrom,
        customeritemno = a.customeritemno,
        itemcode       = a.itemcode,
        itemname       = b.itemname,
        shiporderqty   = a.shiporderqty,
        shipremainqty  = a.shipremainqty,
        srcancelgubun  = a.srcancelgubun,
        shipgubunname  = c.shipgubunname,
        shipqty        = a.shiporderqty - a.shipremainqty
   FROM tsrorder  A,
        tmstitem b,
	tmstshipgubun C
  Where A.applyfrom    >= @ps_applyfrom
    and a.applyfrom    <= @ps_applyto
    and A.AreaCode     = @ps_areacode
    and A.DivisionCode LIKE @ps_divisioncode
    and A.custcode     like @ps_custcode
    and a.shipgubun    = c.shipgubun
    and a.itemcode     *= b.itemcode
    and c.shipoemgubun like @ps_shipgubun
 order by a.divisioncode,a.checksrno,a.applyfrom,a.srno
end

GO
