/*
  File Name : SP_CC_INSERT.SQL
  SYSTEM    : CMMS System
  Procedure Name  : SP_CC_INSERT
  Description : insert cc_master using [ipis].tmstdept
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_CC_INSERT]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_CC_INSERT]
GO

/*
exec SP_CC_INSERT
*/


CREATE PROCEDURE SP_CC_INSERT
AS
BEGIN -- BEGIN PROCEDURE
	TRUNCATE TABLE CC_MASTER

	INSERT INTO CC_MASTER (AREA_CODE, FACTORY_CODE, CC_CODE, CC_NAME)
	SELECT AREACODE, DIVISIONCODE, DEPTCODE, DEPTNAME
	FROM IPIS.DBO.TMSTDEPT

END -- END PROCEDURE
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

