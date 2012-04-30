drop procedure sp_piss540i_01
go
/*
exec sp_piss540i_01         @ps_gubun    = '1',     -- ���ڱ���
	@ps_areacode       = 'j',     -- ��������
        @ps_divisioncode   = '%',     -- �����ڵ�
	@ps_applyfrom	   = '2003.01.01',     -- ������
	@ps_applyto	   = '2003.01.15',     -- ������
        @ps_custcode       = '%',       --��ó�ڵ� 
        @ps_shipgubun      = '%',     -- ���ϱ���,
        @ps_checksrno      = '%',     -- 
        @ps_itemcode       = '%',
        @ps_customeritemno = '%',
        @ps_productgroup   = '%'


*/
CREATE PROCEDURE sp_piss540i_01
        @ps_gubun          char(01),     -- ���ڱ���
	@ps_areacode       char(01),     -- ��������
        @ps_divisioncode   char(01),     -- �����ڵ�
	@ps_applyfrom	   char(10),     -- ������
	@ps_applyto	   char(10),     -- ������
        @ps_custcode       varchar(06),  -- �ŷ�ó�ڵ� 
        @ps_shipgubun      char(01),     -- ���ϱ���,
        @ps_checksrno      varchar(11),     -- 
        @ps_itemcode       varchar(20),
        @ps_customeritemno varchar(20),
        @ps_productgroup   varchar(6)

AS

BEGIN
if @ps_gubun = '1'
  begin
 SELECT distinct divisioncode = A.DivisionCode,
        stcd           = a.stcd,
        checksrno      = a.checksrno,   
        inputdate      = d.inputdate,
        applyfrom      = a.applyfrom,
        srno           = a.srno,
        itemcode       = a.itemcode,
        customeritemno = a.customeritemno,
        itemname       = b.itemname,
        shiporderqty   = a.shiporderqty,
        shipqty        = a.shiporderqty - a.shipremainqty - a.cancelqty,
        shipremainqty  = a.shipremainqty,
        cancelqty      = case a.srcancelgubun when 'Y' then a.cancelqty else 0 end,
        srcancelgubun  = a.srcancelgubun,
        shipgubunname  = c.shipgubunname
   FROM tsrorder  A,
        tmstitem b,
	tmstshipgubun C,
        tsrheader d,
        tmstmodel e
  Where A.applyfrom    >= @ps_applyfrom
    and a.applyfrom    <= @ps_applyto
    and A.AreaCode     = @ps_areacode
    and A.DivisionCode LIKE @ps_divisioncode
    and A.custcode     like @ps_custcode
    and a.shipgubun    = c.shipgubun
    and a.itemcode     *= b.itemcode
    and c.shipoemgubun like @ps_shipgubun
    and a.itemcode     like @ps_itemcode
    and a.checksrno    like @ps_checksrno
    and a.customeritemno like @ps_customeritemno
    and a.checksrno    *= d.checksrno
    and a.areacode     = e.areacode
    and a.divisioncode = e.divisioncode
    and a.itemcode     = e.itemcode
    and e.productgroup like @ps_productgroup
 order by a.divisioncode,a.checksrno,a.applyfrom,a.srno
 end 
else
 begin
 SELECT distinct divisioncode = A.DivisionCode,
        stcd           = a.stcd,
        checksrno      = a.checksrno,   
        inputdate      = d.inputdate,
        applyfrom      = a.applyfrom,
        srno           = a.srno,
        itemcode       = a.itemcode,
        customeritemno = a.customeritemno,
        itemname       = b.itemname,
        shiporderqty   = a.shiporderqty,
        shipqty        = a.shiporderqty - a.shipremainqty - a.cancelqty,
        shipremainqty  = a.shipremainqty,
        cancelqty      = case a.srcancelgubun when 'Y' then a.cancelqty else 0 end,
        srcancelgubun  = a.srcancelgubun,
        shipgubunname  = c.shipgubunname
   FROM tsrorder  A,
        tmstitem b,
	tmstshipgubun C,
        tsrheader D,
        tmstmodel e
  Where d.inputdate    >= @ps_applyfrom
    and d.inputdate    <= @ps_applyto
    and A.AreaCode     = @ps_areacode
    and A.DivisionCode LIKE @ps_divisioncode
    and A.custcode     like @ps_custcode
    and a.shipgubun    = c.shipgubun
    and a.itemcode     *= b.itemcode
    and c.shipoemgubun like @ps_shipgubun
    and a.itemcode     like @ps_itemcode
    and a.checksrno    like @ps_checksrno
    and a.customeritemno like @ps_customeritemno
    and a.checksrno    = d.checksrno
    and a.areacode     = e.areacode
    and a.divisioncode = e.divisioncode
    and a.itemcode     = e.itemcode
    and e.productgroup like @ps_productgroup
 order by a.divisioncode,a.checksrno,a.applyfrom,a.srno
 end 
end

GO
