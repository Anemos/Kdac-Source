select aa.deliveryno,
	aa.areacode,
	aa.divisioncode,
	aa.itemcode,
	bb.itemname,
	aa.suppliercode,
	cc.supplierkorname,
	aa.partreceiptdate,
	sum(aa.rackqty)
from ( select deliveryno, areacode, divisioncode,itemcode,suppliercode,partreceiptdate,rackqty
			from tpartkbhis
			where partreceiptdate >= '2005.09.01' and partreceiptdate <= '2005.09.30'
			union all
			select deliveryno, areacode, divisioncode,itemcode,suppliercode,partreceiptdate,rackqty
			from tpartkbstatus
			where partreceiptdate >= '2005.09.01' and partreceiptdate <= '2005.09.30' and 
			partkbstatus = 'B' ) aa
	 left outer join tmstitem bb
	on aa.itemcode = bb.itemcode
	left outer join tmstsupplier cc
	on aa.suppliercode = cc.suppliercode
where aa.partreceiptdate >= '2005.09.01' and aa.partreceiptdate <= '2005.09.30'
group by aa.deliveryno,
	aa.areacode,
	aa.divisioncode,
	aa.itemcode,
	bb.itemname,
	aa.suppliercode,
	cc.supplierkorname,
	aa.partreceiptdate
order by aa.deliveryno,
	aa.areacode,
	aa.divisioncode,
	aa.itemcode