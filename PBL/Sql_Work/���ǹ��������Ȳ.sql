select areacode, divisioncode, suppliercode, itemcode, partkbno, 
partorderdate,rackqty, lastdate
from tpartkborder_interface
where misflag = 'D' and areacode = 'D' and divisioncode = 'V' and lastdate >= '2005-01-01' and
lastdate < '2006-01-01'

union all

select areacode, divisioncode, suppliercode, itemcode, partkbno, 
partorderdate,rackqty, lastdate
from tpartkborder_interfacehis
where misflag = 'D' and areacode = 'D' and divisioncode = 'V' and lastdate >= '2005-01-01' and
lastdate < '2006-01-01'