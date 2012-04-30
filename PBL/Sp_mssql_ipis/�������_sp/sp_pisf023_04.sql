/*
  File Name : sp_pisf023_04.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf023_04
  Description : 예방정비 작업지시서 - 완료된 예방정비내역
  Use DataBase  : cmms
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf023_04]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf023_04]
GO

/*
exec sp_pisf023_04 'PM-200309-005'
*/

Create Procedure sp_pisf023_04
  @ps_taskcode 		Char(30)  	-- 예방정비코드

As
Begin

Declare	@i			Int,
			@totcnt	Int

select @i = 1
SELECT @totcnt = count(*)
FROM TASK_CLASS
WHERE TASK_CODE = @ps_taskcode

if ( @totcnt  < 1 )

	SELECT task_hist.task_code,   
         	task_hist.equip_code,   
         	equip_master.equip_name,   
         	task_hist.exam_date,   
         	' ',   
         	task_hist.emp_code, 
		task_hist.start_date,
		task_hist.end_date,  
         	' ',   
         	' ',   
         	' ',   
         	' ',   
         	0,   
         	0,   
         	0,   
         	0,   
         	' ',   
         	' ',   
        	' ',   
         	0,   
         	0,
		0,
		task_hist.task_remark, 
		' '
    FROM equip_master,     
         task_hist
   WHERE ( equip_master.equip_code = task_hist.equip_code ) and   
			( task_hist.task_code = @ps_taskcode )

else

	SELECT task_hist.task_code,   
         	task_hist.equip_code,   
         	equip_master.equip_name,   
         	task_hist.exam_date,   
         	task_class.class_div,   
         	task_hist.emp_code, 
		task_hist.start_date,
		task_hist.end_date,  
         	task_class.class_spot,   
         	task_class.class_process,   
         	task_class.class_item,   
         	task_class.class_basis,   
         	task_class.class_est_time_hour,   
         	task_class.class_est_time_min,   
         	task_class.class_time_hour,   
         	task_class.class_time_min,   
         	task_class.part_code,   
         	part_master.part_name,   
         	part_master.part_spec,   
         	task_class.class_est_qty,   
         	task_class.class_qty,
		task_class.class_end,
		task_hist.task_remark, 
		task_class.class_real
    FROM equip_master,   
         part_master,   
         task_hist,   
         task_class  
   WHERE ( equip_master.equip_code = task_hist.equip_code ) and  
         	( task_hist.task_code = task_class.task_code ) and  
         	( task_class.part_code *= part_master.part_code )and
		( task_hist.task_code = @ps_taskcode )

End   -- Procedure End
Go
