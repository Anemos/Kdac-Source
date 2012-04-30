-- 데이타 이동은 테이블키값변경, 공장별데이타생성이 끝난다음에 수행함
-- 해당공장별 데이타(조건절에 포함해서)를 대구공장 서버로 이동하는걸로 처리함.
-- 대구전장 수행순서 : 대구서버 테이블 Truncate And Insert

-- 1. cause_master
TRUNCATE TABLE [CMMS].[dbo].[cause_master]
GO

INSERT INTO [CMMS].[dbo].[cause_master]
([cause_code],[cause_name],[area_code],[factory_code])
select [cause_code],[cause_name],[area_code],[factory_code]
from [CMMS_ELE].[dbo].[cause_master] a
where not exists ( select * from [CMMS].[dbo].[cause_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.cause_code = b.cause_code )

-- 1.1 CC_INV
GO
TRUNCATE TABLE [CMMS].[dbo].[CC_INV]

GO
INSERT INTO [CMMS].[dbo].[CC_INV]
           ([AREA_CODE]
           ,[FACTORY_CODE]
           ,[CC_CODE]
           ,[CC_NAME])
SELECT a.[AREA_CODE]
           ,a.[FACTORY_CODE]
           ,a.[CC_CODE]
           ,a.[CC_NAME]
FROM [CMMS_ELE].[dbo].[CC_INV] a
where not exists ( select * from [CMMS].[dbo].[CC_INV] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.cc_code = b.cc_code )

-- 1.2 cc_master
GO
TRUNCATE TABLE [CMMS].[dbo].[cc_master]

GO
INSERT INTO [CMMS].[dbo].[cc_master]
           ([area_code]
           ,[factory_code]
           ,[cc_code]
           ,[cc_name])
select [area_code]
           ,[factory_code]
           ,[cc_code]
           ,[cc_name]
from [CMMS_ELE].[dbo].[cc_master] a
where not exists ( select * from [CMMS].[dbo].[cc_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.cc_code = b.cc_code )

-- 2. class_div_master
GO
TRUNCATE TABLE [CMMS].[dbo].[class_div_master]

GO
INSERT INTO [CMMS].[dbo].[class_div_master]
([class_div_code],[class_div_name],[area_code],[factory_code])
SELECT [class_div_code],[class_div_name],[area_code],[factory_code]
FROM [CMMS_ELE].[dbo].[class_div_master] a
where not exists ( select * from [CMMS].[dbo].[class_div_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.class_div_code = b.class_div_code )

--2.1 cmms_wo_cost_sum
GO
TRUNCATE TABLE [CMMS].[dbo].[cmms_wo_cost_sum]

GO
INSERT INTO [CMMS].[dbo].[cmms_wo_cost_sum]
           ([area_code]
           ,[factory_code]
           ,[wo_date]
           ,[cc_code]
           ,[part_cost_sum]
           ,[repair_cost_sum])
select [area_code]
           ,[factory_code]
           ,[wo_date]
           ,[cc_code]
           ,[part_cost_sum]
           ,[repair_cost_sum]
from [CMMS_ELE].[dbo].[cmms_wo_cost_sum] a
where not exists ( select * from [CMMS].[dbo].[cmms_wo_cost_sum] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_date = b.wo_date and a.cc_code = b.cc_code )

--2.2 cmms_wo_sum
GO
TRUNCATE TABLE [CMMS].[dbo].[cmms_wo_sum]

GO
INSERT INTO [CMMS].[dbo].[cmms_wo_sum]
           ([area_code]
           ,[factory_code]
           ,[wo_date]
           ,[cc_code]
           ,[wo_firm_time_sum]
           ,[wo_time_sum]
           ,[wo_count])
select [area_code]
           ,[factory_code]
           ,[wo_date]
           ,[cc_code]
           ,[wo_firm_time_sum]
           ,[wo_time_sum]
           ,[wo_count]
from [CMMS_ELE].[dbo].[cmms_wo_sum] a
where not exists ( select * from [CMMS].[dbo].[cmms_wo_sum] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_date = b.wo_date and a.cc_code = b.cc_code )

-- 2.3 comp_div_master
GO
TRUNCATE TABLE [CMMS].[dbo].[comp_div_master]

GO
INSERT INTO [CMMS].[dbo].[comp_div_master]
           ([comp_div_code]
           ,[comp_div_name])
select [comp_div_code]
           ,[comp_div_name]
from [CMMS_ELE].[dbo].[comp_div_master] a
where not exists ( select * from [CMMS].[dbo].[comp_div_master] b
    where a.comp_div_code = b.comp_div_code )

-- 2.4 comp_master
GO
TRUNCATE TABLE [CMMS].[dbo].[comp_master]

GO
INSERT INTO [CMMS].[dbo].[comp_master]
           ([comp_code]
           ,[comp_name]
           ,[comp_div_code1]
           ,[comp_div_code2]
           ,[comp_div_code3]
           ,[comp_address]
           ,[comp_boss]
           ,[comp_homepage]
           ,[comp_zipcode]
           ,[comp_regno]
           ,[comp_dept]
           ,[comp_contact]
           ,[comp_phone]
           ,[comp_hphone]
           ,[comp_fax]
           ,[comp_email]
           ,[comp_remark])
select [comp_code]
           ,[comp_name]
           ,[comp_div_code1]
           ,[comp_div_code2]
           ,[comp_div_code3]
           ,[comp_address]
           ,[comp_boss]
           ,[comp_homepage]
           ,[comp_zipcode]
           ,[comp_regno]
           ,[comp_dept]
           ,[comp_contact]
           ,[comp_phone]
           ,[comp_hphone]
           ,[comp_fax]
           ,[comp_email]
           ,[comp_remark]
from [CMMS_ELE].[dbo].[comp_master] a
where not exists ( select * from [CMMS].[dbo].[comp_master] b
    where a.comp_code = b.comp_code )

-- 2.5 comp_part
GO
TRUNCATE TABLE [CMMS].[dbo].[comp_part]

GO
INSERT INTO [CMMS].[dbo].[comp_part]
           ([comp_code]
           ,[part_code])
select [comp_code]
           ,[part_code]
from [CMMS_ELE].[dbo].[comp_part] a
where not exists ( select * from [CMMS].[dbo].[comp_part] b
    where a.comp_code = b.comp_code and a.part_code = b.part_code )

-- 2.6 comp_service
GO
TRUNCATE TABLE [CMMS].[dbo].[comp_service]

GO
INSERT INTO [CMMS].[dbo].[comp_service]
           ([comp_code]
           ,[comp_service_name]
           ,[comp_hour_value]
           ,[comp_work_value])
select [comp_code]
           ,[comp_service_name]
           ,[comp_hour_value]
           ,[comp_work_value]
from [CMMS_ELE].[dbo].[comp_service] a
where not exists ( select * from [CMMS].[dbo].[comp_service] b
    where a.comp_code = b.comp_code and a.comp_service_name = b.comp_service_name )

-- 3. cycle_master
GO
TRUNCATE TABLE [CMMS].[dbo].[cycle_master]

GO
INSERT INTO [CMMS].[dbo].[cycle_master]
([cycle_code],[cycle_name],[area_code],[factory_code])
SELECT [cycle_code],[cycle_name],[area_code],[factory_code]
FROM [CMMS_ELE].[dbo].[cycle_master] a
where not exists ( select * from [CMMS].[dbo].[cycle_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.cycle_code = b.cycle_code )

-- 3.01 dept_master
GO
TRUNCATE TABLE [CMMS].[dbo].[dept_master]

GO
INSERT INTO [CMMS].[dbo].[dept_master]
           ([dept_code]
           ,[dept_name])
select [dept_code]
           ,[dept_name]
FROM [CMMS_ELE].[dbo].[dept_master] a
where not exists ( select * from [CMMS].[dbo].[dept_master] b
    where a.dept_code = b.dept_code )

-- 3.1 emp_certify
GO
TRUNCATE TABLE [CMMS].[dbo].[emp_certify]

GO
INSERT INTO [CMMS].[dbo].[emp_certify]
([emp_code],[certify_name],[certify_rank],[certify_number],[certify_institution],
[certify_expire],[area_code],[factory_code])
SELECT [emp_code],[certify_name],[certify_rank],[certify_number],[certify_institution],
[certify_expire],[area_code],[factory_code]
FROM [CMMS_ELE].[dbo].[emp_certify] a
where not exists ( select * from [CMMS].[dbo].[emp_certify] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.emp_code = b.emp_code and a.certify_name = b.certify_name and 
      a.certify_rank = b.certify_rank )

-- 3.2 emp_edu
GO
TRUNCATE TABLE [CMMS].[dbo].[emp_edu]

GO
INSERT INTO [CMMS].[dbo].[emp_edu]
([emp_code],[edu_name],[edu_descript],[edu_institution],[edu_start_date],
[edu_end_date],[edu_status],[edu_value],[edu_remark],
[area_code],[factory_code])
SELECT [emp_code],[edu_name],[edu_descript],[edu_institution],[edu_start_date],
[edu_end_date],[edu_status],[edu_value],[edu_remark],
[area_code],[factory_code]
FROM [CMMS_ELE].[dbo].[emp_edu] a
where not exists ( select * from [CMMS].[dbo].[emp_edu] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.emp_code = b.emp_code and a.edu_name = b.edu_name and 
      a.edu_start_date = b.edu_start_date )

-- 3.3 emp_master
GO
TRUNCATE TABLE [CMMS].[dbo].[emp_master]

GO
INSERT INTO [CMMS].[dbo].[emp_master]
           ([emp_code]
           ,[emp_name]
           ,[emp_enter_date]
           ,[area_code]
           ,[factory_code]
           ,[dept_code]
           ,[section_code]
           ,[title_code]
           ,[skill_code]
           ,[team_code]
           ,[emp_zipcode]
           ,[emp_address]
           ,[emp_phone]
           ,[emp_hphone]
           ,[emp_email]
           ,[emp_remark]
           ,[emp_pass]
           ,[pic_path])
select [emp_code]
           ,[emp_name]
           ,[emp_enter_date]
           ,[area_code]
           ,[factory_code]
           ,[dept_code]
           ,[section_code]
           ,[title_code]
           ,[skill_code]
           ,[team_code]
           ,[emp_zipcode]
           ,[emp_address]
           ,[emp_phone]
           ,[emp_hphone]
           ,[emp_email]
           ,[emp_remark]
           ,[emp_pass]
           ,[pic_path]
FROM [CMMS_ELE].[dbo].[emp_master] a
where not exists ( select * from [CMMS].[dbo].[emp_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.emp_code = b.emp_code )

-- 4. equip_change
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_change]

GO
INSERT INTO [CMMS].[dbo].[equip_change]
([equip_code],[change_date],[change_descript],[change_remark],[area_code],[factory_code])
SELECT [equip_code],[change_date],[change_descript],[change_remark],[area_code],[factory_code]
FROM [CMMS_ELE].[dbo].[equip_change] a
where not exists ( select * from [CMMS].[dbo].[equip_change] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.change_date = b.change_date )

-- 5. equip_class
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_class]

GO
INSERT INTO [CMMS].[dbo].[equip_class]
([equip_code],[class_div],[class_spot],[class_item],[class_basis],[class_process],[class_cycle],[cycle_code],[class_est_date],
[class_est_time_hour],[class_est_time_min],[part_code],[class_qty],[area_code],[factory_code])
SELECT [equip_code],[class_div],[class_spot],[class_item],[class_basis],[class_process],[class_cycle],[cycle_code],[class_est_date],
[class_est_time_hour],[class_est_time_min],[part_code],[class_qty],[area_code],[factory_code]
FROM [CMMS_ELE].[dbo].[equip_class] a
where not exists ( select * from [CMMS].[dbo].[equip_class] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.class_div = b.class_div and
      a.class_spot = b.class_spot and a.class_item = b.class_item )

-- 5.1 equip_count
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_count]

GO
INSERT INTO [CMMS].[dbo].[equip_count]
           ([area_code]
           ,[factory_code]
           ,[equip_count])
select [area_code]
           ,[factory_code]
           ,[equip_count]
FROM [CMMS_ELE].[dbo].[equip_count] a
where not exists ( select * from [CMMS].[dbo].[equip_count] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code )

-- 6. equip_daily_01
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_daily_01]

GO
INSERT INTO [CMMS].[dbo].[equip_daily_01]
([equip_code]
,[daily_div]
,[daily_order]
,[descript]
,[area_code]
,[factory_code])
SELECT [equip_code]
,[daily_div]
,[daily_order]
,[descript]
,[area_code]
,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_daily_01] a
where not exists ( select * from [CMMS].[dbo].[equip_daily_01] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.daily_div = b.daily_div and
      a.daily_order = b.daily_order )

