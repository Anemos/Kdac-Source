USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_DATA_DELETE]    Script Date: 01/17/2011 10:11:51 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO



If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_DATA_DELETE]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_DATA_DELETE]
GO



/*
--------------------------------------------------------------------
TITLE 		: OLD DATA 삭제 처리 (최근 1년자료만 보관)   
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_JOB_DATA_DELETE   
--------------------------------------------------------------------
*/
CREATE            PROCEDURE [dbo].[SP_JOB_DATA_DELETE] 
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_DEL_365			AS VARCHAR(8)
  DECLARE @ls_DEL_007			AS VARCHAR(8)

  SELECT @ls_DEL_365 = convert(varchar(8), DATEADD(day, -365, getdate()), 112) 
  SELECT @ls_DEL_007 = convert(varchar(8), DATEADD(day, -07, getdate()), 112) 

  -------------------------------------------------------------------
  -- TH_DATA_DAY 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_DATA_DAY
   WHERE PROD_YMD	< @ls_DEL_365

  -------------------------------------------------------------------
  -- TH_DATA_MODEL 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_DATA_MODEL
   WHERE PROD_YMD	< @ls_DEL_365

  -------------------------------------------------------------------
  -- TH_DATA_TIME 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_DATA_TIME
   WHERE PROD_YMD	< @ls_DEL_365

  -------------------------------------------------------------------
  -- TH_INF_DATA 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_INF_DATA
   WHERE PROD_YMD				< @ls_DEL_007

  -------------------------------------------------------------------
  -- TH_ERROR 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_ERROR
   WHERE convert(varchar(8), ERR_DATE,112)	< @ls_DEL_007


  SET NOCOUNT OFF 

END













GO

