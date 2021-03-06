if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_CMMS_WO_SUM]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_CMMS_WO_SUM]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE SP_CMMS_WO_SUM
AS
BEGIN
INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)		
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPISELE_SVR\IPIS].cmms.dbo.equip_master a, [IPISELE_SVR\IPIS].cmms.dbo.wo_hist b 
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='A'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)		
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPISMAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISMAC_SVR\IPIS].cmms.dbo.wo_hist b 
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='S'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)		
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPISMAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISMAC_SVR\IPIS].cmms.dbo.wo_hist b 
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='M'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)		
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPISHVAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISHVAC_SVR\IPIS].cmms.dbo.wo_hist b 
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='V'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)		
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from [IPISHVAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISHVAC_SVR\IPIS].cmms.dbo.wo_hist b 
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='H'
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, WO_FIRM_TIME_SUM, WO_TIME_SUM, WO_COUNT)		
select  a.area_code, a.factory_code, b.wo_end_date, a.cc_code ,wo_firm_time_sum= sum(wo_firm_time_hour)*60 + sum(wo_firm_time_minute),wo_time_sum= sum(wo_time_hour)*60 + sum(wo_time_minute),wo_count= count(wo_code)
from IPISJIN_SVR.cmms.dbo.equip_master a, IPISJIN_SVR.cmms.dbo.wo_hist b 
where a.equip_code= b.equip_code and convert(varchar(10),b.wo_end_date,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='J' 
group by a.area_code, a.factory_code, a.cc_code, b.wo_end_date

end -- procedure end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

