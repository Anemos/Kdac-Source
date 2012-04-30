USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_ERR_LOG]    Script Date: 01/17/2011 10:10:14 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_ERR_LOG]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_ERR_LOG]
GO

/*
--------------------------------------------------------------------
TITLE 		: ERROR LOG 등록 
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_ERR_LOG 'TEST'
--------------------------------------------------------------------
*/
CREATE         PROCEDURE [dbo].[SP_ERR_LOG]
(
  @parm_MSG		varchar(100)			-- 모델정보	 
)
AS
BEGIN

  INSERT INTO TH_ERROR
	(ERR_MSG, ERR_DATE)
  VALUES
	(@parm_MSG, getdate())

END




GO

