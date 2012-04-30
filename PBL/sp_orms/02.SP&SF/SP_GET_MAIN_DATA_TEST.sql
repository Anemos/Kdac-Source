USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_GET_MAIN_DATA_TEST]    Script Date: 01/17/2011 10:10:39 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_GET_MAIN_DATA_TEST]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_GET_MAIN_DATA_TEST]
GO



/*
--------------------------------------------------------------------
TITLE 		: 가동율 메인화면 DATA 조회  
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	호출주기 => 5초단위
	(가동율 PB 프로그램에서 호출)
7740
7802
	exec SP_GET_MAIN_DATA_TEST
--------------------------------------------------------------------
*/
CREATE                          PROCEDURE [dbo].[SP_GET_MAIN_DATA_TEST] 
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_MODEL_CODE		AS VARCHAR(10)
  DECLARE @ls_MODEL_NAME		AS VARCHAR(40)
  DECLARE @ls_PROD_YMD		AS VARCHAR(8)
  DECLARE @ls_PROD_SHIFT		AS VARCHAR(1)
  DECLARE @ls_DATE_SHIFT 		AS VARCHAR(20) 
  DECLARE @ls_SHIFT_START 		AS VARCHAR(20) 
  DECLARE @ls_START_TIME 		AS VARCHAR(20) 
  DECLARE @ls_END_TIME 			AS VARCHAR(20) 
  DECLARE @ls_Now_HH 			AS VARCHAR(2)
  DECLARE @ls_Now_HHMM		AS VARCHAR(5)
  DECLARE @li_CNT			AS INT

  DECLARE @li_PROD_QTY 		AS INT
  DECLARE @li_PLAN_QTY 			AS INT
  DECLARE @li_CYCLE_TIME		AS INT
  DECLARE @li_NON_WORK_TIME		AS INT
  DECLARE @li_TOTAL_TIME		AS INT
  DECLARE @li_WORK_TIME		AS INT
  DECLARE @li_WORK_RATE		AS FLOAT
  DECLARE @li_BOF_RATE			AS FLOAT 
  DECLARE @li_TARGET_RATE		AS FLOAT 
  DECLARE @li_INPUT_MAN			AS INT


  -- 현재기준 생산일자.SHIFT를 조회  
  SELECT @ls_DATE_SHIFT = dbo.FN_GET_DATE_SHIFT(getdate())

  -- 생산일자  
  SET @ls_PROD_YMD = LEFT(@ls_DATE_SHIFT, 8)

  -- 생산 근무조 
  SET @ls_PROD_SHIFT = RIGHT(@ls_DATE_SHIFT, 1)


  ------------------------------------------------------------------
  -- STEP-01
  -- 	가장 최근에 수신된 모델 정보를 조회 
  ------------------------------------------------------------------
  SELECT @ls_MODEL_CODE	= MODEL 
     FROM TH_INF_DATA
   WHERE RecordID = 
	(SELECT MAX(RecordID)
	     FROM TH_INF_DATA)


  -- 모델명 조회 
  SELECT @ls_MODEL_NAME	= dbo.FN_GET_MODEL_NAME(@ls_MODEL_CODE)


  ------------------------------------------------------------------
  -- STEP-02
  -- 	실적 수량을 조회 
  ------------------------------------------------------------------
  SELECT @li_PROD_QTY		= SUM(PROD_QTY)
     FROM TH_INF_DATA
   WHERE PROD_YMD		= @ls_PROD_YMD
        AND PROD_SHIFT		= @ls_PROD_SHIFT
        AND LEFT(PROD_HH,2)	NOT IN ('17', '18', '19', '20', '21', '22')


  ------------------------------------------------------------------
  -- STEP-03
  -- 	계획 수량을 계산  
  ------------------------------------------------------------------

  -- CYCLE TIME
  -- 
  SET @li_CYCLE_TIME 		= 0
  SELECT @li_CYCLE_TIME		= AVG(CYCLE_TIME)
     FROM TH_INF_DATA
   WHERE PROD_YMD		= @ls_PROD_YMD
        AND PROD_SHIFT		= @ls_PROD_SHIFT
        AND LEFT(PROD_HH,2)	NOT IN ('17', '18', '19', '20', '21', '22')
        AND ISNULL( CYCLE_TIME,0)	<> 0

  IF (@li_CYCLE_TIME IS NULL) OR (@li_CYCLE_TIME = 0)
  BEGIN
	  SELECT @li_CYCLE_TIME = CYCLE_TIME
	     FROM TH_INF_DATA
	   WHERE RecordID = 
		(SELECT MAX(RecordID)
		     FROM TH_INF_DATA)
  END


  -- 비가동 시간 (단위, Sec)
  -- 
  SET @li_NON_WORK_TIME	= 0 
  SELECT @li_NON_WORK_TIME	= UNWORK_TIME
     FROM TH_WORK_TIME_NONE
   WHERE PROD_YMD		= @ls_PROD_YMD
        AND PROD_SHIFT		= @ls_PROD_SHIFT


  -- 작업시간 (단위, Sec)
  -- 	SHIFT 시작시각부터 현재시각까지의 시간  
  --
  SELECT @ls_SHIFT_START = LEFT(REMARK,5) 
     FROM TM_CODE
   WHERE MCD		= '10'
        AND SCD		= @ls_PROD_SHIFT

  SELECT @ls_START_TIME = 
	SUBSTRING(@ls_PROD_YMD,1,4) + '-' + 
	SUBSTRING(@ls_PROD_YMD,5,2) + '-' + 
	SUBSTRING(@ls_PROD_YMD,7,2) + ' ' +
	@ls_SHIFT_START + ':00'



  SET @ls_Now_HH = convert(varchar(2), GETDATE(), 114)
  SET @ls_Now_HHMM = convert(varchar(5), GETDATE(), 114)
  SELECT @li_CNT = dbo.FN_GET_WORK_TIME(@ls_Now_HHMM) 


  IF (@ls_Now_HH >= '17') AND (@ls_Now_HH <= '22')
      BEGIN
	SET @ls_END_TIME =  LEFT(convert(varchar(20), GETDATE(), 120),17) + '00'
	SELECT @li_TOTAL_TIME = DATEDIFF(ss, @ls_START_TIME, @ls_END_TIME)
      END
  ELSE IF (@ls_Now_HH >= '08') AND (@ls_Now_HH <= '17')
	IF (@li_CNT = 0)
	    BEGIN
		-- 가동시간은 실시간 반영
		SELECT @li_TOTAL_TIME = DATEDIFF(mi, @ls_START_TIME, GETDATE())
		  PRINT '작업.' +CONVERT(VARCHAR(10), @li_TOTAL_TIME) 
	    END
	ELSE
	    BEGIN
		SET @ls_END_TIME =  LEFT(convert(varchar(20), GETDATE(), 120),17) + '00'
		SELECT @li_TOTAL_TIME = DATEDIFF(mi, @ls_START_TIME, @ls_END_TIME)
		  PRINT '휴식.' +CONVERT(VARCHAR(10), @li_TOTAL_TIME) 
	    END 
  ELSE 
      BEGIN
	IF (@li_CNT = 0)
	    BEGIN
		SELECT @li_TOTAL_TIME = DATEDIFF(ss, @ls_START_TIME, GETDATE())
	    END
	ELSE
	    BEGIN
		SET @ls_END_TIME =  LEFT(convert(varchar(20), GETDATE(), 120),17) + '00'
		SELECT @li_TOTAL_TIME = DATEDIFF(ss, @ls_START_TIME, @ls_END_TIME)
	    END
      END

  --PRINT CONVERT(VARCHAR(10), @li_TOTAL_TIME) 

