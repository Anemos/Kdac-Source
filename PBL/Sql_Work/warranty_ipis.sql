-- �뱸 ����(EIS)
insert	into [ipisele_svr\ipis].eis.dbo.tlotno
	(tracedate,areacode,divisioncode,lotno,itemcode,custcode,shipgubun,shipusage,
	prdqty,stockqty,shipqty,lastemp,lastdate)
select 	tracedate,areacode,divisioncode,lotno,itemcode,custcode,shipgubun,shipusage,
	prdqty,stockqty,shipqty,lastemp,getdate()
from	warranty2002
where areacode = 'D' and divisioncode = 'A'


-- �뱸 ���
insert	into [ipismac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)

-- �뱸 ����
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,	ProductGroup,		ModelGroup,
	ProductCode,		ProductName,	LastEmp)

-- ����
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)

-- ����
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)

-- ��õ
insert	into [ipisjin_svr].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)


