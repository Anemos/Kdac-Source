select a.areacode,a.divisioncode,a.releasedate,a.serialno,a.itemcode,a.releaseqty,
b.part_code,b.part_tag
from tmcpartrelease a, [ipisele_svr\ipis].cmms.dbo.part_out b
where a.areacode = b.area_code and a.divisioncode = b.factory_code and
a.itemcode = b.part_code and b.out_serial = a.serialno and a.uploadflag = 'N'
