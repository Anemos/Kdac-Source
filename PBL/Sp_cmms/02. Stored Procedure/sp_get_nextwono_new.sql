/*
  file name : sp_get_nextwono_new.sql
  system    : cmms system
  procedure name  : sp_get_nextwono_new
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_get_nextwono_new]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_get_nextwono_new]
go

/*
execute sp_get_nextwono_new
*/

create procedure [dbo].[sp_get_nextwono_new]
@area_code char(1),
@factory_code char(1),
@psNOCODE   VARCHAR(30),
@NEXTWONO   VARCHAR(30) OUTPUT
AS
BEGIN
BEGIN TRAN
DECLARE @WONO   VARCHAR(30) , @NODATE   VARCHAR(30)
IF EXISTS ( SELECT 1 FROM WO_AUTONUMBER
      WHERE NO_CODE = @psNOCODE AND (NEXT_NO IS NULL or NEXT_NO='') and area_code=@area_code and factory_code=@factory_code )
  BEGIN
    UPDATE WO_AUTONUMBER SET
    NO_DATE = CONVERT(VARCHAR(6),GETDATE(),112),
    NEXT_NO ='001'
    WHERE NO_CODE = @psNOCODE and area_code=@area_code and factory_code=@factory_code

--    SELECT @NEXTWONO=CONVERT(VARCHAR(6),GETDATE,112)
  END
SELECT @NEXTWONO=NEXT_NO, @NODATE = NO_DATE  FROM WO_AUTONUMBER
      WHERE NO_CODE = @psNOCODE and area_code=@area_code and factory_code=@factory_code
SELECT @NEXTWONO=@psNOCODE+'-'+@NODATE+'-'+@NEXTWONO
IF  EXISTS ( SELECT 1 FROM WO_AUTONUMBER
    WHERE NO_CODE = @psNOCODE  AND NO_DATE<>CONVERT(VARCHAR(6),GETDATE(),112)
      AND NEXT_NO IS NOT NULL and area_code=@area_code and factory_code=@factory_code )
  BEGIN
    UPDATE WO_AUTONUMBER SET
    NO_DATE = CONVERT(VARCHAR(6),GETDATE(),112),
    NEXT_NO ='001'
    WHERE NO_CODE = @psNOCODE and area_code=@area_code and factory_code=@factory_code
  --  SELECT @NEXTWONO=CONVERT(VARCHAR(6),GETDATE(),112)
    SELECT @NEXTWONO=NEXT_NO, @NODATE = NO_DATE  FROM WO_AUTONUMBER
      WHERE NO_CODE = @psNOCODE and area_code=@area_code and factory_code=@factory_code
    SELECT @NEXTWONO=@psNOCODE+'-'+@NODATE+'-'+@NEXTWONO
    SELECT @WONO = '001'
  END
ELSE
  BEGIN
    SELECT @WONO=NEXT_NO FROM WO_AUTONUMBER
      WHERE NO_CODE = @psNOCODE and area_code=@area_code and factory_code=@factory_code
    SELECT @WONO=CONVERT(VARCHAR(3),CONVERT(INT,@WONO)+1)

    IF (LEN(@WONO) <2)
      BEGIN
        SELECT @WONO = '00'+@WONO
      END
    IF (LEN(@WONO) <3)
      BEGIN
        SELECT @WONO = '0'+@WONO
      END
    UPDATE WO_AUTONUMBER SET
    NEXT_NO =@WONO
    WHERE NO_CODE = @psNOCODE and area_code=@area_code and factory_code=@factory_code

  END
COMMIT TRAN
SELECT @NEXTWONO=@psNOCODE+'-'+@NODATE+'-'+@WONO
END