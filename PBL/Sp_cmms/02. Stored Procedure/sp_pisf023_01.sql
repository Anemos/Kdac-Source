/*
  file name : sp_pisf023_01.sql
  system    : cmms system
  procedure name  : sp_pisf023_01
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf023_01]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf023_01]
go

------------------------------------------------------------------
--  예방정비 작업지시서 - 예상자재 리스트
--  exec sp_pisf023_01 'PM-200309-055'
------------------------------------------------------------------

create PROCEDURE [dbo].[sp_pisf023_01]
  @ps_area char(1),
  @ps_factory char(1),
  @ps_taskcode    Char(30)    -- 예방정비코드

AS

BEGIN

Create Table #Tmp_Task
  (
    part_name char(100) null,
    part_cost   float null,
    part_code char(30) null,
    est_qty   float null,
    qty       float null
  )

Declare @i      Int,
      @totcnt Int

INSERT INTO #Tmp_Task
SELECT part_master.part_name,
         part_master.part_cost,
         task_part.part_code,
         isnull(task_part.est_qty, 0),
         isnull(task_part.qty, 0)
    FROM part_master inner join task_part
      on ( part_master.area_code = task_part.area_code ) and
        ( part_master.factory_code = task_part.factory_code ) and
        ( part_master.part_code = task_part.part_code )
   WHERE ( task_part.area_code = @ps_area ) and
      ( task_part.factory_code = @ps_factory ) and
      ( task_part.task_code = @ps_taskcode )

select @i = 1
SELECT @totcnt = count(*)
FROM #Tmp_Task

if (( @totcnt - 5 ) < 0 )
  while (( @totcnt + @i ) < 6 )
    BEGIN
      select @i = @i + 1
      INSERT INTO #Tmp_Task(part_name,part_cost,part_code,est_qty,qty)
      VALUES(' ',null,null,null,null)
    END

SELECT *
FROM #Tmp_Task

END

Drop table #Tmp_Task