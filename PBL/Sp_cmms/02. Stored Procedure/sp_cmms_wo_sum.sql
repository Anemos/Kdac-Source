/*
  file name : sp_cmms_wo_sum.sql
  system    : cmms system
  procedure name  : sp_cmms_wo_sum
  description : EIS DB에 작업명령 Summary 작업
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_cmms_wo_sum]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_cmms_wo_sum]
go

/*
execute sp_cmms_wo_sum
*/

create procedure [dbo].[sp_cmms_wo_sum]
as
BEGIN
INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPIS_DAEGU].cmms.dbo.equip_master a, [IPIS_DAEGU].cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='A'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPIS_DAEGU].cmms.dbo.equip_master a, [IPIS_DAEGU].cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='S'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPIS_DAEGU].cmms.dbo.equip_master a, [IPIS_DAEGU].cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='M'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPIS_DAEGU].cmms.dbo.equip_master a, [IPIS_DAEGU].cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='V'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPIS_DAEGU].cmms.dbo.equip_master a, [IPIS_DAEGU].cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='H'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from IPISJIN_SVR.cmms.dbo.equip_master a, IPISJIN_SVR.cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='J'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [ipisyeo_svr\ipis].cmms.dbo.equip_master a, [ipisyeo_svr\ipis].cmms.dbo.wo_hist b
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='Y'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

end -- procedure end

go