-- 7. equip_daily_02
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_daily_02]

GO
INSERT INTO [CMMS].[dbo].[equip_daily_02]
           ([equip_code]
           ,[daily_div]
           ,[daily_order]
           ,[descript]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[daily_div]
           ,[daily_order]
           ,[descript]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_daily_02] a
where not exists ( select * from [CMMS].[dbo].[equip_daily_02] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.daily_div = b.daily_div and
      a.daily_order = b.daily_order )

-- 8. equip_daily_03
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_daily_03]

GO
INSERT INTO [CMMS].[dbo].[equip_daily_03]
           ([equip_code]
           ,[daily_div]
           ,[daily_order]
           ,[descript]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[daily_div]
           ,[daily_order]
           ,[descript]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_daily_03] a
where not exists ( select * from [CMMS].[dbo].[equip_daily_03] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.daily_div = b.daily_div and
      a.daily_order = b.daily_order )

-- 9. equip_div_a
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_div_a]

GO
INSERT INTO [CMMS].[dbo].[equip_div_a]
           ([equip_div_a_code]
           ,[equip_div_a_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_div_a_code]
           ,[equip_div_a_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_div_a] a
where not exists ( select * from [CMMS].[dbo].[equip_div_a] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_div_a_code = b.equip_div_a_code )

-- 10. equip_div_b
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_div_b]

GO
INSERT INTO [CMMS].[dbo].[equip_div_b]
           ([equip_div_a_code]
           ,[equip_div_b_code]
           ,[equip_div_b_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_div_a_code]
           ,[equip_div_b_code]
           ,[equip_div_b_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_div_b] a
where not exists ( select * from [CMMS].[dbo].[equip_div_b] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_div_a_code = b.equip_div_a_code and a.equip_div_b_code = b.equip_div_b_code )

-- 11. equip_div_master
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_div_master]

