USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_DATA_SUM]    Script Date: 01/17/2011 10:12:13 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_DATA_SUM]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_DATA_SUM]
GO

/*
--------------------------------------------------------------------
TITLE 		: 가동율 집계처리    
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_JOB_DATA_SUM  '20100719', 'N'
--------------------------------------------------------------------
*/
CREATE            PROCEDURE [dbo].[SP_JOB_DATA_SUM] 
(
  @parm_YMD		varchar(8), 	-- 생산일자 	
  @parm_TYPE		varchar(1) 	-- 구분자 (N:08시 집계시, T:사용자 실시간 집계시) 	  
)
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_YMD	AS VARCHAR(8) 

  IF (@parm_YMD = '')
	SET @ls_YMD = CONVERT(VARCHAR(8), GETDATE(), 112)
  ELSE
	SET @ls_YMD = @parm_YMD

  EXEC SP_SUM_TIME	@ls_YMD,  @parm_TYPE
  EXEC SP_SUM_MODEL	@ls_YMD

  SET NOCOUNT OFF 

END





GO

