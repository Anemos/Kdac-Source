USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_ADJUST_TYPE]    Script Date: 01/17/2011 10:11:35 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_ADJUST_TYPE]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_ADJUST_TYPE]
GO

/*
--------------------------------------------------------------------
TITLE 		: 비가동시간 적용유형을 반영 
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	매일아침 07:59분에 비가동시간 적용일자를 감지하여
	적용유형을 설정하여 둔다. (하루에 한번만) 

	EXEC SP_JOB_ADJUST_TYPE     
--------------------------------------------------------------------
*/
CREATE           PROCEDURE [dbo].[SP_JOB_ADJUST_TYPE]
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_MMDD		AS VARCHAR(4)
  DECLARE @ls_SCD		AS VARCHAR(4)
  SELECT @ls_MMDD = substring(convert(varchar(8), getdate(), 112),5,4) 

  SELECT @ls_SCD	= SCD  
     FROM TM_CODE
   WHERE MCD  		= '90'
        AND SCD  		IN ('20', '30', '40')
        AND LEFT(CDNAME,4) 	<= @ls_MMDD
        AND RIGHT(CDNAME,4) 	>= @ls_MMDD


  IF (@@ROWCOUNT < 1)
  BEGIN
	SELECT @ls_SCD	= SCD  
	   FROM TM_CODE
	 WHERE MCD  		= '90'
	      AND SCD  		IN ('20', '30', '40')
	      AND LEFT(CDNAME,4) 	<= @ls_MMDD

	IF (@@ROWCOUNT < 1)
	BEGIN
		SET @ls_SCD	= '20'
	END
  END

  UPDATE TM_CODE
        SET CDNAME	= @ls_SCD
   WHERE MCD		= '90'	  
        AND SCD		= '01'


  SET NOCOUNT OFF 

END




GO

