
insert into[ipishvac_svr\ipis].cmms.dbo.part_out 
(area_code,factory_code,part_code,part_tag,wo_code,dept_code,part_used,equip_code,
out_date,invy_state,out_qty,out_serial,input_div,up_div)
select b.areacode,b.divisioncode,b.itemcode,b.slipno,b.orderno,b.deptcode,b.usage,b.mcno
,b.lastdate,b.stockstatus,b.releaseqty,b.serialno,'A','N'
from [ipisele_svr\ipis].interface.dbo.tmcpartrelease b
where b.releasedate >= '20030729' and b.divisioncode in ('H','V') and
	b.areacode = 'D' and
      not exists ( select * from [ipishvac_svr\ipis].cmms.dbo.part_out a
	where a.area_code = b.areacode and
	a.factory_code = b.divisioncode and a.part_code = b.itemcode and a.out_date >= '20030729')