GO
INSERT INTO [CMMS].[dbo].[equip_div_master]
           ([equip_div_code]
           ,[equip_div_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_div_code]
           ,[equip_div_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_div_master] a
where not exists ( select * from [CMMS].[dbo].[equip_div_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_div_code = b.equip_div_code )

-- 12. equip_file
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_file]

GO
INSERT INTO [CMMS].[dbo].[equip_file]
           ([equip_code]
           ,[equip_file_code]
           ,[equip_file_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[equip_file_code]
           ,[equip_file_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_file] a
where not exists ( select * from [CMMS].[dbo].[equip_file] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.equip_file_code = b.equip_file_code )

-- 12.1 equip_ftpfile
GO
TRUNCATE TABLE [CMMS].[dbo].[EQUIP_FTPFILE]

GO
INSERT INTO [CMMS].[dbo].[EQUIP_FTPFILE]
           ([File_id]
           ,[Area_code]
           ,[Factory_code]
           ,[Equip_code]
           ,[File_name]
           ,[File_desc]
           ,[File_size]
           ,[LastEmp]
           ,[LastDate])
select [File_id]
           ,[Area_code]
           ,[Factory_code]
           ,[Equip_code]
           ,[File_name]
           ,[File_desc]
           ,[File_size]
           ,[LastEmp]
           ,[LastDate]
FROM [CMMS_ELE].[dbo].[EQUIP_FTPFILE] a
where not exists ( select * from [CMMS].[dbo].[EQUIP_FTPFILE] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.File_id = b.File_id )

-- 12.2 equip_ftpuser
GO
TRUNCATE TABLE [CMMS].[dbo].[EQUIP_FTPUSER]

GO
INSERT INTO [CMMS].[dbo].[EQUIP_FTPUSER]
           ([AREA_CODE]
           ,[FACTORY_CODE]
           ,[USER_ID]
           ,[USER_PW]
           ,[DEL_PW]
           ,[FTP_MAXSIZE]
           ,[TABU_FILE]
           ,[LASTEMP]
           ,[LASTDATE])
select [AREA_CODE]
           ,[FACTORY_CODE]
           ,[USER_ID]
           ,[USER_PW]
           ,[DEL_PW]
           ,[FTP_MAXSIZE]
           ,[TABU_FILE]
           ,[LASTEMP]
           ,[LASTDATE]
FROM [CMMS_ELE].[dbo].[EQUIP_FTPUSER] a
where not exists ( select * from [CMMS].[dbo].[EQUIP_FTPUSER] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code )

-- 13. equip_guide
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_guide]

GO
INSERT INTO [CMMS].[dbo].[equip_guide]
           ([equip_code]
           ,[guide_code]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[guide_code]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_guide] a
where not exists ( select * from [CMMS].[dbo].[equip_guide] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.guide_code = b.guide_code )

-- 13.1 equip_guide_code
GO
TRUNCATE TABLE [CMMS].[dbo].[EQUIP_GUIDE_CODE]

GO
INSERT INTO [CMMS].[dbo].[EQUIP_GUIDE_CODE]
           ([GUIDE_CODE])
select [GUIDE_CODE]
FROM [CMMS_ELE].[dbo].[EQUIP_GUIDE_CODE] a
where not exists ( select * from [CMMS].[dbo].[EQUIP_GUIDE_CODE] b
    where a.GUIDE_CODE = b.GUIDE_CODE )

-- 14. equip_list
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_list]

GO
INSERT INTO [CMMS].[dbo].[equip_list]
           ([equip_code]
           ,[list_order]
           ,[list_name]
           ,[list_descript]
           ,[list_date]
           ,[list_location]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[list_order]
           ,[list_name]
           ,[list_descript]
           ,[list_date]
           ,[list_location]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_list] a
where not exists ( select * from [CMMS].[dbo].[equip_list] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.list_order = b.list_order )

-- 14.1 equip_master
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_master]

GO
INSERT INTO [CMMS].[dbo].[equip_master]
           ([equip_code]
           ,[equip_name]
           ,[asset_code]
           ,[equip_div_code]
           ,[equip_spec]
           ,[equip_use]
           ,[cc_code]
           ,[line_code]
           ,[dept_code]
           ,[equip_short_name]
           ,[equip_install_date]
           ,[equip_cost]
           ,[equip_year]
           ,[equip_process_number]
           ,[equip_dep_cost]
           ,[equip_remain_cost]
           ,[dept_code_op]
           ,[dept_code_use]
           ,[comp_code_vender]
           ,[comp_code_agent]
           ,[equip_pwr_v]
           ,[equip_pwr_p]
           ,[equip_pwr_kva]
           ,[equip_air]
           ,[equip_water_iw]
           ,[equip_water_pw]
           ,[equip_water_cw]
           ,[equip_water_mh]
           ,[equip_steam]
           ,[equip_gas]
           ,[equip_etc]
           ,[equip_weight]
           ,[equip_width]
           ,[equip_length]
           ,[equip_height]
           ,[area_code]
           ,[factory_code]
           ,[target_area]
           ,[target_factory])
select [equip_code]
           ,[equip_name]
           ,[asset_code]
           ,[equip_div_code]
           ,[equip_spec]
           ,[equip_use]
           ,[cc_code]
           ,[line_code]
           ,[dept_code]
           ,[equip_short_name]
           ,[equip_install_date]
           ,[equip_cost]
           ,[equip_year]
           ,[equip_process_number]
           ,[equip_dep_cost]
           ,[equip_remain_cost]
           ,[dept_code_op]
           ,[dept_code_use]
           ,[comp_code_vender]
           ,[comp_code_agent]
           ,[equip_pwr_v]
           ,[equip_pwr_p]
           ,[equip_pwr_kva]
           ,[equip_air]
           ,[equip_water_iw]
           ,[equip_water_pw]
           ,[equip_water_cw]
           ,[equip_water_mh]
           ,[equip_steam]
           ,[equip_gas]
           ,[equip_etc]
           ,[equip_weight]
           ,[equip_width]
           ,[equip_length]
           ,[equip_height]
           ,[area_code]
           ,[factory_code]
           ,[target_area]
           ,[target_factory]
FROM [CMMS_ELE].[dbo].[equip_master] a
where not exists ( select * from [CMMS].[dbo].[equip_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and a.equip_code = b.equip_code )

-- 14.2 equip_master_upload
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_master_upload]

GO
INSERT INTO [CMMS].[dbo].[equip_master_upload]
           ([area_code]
           ,[factory_code]
           ,[equip_code]
           ,[equip_name]
           ,[asset_code]
           ,[equip_div_code]
           ,[equip_spec]
           ,[equip_use]
           ,[cc_code]
           ,[line_code]
           ,[equip_short_name]
           ,[equip_install_date]
           ,[equip_process_number]
           ,[dept_code_op]
           ,[dept_code_use]
           ,[comp_code_vender]
           ,[comp_code_agent]
           ,[input_div]
           ,[up_div]
           ,[last_dttm])
select [area_code]
           ,[factory_code]
           ,[equip_code]
           ,[equip_name]
           ,[asset_code]
           ,[equip_div_code]
           ,[equip_spec]
           ,[equip_use]
           ,[cc_code]
           ,[line_code]
           ,[equip_short_name]
           ,[equip_install_date]
           ,[equip_process_number]
           ,[dept_code_op]
           ,[dept_code_use]
           ,[comp_code_vender]
           ,[comp_code_agent]
           ,[input_div]
           ,[up_div]
           ,[last_dttm]
FROM [CMMS_ELE].[dbo].[equip_master_upload] a
where a.[up_div] <> 'Y' and not exists ( select * from [CMMS].[dbo].[equip_master_upload] b
    where a.equip_code = b.equip_code )

-- 15. equip_meter
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_meter]

