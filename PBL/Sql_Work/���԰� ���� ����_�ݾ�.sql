select areacode = aa.areacode, 
	divisioncode = aa.divisioncode,
	itemcode = aa.itemcode,
	itemclass = cc.itemclass,
	itemsrce = cc.itembuysource,
	itemname = dd.itemname,
   totqty = sum(aa.rackqty),
   totamt = sum(aa.rackqty * bb.unitcost)
from tpartkbstatus aa left outer join tmstpartcost bb
	on aa.suppliercode = bb.suppliercode and aa.itemcode = bb.itemcode
	left outer join tmstmodel cc
	on aa.areacode = cc.areacode and aa.divisioncode = cc.divisioncode and
	aa.itemcode = cc.itemcode
	left outer join tmstitem dd
	on cc.itemcode = dd.itemcode
where aa.partkbstatus = 'B'
group by aa.areacode, aa.divisioncode, aa.itemcode, cc.itemclass,
	cc.itembuysource, dd.itemname
