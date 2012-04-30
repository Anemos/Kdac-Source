USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_DATA_TIME_NONE]    Script Date: 01/17/2011 10:12:27 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_DATA_TIME_NONE]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_DATA_TIME_NONE]
GO

/*
--------------------------------------------------------------------
TITLE 		: 비가동 시간정보를 ADD (1분단위)   
DATE		: 2010.10.16  
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_JOB_DATA_TIME_NONE   
--------------------------------------------------------------------
*/
CREATE              PROCEDURE [dbo].[SP_JOB_DATA_TIME_NONE]  
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_NOW_TIME			AS VARCHAR(5)
  DECLARE @ls_DATE_SHIFT		AS VARCHAR(20)
  DECLARE @ls_PROD_YMD		AS VARCHAR(8)
  DECLARE @ls_PROD_SHIFT		AS VARCHAR(1)
  DECLARE @li_CNT			AS INT


  -------------------------------------------------------------------
  -- STEP-01
  -- 	현재기준 생산일자.SHIFT 계산 
  -------------------------------------------------------------------
  SELECT @ls_DATE_SHIFT = dbo.FN_GET_DATE_SHIFT(GETDATE()) 

  -- 생산일자  
  SET @ls_PROD_YMD = LEFT(@ls_DATE_SHIFT, 8)

  -- SHIFT  
  SET @ls_PROD_SHIFT = RIGHT(@ls_DATE_SHIFT, 1)

  -- 현재일시 
  --	등록된 시간 이후에 반영되도록 수정
  --	예) 10:00분 의 비가동 '60'초는 10:01:00초에 반영되도록 함.
  --  
  SELECT @ls_NOW_TIME = SUBSTRING(CONVERT(VARCHAR(20), DATEADD(mi, -1, getdate()), 120), 12, 5)


  -------------------------------------------------------------------
  -- STEP-02
  -- 	생산일자.SHIFT 기준 비가동정보가 존재하지 않으면 생성  
  -------------------------------------------------------------------
  IF NOT EXISTS (SELECT * FROM TH_WORK_TIME_NONE
                            WHERE   PROD_YMD	= @ls_PROD_YMD
	                   AND   PROD_SHIFT	= @ls_PROD_SHIFT)
  BEGIN
	INSERT INTO TH_WORK_TIME_NONE
		(PROD_YMD, PROD_SHIFT, UNWORK_TIME)
	VALUES
		(@ls_PROD_YMD, @ls_PROD_SHIFT, 0)
  END


  -------------------------------------------------------------------
  -- STEP-03
  -- 	17:00 ~ 22:59 사이는 비가동으로 처리  
  -------------------------------------------------------------------
  IF (@ls_NOW_TIME >= '17:00') AND (@ls_NOW_TIME <= '22:59')
  BEGIN
	UPDATE TH_WORK_TIME_NONE
	       SET UNWORK_TIME 	= UNWORK_TIME + 60
	        WHERE PROD_YMD	= @ls_PROD_YMD
	             AND PROD_SHIFT	= @ls_PROD_SHIFT
	
	RETURN		
  END


  -------------------------------------------------------------------
  -- STEP-04
  -- 	기타 설정된 시간에는 비가동으로 처리  
  -------------------------------------------------------------------
  SELECT @li_CNT = dbo.FN_GET_WORK_TIME(@ls_NOW_TIME) 
  IF (@li_CNT = 1)
  BEGIN
	UPDATE TH_WORK_TIME_NONE
	       SET UNWORK_TIME 	= UNWORK_TIME + 60
	        WHERE PROD_YMD	= @ls_PROD_YMD
	             AND PROD_SHIFT	= @ls_PROD_SHIFT
  END


  SET NOCOUNT OFF 


END





GO

