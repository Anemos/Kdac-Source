-- 1. cause_master
alter table cause_master
drop constraint pk_cause_master
go
alter table cause_master
add area_code char(1) not null default 'J'
go
alter table cause_master
add factory_code char(1) not null default 'S'
go
alter table cause_master
add constraint pk_cause_master primary key(area_code,factory_code,cause_code)
go

-- 2. class_div_master
alter table class_div_master
drop constraint pk_class_div
go
alter table class_div_master
add area_code char(1) not null default 'J'
go
alter table class_div_master
add factory_code char(1) not null default 'S'
go
alter table class_div_master
add constraint pk_class_div primary key(area_code,factory_code,class_div_code)
go

-- 3. cycle_master
alter table cycle_master
drop constraint pk_cycle_master
go
alter table cycle_master
add area_code char(1) not null default 'J'
go
alter table cycle_master
add factory_code char(1) not null default 'S'
go
alter table cycle_master
add constraint pk_cycle_master primary key(area_code,factory_code,cycle_code)
go

-- 3.1 emp_certify
alter table emp_certify
drop constraint pk_emp_certify
go
alter table emp_certify
add area_code char(1) not null default 'J'
go
alter table emp_certify
add factory_code char(1) not null default 'S'
go
alter table emp_certify
add constraint pk_emp_certify primary key(area_code,factory_code,emp_code,certify_name,certify_rank)
go

-- 32. emp_edu
alter table emp_edu
drop constraint pk_emp_edu
go
alter table emp_edu
add area_code char(1) not null default 'J'
go
alter table emp_edu
add factory_code char(1) not null default 'S'
go
alter table emp_edu
add constraint pk_emp_edu primary key(area_code,factory_code,emp_code,edu_name,edu_start_date)
go

-- 4. equip_change
alter table equip_change
drop constraint pk_equip_change
go
alter table equip_change
add area_code char(1) not null default 'J'
go
alter table equip_change
add factory_code char(1) not null default 'S'
go
alter table equip_change
add constraint pk_equip_change primary key(area_code,factory_code,equip_code,change_date)
go

-- 5. equip_class
alter table equip_class
drop constraint pk_equip_class
go
alter table equip_class
add area_code char(1) not null default 'J'
go
alter table equip_class
add factory_code char(1) not null default 'S'
go
alter table equip_class
add constraint pk_equip_class primary key(area_code,factory_code,equip_code,class_div,class_spot,class_item)
go

-- 6. equip_daily_01
alter table equip_daily_01
drop constraint pk_equip_daily_01
go
alter table equip_daily_01
add area_code char(1) not null default 'J'
go
alter table equip_daily_01
add factory_code char(1) not null default 'S'
go
alter table equip_daily_01
add constraint pk_equip_daily_01 primary key(area_code,factory_code,equip_code,daily_div,daily_order)
go

-- 7. equip_daily_02
alter table equip_daily_02
drop constraint pk_equip_daily_02
go
alter table equip_daily_02
add area_code char(1) not null default 'J'
go
alter table equip_daily_02
add factory_code char(1) not null default 'S'
go
alter table equip_daily_02
add constraint pk_equip_daily_02 primary key(area_code,factory_code,equip_code,daily_div,daily_order)
go

-- 8. equip_daily_03
alter table equip_daily_03
drop constraint pk_equip_daily_03
go
alter table equip_daily_03
add area_code char(1) not null default 'J'
go
alter table equip_daily_03
add factory_code char(1) not null default 'S'
go
alter table equip_daily_03
add constraint pk_equip_daily_03 primary key(area_code,factory_code,equip_code,daily_div,daily_order)
go

-- 9. equip_div_a
alter table equip_div_a
drop constraint pk_equip_div_a
go
alter table equip_div_a
add area_code char(1) not null default 'J'
go
alter table equip_div_a
add factory_code char(1) not null default 'S'
go
alter table equip_div_a
add constraint pk_equip_div_a primary key(area_code,factory_code,equip_div_a_code)
go

-- 10. equip_div_b
alter table equip_div_b
drop constraint pk_equip_div_b
go
alter table equip_div_b
add area_code char(1) not null default 'J'
go
alter table equip_div_b
add factory_code char(1) not null default 'S'
go
alter table equip_div_b
add constraint pk_equip_div_b primary key(area_code,factory_code,equip_div_a_code,equip_div_b_code)
go

-- 11. equip_div_master
alter table equip_div_master
drop constraint pk_equip_div_master
go
alter table equip_div_master
add area_code char(1) not null default 'J'
go
alter table equip_div_master
add factory_code char(1) not null default 'S'
go
alter table equip_div_master
add constraint pk_equip_div_master primary key(area_code,factory_code,equip_div_code)
go

-- 12. equip_file
alter table equip_file
drop constraint pk_equip_file
go
alter table equip_file
add area_code char(1) not null default 'J'
go
alter table equip_file
add factory_code char(1) not null default 'S'
go
alter table equip_file
add constraint pk_equip_file primary key(area_code,factory_code,equip_code,equip_file_code)
go

