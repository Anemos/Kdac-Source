drop procedure sp_piss530i_01
go
/*
exec sp_piss530i_01 @ps_areacode      = 'J',         -- ��������
                    @ps_divisioncode  = 'S',         -- �����ڵ�
	            @ps_applyfrom     = '2003.01.01',-- ���Ͽ䱸��
	            @ps_applyto       = '2003.01.31',-- ���Ͽ䱸��
                    @ps_custcode      = '%',         -- �ŷ�ó
                    @ps_shipgubun     = '%'          -- ���ϱ���

*/
CREATE PROCEDURE sp_piss530i_01
	@ps_areacode       char(01),     -- ��������
        @ps_divisioncode   char(01),     -- �����ڵ�
	@ps_applyfrom	   char(10),     -- ������
	@ps_applyto	   char(10),     -- ������
        @ps_custcode       varchar(06),  -- �ŷ�ó�ڵ� 
        @ps_shipgubun      char(01)      -- ���ϱ���,

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