GO
INSERT INTO [CMMS].[dbo].[equip_meter]
           ([equip_code]
           ,[meter_code]
           ,[meter_date]
           ,[meter_value]
           ,[meter_svalue]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[meter_code]
           ,[meter_date]
           ,[meter_value]
           ,[meter_svalue]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_meter] a
where not exists ( select * from [CMMS].[dbo].[equip_meter] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.meter_code = b.meter_code )

-- 16. equip_meter_master
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_meter_master]

GO
INSERT INTO [CMMS].[dbo].[equip_meter_master]
           ([equip_code]
           ,[meter_code]
           ,[meter_unit]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[meter_code]
           ,[meter_unit]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_meter_master] a
where not exists ( select * from [CMMS].[dbo].[equip_meter_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.meter_code = b.meter_code )

-- 16.1 equip_safe
GO
TRUNCATE TABLE [CMMS].[dbo].[equip_safe]

GO
INSERT INTO [CMMS].[dbo].[equip_safe]
           ([equip_code]
           ,[equip_safe]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[equip_safe]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[equip_safe] a
where not exists ( select * from [CMMS].[dbo].[equip_safe] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code )
-- 16.2 equip_spare
GO
TRUNCATE TABLE [CMMS].[dbo].[EQUIP_SPARE]

GO
INSERT INTO [CMMS].[dbo].[EQUIP_SPARE]
           ([Area_code]
           ,[Factory_code]
           ,[Equip_code]
           ,[Part_code]
           ,[Part_qty]
           ,[Part_flag]
           ,[Spare_desc])
select [Area_code]
           ,[Factory_code]
           ,[Equip_code]
           ,[Part_code]
           ,[Part_qty]
           ,[Part_flag]
           ,[Spare_desc]
FROM [CMMS_ELE].[dbo].[EQUIP_SPARE] a
where not exists ( select * from [CMMS].[dbo].[EQUIP_SPARE] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.Part_code = b.Part_code )

-- 17. guide_master
GO
TRUNCATE TABLE [CMMS].[dbo].[guide_master]

GO
INSERT INTO [CMMS].[dbo].[guide_master]
           ([guide_code]
           ,[guide_name]
           ,[guide_descript]
           ,[area_code]
           ,[factory_code])
SELECT [guide_code]
           ,[guide_name]
           ,[guide_descript]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[guide_master] a
where not exists ( select * from [CMMS].[dbo].[guide_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.guide_code = b.guide_code )

-- 17.1 INVMASTER
GO
TRUNCATE TABLE [CMMS].[dbo].[INVMASTER]

GO
INSERT INTO [CMMS].[dbo].[INVMASTER]
           ([logid]
           ,[CHGDATE]
           ,[CHGCD]
           ,[XPLANT]
           ,[DIV]
           ,[PDCD]
           ,[ITNO]
           ,[CLS]
           ,[SRCE]
           ,[XUNIT]
           ,[CONVQTY]
           ,[SAUD]
           ,[ABCCD]
           ,[WLOC]
           ,[XPLAN]
           ,[MCNO]
           ,[STSCD]
           ,[DOWNDATE])
select [logid]
           ,[CHGDATE]
           ,[CHGCD]
           ,[XPLANT]
           ,[DIV]
           ,[PDCD]
           ,[ITNO]
           ,[CLS]
           ,[SRCE]
           ,[XUNIT]
           ,[CONVQTY]
           ,[SAUD]
           ,[ABCCD]
           ,[WLOC]
           ,[XPLAN]
           ,[MCNO]
           ,[STSCD]
           ,[DOWNDATE]
FROM [CMMS_ELE].[dbo].[INVMASTER] a
where a.STSCD = 'N'

-- 17.2 invtrans
GO
TRUNCATE TABLE [CMMS].[dbo].[INVTRANS]

GO
INSERT INTO [CMMS].[dbo].[INVTRANS]
           ([logid]
           ,[CHGDATE]
           ,[CHGCD]
           ,[SLIPTYPE]
           ,[SRNO]
           ,[SRNO1]
           ,[SRNO2]
           ,[XPLANT]
           ,[DIV]
           ,[ITNO]
           ,[INVSTCD]
           ,[TQTY4]
           ,[INVSTCD1]
           ,[SLIPGUBUN]
           ,[STSCD]
           ,[DOWNDATE])
select [logid]
           ,[CHGDATE]
           ,[CHGCD]
           ,[SLIPTYPE]
           ,[SRNO]
           ,[SRNO1]
           ,[SRNO2]
           ,[XPLANT]
           ,[DIV]
           ,[ITNO]
           ,[INVSTCD]
           ,[TQTY4]
           ,[INVSTCD1]
           ,[SLIPGUBUN]
           ,[STSCD]
           ,[DOWNDATE]
FROM [CMMS_ELE].[dbo].[INVTRANS] a
where a.STSCD = 'N'

-- 17.3 line_master
GO
TRUNCATE TABLE [CMMS].[dbo].[LINE_MASTER]

GO
INSERT INTO [CMMS].[dbo].[LINE_MASTER]
           ([area_code]
           ,[factory_code]
           ,[line_code]
           ,[line_name]
           ,[lastemp]
           ,[lastdate])
select [area_code]
           ,[factory_code]
           ,[line_code]
           ,[line_name]
           ,[lastemp]
           ,[lastdate]
FROM [CMMS_ELE].[dbo].[LINE_MASTER] a
where not exists ( select * from [CMMS].[dbo].[LINE_MASTER] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.line_code = b.line_code )

-- 18. numbering
GO
TRUNCATE TABLE [CMMS].[dbo].[numbering]

GO
INSERT INTO [CMMS].[dbo].[numbering]
           ([number_div]
           ,[number_order]
           ,[area_code]
           ,[factory_code])
SELECT [number_div]
           ,[number_order]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[numbering] a
where not exists ( select * from [CMMS].[dbo].[numbering] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.number_div = b.number_div )

-- 18.1 part_buyback
GO
TRUNCATE TABLE [CMMS].[dbo].[part_buyback]

GO
INSERT INTO [CMMS].[dbo].[part_buyback]
           ([AreaCode]
           ,[DivisionCode]
           ,[BuyBackNo]
           ,[BuyBackDept]
           ,[BuyBackSupplier]
           ,[BuyBackEmp]
           ,[BuyBackTime]
           ,[BuyBackDate]
           ,[ApprovalEmp]
           ,[ApprovalTime]
           ,[CarNo]
           ,[TakingName]
           ,[OutEmp]
           ,[OutTime]
           ,[StatusFlag]
           ,[BuyBackFlag]
           ,[Remark01]
           ,[Remark02]
           ,[BackCheck]
           ,[LastEmp]
           ,[LastDate])
select [AreaCode]
           ,[DivisionCode]
           ,[BuyBackNo]
           ,[BuyBackDept]
           ,[BuyBackSupplier]
           ,[BuyBackEmp]
           ,[BuyBackTime]
           ,[BuyBackDate]
           ,[ApprovalEmp]
           ,[ApprovalTime]
           ,[CarNo]
           ,[TakingName]
           ,[OutEmp]
           ,[OutTime]
           ,[StatusFlag]
           ,[BuyBackFlag]
           ,[Remark01]
           ,[Remark02]
           ,[BackCheck]
           ,[LastEmp]
           ,[LastDate]
FROM [CMMS_ELE].[dbo].[part_buyback] a
where not exists ( select * from [CMMS].[dbo].[part_buyback] b
    where a.AreaCode = b.AreaCode and a.DivisionCode = b.DivisionCode and
      a.BuyBackNo = b.BuyBackNo and a.BuyBackDept = b.BuyBackDept )

-- 18.2 part_in
GO
TRUNCATE TABLE [CMMS].[dbo].[part_in]

GO
INSERT INTO [CMMS].[dbo].[part_in]
           ([area_code]
           ,[factory_code]
           ,[part_code]
           ,[in_qty]
           ,[part_tag]
           ,[in_div]
           ,[down_div])
select [area_code]
           ,[factory_code]
           ,[part_code]
           ,[in_qty]
           ,[part_tag]
           ,[in_div]
           ,[down_div]
FROM [CMMS_ELE].[dbo].[part_in] a
where not exists ( select * from [CMMS].[dbo].[part_in] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code )

-- 18.3 part_master
GO
TRUNCATE TABLE [CMMS].[dbo].[part_master]

GO
INSERT INTO [CMMS].[dbo].[part_master]
           ([area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[normal_qty]
           ,[repair_qty]
           ,[etc_qty]
           ,[scram_qty]
           ,[MAXQ]
           ,[MINQ]
           ,[part_unit]
           ,[part_cost]
           ,[comp_code]
           ,[part_location])
select [area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[normal_qty]
           ,[repair_qty]
           ,[etc_qty]
           ,[scram_qty]
           ,[MAXQ]
           ,[MINQ]
           ,[part_unit]
           ,[part_cost]
           ,[comp_code]
           ,[part_location]
FROM [CMMS_ELE].[dbo].[part_master] a
where not exists ( select * from [CMMS].[dbo].[part_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code )

-- 18.4 part_master_in
GO
TRUNCATE TABLE [CMMS].[dbo].[part_master_in]

GO
INSERT INTO [CMMS].[dbo].[part_master_in]
           ([area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[part_unit]
           ,[part_cost]
           ,[comp_code]
           ,[down_div])
select [area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[part_unit]
           ,[part_cost]
           ,[comp_code]
           ,[down_div]
FROM [CMMS_ELE].[dbo].[part_master_in] a
where not exists ( select * from [CMMS].[dbo].[part_master_in] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code )

-- 18.5 part_master_real
GO
TRUNCATE TABLE [CMMS].[dbo].[part_master_real]

GO
INSERT INTO [CMMS].[dbo].[part_master_real]
           ([part_location]
           ,[area_code]
           ,[factory_code]
           ,[part_code]
           ,[comp_code]
           ,[part_name]
           ,[part_spec]
           ,[normal_qty]
           ,[repair_qty]
           ,[etc_qty]
           ,[scram_qty]
           ,[part_unit]
           ,[part_cost])
select [part_location]
           ,[area_code]
           ,[factory_code]
           ,[part_code]
           ,[comp_code]
           ,[part_name]
           ,[part_spec]
           ,[normal_qty]
           ,[repair_qty]
           ,[etc_qty]
           ,[scram_qty]
           ,[part_unit]
           ,[part_cost]
FROM [CMMS_ELE].[dbo].[part_master_real] a

-- 18.6 part_out
GO
TRUNCATE TABLE [CMMS].[dbo].[part_out]

GO
INSERT INTO [CMMS].[dbo].[part_out]
           ([area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_tag]
           ,[wo_code]
           ,[dept_code]
           ,[part_used]
           ,[equip_code]
           ,[out_date]
           ,[invy_state]
           ,[out_qty]
           ,[out_serial]
           ,[input_div]
           ,[up_div]
           ,[buybackno]
           ,[buybackflag])
select [area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_tag]
           ,[wo_code]
           ,[dept_code]
           ,[part_used]
           ,[equip_code]
           ,[out_date]
           ,[invy_state]
           ,[out_qty]
           ,[out_serial]
           ,[input_div]
           ,[up_div]
           ,[buybackno]
           ,[buybackflag]
FROM [CMMS_ELE].[dbo].[part_out] a
where not exists ( select * from [CMMS].[dbo].[part_out] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code and a.part_tag = b.part_tag )

-- 18.7 part_out_hist
GO
TRUNCATE TABLE [CMMS].[dbo].[PART_OUT_HIST]

GO
INSERT INTO [CMMS].[dbo].[PART_OUT_HIST]
           ([EQUIP_CODE]
           ,[PART_CODE]
           ,[PART_NAME]
           ,[PART_SPEC]
           ,[LASTDATE]
           ,[AREA_CODE]
           ,[FACTORY_CODE])
select [EQUIP_CODE]
           ,[PART_CODE]
           ,[PART_NAME]
           ,[PART_SPEC]
           ,[LASTDATE]
           ,[AREA_CODE]
           ,[FACTORY_CODE]
FROM [CMMS_ELE].[dbo].[PART_OUT_HIST] a
where not exists ( select * from [CMMS].[dbo].[PART_OUT_HIST] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code and a.EQUIP_CODE = b.EQUIP_CODE and
      a.LASTDATE = b.LASTDATE )

-- 18.8 part_out_temp
GO
TRUNCATE TABLE [CMMS].[dbo].[part_out_temp]

GO
INSERT INTO [CMMS].[dbo].[part_out_temp]
           ([scandate]
           ,[area_code]
           ,[factory_code]
           ,[part_code]
           ,[flag]
           ,[stscd]
           ,[out_qty]
           ,[inptid]
           ,[inptdt]
           ,[updtid]
           ,[updtdt]
           ,[ipaddr]
           ,[macaddr])
select [scandate]
           ,[area_code]
           ,[factory_code]
           ,[part_code]
           ,[flag]
           ,[stscd]
           ,[out_qty]
           ,[inptid]
           ,[inptdt]
           ,[updtid]
           ,[updtdt]
           ,[ipaddr]
           ,[macaddr]
FROM [CMMS_ELE].[dbo].[part_out_temp] a
where not exists ( select * from [CMMS].[dbo].[part_out_temp] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code and a.scandate = b.scandate )

-- 18.9 part_return
GO
TRUNCATE TABLE [CMMS].[dbo].[part_return]

GO
INSERT INTO [CMMS].[dbo].[part_return]
           ([area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_tag]
           ,[wo_code]
           ,[dept_code]
           ,[part_used]
           ,[equip_code]
           ,[return_date]
           ,[invy_state]
           ,[return_qty]
           ,[return_serial]
           ,[input_div]
           ,[up_div])
select [area_code]
           ,[factory_code]
           ,[part_code]
           ,[part_tag]
           ,[wo_code]
           ,[dept_code]
           ,[part_used]
           ,[equip_code]
           ,[return_date]
           ,[invy_state]
           ,[return_qty]
           ,[return_serial]
           ,[input_div]
           ,[up_div]
FROM [CMMS_ELE].[dbo].[part_return] a
where not exists ( select * from [CMMS].[dbo].[part_return] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.part_code = b.part_code and a.part_tag = b.part_tag )

-- 19. process_master
GO
TRUNCATE TABLE [CMMS].[dbo].[process_master]

GO
INSERT INTO [CMMS].[dbo].[process_master]
           ([process_code]
           ,[process_name]
           ,[area_code]
           ,[factory_code])
SELECT [process_code]
           ,[process_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[process_master] a
where not exists ( select * from [CMMS].[dbo].[process_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.process_code = b.process_code )

-- 20. sched_div_master
GO
TRUNCATE TABLE [CMMS].[dbo].[sched_div_master]

GO
INSERT INTO [CMMS].[dbo].[sched_div_master]
           ([sched_div_code]
           ,[sched_div_name]
           ,[area_code]
           ,[factory_code])
SELECT [sched_div_code]
           ,[sched_div_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[sched_div_master] a
where not exists ( select * from [CMMS].[dbo].[sched_div_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.sched_div_code = b.sched_div_code )

-- 21. schedule_next
GO
TRUNCATE TABLE [CMMS].[dbo].[schedule_next]

GO
INSERT INTO [CMMS].[dbo].[schedule_next]
           ([equip_code]
           ,[class_div]
           ,[class_spot]
           ,[class_item]
           ,[class_basis]
           ,[class_process]
           ,[class_cycle]
           ,[cycle_code]
           ,[class_est_date]
           ,[class_est_time_hour]
           ,[class_est_time_min]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[class_qty]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[class_div]
           ,[class_spot]
           ,[class_item]
           ,[class_basis]
           ,[class_process]
           ,[class_cycle]
           ,[cycle_code]
           ,[class_est_date]
           ,[class_est_time_hour]
           ,[class_est_time_min]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[class_qty]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[schedule_next] a
where not exists ( select * from [CMMS].[dbo].[schedule_next] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.class_div = b.class_div and
      a.class_spot = b.class_spot and a.class_item = b.class_item and
      a.class_est_date = b.class_est_date )

-- 22. schedule_next2
GO
TRUNCATE TABLE [CMMS].[dbo].[schedule_next2]

GO
INSERT INTO [CMMS].[dbo].[schedule_next2]
           ([equip_code]
           ,[class_div]
           ,[class_spot]
           ,[class_item]
           ,[class_basis]
           ,[class_process]
           ,[class_cycle]
           ,[cycle_code]
           ,[class_est_date]
           ,[class_est_time_hour]
           ,[class_est_time_min]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[class_qty]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[class_div]
           ,[class_spot]
           ,[class_item]
           ,[class_basis]
           ,[class_process]
           ,[class_cycle]
           ,[cycle_code]
           ,[class_est_date]
           ,[class_est_time_hour]
           ,[class_est_time_min]
           ,[part_code]
           ,[part_name]
           ,[part_spec]
           ,[class_qty]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[schedule_next2] a
where not exists ( select * from [CMMS].[dbo].[schedule_next2] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.equip_code = b.equip_code and a.class_div = b.class_div and
      a.class_spot = b.class_spot and a.class_item = b.class_item and
      a.class_est_date = b.class_est_date )

-- 23. section_master
GO
TRUNCATE TABLE [CMMS].[dbo].[section_master]

GO
INSERT INTO [CMMS].[dbo].[section_master]
           ([section_code]
           ,[section_name]
           ,[area_code]
           ,[factory_code])
SELECT [section_code]
           ,[section_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[section_master] a
where not exists ( select * from [CMMS].[dbo].[section_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.section_code = b.section_code )

-- 24. serial
GO
TRUNCATE TABLE [CMMS].[dbo].[serial]

GO
INSERT INTO [CMMS].[dbo].[serial]
           ([serial_div]
           ,[serlal_no]
           ,[area_code]
           ,[factory_code])
SELECT [serial_div]
           ,[serlal_no]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[serial] a
where not exists ( select * from [CMMS].[dbo].[serial] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.serial_div = b.serial_div )

-- 25. setup
GO
TRUNCATE TABLE [CMMS].[dbo].[setup]

GO
INSERT INTO [CMMS].[dbo].[setup]
           ([work_fee]
           ,[area_code]
           ,[factory_code])
SELECT [work_fee]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[setup] a
where not exists ( select * from [CMMS].[dbo].[setup] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code )

-- 26. skill_master
GO
TRUNCATE TABLE [CMMS].[dbo].[skill_master]

GO
INSERT INTO [CMMS].[dbo].[skill_master]
           ([skill_code]
           ,[skill_name]
           ,[area_code]
           ,[factory_code])
SELECT [skill_code]
           ,[skill_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[skill_master] a
where not exists ( select * from [CMMS].[dbo].[skill_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.skill_code = b.skill_code )

-- 27. status_master
GO
TRUNCATE TABLE [CMMS].[dbo].[status_master]

GO
INSERT INTO [CMMS].[dbo].[status_master]
           ([status_code]
           ,[status_name]
           ,[area_code]
           ,[factory_code])
SELECT [status_code]
           ,[status_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[status_master] a
where not exists ( select * from [CMMS].[dbo].[status_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.status_code = b.status_code )

-- 27.1 task
GO
TRUNCATE TABLE [CMMS].[dbo].[task]

GO
INSERT INTO [CMMS].[dbo].[task]
           ([task_code]
           ,[equip_code]
           ,[task_cycle]
           ,[cycle_code]
           ,[emp_code]
           ,[exam_date]
           ,[task_est_date]
           ,[status_code]
           ,[start_date]
           ,[end_date]
           ,[task_time_hour]
           ,[task_time_min]
           ,[area_code]
           ,[factory_code]
           ,[task_remark])
select [task_code]
           ,[equip_code]
           ,[task_cycle]
           ,[cycle_code]
           ,[emp_code]
           ,[exam_date]
           ,[task_est_date]
           ,[status_code]
           ,[start_date]
           ,[end_date]
           ,[task_time_hour]
           ,[task_time_min]
           ,[area_code]
           ,[factory_code]
           ,[task_remark]
FROM [CMMS_ELE].[dbo].[task] a
where not exists ( select * from [CMMS].[dbo].[task] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.task_code = b.task_code )

-- 28. task_autonumber
GO
TRUNCATE TABLE [CMMS].[dbo].[task_autonumber]

GO
INSERT INTO [CMMS].[dbo].[task_autonumber]
           ([no_code]
           ,[no_date]
           ,[no_name]
           ,[next_no]
           ,[area_code]
           ,[factory_code])
SELECT [no_code]
           ,[no_date]
           ,[no_name]
           ,[next_no]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[task_autonumber] a
where not exists ( select * from [CMMS].[dbo].[task_autonumber] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.no_code = b.no_code )

-- 29. task_class
GO
TRUNCATE TABLE [CMMS].[dbo].[task_class]

GO
INSERT INTO [CMMS].[dbo].[task_class]
           ([task_code]
           ,[class_div]
           ,[class_spot]
           ,[class_item]
           ,[class_basis]
           ,[class_process]
           ,[class_est_time_hour]
           ,[class_est_time_min]
           ,[class_time_hour]
           ,[class_time_min]
           ,[part_code]
           ,[class_est_qty]
           ,[class_qty]
           ,[class_end]
           ,[class_real]
           ,[area_code]
           ,[factory_code])
SELECT [task_code]
           ,[class_div]
           ,[class_spot]
           ,[class_item]
           ,[class_basis]
           ,[class_process]
           ,[class_est_time_hour]
           ,[class_est_time_min]
           ,[class_time_hour]
           ,[class_time_min]
           ,[part_code]
           ,[class_est_qty]
           ,[class_qty]
           ,[class_end]
           ,[class_real]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[task_class] a
where not exists ( select * from [CMMS].[dbo].[task_class] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.task_code = b.task_code and a.class_div = b.class_div and
      a.class_spot = b.class_spot and a.class_item = b.class_item )

-- 30. task_emp
GO
TRUNCATE TABLE [CMMS].[dbo].[task_emp]

GO
INSERT INTO [CMMS].[dbo].[task_emp]
           ([task_code]
           ,[emp_code]
           ,[task_date]
           ,[manhour_hour]
           ,[manhour_second]
           ,[area_code]
           ,[factory_code])
SELECT [task_code]
           ,[emp_code]
           ,[task_date]
           ,[manhour_hour]
           ,[manhour_second]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[task_emp] a
where not exists ( select * from [CMMS].[dbo].[task_emp] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.task_code = b.task_code and a.emp_code = b.emp_code )

-- 31. task_equip
GO
TRUNCATE TABLE [CMMS].[dbo].[task_equip]

GO
INSERT INTO [CMMS].[dbo].[task_equip]
           ([task_code]
           ,[equip_code]
           ,[area_code]
           ,[factory_code])
SELECT [task_code]
           ,[equip_code]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[task_equip] a
where not exists ( select * from [CMMS].[dbo].[task_equip] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.task_code = b.task_code and a.equip_code = b.equip_code )

-- 31.1 task_hist
GO
TRUNCATE TABLE [CMMS].[dbo].[task_hist]

GO
INSERT INTO [CMMS].[dbo].[task_hist]
           ([task_code]
           ,[equip_code]
           ,[task_cycle]
           ,[cycle_code]
           ,[emp_code]
           ,[exam_date]
           ,[task_est_date]
           ,[status_code]
           ,[start_date]
           ,[end_date]
           ,[task_time_hour]
           ,[task_time_min]
           ,[area_code]
           ,[factory_code]
           ,[task_remark])
select [task_code]
           ,[equip_code]
           ,[task_cycle]
           ,[cycle_code]
           ,[emp_code]
           ,[exam_date]
           ,[task_est_date]
           ,[status_code]
           ,[start_date]
           ,[end_date]
           ,[task_time_hour]
           ,[task_time_min]
           ,[area_code]
           ,[factory_code]
           ,[task_remark]
FROM [CMMS_ELE].[dbo].[task_hist] a
where not exists ( select * from [CMMS].[dbo].[task_hist] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.task_code = b.task_code )

-- 32. task_part
GO
TRUNCATE TABLE [CMMS].[dbo].[task_part]

GO
INSERT INTO [CMMS].[dbo].[task_part]
           ([task_code]
           ,[part_code]
           ,[est_qty]
           ,[qty]
           ,[area_code]
           ,[factory_code])
SELECT [task_code]
           ,[part_code]
           ,[est_qty]
           ,[qty]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[task_part] a
where not exists ( select * from [CMMS].[dbo].[task_part] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.task_code = b.task_code and a.part_code = b.part_code )

-- 33. team_master
GO
TRUNCATE TABLE [CMMS].[dbo].[team_master]

GO
INSERT INTO [CMMS].[dbo].[team_master]
           ([team_code]
           ,[team_name]
           ,[area_code]
           ,[factory_code])
SELECT [team_code]
           ,[team_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[team_master] a
where not exists ( select * from [CMMS].[dbo].[team_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.team_code = b.team_code )

-- 34. title_master
GO
TRUNCATE TABLE [CMMS].[dbo].[title_master]

GO
INSERT INTO [CMMS].[dbo].[title_master]
           ([title_code]
           ,[title_name]
           ,[area_code]
           ,[factory_code])
SELECT [title_code]
           ,[title_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[title_master] a
where not exists ( select * from [CMMS].[dbo].[title_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.title_code = b.title_code )

-- 35. tmstautono
GO
TRUNCATE TABLE [CMMS].[dbo].[TMSTAUTONO]

GO
INSERT INTO [CMMS].[dbo].[TMSTAUTONO]
           ([NOTYPE]
           ,[NONAME]
           ,[DESCRIPT]
           ,[NEXTNO]
           ,[area_code]
           ,[factory_code])
SELECT [NOTYPE]
           ,[NONAME]
           ,[DESCRIPT]
           ,[NEXTNO]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[TMSTAUTONO] a
where not exists ( select * from [CMMS].[dbo].[TMSTAUTONO] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.NEXTNO = b.NEXTNO and a.NOTYPE = b.NOTYPE  and
      a.NONAME = b.NONAME )

-- 36. tmstcalendar
GO
TRUNCATE TABLE [CMMS].[dbo].[TMSTCALENDAR]

GO
INSERT INTO [CMMS].[dbo].[TMSTCALENDAR]
           ([DDATE]
           ,[YYYYMM]
           ,[YYYYMMDD]
           ,[IWEEKDAY]
           ,[area_code]
           ,[factory_code])
SELECT [DDATE]
           ,[YYYYMM]
           ,[YYYYMMDD]
           ,[IWEEKDAY]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[TMSTCALENDAR] a
where not exists ( select * from [CMMS].[dbo].[TMSTCALENDAR] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.DDATE = b.DDATE )

-- 37. used_master
GO
TRUNCATE TABLE [CMMS].[dbo].[used_master]

GO
INSERT INTO [CMMS].[dbo].[used_master]
           ([used_code]
           ,[used_name]
           ,[area_code]
           ,[factory_code])
SELECT [used_code]
           ,[used_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[used_master] a
where not exists ( select * from [CMMS].[dbo].[used_master] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.used_code = b.used_code )

-- 37.1 wo
GO
TRUNCATE TABLE [CMMS].[dbo].[wo]

GO
INSERT INTO [CMMS].[dbo].[wo]
           ([wo_code]
           ,[wo_base]
           ,[wo_descript]
           ,[wo_priorty]
           ,[wo_outorder]
           ,[wo_mh]
           ,[wo_esttime_hour]
           ,[wo_esttime_minute]
           ,[wo_div_code]
           ,[wo_state_code]
           ,[wo_float_date]
           ,[wo_estend_date]
           ,[wo_acc_date]
           ,[wo_start_date]
           ,[wo_end_date]
           ,[wo_firm_time_hour]
           ,[wo_firm_time_minute]
           ,[wo_time_hour]
           ,[wo_time_minute]
           ,[cause_code_a]
           ,[wo_cause]
           ,[wo_status]
           ,[wo_action]
           ,[comp_code]
           ,[wo_value]
           ,[equip_code]
           ,[area_code]
           ,[factory_code]
           ,[cause_code_b])
select [wo_code]
           ,[wo_base]
           ,[wo_descript]
           ,[wo_priorty]
           ,[wo_outorder]
           ,[wo_mh]
           ,[wo_esttime_hour]
           ,[wo_esttime_minute]
           ,[wo_div_code]
           ,[wo_state_code]
           ,[wo_float_date]
           ,[wo_estend_date]
           ,[wo_acc_date]
           ,[wo_start_date]
           ,[wo_end_date]
           ,[wo_firm_time_hour]
           ,[wo_firm_time_minute]
           ,[wo_time_hour]
           ,[wo_time_minute]
           ,[cause_code_a]
           ,[wo_cause]
           ,[wo_status]
           ,[wo_action]
           ,[comp_code]
           ,[wo_value]
           ,[equip_code]
           ,[area_code]
           ,[factory_code]
           ,[cause_code_b]
FROM [CMMS_ELE].[dbo].[wo] a
where not exists ( select * from [CMMS].[dbo].[wo] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code )

-- 37.2 wo_autonumber
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_autonumber]

GO
INSERT INTO [CMMS].[dbo].[wo_autonumber]
           ([area_code]
           ,[factory_code]
           ,[no_code]
           ,[no_date]
           ,[no_name]
           ,[next_no])
select [area_code]
           ,[factory_code]
           ,[no_code]
           ,[no_date]
           ,[no_name]
           ,[next_no]
FROM [CMMS_ELE].[dbo].[wo_autonumber] a
where not exists ( select * from [CMMS].[dbo].[wo_autonumber] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.no_code = b.no_code )

-- 38. wo_div
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_div]

GO
INSERT INTO [CMMS].[dbo].[wo_div]
           ([wo_div_code]
           ,[wo_div_name]
           ,[area_code]
           ,[factory_code])
SELECT [wo_div_code]
           ,[wo_div_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[wo_div] a
where not exists ( select * from [CMMS].[dbo].[wo_div] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_div_code = b.wo_div_code )

-- 38.1 wo_emp
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_emp]

GO
INSERT INTO [CMMS].[dbo].[wo_emp]
           ([wo_code]
           ,[emp_code]
           ,[wo_date]
           ,[manhour_hour]
           ,[manhour_second]
           ,[area_code]
           ,[factory_code])
select [wo_code]
           ,[emp_code]
           ,[wo_date]
           ,[manhour_hour]
           ,[manhour_second]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[wo_emp] a
where not exists ( select * from [CMMS].[dbo].[wo_emp] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code and a.emp_code = b.emp_code )

-- 39. wo_euqip
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_euqip]

GO
INSERT INTO [CMMS].[dbo].[wo_euqip]
           ([wo_code]
           ,[equip_code]
           ,[area_code]
           ,[factory_code])
SELECT [wo_code]
           ,[equip_code]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[wo_euqip] a
where not exists ( select * from [CMMS].[dbo].[wo_euqip] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code and a.equip_code = b.equip_code )

-- 39.1 wo_except_time
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_except_time]

GO
INSERT INTO [CMMS].[dbo].[wo_except_time]
           ([Area_Code]
           ,[Factory_Code]
           ,[except_time_div_code]
           ,[except_time_code_name]
           ,[except_time_start_time]
           ,[except_time_end_time]
           ,[except_time_time]
           ,[check_box])
select [Area_Code]
           ,[Factory_Code]
           ,[except_time_div_code]
           ,[except_time_code_name]
           ,[except_time_start_time]
           ,[except_time_end_time]
           ,[except_time_time]
           ,[check_box]
FROM [CMMS_ELE].[dbo].[wo_except_time] a
where not exists ( select * from [CMMS].[dbo].[wo_except_time] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.except_time_div_code = b.except_time_div_code and 
      a.except_time_code_name = b.except_time_code_name )

-- 40. wo_file
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_file]

GO
INSERT INTO [CMMS].[dbo].[wo_file]
           ([wo_code]
           ,[wo_file_code]
           ,[wo_file_name]
           ,[area_code]
           ,[factory_code])
SELECT [wo_code]
           ,[wo_file_code]
           ,[wo_file_name]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[wo_file] a
where not exists ( select * from [CMMS].[dbo].[wo_file] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code and a.wo_file_code = b.wo_file_code )

-- 41. wo_guide
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_guide]

GO
INSERT INTO [CMMS].[dbo].[wo_guide]
           ([wo_code]
           ,[wo_guide_code]
           ,[wo_guide_descript]
           ,[area_code]
           ,[factory_code])
SELECT [wo_code]
           ,[wo_guide_code]
           ,[wo_guide_descript]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[wo_guide] a
where not exists ( select * from [CMMS].[dbo].[wo_guide] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code and a.wo_guide_code = b.wo_guide_code )

-- 41.1 wo_hist
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_hist]

GO
INSERT INTO [CMMS].[dbo].[wo_hist]
           ([wo_code]
           ,[wo_base]
           ,[wo_descript]
           ,[wo_priorty]
           ,[wo_outorder]
           ,[wo_mh]
           ,[wo_esttime_hour]
           ,[wo_esttime_minute]
           ,[wo_div_code]
           ,[wo_state_code]
           ,[wo_float_date]
           ,[wo_estend_date]
           ,[wo_acc_date]
           ,[wo_start_date]
           ,[wo_end_date]
           ,[wo_firm_time_hour]
           ,[wo_firm_time_minute]
           ,[wo_time_hour]
           ,[wo_time_minute]
           ,[cause_code_a]
           ,[wo_cause]
           ,[wo_status]
           ,[wo_action]
           ,[comp_code]
           ,[wo_value]
           ,[equip_code]
           ,[area_code]
           ,[factory_code]
           ,[cause_code_b])
select [wo_code]
           ,[wo_base]
           ,[wo_descript]
           ,[wo_priorty]
           ,[wo_outorder]
           ,[wo_mh]
           ,[wo_esttime_hour]
           ,[wo_esttime_minute]
           ,[wo_div_code]
           ,[wo_state_code]
           ,[wo_float_date]
           ,[wo_estend_date]
           ,[wo_acc_date]
           ,[wo_start_date]
           ,[wo_end_date]
           ,[wo_firm_time_hour]
           ,[wo_firm_time_minute]
           ,[wo_time_hour]
           ,[wo_time_minute]
           ,[cause_code_a]
           ,[wo_cause]
           ,[wo_status]
           ,[wo_action]
           ,[comp_code]
           ,[wo_value]
           ,[equip_code]
           ,[area_code]
           ,[factory_code]
           ,[cause_code_b]
FROM [CMMS_ELE].[dbo].[wo_hist] a
where not exists ( select * from [CMMS].[dbo].[wo_hist] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code )

-- 41.2 wo_lab_list
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_lab_list]

GO
INSERT INTO [CMMS].[dbo].[wo_lab_list]
           ([mchno]
           ,[mchnm]
           ,[wo_code]
           ,[wo_status]
           ,[wo_cause]
           ,[wo_action]
           ,[wo_base]
           ,[wo_state_code]
           ,[wo_acc_date]
           ,[wo_start_date]
           ,[wo_end_date]
           ,[wo_firm_time_hour]
           ,[wo_firm_time_minute]
           ,[wo_time_hour]
           ,[wo_time_minute]
           ,[emp_code]
           ,[wo_emp_wo_date]
           ,[manhour_hour]
           ,[manhour_second]
           ,[wo_out_order]
           ,[comp_code]
           ,[wo_value])
select [mchno]
           ,[mchnm]
           ,[wo_code]
           ,[wo_status]
           ,[wo_cause]
           ,[wo_action]
           ,[wo_base]
           ,[wo_state_code]
           ,[wo_acc_date]
           ,[wo_start_date]
           ,[wo_end_date]
           ,[wo_firm_time_hour]
           ,[wo_firm_time_minute]
           ,[wo_time_hour]
           ,[wo_time_minute]
           ,[emp_code]
           ,[wo_emp_wo_date]
           ,[manhour_hour]
           ,[manhour_second]
           ,[wo_out_order]
           ,[comp_code]
           ,[wo_value]
FROM [CMMS_ELE].[dbo].[wo_lab_list] a
where not exists ( select * from [CMMS].[dbo].[wo_lab_list] b
    where a.wo_code = b.wo_code )

-- 41.3 wo_part
GO
TRUNCATE TABLE [CMMS].[dbo].[wo_part]

GO
INSERT INTO [CMMS].[dbo].[wo_part]
           ([wo_code]
           ,[part_code]
           ,[estqty]
           ,[qty]
           ,[area_code]
           ,[factory_code])
select [wo_code]
           ,[part_code]
           ,[estqty]
           ,[qty]
           ,[area_code]
           ,[factory_code]
FROM [CMMS_ELE].[dbo].[wo_part] a
where not exists ( select * from [CMMS].[dbo].[wo_part] b
    where a.area_code = b.area_code and a.factory_code = b.factory_code and
      a.wo_code = b.wo_code and a.part_code = b.part_code )
