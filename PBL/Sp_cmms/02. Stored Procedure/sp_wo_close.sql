/*
  file name : sp_wo_close.sql
  system    : cmms system
  procedure name  : sp_wo_close
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_close]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_close]
go

/*
execute sp_wo_close
*/

create PROCEDURE [dbo].[sp_wo_close]
@area char(1),
@factory char(1),
@LS_WO_CODE VARCHAR(30)

AS
BEGIN
BEGIN TRAN
INSERT INTO WO_HIST
  SELECT *
  from WO
  where area_code = @area and factory_code = @factory and WO_CODE=@LS_WO_CODE
DELETE WO where area_code = @area and factory_code = @factory and WO_CODE=@LS_WO_CODE
COMMIT TRAN
select @@ROWCOUNT
END