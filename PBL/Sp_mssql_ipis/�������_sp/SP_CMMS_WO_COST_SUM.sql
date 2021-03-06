if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_CMMS_WO_COST_SUM]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_CMMS_WO_COST_SUM]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE SP_CMMS_WO_COST_SUM
AS
BEGIN

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from [IPISELE_SVR\IPIS].cmms.dbo.equip_master a, [IPISELE_SVR\IPIS].cmms.dbo.wo_hist b, [IPISELE_SVR\IPIS].cmms.dbo.wo_part c, [IPISELE_SVR\IPIS].cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='A' and c.part_code=d.part_code and b.wo_code=c.wo_code AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from [IPISMAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISMAC_SVR\IPIS].cmms.dbo.wo_hist b, [IPISMAC_SVR\IPIS].cmms.dbo.wo_part c, [IPISMAC_SVR\IPIS].cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='S' and c.part_code=d.part_code and b.wo_code=c.wo_code AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from [IPISMAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISMAC_SVR\IPIS].cmms.dbo.wo_hist b, [IPISMAC_SVR\IPIS].cmms.dbo.wo_part c, [IPISMAC_SVR\IPIS].cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='M' and c.part_code=d.part_code and b.wo_code=c.wo_code  AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from [IPISHVAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISHVAC_SVR\IPIS].cmms.dbo.wo_hist b, [IPISHVAC_SVR\IPIS].cmms.dbo.wo_part c, [IPISHVAC_SVR\IPIS].cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='V' and c.part_code=d.part_code and b.wo_code=c.wo_code  AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from [IPISHVAC_SVR\IPIS].cmms.dbo.equip_master a, [IPISHVAC_SVR\IPIS].cmms.dbo.wo_hist b, [IPISHVAC_SVR\IPIS].cmms.dbo.wo_part c, [IPISHVAC_SVR\IPIS].cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='D' AND b.FACTORY_CODE='H' and c.part_code=d.part_code and b.wo_code=c.wo_code  AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from IPISJIN_SVR.cmms.dbo.equip_master a, IPISJIN_SVR.cmms.dbo.wo_hist b, IPISJIN_SVR.cmms.dbo.wo_part c, IPISJIN_SVR.cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='J'  AND B.FACTORY_CODE='M' and c.part_code=d.part_code and b.wo_code=c.wo_code AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from IPISJIN_SVR.cmms.dbo.equip_master a, IPISJIN_SVR.cmms.dbo.wo_hist b, IPISJIN_SVR.cmms.dbo.wo_part c, IPISJIN_SVR.cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='J' AND B.FACTORY_CODE='H' and c.part_code=d.part_code and b.wo_code=c.wo_code AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE

INSERT INTO [IPISELE_SVR\IPIS].EIS.DBO.CMMS_WO_COST_SUM(AREA_CODE, FACTORY_CODE, WO_DATE, CC_CODE, PART_COST_SUM, REPAIR_COST_SUM)		
select  a.area_code, a.factory_code, b.WO_FLOAT_DATE, a.cc_code , part_cost_sum=ISNULL(sum(part_cost*qty),0) , repair_cost_sum=ISNULL(sum(wo_value) ,0)
from IPISJIN_SVR.cmms.dbo.equip_master a, IPISJIN_SVR.cmms.dbo.wo_hist b, IPISJIN_SVR.cmms.dbo.wo_part c, IPISJIN_SVR.cmms.dbo.part_master d
where a.equip_code= b.equip_code and convert(varchar(10),b.WO_FLOAT_DATE,120)=convert(varchar(10),dateadd(day ,-1,getdate()),120) AND b.AREA_CODE='J' AND B.FACTORY_CODE='S' and c.part_code=d.part_code and b.wo_code=c.wo_code  AND ( part_cost*qty>0 OR wo_value>0)
group by a.area_code, a.factory_code, a.cc_code, b.WO_FLOAT_DATE
end -- procedure end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

