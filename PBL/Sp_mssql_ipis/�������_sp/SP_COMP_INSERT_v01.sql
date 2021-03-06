/*
  File Name : SP_COMP_INSERT.SQL
  SYSTEM    : CMMS System
  Procedure Name  : SP_COMP_INSERT
  Description : insert comp_master using [ipis].tmstsupplier
  Use DataBase  : cmms
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2006.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_COMP_INSERT]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_COMP_INSERT]
GO

/*
exec SP_COMP_INSERT
*/


CREATE PROCEDURE SP_COMP_INSERT
AS
BEGIN -- BEGIN PROCEDURE
	
	DELETE FROM COMP_MASTER
	WHERE COMP_DIV_CODE1='외주업체'

	INSERT INTO COMP_MASTER (COMP_CODE, COMP_NAME, COMP_DIV_CODE1, COMP_ADDRESS, COMP_BOSS, COMP_ZIPCODE, COMP_PHONE, COMP_FAX)
	SELECT SUPPLIERCODE, SUPPLIERKORNAME, '외주업체', SUPPLIERADDRESS, SUPPLIERHEADNAME, SUPPLIERPOSTNO, SUPPLIERTELNO, SUPPLIERFAXNO
	FROM IPIS.DBO.TMSTSUPPLIER
	WHERE ISNULL(XSTOP,'') <> 'X'

END -- END PROCEDURE

