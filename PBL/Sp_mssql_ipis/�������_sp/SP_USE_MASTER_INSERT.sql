if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_USE_MASTER_INSERT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_USE_MASTER_INSERT]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE SP_USE_MASTER_INSERT
AS
BEGIN -- BEGIN PROCEDURE
	
	TRUNCATE TABLE USED_MASTER

	INSERT INTO USED_MASTER(USED_CODE, USED_NAME)
	SELECT CODEID, CODENAME 
	FROM IPIS.DBO.TMSTCODE
	WHERE CODEGROUP='DAC092'

END -- END PROCEDURE


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

