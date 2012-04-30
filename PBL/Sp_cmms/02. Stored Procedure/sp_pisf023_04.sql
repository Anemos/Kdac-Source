/*
  file name : sp_pisf023_04.sql
  system    : cmms system
  procedure name  : sp_pisf023_04
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf023_04]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf023_04]
go

------------------------------------------------------------------
--  예방정비 작업지시서 - 완료된 예방정비내역
--  exec sp_pisf023_04 'PM-200309-005'
------------------------------------------------------------------

create PROCEDURE [dbo].[sp_pisf023_04]
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
    FROM equip_master inner join task_hist
      on ( equip_master.area_code = task_hist.area_code ) and
        ( equip_master.factory_code = task_hist.factory_code ) and
        ( equip_master.equip_code = task_hist.equip_code )
   WHERE ( task_hist.area_code = @ps_area ) and
      ( task_hist.factory_code = @ps_factory ) and
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
    FROM equip_master inner join task_hist
        on ( equip_master.area_code = task_hist.area_code ) and
          ( equip_master.factory_code = task_hist.factory_code ) and
          ( equip_master.equip_code = task_hist.equip_code )
        inner join task_class
        on ( task_hist.area_code = task_class.area_code ) and
          ( task_hist.factory_code = task_class.factory_code ) and
          ( task_hist.task_code = task_class.task_code )
        left outer join part_master
        on ( task_class.area_code = part_master.area_code ) and
          ( task_class.factory_code = part_master.factory_code ) and
          ( task_class.part_code = part_master.part_code )
   WHERE ( task_hist.area_code = @ps_area ) and
      ( task_hist.factory_code = @ps_factory ) and
      ( task_hist.task_code = @ps_taskcode )

END