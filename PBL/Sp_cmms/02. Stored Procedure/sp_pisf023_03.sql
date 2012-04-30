/*
  file name : sp_pisf023_03.sql
  system    : cmms system
  procedure name  : sp_pisf023_03
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf023_03]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf023_03]
go

------------------------------------------------------------------
--  예방정비 작업지시서 - 계획중인 예방정비
--  exec sp_pisf023_03 'PM-200309-055'
------------------------------------------------------------------

create PROCEDURE [dbo].[sp_pisf023_03]
  @ps_area char(1),
  @ps_factory char(1),
  @ps_taskcode    Char(30)    -- 예방정비코드

AS

BEGIN

Declare @i      Int,
      @totcnt Int

select @i = 1
SELECT @totcnt = count(*)
FROM TASK_CLASS
WHERE area_code = @ps_area and factory_code = @ps_factory and TASK_CODE = @ps_taskcode

if ( @totcnt  < 1 )

  SELECT task.task_code,
          task.equip_code,
          equip_master.equip_name,
          task.exam_date,
          ' ',
          task.emp_code,
    task.start_date,
    task.end_date,
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
    task.task_remark,
    0
    FROM equip_master inner join task
      ON ( equip_master.area_code = task.area_code ) and
        ( equip_master.factory_code = task.factory_code ) and
        ( equip_master.equip_code = task.equip_code )
   WHERE ( equip_master.equip_code = task.equip_code ) and
      ( task.area_code = @ps_area ) and
      ( task.factory_code = @ps_factory ) and
      ( task.task_code = @ps_taskcode )
else

  SELECT task.task_code,
          task.equip_code,
          equip_master.equip_name,
          task.exam_date,
          task_class.class_div,
          task.emp_code,
    task.start_date,
    task.end_date,
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
    task.task_remark,
    task_class.class_real
    FROM equip_master inner join task
      on ( equip_master.area_code = task.area_code ) and
        ( equip_master.factory_code = task.factory_code ) and
        ( equip_master.equip_code = task.equip_code )
      inner join task_class
      on ( task.area_code = task_class.area_code ) and
        ( task.factory_code = task_class.factory_code ) and
        ( task.task_code = task_class.task_code )
      left outer join part_master
      on ( task_class.area_code = part_master.area_code )and
        ( task_class.factory_code = part_master.factory_code )and
        ( task_class.part_code = part_master.part_code )
   WHERE task.area_code = @ps_area and
      task.factory_code = @ps_factory and
      task.task_code = @ps_taskcode

END