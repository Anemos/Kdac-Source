/*
	File Name	: SP_EQUIP_UP.SQL
	SYSTEM		: 설비관리시스템
	Procedure Name	: SP_EQUIP_UP
	Description	: 설비장비 업로드
			  여주전자 서버추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: CMMS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[SP_EQUIP_UP]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[SP_EQUIP_UP]
GO

/*
Execute SP_EQUIP_UP
*/

CREATE PROCEDURE SP_EQUIP_UP
AS
BEGIN -- BEGIN PROCEDURE
-- ele server
if exists(select 1 from [ipisele_svr\ipis].cmms.dbo.equip_master_upload  where up_div ='N' )
begin
  
  select * into #tmp_ele
  from [ipisele_svr\ipis].cmms.dbo.equip_master_upload
	where up_div = 'N' 
  
	INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCmaster
	(misflag, AREACODE,DIVISIONCODE,mccode,mcname, assetcode,status, mcspec, 
	mcusage, cccode,line,mcshortname,setupdate, processno, admindept, usedept, buyer, domesticagent, uploadflag)
	select isnull(input_div,'') , area_code, factory_code, upper(equip_code), isnull(equip_name,''), isnull(asset_code,''), isnull(equip_div_code,''), isnull(equip_spec,''),      
	isnull(equip_use,''), isnull(cc_code,''), isnull(line_code,''), isnull(equip_short_name,''), isnull(convert(varchar(8),equip_install_date,112),''), 
  isnull(equip_process_number,''),  isnull(dept_code_op,''), isnull(dept_code_use,''), isnull(comp_code_vender,''), isnull(comp_code_agent,''),up_div
	from #tmp_ele

	update [ipisele_svr\ipis].cmms.dbo.equip_master_upload 
	set up_div = 'Y'
	from [ipisele_svr\ipis].cmms.dbo.equip_master_upload aa, #tmp_ele bb
	where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
	  aa.last_dttm = bb.last_dttm
	  
	drop table #tmp_ele
	 
end

-- mac server
if exists(select 1 from [ipismac_svr\ipis].cmms.dbo.equip_master_upload  where up_div ='N' )
begin

  select * into #tmp_mac
  from [ipismac_svr\ipis].cmms.dbo.equip_master_upload
	where up_div = 'N' 
	
	INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCmaster
	(misflag, AREACODE,DIVISIONCODE,mccode,mcname, assetcode,status, mcspec, 
	mcusage, cccode,line,mcshortname,setupdate, processno, admindept, usedept, buyer, domesticagent, uploadflag)
	select isnull(input_div,''), area_code, factory_code, upper(equip_code),  isnull(equip_name,''), isnull(asset_code,''), isnull(equip_div_code,''), isnull(equip_spec,''),      
	isnull(equip_use,''), isnull(cc_code,''), isnull(line_code,''), isnull(equip_short_name,''), isnull(convert(varchar(8),equip_install_date,112),''), 
              isnull(equip_process_number,''),  isnull(dept_code_op,''), isnull(dept_code_use,''), isnull(comp_code_vender,''), isnull(comp_code_agent,''),up_div
	from #tmp_mac

	update [ipismac_svr\ipis].cmms.dbo.equip_master_upload 
	set up_div = 'Y'
	from [ipismac_svr\ipis].cmms.dbo.equip_master_upload aa, #tmp_mac bb
	where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
	  aa.last_dttm = bb.last_dttm
	  
	drop table #tmp_mac
	
end

