/*
  file name : sp_task_close_auto.sql
  system    : cmms system
  procedure name  : sp_task_close_auto
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_task_close_auto]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_task_close_auto]
go

/*
execute sp_task_close_auto
*/

create PROCEDURE [dbo].[sp_task_close_auto]
AS
BEGIN

DECLARE @sTASKNO  varchar(30)
declare @area char(1)
declare @factory char(1)

SELECT area_code,factory_code,TASK_CODE
    INTO #TTASK_GEN
    FROM TASK
  WHERE (STATUS_CODE = '¿Ï·á')

DECLARE CURSOR_TASK_GEN CURSOR
    FOR SELECT area_code,factory_code,TASK_CODE FROM #TTASK_GEN
OPEN CURSOR_TASK_GEN
FETCH NEXT FROM CURSOR_TASK_GEN INTO @area,@factory,@sTASKNO
WHILE (@@FETCH_STATUS <> -1)
begin
  if (@@FETCH_STATUS <> -2)
  begin
    BEGIN TRAN

    INSERT INTO TASK_HIST
      SELECT *
      from TASK
      where area_code = @area and factory_code = @factory and TASK_CODE= @sTASKNO

    DELETE TASK where area_code = @area and factory_code = @factory and TASK_CODE= @sTASKNO

    COMMIT TRAN
  END

  FETCH NEXT FROM CURSOR_TASK_GEN INTO @area,@factory,@sTASKNO
END
END
DEALLOCATE CURSOR_TASK_GEN