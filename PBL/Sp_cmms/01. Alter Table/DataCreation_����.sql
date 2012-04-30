-- 1. cause_master
INSERT INTO [CMMS_HVAC].[dbo].[cause_master]
([cause_code],[cause_name],[area_code],[factory_code])
select [cause_code],[cause_name],[area_code],'H'
from [CMMS_HVAC].[dbo].[cause_master]
where [area_code] = 'D' and [factory_code] = 'V'

-- 2. class_div_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[class_div_master]
([class_div_code],[class_div_name],[area_code],[factory_code])
SELECT [class_div_code],[class_div_name],[area_code],'H'
FROM [CMMS_HVAC].[dbo].[class_div_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 3. cycle_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[cycle_master]
([cycle_code],[cycle_name],[area_code],[factory_code])
SELECT [cycle_code],[cycle_name],[area_code],'H'
FROM [CMMS_HVAC].[dbo].[cycle_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 3.1 emp_certify
GO
INSERT INTO [CMMS_HVAC].[dbo].[emp_certify]
([emp_code],[certify_name],[certify_rank],[certify_number],[certify_institution],[certify_expire],[area_code],[factory_code])
SELECT [emp_code],[certify_name],[certify_rank],[certify_number],[certify_institution],[certify_expire],[area_code],'H'
FROM [CMMS_HVAC].[dbo].[emp_certify]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 3.2 emp_edu
GO
INSERT INTO [CMMS_HVAC].[dbo].[emp_edu]
([emp_code],[edu_name],[edu_descript],[edu_institution],[edu_start_date],[edu_end_date],[edu_status],[edu_value],[edu_remark],
[area_code],[factory_code])
SELECT [emp_code],[edu_name],[edu_descript],[edu_institution],[edu_start_date],[edu_end_date],[edu_status],[edu_value],[edu_remark],
[area_code],'H'
FROM [CMMS_HVAC].[dbo].[emp_edu]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 4. equip_change
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_change]
([equip_code],[change_date],[change_descript],[change_remark],[area_code],[factory_code])
SELECT [equip_code],[change_date],[change_descript],[change_remark],[area_code],'H'
FROM [CMMS_HVAC].[dbo].[equip_change]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 5. equip_class
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_class]
([equip_code],[class_div],[class_spot],[class_item],[class_basis],[class_process],[class_cycle],[cycle_code],[class_est_date],
[class_est_time_hour],[class_est_time_min],[part_code],[class_qty],[area_code],[factory_code])
SELECT [equip_code],[class_div],[class_spot],[class_item],[class_basis],[class_process],[class_cycle],[cycle_code],[class_est_date],
[class_est_time_hour],[class_est_time_min],[part_code],[class_qty],[area_code],'H'
FROM [CMMS_HVAC].[dbo].[equip_class]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 6. equip_daily_01
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_daily_01]
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
,'H'
FROM [CMMS_HVAC].[dbo].[equip_daily_01]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 7. equip_daily_02
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_daily_02]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_daily_02]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 8. equip_daily_03
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_daily_03]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_daily_03]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 9. equip_div_a
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_div_a]
           ([equip_div_a_code]
           ,[equip_div_a_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_div_a_code]
           ,[equip_div_a_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_div_a]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 10. equip_div_b
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_div_b]
           ([equip_div_a_code]
           ,[equip_div_b_code]
           ,[equip_div_b_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_div_a_code]
           ,[equip_div_b_code]
           ,[equip_div_b_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_div_b]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 11. equip_div_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_div_master]
           ([equip_div_code]
           ,[equip_div_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_div_code]
           ,[equip_div_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_div_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 12. equip_file
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_file]
           ([equip_code]
           ,[equip_file_code]
           ,[equip_file_name]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[equip_file_code]
           ,[equip_file_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_file]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 13. equip_guide
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_guide]
           ([equip_code]
           ,[guide_code]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[guide_code]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_guide]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 14. equip_list
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_list]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_list]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 15. equip_meter
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_meter]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_meter]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 16. equip_meter_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_meter_master]
           ([equip_code]
           ,[meter_code]
           ,[meter_unit]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[meter_code]
           ,[meter_unit]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_meter_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 16. equip_safe
GO
INSERT INTO [CMMS_HVAC].[dbo].[equip_safe]
           ([equip_code]
           ,[equip_safe]
           ,[area_code]
           ,[factory_code])
SELECT [equip_code]
           ,[equip_safe]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[equip_safe]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 17. guide_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[guide_master]
           ([guide_code]
           ,[guide_name]
           ,[guide_descript]
           ,[area_code]
           ,[factory_code])
SELECT [guide_code]
           ,[guide_name]
           ,[guide_descript]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[guide_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 18. numbering
GO
INSERT INTO [CMMS_HVAC].[dbo].[numbering]
           ([number_div]
           ,[number_order]
           ,[area_code]
           ,[factory_code])
SELECT [number_div]
           ,[number_order]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[numbering]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 19. process_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[process_master]
           ([process_code]
           ,[process_name]
           ,[area_code]
           ,[factory_code])
SELECT [process_code]
           ,[process_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[process_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 20. sched_div_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[sched_div_master]
           ([sched_div_code]
           ,[sched_div_name]
           ,[area_code]
           ,[factory_code])
SELECT [sched_div_code]
           ,[sched_div_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[sched_div_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 21. schedule_next
GO
INSERT INTO [CMMS_HVAC].[dbo].[schedule_next]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[schedule_next]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 22. schedule_next2
GO
INSERT INTO [CMMS_HVAC].[dbo].[schedule_next2]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[schedule_next2]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 23. section_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[section_master]
           ([section_code]
           ,[section_name]
           ,[area_code]
           ,[factory_code])
SELECT [section_code]
           ,[section_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[section_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 24. serial
GO
INSERT INTO [CMMS_HVAC].[dbo].[serial]
           ([serial_div]
           ,[serlal_no]
           ,[area_code]
           ,[factory_code])
SELECT [serial_div]
           ,[serlal_no]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[serial]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 25. setup
GO
INSERT INTO [CMMS_HVAC].[dbo].[setup]
           ([work_fee]
           ,[area_code]
           ,[factory_code])
SELECT [work_fee]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[setup]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 26. skill_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[skill_master]
           ([skill_code]
           ,[skill_name]
           ,[area_code]
           ,[factory_code])
SELECT [skill_code]
           ,[skill_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[skill_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 27. status_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[status_master]
           ([status_code]
           ,[status_name]
           ,[area_code]
           ,[factory_code])
SELECT [status_code]
           ,[status_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[status_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 28. task_autonumber
GO
INSERT INTO [CMMS_HVAC].[dbo].[task_autonumber]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[task_autonumber]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 29. task_class
GO
INSERT INTO [CMMS_HVAC].[dbo].[task_class]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[task_class]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 30. task_emp
GO
INSERT INTO [CMMS_HVAC].[dbo].[task_emp]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[task_emp]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 31. task_equip
GO
INSERT INTO [CMMS_HVAC].[dbo].[task_equip]
           ([task_code]
           ,[equip_code]
           ,[area_code]
           ,[factory_code])
SELECT [task_code]
           ,[equip_code]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[task_equip]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 32. task_part
GO
INSERT INTO [CMMS_HVAC].[dbo].[task_part]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[task_part]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 33. team_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[team_master]
           ([team_code]
           ,[team_name]
           ,[area_code]
           ,[factory_code])
SELECT [team_code]
           ,[team_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[team_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 34. title_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[title_master]
           ([title_code]
           ,[title_name]
           ,[area_code]
           ,[factory_code])
SELECT [title_code]
           ,[title_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[title_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 35. tmstautono
GO
INSERT INTO [CMMS_HVAC].[dbo].[TMSTAUTONO]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[TMSTAUTONO]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 36. tmstcalendar
GO
INSERT INTO [CMMS_HVAC].[dbo].[TMSTCALENDAR]
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
           ,'H'
FROM [CMMS_HVAC].[dbo].[TMSTCALENDAR]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 37. used_master
GO
INSERT INTO [CMMS_HVAC].[dbo].[used_master]
           ([used_code]
           ,[used_name]
           ,[area_code]
           ,[factory_code])
SELECT [used_code]
           ,[used_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[used_master]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 38. wo_div
GO
INSERT INTO [CMMS_HVAC].[dbo].[wo_div]
           ([wo_div_code]
           ,[wo_div_name]
           ,[area_code]
           ,[factory_code])
SELECT [wo_div_code]
           ,[wo_div_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[wo_div]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 39. wo_euqip
GO
INSERT INTO [CMMS_HVAC].[dbo].[wo_euqip]
           ([wo_code]
           ,[equip_code]
           ,[area_code]
           ,[factory_code])
SELECT [wo_code]
           ,[equip_code]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[wo_euqip]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 40. wo_file
GO
INSERT INTO [CMMS_HVAC].[dbo].[wo_file]
           ([wo_code]
           ,[wo_file_code]
           ,[wo_file_name]
           ,[area_code]
           ,[factory_code])
SELECT [wo_code]
           ,[wo_file_code]
           ,[wo_file_name]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[wo_file]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'

-- 41. wo_guide
GO
INSERT INTO [CMMS_HVAC].[dbo].[wo_guide]
           ([wo_code]
           ,[wo_guide_code]
           ,[wo_guide_descript]
           ,[area_code]
           ,[factory_code])
SELECT [wo_code]
           ,[wo_guide_code]
           ,[wo_guide_descript]
           ,[area_code]
           ,'H'
FROM [CMMS_HVAC].[dbo].[wo_guide]
WHERE [AREA_CODE] = 'D' AND [FACTORY_CODE] = 'V'