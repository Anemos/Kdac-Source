/*
  file name : sp_equip_count.sql
  system    : cmms system
  procedure name  : sp_equip_count
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_equip_count]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_equip_count]
go

/*
execute sp_equip_count
*/

create procedure [dbo].[sp_equip_count]
AS
BEGIN

DECLARE @EQUIP_COUNT FLOAT

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='A')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='D' AND FACTORY_CODE='A' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='A'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE = 'D',
    FACTORY_CODE ='A',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='D' AND FACTORY_CODE='A' and equip_div_code='1'
  END


IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='S')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='D' AND FACTORY_CODE='S' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='S'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE = 'D',
    FACTORY_CODE= 'S',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='D' AND FACTORY_CODE='S' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='M')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='D' AND FACTORY_CODE='M' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='M'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='D',
    FACTORY_CODE='M',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='D' AND FACTORY_CODE='M' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='V')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='D' AND FACTORY_CODE='V' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='V'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='D',
    FACTORY_CODE='V',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='D' AND FACTORY_CODE='V' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='D' AND FACTORY_CODE='H')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='D' AND FACTORY_CODE='H' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT  WHERE AREA_CODE='D' AND FACTORY_CODE='H'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='D',
    FACTORY_CODE='H',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM [IPIS_DAEGU].CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='D' AND FACTORY_CODE='H' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='J' AND FACTORY_CODE='M')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM IPISJIN_SVR.CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='J' AND FACTORY_CODE='M' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='J' AND FACTORY_CODE='M'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='J',
    FACTORY_CODE='M',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM IPISJIN_SVR.CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='J' AND FACTORY_CODE='M' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='J' AND FACTORY_CODE='S')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM IPISJIN_SVR.CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='J' AND FACTORY_CODE='S' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='J' AND FACTORY_CODE='S'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='J',
    FACTORY_CODE='S',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM IPISJIN_SVR.CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='J' AND FACTORY_CODE='S' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='J' AND FACTORY_CODE='H')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM IPISJIN_SVR.CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='J' AND FACTORY_CODE='H' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='J' AND FACTORY_CODE='H'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='J',
    FACTORY_CODE='H',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM IPISJIN_SVR.CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='J' AND FACTORY_CODE='H' and equip_div_code='1'
  END

IF EXISTS(SELECT 1 FROM [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT WHERE AREA_CODE='Y' AND FACTORY_CODE='Y')
  BEGIN
    SELECT @EQUIP_COUNT=COUNT(EQUIP_CODE) FROM [ipisyeo_svr\ipis].CMMS.DBO.EQUIP_MASTER WHERE AREA_CODE='Y' AND FACTORY_CODE='Y' and equip_div_code='1'
    UPDATE [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT SET EQUIP_COUNT=@EQUIP_COUNT WHERE AREA_CODE='Y' AND FACTORY_CODE='Y'
  END
ELSE
  BEGIN
    INSERT INTO [IPIS_DAEGU].EIS.DBO.CMMS_EQUIP_COUNT(AREA_CODE, FACTORY_CODE,  EQUIP_COUNT)
    SELECT AREA_CODE='Y',
    FACTORY_CODE='Y',
    EQUIP_COUNT = COUNT(EQUIP_CODE)
    FROM [ipisyeo_svr\ipis].CMMS.DBO.EQUIP_MASTER  A
    WHERE AREA_CODE='Y' AND FACTORY_CODE='Y' and equip_div_code='1'
  END

end -- procedure end