/*
  file name : sp_cmms_wo_cost_sum_temp.sql
  system    : cmms system
  procedure name  : sp_cmms_wo_cost_sum_temp
  description : EIS DB에 작업명령 Summary 작업
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_cmms_wo_cost_sum_temp]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_cmms_wo_cost_sum_temp]
go

/*
execute sp_cmms_wo_cost_sum_temp
*/

create procedure [dbo].[sp_cmms_wo_cost_sum_temp]
as
begin

DECLARE @AA INT
SET @AA=1

WHILE @AA<50
BEGIN

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120) AND
b.AREA_CODE='D' AND b.FACTORY_CODE='A'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='D' AND b.FACTORY_CODE='S'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='D' AND b.FACTORY_CODE='M'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='D' AND b.FACTORY_CODE='V'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipis_daegu].cmms.dbo.equip_master a inner join [ipis_daegu].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipis_daegu].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipis_daegu].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='D' AND b.FACTORY_CODE='H'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipisjin_svr].cmms.dbo.equip_master a inner join [ipisjin_svr].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisjin_svr].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisjin_svr].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='J'  AND B.FACTORY_CODE='M'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipisjin_svr].cmms.dbo.equip_master a inner join [ipisjin_svr].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisjin_svr].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisjin_svr].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='J' AND B.FACTORY_CODE='H'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipisjin_svr].cmms.dbo.equip_master a inner join [ipisjin_svr].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisjin_svr].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisjin_svr].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='J' AND B.FACTORY_CODE='S'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,
part_cost_sum=sum(d.part_cost*c.qty), repair_cost_sum=sum(b.wo_value)
from [ipisyeo_svr\ipis].cmms.dbo.equip_master a inner join [ipisyeo_svr\ipis].cmms.dbo.wo_hist b
  on a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code
  inner join [ipisyeo_svr\ipis].cmms.dbo.wo_part c
  on b.area_code = c.area_code and b.factory_code = c.factory_code and b.wo_code = c.wo_code
  inner join [ipisyeo_svr\ipis].cmms.dbo.part_master d
  on c.area_code = d.area_code and c.factory_code = d.factory_code and c.part_code= d.part_code
where convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-@AA,getdate()),120)
AND b.AREA_CODE='Y' AND B.FACTORY_CODE='Y'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

SET @AA = @AA + 1

END
end -- procedure end

go