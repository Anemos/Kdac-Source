-- UPDATE TMSTMODEL
UPDATE [ipisele_svr\ipis].ipis.dbo.tmstmodel
SET ProductGroup = substring(pdcd, 1, 2),	
	ModelGroup = substring(pdcd, 1, 3),
	ProductCode = pdcd,
     ItemClass = cls,
	ItemBuySource = srce,
	ItemUnit = xunit,
	ConvertFactor = convqty,
	AverageUnitCost = saud,
	AbcCode = abccd,
     Location = wloc,
	Planner = xplan,
	LastEmp = 'SYSTEM'
FROM [ipisele_svr\ipis].ipis.dbo.tmstmodel, PDINV101_LOG
where areacode = xplant and divisioncode = div and
		itemcode = itno and xplant = 'D' and div = 'A'
				
-- UPDATE TMSTITEMCOST
UPDATE [ipisele_svr\ipis].ipis.dbo.tmstitemcost
SET ItemClass = cls,
	ItemBuySource = srce,
	ItemUnit = xunit,
	UnitCost = saud,
	LastEmp = 'SYSTEM'
FROM [ipisele_svr\ipis].ipis.dbo.tmstitemcost, PDINV101_LOG
where areacode = xplant and divisioncode = div and
		itemcode = itno and xplant = 'D' and div = 'A'

-- UPDATE EIS TMSTMODEL
UPDATE [ipisele_svr\ipis].eis.dbo.tmstmodel
SET ProductGroup = substring(pdcd, 1, 2),	
	ModelGroup = substring(pdcd, 1, 3),
	ProductCode = pdcd,
     ItemClass = cls,
	ItemBuySource = srce,
	ItemUnit = xunit,
	ConvertFactor = convqty,
	AverageUnitCost = saud,
	AbcCode = abccd,
     Location = wloc,
	Planner = xplan,
	LastEmp = 'SYSTEM'
FROM [ipisele_svr\ipis].eis.dbo.tmstmodel, PDINV101_LOG
where areacode = xplant and divisioncode = div and
		itemcode = itno and xplant = 'D' and div = 'A'

-- Delete pdinv101_log
DELETE select * FROM PdINV101_LOG
WHERE xplant = 'D' and div = 'A'