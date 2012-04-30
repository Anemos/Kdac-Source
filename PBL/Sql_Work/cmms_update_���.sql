update [ipishvac_svr\ipis].cmms.dbo.part_master
set normal_qty = ohuqty, repair_qty = ohrqty, scram_qty = ohsqty
from [ipisele_svr\ipis].cmms.dbo.kiss200309 
where comltd = '01' and area_code = xplant and factory_code = div and
part_code = itno and ( normal_qty <> ohuqty or repair_qty <> ohrqty or
scram_qty <> ohsqty )

select a.normal_qty, a.repair_qty,a.scram_qty,b.ohuqty,b.ohrqty,b.ohsqty
from [ipishvac_svr\ipis].cmms.dbo.part_master a,[ipisele_svr\ipis].cmms.dbo.kiss200309 b
where b.comltd = '01' and a.area_code = b.xplant and a.factory_code = b.div and
a.part_code = b.itno and ( a.normal_qty <> b.ohuqty or a.repair_qty <> b.ohrqty or
a.scram_qty <> b.ohsqty )