-- hvac server
if exists(select 1 from [ipishvac_svr\ipis].cmms.dbo.equip_master_upload  where up_div ='N' )
begin

  select * into #tmp_hvac
  from [ipishvac_svr\ipis].cmms.dbo.equip_master_upload
	where up_div = 'N'
	
	INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCmaster
	(misflag, AREACODE,DIVISIONCODE,mccode,mcname, assetcode,status, mcspec, 
	mcusage, cccode,line,mcshortname,setupdate, processno, admindept, usedept, buyer, domesticagent, uploadflag)
	select isnull(input_div,''), area_code, factory_code, upper(equip_code), isnull(equip_name,''), isnull(asset_code,''), isnull(equip_div_code,''), isnull(equip_spec,''),      
	isnull(equip_use,''), isnull(cc_code,''), isnull(line_code,''), isnull(equip_short_name,''), isnull(convert(varchar(8),equip_install_date,112),''), 
              isnull(equip_process_number,''),  isnull(dept_code_op,''), isnull(dept_code_use,''), isnull(comp_code_vender,''), isnull(comp_code_agent,''),up_div
	from #tmp_hvac
	
	update [ipishvac_svr\ipis].cmms.dbo.equip_master_upload 
	set up_div = 'Y'
	from [ipishvac_svr\ipis].cmms.dbo.equip_master_upload aa, #tmp_hvac bb
	where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
	  aa.last_dttm = bb.last_dttm
	  
	drop table #tmp_hvac
	
end

-- jin server
if exists(select 1 from ipisjin_svr.cmms.dbo.equip_master_upload  where up_div ='N' )
begin

  select * into #tmp_jin
  from ipisjin_svr.cmms.dbo.equip_master_upload
	where up_div = 'N'
	
	INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCmaster
	(misflag, AREACODE,DIVISIONCODE,mccode,mcname, assetcode,status, mcspec, 
	mcusage, cccode,line,mcshortname,setupdate, processno, admindept, usedept, buyer, domesticagent, uploadflag)
	select isnull(input_div,''), area_code, factory_code, upper(equip_code), isnull(equip_name,''), isnull(asset_code,''), isnull(equip_div_code,''), isnull(equip_spec,''),      
	isnull(equip_use,''), isnull(cc_code,''), isnull(line_code,''), isnull(equip_short_name,''), isnull(convert(varchar(8),equip_install_date,112),''), 
              isnull(equip_process_number,''),  isnull(dept_code_op,''), isnull(dept_code_use,''), isnull(comp_code_vender,''), isnull(comp_code_agent,''),up_div
	from #tmp_jin

	update ipisjin_svr.cmms.dbo.equip_master_upload 
	set up_div = 'Y'
	from ipisjin_svr.cmms.dbo.equip_master_upload aa, #tmp_jin bb
	where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
	  aa.last_dttm = bb.last_dttm
	  
	drop table #tmp_jin
	
end

-- yeo server
if exists(select 1 from [ipisyeo_svr\ipis].cmms.dbo.equip_master_upload  where up_div ='N' )
begin

  select * into #tmp_yeo
  from [ipisyeo_svr\ipis].cmms.dbo.equip_master_upload
	where up_div = 'N'
	
	INSERT INTO [ipisele_svr\ipis].INTERFACE.dbo.TMCmaster
	(misflag, AREACODE,DIVISIONCODE,mccode,mcname, assetcode,status, mcspec, 
	mcusage, cccode,line,mcshortname,setupdate, processno, admindept, usedept, buyer, domesticagent, uploadflag)
	select isnull(input_div,''), area_code, factory_code, upper(equip_code), isnull(equip_name,''), isnull(asset_code,''), isnull(equip_div_code,''), isnull(equip_spec,''),      
	isnull(equip_use,''), isnull(cc_code,''), isnull(line_code,''), isnull(equip_short_name,''), isnull(convert(varchar(8),equip_install_date,112),''), 
              isnull(equip_process_number,''),  isnull(dept_code_op,''), isnull(dept_code_use,''), isnull(comp_code_vender,''), isnull(comp_code_agent,''),up_div
	from #tmp_yeo
	
	update [ipisyeo_svr\ipis].cmms.dbo.equip_master_upload 
	set up_div = 'Y'
	from [ipisyeo_svr\ipis].cmms.dbo.equip_master_upload aa, #tmp_yeo bb
	where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
	  aa.last_dttm = bb.last_dttm
	  
	drop table #tmp_yeo
	
end

END -- END PROCEDURE
GO
