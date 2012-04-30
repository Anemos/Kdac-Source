-- 대구 전장(EIS)
insert	into [ipisele_svr\ipis].eis.dbo.tlotno
	(tracedate,areacode,divisioncode,lotno,itemcode,custcode,shipgubun,shipusage,
	prdqty,stockqty,shipqty,lastemp,lastdate)
select 	tracedate,areacode,divisioncode,lotno,itemcode,custcode,shipgubun,shipusage,
	prdqty,stockqty,shipqty,lastemp,getdate()
from	warranty2002
where areacode = 'D' and divisioncode = 'A'


-- 대구 기계
insert	into [ipismac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)

-- 대구 공조
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,	ProductGroup,		ModelGroup,
	ProductCode,		ProductName,	LastEmp)

-- 여주
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)

-- 군산
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)

-- 진천
insert	into [ipisjin_svr].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)


