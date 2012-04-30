USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_MINUTE]    Script Date: 01/17/2011 10:13:02 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_MINUTE]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_MINUTE]
GO



/*
--------------------------------------------------------------------
TITLE 		: 1분단위 JOB 
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_JOB_MINUTE 
--------------------------------------------------------------------
*/
CREATE                  PROCEDURE [dbo].[SP_JOB_MINUTE] 
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_TIME	VARCHAR(10)
  DECLARE @ls_YMD 	VARCHAR(8)
  DECLARE @ls_YMD_BF	VARCHAR(8)

  SELECT @ls_TIME 	= SUBSTRING(CONVERT(VARCHAR(20), GETDATE(), 120), 12,5)
  SELECT @ls_YMD  	= CONVERT(VARCHAR(8),  GETDATE(), 112)
  SELECT @ls_YMD_BF 	= CONVERT(VARCHAR(8), DATEADD(day, -1, GETDATE()), 112)


  -------------------------------------------------------------------
  -- STEP-01 
  -- 	INTERFACE 된 생산정보로 
  --  		일자.SHIFT.시각 정보로 반영
  -------------------------------------------------------------------
  EXEC SP_JOB_DATA_PROCESS 


  -------------------------------------------------------------------
  -- STEP-02 
  -- 	SHIFT 변경 시각에 계획수량을 초기화 시킨다.  
  -------------------------------------------------------------------
  IF EXISTS
	(
	SELECT *
	   FROM TM_CODE
	 WHERE MCD		= '10'
	      AND SCD		= '1'
	      AND REMARK		LIKE '%' + SUBSTRING(CONVERT(VARCHAR(20),  GETDATE(), 120), 12, 5) + '%'
	)
  BEGIN
	UPDATE TM_CODE	
	       SET CDNAME		= '0', 
		REMARK		= SUBSTRING(CONVERT(VARCHAR(20),  GETDATE(), 120), 12, 5) 
	  WHERE MCD		= 'ZA'
	       AND SCD		= '01'
  END
  
  -----------------------------------------
	-- 시간별.일자별.모델별 가동율정보 생성  
	-----------------------------------------
	EXEC SP_JOB_DATA_SUM		@ls_YMD_BF, 'N' 
  
  -------------------------------------------------------------------
  -- STEP-03 
  -- 	1. 시간별.일자별.모델별 가동율정보 생성  
  --		(전일 실적자료를 가지고 집계한다)
  --	2. 비가동 적용유형을 설정한다. 
  -- 	3. 매월 1일에 EXCEL 파일을 생성한다.  
  -------------------------------------------------------------------
  IF (@ls_TIME = '07:59')
  BEGIN
	-----------------------------------------
	-- 시간별.일자별.모델별 가동율정보 생성  
	-----------------------------------------
	EXEC SP_JOB_DATA_SUM		@ls_YMD_BF, 'N' 

	-----------------------------------------
	-- 비가동 적용유형을 설정  
	-----------------------------------------
	EXEC SP_JOB_ADJUST_TYPE

	-----------------------------------------
	-- 매월 1일에 EXCEL 파일을 생성 
	-----------------------------------------
	IF (RIGHT(@ls_YMD,2) = '01')
	BEGIN
		EXEC SP_JOB_EXCEL_CREATE   
			'C:\data\', 
			'ORMS', 
			'DATA'
	END 
  END


  -------------------------------------------------------------------
  -- STEP-04 
  --  	1. OLD DATA 삭제처리 
  -- 	2. TRANSACTION LOG 정리
  -------------------------------------------------------------------
  IF (@ls_TIME = '12:20')
  BEGIN
	-----------------------------------------
	-- OLD DATA 삭제처리 
	-----------------------------------------
	EXEC SP_JOB_DATA_DELETE 

	-----------------------------------------
	-- TRANSACTION LOG 정리 
	-----------------------------------------
	--BACKUP LOG [ORMS] WITH NO_LOG
	BACKUP LOG [ORMS]
	
	DECLARE @SIZE INT
	DECLARE @NAME NVARCHAR(128)
	
	SELECT @SIZE=SIZE, @NAME=RTRIM(NAME)
	FROM SYSFILES
	WHERE FILEID = 2
	
	IF (@SIZE / 8) >= 128
	BEGIN
	DBCC SHRINKFILE(@NAME, 128)
	END  
  END


  SET NOCOUNT OFF  


END







GO

