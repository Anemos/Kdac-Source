select bb.supplierkorname, 
	aa.itemcode, cc.itemname, 
	aa.partkbno, aa.partorderdate, 
	aa.partreceiptdate
from tpartkbstatus aa inner join tmstsupplier bb
	on aa.suppliercode = bb.suppliercode
	inner join tmstitem cc
	on aa.itemcode = cc.itemcode
where aa.areacode = 'D' and aa.divisioncode = 'V' and
	aa.partorderdate = aa.partreceiptdate and
	aa.partorderdate >= '2005.10.17' and aa.partorderdate <= '2005.10.22'

union all

select bb.supplierkorname, 
	aa.itemcode, cc.itemname, 
	aa.partkbno, aa.partorderdate, 
	aa.partreceiptdate
from tpartkbhis aa inner join tmstsupplier bb
	on aa.suppliercode = bb.suppliercode
	inner join tmstitem cc
	on aa.itemcode = cc.itemcode
where  aa.areacode = 'D' and aa.divisioncode = 'V' and
	aa.partorderdate = aa.partreceiptdate and
	aa.partorderdate >= '2005.10.17' and aa.partorderdate <= '2005.10.22'