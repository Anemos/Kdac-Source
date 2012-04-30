/*
  file name : sp_get_nexttaskno.sql
  system    : cmms system
  procedure name  : sp_get_nexttaskno
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_get_nexttaskno]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_get_nexttaskno]
go

/*
execute sp_get_nexttaskno
*/

create procedure [dbo].[sp_get_nexttaskno]
@area char(1),
@factory char(1),
@psNOCODE   VARCHAR(30),
@NEXTTASKNO   VARCHAR(30) OUTPUT
AS
BEGIN
BEGIN TRAN
DECLARE @TASKNO   VARCHAR(30) , @NODATE   VARCHAR(30)
IF EXISTS ( SELECT 1 FROM TASK_AUTONUMBER
      WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE
      AND (NEXT_NO IS NULL or NEXT_NO=''))
  BEGIN
    UPDATE TASK_AUTONUMBER SET
    NO_DATE = CONVERT(VARCHAR(6),GETDATE(),112),
    NEXT_NO ='001'
    WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE

--    SELECT @NEXTTASKNO=CONVERT(VARCHAR(6),GETDATE,112)
  END
SELECT @NEXTTASKNO=NEXT_NO, @NODATE = NO_DATE
FROM TASK_AUTONUMBER
WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE

SELECT @NEXTTASKNO=@psNOCODE+'-'+@NODATE+'-'+@NEXTTASKNO
IF  EXISTS ( SELECT 1 FROM TASK_AUTONUMBER
    WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE
      AND NO_DATE<>CONVERT(VARCHAR(6),GETDATE(),112)
      AND NEXT_NO IS NOT NULL )
  BEGIN
    UPDATE TASK_AUTONUMBER SET
    NO_DATE = CONVERT(VARCHAR(6),GETDATE(),112),
    NEXT_NO ='001'
    WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE
    --SELECT @NEXTTASKNO=CONVERT(VARCHAR(6),GETDATE(),112)
    SELECT @NEXTTASKNO=NEXT_NO, @NODATE = NO_DATE
    FROM TASK_AUTONUMBER
    WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE

    SELECT @NEXTTASKNO=@psNOCODE+'-'+@NODATE+'-'+@NEXTTASKNO
  END
ELSE
  BEGIN
    SELECT @TASKNO=NEXT_NO FROM TASK_AUTONUMBER
      WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE
    SELECT @TASKNO=CONVERT(VARCHAR(3),CONVERT(INT,@TASKNO)+1)

    IF (LEN(@TASKNO) <2)
      BEGIN
        SELECT @TASKNO = '00'+@TASKNO
      END
    IF (LEN(@TASKNO) <3)
      BEGIN
        SELECT @TASKNO = '0'+@TASKNO
      END
    UPDATE TASK_AUTONUMBER SET
    NEXT_NO =@TASKNO
    WHERE area_code = @area and factory_code = @factory and NO_CODE = @psNOCODE

  END
COMMIT TRAN
SELECT @NEXTTASKNO
END