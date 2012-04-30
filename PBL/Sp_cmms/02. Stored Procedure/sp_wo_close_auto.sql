/*
  file name : sp_wo_close_auto.sql
  system    : cmms system
  procedure name  : sp_wo_close_auto
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_close_auto]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_close_auto]
go

/*
execute sp_wo_close_auto
*/

create PROCEDURE [dbo].[sp_wo_close_auto]
AS
BEGIN
DECLARE @sWONO  varchar(30)
declare @area char(1)
declare @factory char(1)

SELECT area_code, factory_code, WO_CODE
  INTO #WO_GEN
  FROM WO
 WHERE (WO_STATE_CODE = '¿Ï·á')
DECLARE CURSOR_WO_GEN CURSOR
    FOR SELECT area_code,factory_code,WO_CODE FROM #WO_GEN
OPEN CURSOR_WO_GEN
FETCH NEXT FROM CURSOR_WO_GEN INTO @area,@factory,@sWONO
WHILE (@@FETCH_STATUS <> -1)
begin
  if (@@FETCH_STATUS <> -2)
  begin
    BEGIN TRAN
    INSERT INTO WO_HIST
    SELECT *
    from WO
    where area_code = @area and factory_code = @factory and WO_CODE=@sWONO
    DELETE WO where area_code = @area and factory_code = @factory and WO_CODE=@sWONO
    COMMIT TRAN
  END

  FETCH NEXT FROM CURSOR_WO_GEN INTO @area,@factory,@sWONO
END
END
DEALLOCATE CURSOR_WO_GEN