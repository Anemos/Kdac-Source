/*
  file name : sp_task_close.sql
  system    : cmms system
  procedure name  : sp_task_close
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_task_close]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_task_close]
go

/*
execute sp_task_close 'D','A','task_code'
*/

create PROCEDURE [dbo].[sp_task_close]
@LS_AREA_CODE CHAR(1),
@LS_FACTORY_CODE CHAR(1),
@LS_TASK_CODE VARCHAR(30)
AS
BEGIN
BEGIN TRAN
INSERT INTO TASK_HIST
  SELECT *
  from TASK
  where AREA_CODE = @LS_AREA_CODE AND FACTORY_CODE = @LS_FACTORY_CODE AND
    TASK_CODE = @LS_TASK_CODE
DELETE TASK where AREA_CODE = @LS_AREA_CODE AND FACTORY_CODE = @LS_FACTORY_CODE AND
  TASK_CODE=@LS_TASK_CODE
COMMIT TRAN
select @@ROWCOUNT
END