/*

  -- 가동시간 (단위, Sec)
  -- 	= 작업시간 - 비가동 시간
  -- 	
  SELECT @li_WORK_TIME = @li_TOTAL_TIME  - @li_NON_WORK_TIME


  -- 계획수량 
  --	= 가동시간 / CYCLE TIME
  -- 
  IF (@li_CYCLE_TIME = 0)
	SELECT @li_PLAN_QTY = 0 
  ELSE
	SELECT @li_PLAN_QTY = (@li_WORK_TIME) / @li_CYCLE_TIME

*/

  RETURN







  IF (@li_PLAN_QTY < 0) 
	SET @li_PLAN_QTY = 0

  ------------------------------------------------------------------
  -- STEP-04
  -- 	가동을 계산  
  --	= 생산수량 / 계획수량 * 100 
  ------------------------------------------------------------------
  SELECT @li_WORK_RATE = ROUND(CONVERT(FLOAT,@li_PROD_QTY) / CONVERT(FLOAT, @li_PLAN_QTY) * 100, 1)


  ------------------------------------------------------------------
  -- STEP-05
  -- 	전일 가동율 조회   
  ------------------------------------------------------------------
  SET @li_BOF_RATE 		= 0
  SELECT @li_BOF_RATE 		= ROUND(WORK_RATE,1)
    FROM TH_DATA_DAY
  WHERE RecordID		= 
	(SELECT MAX(RecordID)
	    FROM TH_DATA_DAY
	  WHERE PROD_YMD <> @ls_PROD_YMD)

  IF (@li_BOF_RATE IS NULL)
	SET @li_BOF_RATE = 0


  ------------------------------------------------------------------
  -- STEP-06
  -- 	표준 가동율. 투입인원 조회   
  ------------------------------------------------------------------
  SET @li_TARGET_RATE 		= 0
  SET @li_INPUT_MAN		= 0

  SELECT TOP 1 
	 @li_TARGET_RATE	= TARGET_RATE,
	 @li_INPUT_MAN		= INPUT_MAN
     FROM TM_MODEL_CYCLE
   WHERE MODEL			= @ls_MODEL_CODE
        AND FLAG			= 'Y'

  IF (@@ROWCOUNT < 1)
  BEGIN
	SELECT TOP 1 
	 	@li_TARGET_RATE	= TARGET_RATE,
	 	@li_INPUT_MAN		= INPUT_MAN
	  FROM TM_MODEL_CYCLE
	WHERE MODEL			= @ls_MODEL_CODE
  END

  IF (@li_TARGET_RATE IS NULL)
	SET @li_TARGET_RATE = 0
  IF (@li_INPUT_MAN IS NULL)
	SET @li_INPUT_MAN = 0


  ------------------------------------------------------------------
  -- STEP-END
  -- 	계산된 자료를 리턴한다.  
  ------------------------------------------------------------------
  SELECT @ls_MODEL_CODE			AS MODEL_CODE,	-- 모델코드
	 @ls_MODEL_NAME			AS MODEL_NAME,	-- 모델명 
	 ISNULL(@li_PLAN_QTY,0)			AS PLAN_QTY,		-- 계획수량 		
	 ISNULL(@li_PROD_QTY,0)			AS PROD_QTY,		-- 실적수량
	 ROUND(ISNULL(@li_WORK_RATE,0),1)	AS WORK_RATE,		-- 가동율 
	 ROUND(ISNULL(@li_BOF_RATE,0),1) 	AS BF_WORK_RATE,	-- 전일 가동율 
	 ROUND(ISNULL(@li_TARGET_RATE,0),1) 	AS TARGET_RATE,	-- 표준 가동율 
	 ROUND(ISNULL(@li_INPUT_MAN,0),1) 	AS INPUT_MAN		-- 투입인원  
 

  SET NOCOUNT OFF  

END









GO

