if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_COMP_INSERT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_COMP_INSERT]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE SP_COMP_INSERT
AS
BEGIN -- BEGIN PROCEDURE
	
	DELETE FROM COMP_MASTER
	WHERE COMP_DIV_CODE1='외주업체'

	INSERT INTO COMP_MASTER (COMP_CODE, COMP_NAME, COMP_DIV_CODE1, COMP_ADDRESS, COMP_BOSS, COMP_ZIPCODE, COMP_PHONE, COMP_FAX)
	SELECT SUPPLIERCODE, SUPPLIERKORNAME, '외주업체', SUPPLIERADDRESS, SUPPLIERHEADNAME, SUPPLIERPOSTNO, SUPPLIERTELNO, SUPPLIERFAXNO
	FROM IPIS.DBO.TMSTSUPPLIER  

END -- END PROCEDURE

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