-- 13. equip_guide
alter table equip_guide
drop constraint pk_equip_guide
go
alter table equip_guide
add area_code char(1) not null default 'J'
go
alter table equip_guide
add factory_code char(1) not null default 'S'
go
alter table equip_guide
add constraint pk_equip_guide primary key(area_code,factory_code,equip_code,guide_code)
go

-- 14. equip_list
alter table equip_list
drop constraint pk_equip_list
go
alter table equip_list
add area_code char(1) not null default 'J'
go
alter table equip_list
add factory_code char(1) not null default 'S'
go
alter table equip_list
add constraint pk_equip_list primary key(area_code,factory_code,equip_code,list_order)
go

-- 15. equip_meter
alter table equip_meter
drop constraint pk_equip_meter
go
alter table equip_meter
add area_code char(1) not null default 'J'
go
alter table equip_meter
add factory_code char(1) not null default 'S'
go
alter table equip_meter
add constraint pk_equip_meter primary key(area_code,factory_code,equip_code,meter_code)
go

-- 16. equip_meter_master
alter table equip_meter_master
drop constraint pk_equip_meter_master
go
alter table equip_meter_master
add area_code char(1) not null default 'J'
go
alter table equip_meter_master
add factory_code char(1) not null default 'S'
go
alter table equip_meter_master
add constraint pk_equip_meter_master primary key(area_code,factory_code,equip_code,meter_code)
go

-- 16. equip_safe
alter table equip_safe
drop constraint pk_equip_safe
go
alter table equip_safe
add area_code char(1) not null default 'J'
go
alter table equip_safe
add factory_code char(1) not null default 'S'
go
alter table equip_safe
add constraint pk_equip_safe primary key(area_code,factory_code,equip_code)
go

-- 17. guide_master
alter table guide_master
drop constraint pk_guide_master
go
alter table guide_master
add area_code char(1) not null default 'J'
go
alter table guide_master
add factory_code char(1) not null default 'S'
go
alter table guide_master
add constraint pk_guide_master primary key(area_code,factory_code,guide_code)
go

-- 18. numbering
alter table numbering
drop constraint pk_numbering
go
alter table numbering
add area_code char(1) not null default 'J'
go
alter table numbering
add factory_code char(1) not null default 'S'
go
alter table numbering
add constraint pk_numbering primary key(area_code,factory_code,number_div)
go

-- 19. process_master
alter table process_master
drop constraint pk_process_master
go
alter table process_master
add area_code char(1) not null default 'J'
go
alter table process_master
add factory_code char(1) not null default 'S'
go
alter table process_master
add constraint pk_process_master primary key(area_code,factory_code,process_code)
go

-- 20. sched_div_master
alter table sched_div_master
drop constraint pk_sched_div_master
go
alter table sched_div_master
add area_code char(1) not null default 'J'
go
alter table sched_div_master
add factory_code char(1) not null default 'S'
go
alter table sched_div_master
add constraint pk_sched_div_master primary key(area_code,factory_code,sched_div_code)
go

-- 21. schedule_next
alter table schedule_next
drop constraint pk_schedule_next
go
alter table schedule_next
add area_code char(1) not null default 'J'
go
alter table schedule_next
add factory_code char(1) not null default 'S'
go
alter table schedule_next
add constraint pk_schedule_next primary key(area_code,factory_code,equip_code,class_div,class_spot,class_item,class_est_date)
go

-- 22. schedule_next2
alter table schedule_next2
drop constraint pk_schedule_next2
go
alter table schedule_next2
add area_code char(1) not null default 'J'
go
alter table schedule_next2
add factory_code char(1) not null default 'S'
go

-- 23. section_master
alter table section_master
drop constraint pk_section_master
go
alter table section_master
add area_code char(1) not null default 'J'
go
alter table section_master
add factory_code char(1) not null default 'S'
go
alter table section_master
add constraint pk_section_master primary key(area_code,factory_code,section_code)
go

-- 24. serial
alter table serial
drop constraint pk_serial
go
alter table serial
add area_code char(1) not null default 'J'
go
alter table serial
add factory_code char(1) not null default 'S'
go
alter table serial
alter column serial_div char(10) not null
go
alter table serial
add constraint pk_serial primary key(area_code,factory_code,serial_div)
go

-- 25. setup
alter table setup
drop constraint pk_setup
go
alter table setup
add area_code char(1) not null default 'J'
go
alter table setup
add factory_code char(1) not null default 'S'
go
alter table setup
add constraint pk_setup primary key(area_code,factory_code)
go

-- 26. skill_master
alter table skill_master
drop constraint pk_skill_master
go
alter table skill_master
add area_code char(1) not null default 'J'
go
alter table skill_master
add factory_code char(1) not null default 'S'
go
alter table skill_master
add constraint pk_skill_master primary key(area_code,factory_code,skill_code)
go

-- 27. status_master
alter table status_master
drop constraint pk_status_master
go
alter table status_master
add area_code char(1) not null default 'J'
go
alter table status_master
add factory_code char(1) not null default 'S'
go
alter table status_master
add constraint pk_status_master primary key(area_code,factory_code,status_code)
go

