USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_GET_MAIN_DATA]    Script Date: 01/17/2011 10:10:26 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO




If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_GET_MAIN_DATA]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_GET_MAIN_DATA]
GO






/*
--------------------------------------------------------------------
TITLE 		: 가동율 메인화면 DATA 조회  
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	호출주기 => 5초단위
	(가동율 PB 프로그램에서 호출)

	exec SP_GET_MAIN_DATA
--------------------------------------------------------------------
*/
CREATE                            PROCEDURE [dbo].[SP_GET_MAIN_DATA] 
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_MODEL_CODE		AS VARCHAR(10)
  DECLARE @ls_MODEL_NAME		AS VARCHAR(40)
  DECLARE @ls_PROD_YMD		AS VARCHAR(8)
  DECLARE @ls_PROD_SHIFT		AS VARCHAR(1)
  DECLARE @ls_DATE_SHIFT 		AS VARCHAR(20) 
  DECLARE @li_CNT			AS INT

  DECLARE @li_PROD_QTY 		AS INT
  DECLARE @li_PLAN_QTY 			AS INT
  DECLARE @li_ADD_QTY 			AS INT
  DECLARE @li_CYCLE_TIME		AS INT
  DECLARE @li_WORK_RATE		AS FLOAT
  DECLARE @li_BOF_RATE			AS FLOAT 
  DECLARE @li_TARGET_RATE		AS FLOAT 
  DECLARE @li_INPUT_MAN			AS INT
  DECLARE @ls_REMARK			AS VARCHAR(20)
  DECLARE @ls_BOF_HHMM		AS VARCHAR(10)
  DECLARE @ls_NOW_HHMM		AS VARCHAR(10)
  DECLARE @ls_17_19_OT			AS VARCHAR(1)
  DECLARE @ls_19_23_OT			AS VARCHAR(1)


  -- 임시 TABLE 생성  
  -- 
  CREATE TABLE #TMP_DATA (OP_TIME varchar (02))

  -- 현재기준 생산일자.SHIFT를 조회  
  -- 
  SELECT @ls_DATE_SHIFT = dbo.FN_GET_DATE_SHIFT(getdate())

  -- 생산일자  
  -- 
  SET @ls_PROD_YMD 	= LEFT(@ls_DATE_SHIFT, 8)

  -- SHIFT 
  -- 
  SET @ls_PROD_SHIFT 	= RIGHT(@ls_DATE_SHIFT, 1)

  -- 주간 2시간 OT 여부 
  -- 
  SELECT @ls_17_19_OT	= ETC01 
     FROM TM_CODE
   WHERE MCD		= '50'
        AND SCD		= '01'

  IF (@ls_17_19_OT	= 'N')
  BEGIN
	INSERT INTO #TMP_DATA VALUES ('17')
	INSERT INTO #TMP_DATA VALUES ('18')
  END

  -- 야간 4시간 조출 여부 
  -- 
  SELECT @ls_19_23_OT	= ETC01 
     FROM TM_CODE
   WHERE MCD		= '50'
        AND SCD		= '02'

  IF (@ls_19_23_OT	= 'N')
  BEGIN
	INSERT INTO #TMP_DATA VALUES ('19')
	INSERT INTO #TMP_DATA VALUES ('20')
	INSERT INTO #TMP_DATA VALUES ('21')
	INSERT INTO #TMP_DATA VALUES ('22')
  END

  ------------------------------------------------------------------
  -- STEP-01
  -- 	가장 최근에 수신된 모델 정보를 조회 
  ------------------------------------------------------------------
  SET @ls_MODEL_CODE		= '' 
  SELECT @ls_MODEL_CODE	= MODEL 
     FROM TH_INF_DATA
   WHERE RecordID = 
	(SELECT MAX(RecordID)
	     FROM TH_INF_DATA)

  IF (@ls_MODEL_CODE = '')
  BEGIN
	-- 자료가 없으면 초기값으로 DISPLAY
	--  
	SELECT   ''	AS MODEL_CODE,	-- 모델코드
		 ''	AS MODEL_NAME,	-- 모델명 
		 0	AS PLAN_QTY,		-- 계획수량 		
		 0	AS PROD_QTY,		-- 실적수량
		 0	AS WORK_RATE,		-- 가동율 
		 0 	AS BF_WORK_RATE,	-- 전일 가동율 
		 0 	AS TARGET_RATE,	-- 표준 가동율 
		 0 	AS INPUT_MAN,		-- 투입인원  
	 	 0	AS CYCLE_TIME		-- CYCLE TIME (현재모델) 
	RETURN
  END

  -- 모델명 조회 
  -- 
  SELECT @ls_MODEL_NAME	= dbo.FN_GET_MODEL_NAME(@ls_MODEL_CODE)


  ------------------------------------------------------------------
  -- STEP-02
  -- 	실적 수량을 조회 
  ------------------------------------------------------------------
  SELECT @li_PROD_QTY		= SUM(PROD_QTY)
     FROM TH_INF_DATA
   WHERE PROD_YMD		= @ls_PROD_YMD
        AND PROD_SHIFT		= @ls_PROD_SHIFT
        AND LEFT(PROD_HH,2)	NOT IN 
				(SELECT OP_TIME FROM #TMP_DATA)


  ------------------------------------------------------------------
  -- STEP-03
  -- 	계획 수량을 계산  
  ------------------------------------------------------------------

  -- CYCLE TIME
  -- 	제일 마지막 생산한 모델의 CYCLE TIME
  -- 
  SET @li_CYCLE_TIME 		= 0
  SELECT @li_CYCLE_TIME 		= CYCLE_TIME
     FROM TM_MODEL_CYCLE
   WHERE MODEL			= @ls_MODEL_CODE
        AND FLAG			= 'Y'


  -- 계획수량 증가
  -- 
  SET @li_PLAN_QTY 	= 0
  SET @ls_BOF_HHMM	= ''


  -- 현재시점 최종 계획수량, 반영시각 조회  
  -- 
  SELECT @li_PLAN_QTY	= CONVERT(INT, ISNULL(CDNAME,'0')),
	 @ls_BOF_HHMM	= REMARK 
    FROM TM_CODE
  WHERE MCD		= 'ZA'
       AND SCD		= '01'


  SELECT @ls_NOW_HHMM	= SUBSTRING(CONVERT(VARCHAR(20),  GETDATE(), 120), 12, 5) 

  -- SHIFT 변경 시각은 RESET 처리
  --	해당 시작시각에 한번만 RESET 되도록 
  -- 
  SELECT @ls_REMARK	= REMARK
     FROM TM_CODE
   WHERE MCD		= '10'
        AND SCD		= '1'

  IF ((@ls_NOW_HHMM = LEFT(@ls_REMARK, 5)) OR (@ls_NOW_HHMM = RIGHT(@ls_REMARK, 5))) AND
	(@ls_BOF_HHMM	<> @ls_NOW_HHMM)  	
  BEGIN
	SET @li_PLAN_QTY	= 0	
  END

  -- 현재적용 비가동 시간대의 TIME은 계획수량 증가 안시킴 
  -- 
  IF EXISTS 
	( 
	SELECT *
	   FROM TM_CODE
	 WHERE MCD		 	= 
			(
			SELECT CDNAME
			   FROM TM_CODE
			 WHERE MCD		= '90'
			      AND SCD		= '01'
			)
	      AND SCD			<> '00'
	      AND @ls_NOW_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_NOW_HHMM		<= RIGHT(CDNAME,5) 
	)
	SET @li_ADD_QTY	= 0
  ELSE
	SET @li_ADD_QTY	= 1


  -- OT(17-19).조출(19-23) 여부를 판단하여  
  --	계획수량을 증가를 결정함.
  --  
  IF (@ls_17_19_OT = 'N')
  BEGIN
	IF (LEFT(@ls_NOW_HHMM, 2) >= '17') AND (LEFT(@ls_NOW_HHMM, 2) < '19') 	
		SET @li_ADD_QTY	= 0
  END
  IF (@ls_19_23_OT = 'N')
  BEGIN
	IF (LEFT(@ls_NOW_HHMM, 2) >= '19') AND (LEFT(@ls_NOW_HHMM, 2) < '23') 	
		SET @li_ADD_QTY	= 0
  END

  -- 계획수량 증가처리 
  --
  SET @li_PLAN_QTY 	= @li_PLAN_QTY + @li_ADD_QTY
  UPDATE TM_CODE	
         SET CDNAME	= CONVERT(VARCHAR(10), @li_PLAN_QTY), 
	  REMARK	= @ls_NOW_HHMM 
    WHERE MCD		= 'ZA'
         AND SCD		= '01'



  ------------------------------------------------------------------
  -- STEP-04
  -- 	가동을 계산  
  --	= 생산수량 / 계획수량 * 100 
  ------------------------------------------------------------------
  IF (@li_PLAN_QTY = 0)
	SELECT @li_WORK_RATE = 0
  ELSE 
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
  -- STEP-07
  --	일자별 가동율 UPDATE 
  ------------------------------------------------------------------
  IF EXISTS 
	(SELECT *
	    FROM TH_DATA_DAY
	  WHERE PROD_YMD	= @ls_PROD_YMD
	       AND PROD_SHIFT	= @ls_PROD_SHIFT)
      BEGIN
	UPDATE TH_DATA_DAY
	      SET  WORK_QTY	= @li_PROD_QTY,
		WORK_RATE	= ROUND(ISNULL(@li_WORK_RATE,0),1)
	  WHERE PROD_YMD	= @ls_PROD_YMD
	       AND PROD_SHIFT	= @ls_PROD_SHIFT
      END
  ELSE
      BEGIN
	INSERT INTO TH_DATA_DAY
		(PROD_YMD, PROD_SHIFT, WORK_QTY, WORK_RATE)
	VALUES
		(@ls_PROD_YMD, @ls_PROD_SHIFT, @li_PROD_QTY, ROUND(ISNULL(@li_WORK_RATE,0),1))
      END


  ------------------------------------------------------------------
  -- STEP-08
  --	모델별 계획수량 UPDATE 
  ------------------------------------------------------------------
  IF EXISTS 
	(SELECT *
	    FROM TH_DATA_MODEL
	  WHERE PROD_YMD	= @ls_PROD_YMD
	       AND MODEL		= @ls_MODEL_CODE)
      BEGIN
	UPDATE TH_DATA_MODEL
	      SET  PLAN_QTY	= PLAN_QTY + @li_ADD_QTY
	  WHERE PROD_YMD	= @ls_PROD_YMD
	       AND MODEL		= @ls_MODEL_CODE
      END
  ELSE
      BEGIN
	INSERT INTO TH_DATA_MODEL
		(PROD_YMD, MODEL, WORK_QTY, WORK_RATE, PLAN_QTY)
	VALUES
		(@ls_PROD_YMD, @ls_MODEL_CODE, 0, 0, @li_ADD_QTY)
      END


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
	 ROUND(ISNULL(@li_INPUT_MAN,0),1) 	AS INPUT_MAN,		-- 투입인원  
 	 @li_CYCLE_TIME				AS CYCLE_TIME		-- CYCLE TIME (현재모델) 

  SET NOCOUNT OFF  

END











GO

