/*
  file name : sp_cmms_wo_cost_sum.sql
  system    : cmms system
  procedure name  : sp_cmms_wo_cost_sum
  description : EIS DB에 작업명령 Summary 작업
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_cmms_wo_cost_sum]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_cmms_wo_cost_sum]
go

/*
execute sp_cmms_wo_cost_sum
*/

create procedure [dbo].[sp_cmms_wo_cost_sum]
as
begin

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='D' and b.factory_code='A' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='D' and b.factory_code='S' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='D' and b.factory_code='M' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='D' and b.factory_code='H' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='D' and b.factory_code='V' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipisjin_svr].cmms.dbo.equip_master a inner join [ipisjin_svr].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisjin_svr].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisjin_svr].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='J' and b.factory_code='S' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipisjin_svr].cmms.dbo.equip_master a inner join [ipisjin_svr].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisjin_svr].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisjin_svr].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='J' and b.factory_code='M' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipisjin_svr].cmms.dbo.equip_master a inner join [ipisjin_svr].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisjin_svr].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisjin_svr].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='J' and b.factory_code='H' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

insert into [ipis_daegu].eis.dbo.cmms_wo_cost_sum(area_code, factory_code, wo_date, cc_code, part_cost_sum, repair_cost_sum)
select  a.area_code, a.factory_code, b.wo_float_date, a.cc_code ,
  part_cost_sum=isnull(sum(d.part_cost*c.qty),0) ,
  repair_cost_sum=isnull(sum(b.wo_value) ,0)
from [ipisyeo_svr\ipis].cmms.dbo.equip_master a inner join [ipisyeo_svr\ipis].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisyeo_svr\ipis].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisyeo_svr\ipis].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_float_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) and
  b.area_code='Y' and b.factory_code='Y' and ( d.part_cost*qty>0 or b.wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.wo_float_date

end -- procedure end
go