-- 28. task_autonumber
alter table task_autonumber
drop constraint pk_task_autonumber
go
alter table task_autonumber
add area_code char(1) not null default 'J'
go
alter table task_autonumber
add factory_code char(1) not null default 'S'
go
alter table task_autonumber
add constraint pk_task_autonumber primary key(area_code,factory_code,no_code)
go

-- 29. task_class
alter table task_class
drop constraint pk_task_class
go
alter table task_class
add area_code char(1) not null default 'J'
go
alter table task_class
add factory_code char(1) not null default 'S'
go
alter table task_class
add constraint pk_task_class primary key(area_code,factory_code,task_code,class_div,class_spot,class_item)
go

-- 30. task_emp
alter table task_emp
drop constraint pk_task_emp
go
alter table task_emp
add area_code char(1) not null default 'J'
go
alter table task_emp
add factory_code char(1) not null default 'S'
go
alter table task_emp
add constraint pk_task_emp primary key(area_code,factory_code,task_code,emp_code,task_seq)
go

-- 31. task_equip
alter table task_equip
drop constraint pk_task_equip
go
alter table task_equip
add area_code char(1) not null default 'J'
go
alter table task_equip
add factory_code char(1) not null default 'S'
go
alter table task_equip
add constraint pk_task_equip primary key(area_code,factory_code,task_code,equip_code)
go

-- 32. task_part
alter table task_part
drop constraint pk_task_part
go
alter table task_part
add area_code char(1) not null default 'J'
go
alter table task_part
add factory_code char(1) not null default 'S'
go
alter table task_part
add constraint pk_task_part primary key(area_code,factory_code,task_code,part_code)
go

-- 33. team_master
alter table team_master
drop constraint pk_team_master
go
alter table team_master
add area_code char(1) not null default 'J'
go
alter table team_master
add factory_code char(1) not null default 'S'
go
alter table team_master
add constraint pk_team_master primary key(area_code,factory_code,team_code)
go

-- 34. title_master
alter table title_master
drop constraint pk_title_master
go
alter table title_master
add area_code char(1) not null default 'J'
go
alter table title_master
add factory_code char(1) not null default 'S'
go
alter table title_master
add constraint pk_title_master primary key(area_code,factory_code,title_code)
go

-- 35. tmstautono
alter table tmstautono
drop constraint pk_tmstautono
go
alter table tmstautono
add area_code char(1) not null default 'J'
go
alter table tmstautono
add factory_code char(1) not null default 'S'
go
alter table tmstautono
add constraint pk_tmstautono primary key(area_code,factory_code,notype,noname,nextno)
go

-- 36. tmstcalendar
alter table tmstcalendar
drop constraint pk_tmstcalendar
go
alter table tmstcalendar
add area_code char(1) not null default 'J'
go
alter table tmstcalendar
add factory_code char(1) not null default 'S'
go
alter table tmstcalendar
add constraint pk_tmstcalendar primary key(area_code,factory_code,ddate)
go

DROP INDEX [UI_TMSTCALENDAR_YMD] ON [dbo].[TMSTCALENDAR]
go

CREATE UNIQUE NONCLUSTERED INDEX [UI_TMSTCALENDAR_YMD] ON [dbo].[TMSTCALENDAR] 
(
	[YYYYMMDD] ASC, [AREA_CODE] ASC, [FACTORY_CODE] ASC
)ON [PRIMARY]
go

-- 37. used_master
alter table used_master
drop constraint pk_used_master
go
alter table used_master
add area_code char(1) not null default 'J'
go
alter table used_master
add factory_code char(1) not null default 'S'
go
alter table used_master
add constraint pk_used_master primary key(area_code,factory_code,used_code)
go

-- 38. wo_div
alter table wo_div
drop constraint pk_wo_div
go
alter table wo_div
add area_code char(1) not null default 'J'
go
alter table wo_div
add factory_code char(1) not null default 'S'
go
alter table wo_div
add constraint pk_wo_div primary key(area_code,factory_code,wo_div_code)
go

-- 39. wo_euqip
alter table wo_euqip
drop constraint pk_wo_euqip
go
alter table wo_euqip
add area_code char(1) not null default 'J'
go
alter table wo_euqip
add factory_code char(1) not null default 'S'
go
alter table wo_euqip
add constraint pk_wo_euqip primary key(area_code,factory_code,wo_code,equip_code)
go

-- 40. wo_file
alter table wo_file
drop constraint pk_wo_file
go
alter table wo_file
add area_code char(1) not null default 'J'
go
alter table wo_file
add factory_code char(1) not null default 'S'
go
alter table wo_file
add constraint pk_wo_file primary key(area_code,factory_code,wo_code,wo_file_code)
go

-- 41. wo_guide
alter table wo_guide
drop constraint pk_wo_guide
go
alter table wo_guide
add area_code char(1) not null default 'J'
go
alter table wo_guide
add factory_code char(1) not null default 'S'
go
alter table wo_guide
add constraint pk_wo_guide primary key(area_code,factory_code,wo_code,wo_guide_code)
go


