/*
  file name : sp_pisf023_02.sql
  system    : cmms system
  procedure name  : sp_pisf023_02
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf023_02]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf023_02]
go

------------------------------------------------------------------
--  예방정비 작업지시서 - 예상인원 리스트
--  exec sp_pisf023_02 'PM-200309-001'
------------------------------------------------------------------

create PROCEDURE [dbo].[sp_pisf023_02]
  @ps_area char(1),
  @ps_factory char(1),
  @ps_taskcode    Char(30)    -- 예방정비코드

AS

BEGIN

Create Table #Tmp_Emp
  (
    emp_name  char(50) null,
    emp_code  char(30) null,
    task_date   char(10) null,
    manhour_hour    float null,
    manhour_second  float null
  )

Declare @i      Int,
      @totcnt Int

INSERT INTO #Tmp_Emp
SELECT emp_master.emp_name,
         task_emp.emp_code,
         convert(varchar(10),task_emp.task_date,120),
         isnull(task_emp.manhour_hour, 0),
         isnull(task_emp.manhour_second, 0)
    FROM emp_master,task_emp
   WHERE ( emp_master.emp_code = task_emp.emp_code ) and
         ( task_emp.area_code = @ps_area ) and
         ( task_emp.factory_code = @ps_factory ) and
         ( task_emp.task_code = @ps_taskcode )

select @i = 1
SELECT @totcnt = count(*)
FROM #Tmp_Emp

if (( @totcnt - 5 ) < 0 )
  while (( @totcnt + @i ) < 6 )
    BEGIN
      select @i = @i + 1
      INSERT INTO #Tmp_Emp(emp_name,emp_code,task_date,manhour_hour,manhour_second)
      VALUES(' ',' ',null,null,null)
    END

SELECT *
FROM #Tmp_Emp

END

Drop table #Tmp_Emp