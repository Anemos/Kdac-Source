/*
  file name : sp_equip_up.sql
  system    : cmms system
  procedure name  : sp_equip_up
  description : 
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_equip_up]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_equip_up]
go

/*
execute sp_equip_up
*/

create procedure [dbo].[sp_equip_up]
AS
BEGIN -- BEGIN PROCEDURE
-- ele server
if exists(select 1 from [ipis_daegu].cmms.dbo.equip_master_upload  where up_div ='N' )
begin
  
  select * into #tmp_ele
  from [ipis_daegu].cmms.dbo.equip_master_upload
	where up_div = 'N' 
  
	INSERT INTO [ipis_daegu].INTERFACE.dbo.TMCmaster
	(misflag, AREACODE,DIVISIONCODE,mccode,mcname, assetcode,status, mcspec, 
	mcusage, cccode,line,mcshortname,setupdate, processno, admindept, usedept, buyer, domesticagent, uploadflag)
	select isnull(input_div,'') , area_code, factory_code, upper(equip_code), isnull(equip_name,''), isnull(asset_code,''), isnull(equip_div_code,''), isnull(equip_spec,''),      
	isnull(equip_use,''), isnull(cc_code,''), isnull(line_code,''), isnull(equip_short_name,''), isnull(convert(varchar(8),equip_install_date,112),''), 
  isnull(equip_process_number,''),  isnull(dept_code_op,''), isnull(dept_code_use,''), isnull(comp_code_vender,''), isnull(comp_code_agent,''),up_div
	from #tmp_ele
	order by last_dttm,logid

	update [ipis_daegu].cmms.dbo.equip_master_upload 
	set up_div = 'Y'
	from [ipis_daegu].cmms.dbo.equip_master_upload aa, #tmp_ele bb
	where aa.area_code = bb.area_code and aa.factory_code = bb.factory_code and
	  aa.last_dttm = bb.last_dttm
	  
	drop table #tmp_ele
	 
end

-- jin server
if exists(select 1 from ipisjin_svr.cmms.dbo.equip_master_upload  where up_div ='N' )
begin

  select * into #tmp_jin
  from ipisjin_svr.cmms.dbo.equip_master_upload
	where up_div = 'N'
	
	INSERT INTO [ipis_daegu].INTERFACE.dbo.TMCmaster
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
	
	INSERT INTO [ipis_daegu].INTERFACE.dbo.TMCmaster
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
