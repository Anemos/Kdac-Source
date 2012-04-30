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
MODIFIED : 2011.12.13 모델별 사이클타임을 초에서 밀리초로 변경함
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
  DECLARE @li_CYCLE_TIME		AS NUMERIC(12,1)
  DECLARE @li_WORK_RATE		AS FLOAT
  DECLARE @li_BOF_RATE			AS FLOAT 
  DECLARE @li_TARGET_RATE		AS FLOAT 
  DECLARE @li_INPUT_MAN			AS INT
  DECLARE @ls_REMARK			AS VARCHAR(20)
  DECLARE @ls_NOW_DATETIME AS DATETIME     -- 현재실행 일,시,분,초,밀리초
  DECLARE @ls_SHIFT_DATETIME AS DATETIME   -- 주/야실행 일,시,분,초,밀리초
  DECLARE @ls_ADD_DATETIME AS DATETIME     -- 추가수량만큼 증가된 일,시,분,초,밀리초
  DECLARE @ls_BOF_HHMM		AS VARCHAR(10)      -- 최종실행시간
  DECLARE @ls_DAY_DATE    AS VARCHAR(10)      -- 최종실행일자
  DECLARE @ls_NOW_HHMM		AS VARCHAR(10)      -- 현재실행시간
  DECLARE @ls_NOW_MS		  AS VARCHAR(20)      -- 시,분,초,밀리초
  DECLARE @ls_NONE_HHMM_MAX   AS VARCHAR(10)  -- 비가동 완료 시분
  DECLARE @ls_NONE_HHMM_MIN   AS VARCHAR(10)  -- 비가동 시작 시분
  DECLARE @ls_DAY_SHIFT     AS CHAR(1)          -- 주/야 쉬프트
  DECLARE @ls_DAY_HHMM    AS VARCHAR(10)      -- 주/야 시작시분
  DECLARE @li_NONE_TIME			AS INT            -- 최종,현재사이 비가동시간합계
  DECLARE @ls_17_19_OT			AS VARCHAR(1)
  DECLARE @ls_19_23_OT			AS VARCHAR(1)
  DECLARE @ls_CDNAME			AS VARCHAR(60)
  DECLARE @ls_ETC01			AS VARCHAR(60)
  DECLARE @ls_DEBUG  AS CHAR(4)

  -- DEBUGGINN MODE 설정
  SET @ls_DEBUG = 'TRUE'
  
  -- 임시 TABLE 생성  
  -- 
  CREATE TABLE #TMP_DATA (OP_TIME varchar (02))
  
  ----------
  -- STEP-00
  -- 현재일시 분 초 밀리초
  ----------
  SELECT @ls_NOW_DATETIME	= GETDATE()
  SET @ls_NOW_MS	= SUBSTRING(CONVERT(VARCHAR(30),@ls_NOW_DATETIME,121), 12, 12) 
  SET @ls_NOW_HHMM = SUBSTRING(@ls_NOW_MS,1,5)
  
  -- 현재기준 생산일자.SHIFT를 조회  
  -- 
  SELECT @ls_DATE_SHIFT = dbo.FN_GET_DATE_SHIFT(@ls_NOW_DATETIME)

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
  
  -- SHIFT 변경 시각
  -- 
  SELECT @ls_REMARK	= REMARK
     FROM TM_CODE
   WHERE MCD		= '10'
        AND SCD		= '1'

  -- 주간 시작
  IF ((@ls_NOW_HHMM >= LEFT(@ls_REMARK, 5)) AND (@ls_NOW_HHMM < RIGHT(@ls_REMARK, 5)))  	
    SET @ls_SHIFT_DATETIME = CONVERT(DATETIME,SUBSTRING(CONVERT(VARCHAR(20),CAST(@ls_PROD_YMD AS DATETIME),120),1,11) + LEFT(@ls_REMARK, 5) + ':00.000',121)
  ELSE
    SET @ls_SHIFT_DATETIME = CONVERT(DATETIME,SUBSTRING(CONVERT(VARCHAR(20),CAST(@ls_PROD_YMD AS DATETIME),120),1,11) + RIGHT(@ls_REMARK, 5) + ':00.000',121)
  
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
        AND INF_TIME >= @ls_SHIFT_DATETIME
        AND INF_TIME <= @ls_NOW_DATETIME
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


  -- 현재시점 최종 계획수량, 반영시각, 일자 조회  
  -- 
  SELECT @li_PLAN_QTY	= CONVERT(INT, ISNULL(CDNAME,'0')),
	 @ls_BOF_HHMM	= REMARK,
	 @ls_DAY_DATE = ETC02,
	 @ls_CDNAME = CDNAME,
	 @ls_ETC01 = ETC01
    FROM TM_CODE
  WHERE MCD		= 'ZA'
       AND SCD		= '01'
  
  -- 최종실행일자가 ''이거나, 현재일보다 적은경우
  -- 자료를 초기값으로 DISPLAY
	--  
  if ( @ls_DAY_DATE <> SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME, 120), 1, 10) )
    BEGIN
    if (@ls_BOF_HHMM < RIGHT(@ls_REMARK, 5))  -- 최종실행시간이 야간시작보다 적은경우
      BEGIN
	      UPDATE TM_CODE	
            SET CDNAME	= CONVERT(VARCHAR(10), 0), 
	          REMARK	= RIGHT(@ls_REMARK, 5),
	          ETC01 = '00.000',
	          ETC02 = SUBSTRING(CONVERT(VARCHAR(20),DATEADD(DD,-1,@ls_NOW_DATETIME), 120), 1, 10)
        WHERE MCD		= 'ZA'
            AND SCD		= '01'
        
        if @ls_DEBUG = 'TRUE'
          BEGIN
            ------ 야간데이타 검증용으로 추가함 2011.12.26
            -- create history data
            INSERT INTO ORMS.dbo.TH_HISTORY_STOCK
            (CreateDate,ModelCode,ModelName,PlanQty,ProdQty
            ,WorkRate,BofRate,TargetRate,InputMan,CycleTime,CdName,Remark,Etc01)
            VALUES(@ls_NOW_DATETIME,@ls_MODEL_CODE,@ls_MODEL_NAME,
            0,0,0,0,0,0,1,@ls_CDNAME,@ls_BOF_HHMM,@ls_ETC01)
          END
        
        SELECT   @ls_MODEL_CODE			AS MODEL_CODE,	-- 모델코드
	      @ls_MODEL_NAME			AS MODEL_NAME,	-- 모델명 
		    0	AS PLAN_QTY,		-- 계획수량 		
		    0	AS PROD_QTY,		-- 실적수량
		    0	AS WORK_RATE,		-- 가동율 
		    0 	AS BF_WORK_RATE,	-- 전일 가동율 
		    0 	AS TARGET_RATE,	-- 표준 가동율 
		    0 	AS INPUT_MAN,		-- 투입인원  
	 	    0	AS CYCLE_TIME		-- CYCLE TIME (현재모델) 
	      RETURN
      END
    if (@ls_NOW_HHMM > LEFT(@ls_REMARK, 5))  --현재시간이 주간시작보다 큰경우
      BEGIN
        UPDATE TM_CODE	
            SET CDNAME	= CONVERT(VARCHAR(10), 0), 
	          REMARK	= LEFT(@ls_REMARK, 5),
	          ETC01 = '00.000',
	          ETC02 = SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME, 120), 1, 10)
        WHERE MCD		= 'ZA'
            AND SCD		= '01'
        
        if @ls_DEBUG = 'TRUE'
          BEGIN
            ------ 야간데이타 검증용으로 추가함 2011.12.26
            -- create history data
            INSERT INTO ORMS.dbo.TH_HISTORY_STOCK
            (CreateDate,ModelCode,ModelName,PlanQty,ProdQty
            ,WorkRate,BofRate,TargetRate,InputMan,CycleTime,CdName,Remark,Etc01)
            VALUES(@ls_NOW_DATETIME,@ls_MODEL_CODE,@ls_MODEL_NAME,
            0,0,0,0,0,0,2,@ls_CDNAME,@ls_BOF_HHMM,@ls_ETC01)
          END
        
        SELECT   @ls_MODEL_CODE			AS MODEL_CODE,	-- 모델코드
	      @ls_MODEL_NAME			AS MODEL_NAME,	-- 모델명 
		    0	AS PLAN_QTY,		-- 계획수량 		
		    0	AS PROD_QTY,		-- 실적수량
		    0	AS WORK_RATE,		-- 가동율 
		    0 	AS BF_WORK_RATE,	-- 전일 가동율 
		    0 	AS TARGET_RATE,	-- 표준 가동율 
		    0 	AS INPUT_MAN,		-- 투입인원  
	 	    0	AS CYCLE_TIME		-- CYCLE TIME (현재모델) 
	      RETURN
      END
    END
  else
    BEGIN
    -- 최종실행시간이 주간시작보다 적은면서 현재시간이 주간시작보다 큰경우
    if (@ls_BOF_HHMM < LEFT(@ls_REMARK, 5) and @ls_NOW_HHMM > LEFT(@ls_REMARK, 5)) or
        (@ls_BOF_HHMM <> @ls_NOW_HHMM and @ls_NOW_HHMM = LEFT(@ls_REMARK, 5))
      BEGIN
	      UPDATE TM_CODE	
            SET CDNAME	= CONVERT(VARCHAR(10), 0), 
	          REMARK	= LEFT(@ls_REMARK, 5),
	          ETC01 = '00.000',
	          ETC02 = SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME, 120), 1, 10)
        WHERE MCD		= 'ZA'
            AND SCD		= '01'
        
        if @ls_DEBUG = 'TRUE'
          BEGIN
            ------ 야간데이타 검증용으로 추가함 2011.12.26
            -- create history data
            INSERT INTO ORMS.dbo.TH_HISTORY_STOCK
            (CreateDate,ModelCode,ModelName,PlanQty,ProdQty
            ,WorkRate,BofRate,TargetRate,InputMan,CycleTime,CdName,Remark,Etc01)
            VALUES(@ls_NOW_DATETIME,@ls_MODEL_CODE,@ls_MODEL_NAME,
            0,0,0,0,0,0,3,@ls_CDNAME,@ls_BOF_HHMM,@ls_ETC01)
          END
        
        SELECT   @ls_MODEL_CODE			AS MODEL_CODE,	-- 모델코드
	      @ls_MODEL_NAME			AS MODEL_NAME,	-- 모델명 
		    0	AS PLAN_QTY,		-- 계획수량 		
		    0	AS PROD_QTY,		-- 실적수량
		    0	AS WORK_RATE,		-- 가동율 
		    0 	AS BF_WORK_RATE,	-- 전일 가동율 
		    0 	AS TARGET_RATE,	-- 표준 가동율 
		    0 	AS INPUT_MAN,		-- 투입인원  
	 	    0	AS CYCLE_TIME		-- CYCLE TIME (현재모델) 
	      RETURN
      END
    -- 최종실행시간이 야간시작보다 적은면서 현재시간이 야간시작보다 큰경우
    if (@ls_BOF_HHMM < RIGHT(@ls_REMARK, 5) and @ls_NOW_HHMM > RIGHT(@ls_REMARK, 5)) or
        (@ls_BOF_HHMM <> @ls_NOW_HHMM and @ls_NOW_HHMM = RIGHT(@ls_REMARK, 5))
      BEGIN
        UPDATE TM_CODE	
            SET CDNAME	= CONVERT(VARCHAR(10), 0), 
	          REMARK	= RIGHT(@ls_REMARK, 5),
	          ETC01 = '00.000',
	          ETC02 = SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME, 120), 1, 10)
        WHERE MCD		= 'ZA'
            AND SCD		= '01'
        
        if @ls_DEBUG = 'TRUE'
          BEGIN
            ------ 데이타 검증용으로 추가함 2011.12.26
            -- create history data
            INSERT INTO ORMS.dbo.TH_HISTORY_STOCK
            (CreateDate,ModelCode,ModelName,PlanQty,ProdQty
            ,WorkRate,BofRate,TargetRate,InputMan,CycleTime,CdName,Remark,Etc01)
            VALUES(@ls_NOW_DATETIME,@ls_MODEL_CODE,@ls_MODEL_NAME,
            0,0,0,0,0,0,4,@ls_CDNAME,@ls_BOF_HHMM,@ls_ETC01)
          END
        
        SELECT   @ls_MODEL_CODE			AS MODEL_CODE,	-- 모델코드
	      @ls_MODEL_NAME			AS MODEL_NAME,	-- 모델명 
		    0	AS PLAN_QTY,		-- 계획수량 		
		    0	AS PROD_QTY,		-- 실적수량
		    0	AS WORK_RATE,		-- 가동율 
		    0 	AS BF_WORK_RATE,	-- 전일 가동율 
		    0 	AS TARGET_RATE,	-- 표준 가동율 
		    0 	AS INPUT_MAN,		-- 투입인원  
	 	    0	AS CYCLE_TIME		-- CYCLE TIME (현재모델) 
	      RETURN
      END
    END
  -- 현재적용 비가동 시간대의 TIME은 계획수량 증가 안시킴 
  -- 
  IF EXISTS ( 
	    SELECT *
	    FROM TM_CODE
	    WHERE MCD		 	= 
			( SELECT CDNAME
			   FROM TM_CODE
			 WHERE MCD		= '90'
			      AND SCD		= '01'
			)
	      AND SCD			<> '00'
	      AND @ls_NOW_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_NOW_HHMM		<= RIGHT(CDNAME,5) 
	  )
	    BEGIN
	      SET @li_ADD_QTY	= 0
	      SELECT @ls_NONE_HHMM_MAX = MAX(RIGHT(CDNAME,5)),
	        @ls_NONE_HHMM_MIN = MIN(LEFT(CDNAME,5))
	      FROM TM_CODE
	      WHERE MCD		 	= 
			    ( SELECT CDNAME
			      FROM TM_CODE
			      WHERE MCD		= '90'
			      AND SCD		= '01'
			    )
	      AND SCD			<> '00'
	      AND @ls_NOW_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_NOW_HHMM		<= RIGHT(CDNAME,5)
	    END
  ELSE
	    SET @li_ADD_QTY	= 1
  
  -- 최종실행시간과 현재시간사이의 비가동시간 합
  SELECT @li_NONE_TIME = ISNULL(SUM(DATEDIFF(MS,
          CASE WHEN LEFT(CDNAME,5) < LEFT(@ls_REMARK, 5) THEN
            CAST( SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME, 120), 1, 11) + LEFT(CDNAME,5) + ':00.000'  AS DATETIME)
          ELSE
            CAST( SUBSTRING(CONVERT(VARCHAR(20),CAST(@ls_PROD_YMD AS DATETIME),120),1,11) + LEFT(CDNAME,5) + ':00.000'  AS DATETIME)
          END,
          CASE WHEN RIGHT(CDNAME,5) < LEFT(@ls_REMARK, 5) THEN
            CAST( SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME,120), 1, 11) + RIGHT(CDNAME,5) + ':59.999' AS DATETIME)
          ELSE
            CAST( SUBSTRING(CONVERT(VARCHAR(20),CAST(@ls_PROD_YMD AS DATETIME),120),1,11) + RIGHT(CDNAME,5) + ':59.999' AS DATETIME)
          END) ),0)
	    FROM TM_CODE
	    WHERE MCD		 	= 
			( SELECT CDNAME
			   FROM TM_CODE
			 WHERE MCD		= '90'
			      AND SCD		= '01'
			)
	      AND SCD			<> '00'
	      AND @ls_BOF_HHMM		<= LEFT(CDNAME,5) 
	      AND @ls_NOW_HHMM		>= RIGHT(CDNAME,5)
	
  -- OT(17-19).조출(19-23) 여부를 판단하여  
  --	계획수량을 증가를 결정함.
  --  
  IF (@ls_17_19_OT = 'N')
  BEGIN
	IF (LEFT(@ls_NOW_HHMM, 2) >= '17') AND (LEFT(@ls_NOW_HHMM, 2) < '19') 	
		SET @li_ADD_QTY	= -1
  END
  IF (@ls_19_23_OT = 'N')
  BEGIN
	IF (LEFT(@ls_NOW_HHMM, 2) >= '19') AND (LEFT(@ls_NOW_HHMM, 2) < '23') 	
		SET @li_ADD_QTY	= -1
  END

  -- 계획수량 증가처리 
  -- FLOOR(DIFF_TIME / @li_CYCLE_TIME)
  
  IF (@li_ADD_QTY > 0)
    BEGIN
      SELECT @li_ADD_QTY =
        FLOOR((DATEDIFF(MS,CAST( ETC02 + ' ' + REMARK + ':' + ETC01 AS DATETIME),
          CAST( SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME,120), 1, 11) + @ls_NOW_MS AS DATETIME)) - @li_NONE_TIME) / (@li_CYCLE_TIME * 1000))
      FROM TM_CODE
      WHERE MCD		= 'ZA'
        AND SCD		= '01'
        
      IF (@li_ADD_QTY > 0)
        BEGIN
          SET @li_PLAN_QTY 	= @li_PLAN_QTY + @li_ADD_QTY
          
          SELECT @ls_ADD_DATETIME = DATEADD(MS,(@li_CYCLE_TIME * 1000 * @li_ADD_QTY + @li_NONE_TIME),CAST( ETC02 + ' ' + REMARK + ':' + ETC01 AS DATETIME))
          FROM TM_CODE
          WHERE MCD		= 'ZA'
            AND SCD		= '01'
            
          UPDATE TM_CODE	
            SET CDNAME	= CONVERT(VARCHAR(10), @li_PLAN_QTY), 
	          REMARK	= SUBSTRING(CONVERT(VARCHAR(30),@ls_ADD_DATETIME,121), 12, 5),
	          ETC01 = RIGHT(CONVERT(VARCHAR(30),@ls_ADD_DATETIME,121),6),
	          ETC02 = SUBSTRING(CONVERT(VARCHAR(30),@ls_ADD_DATETIME, 121), 1, 10)
          WHERE MCD		= 'ZA'
            AND SCD		= '01'
        END
    END
  ELSE
    BEGIN
      -- OT 시간은 시간업데이트 적용
      IF (@li_ADD_QTY < 0)
        UPDATE TM_CODE	
            SET REMARK	= SUBSTRING(@ls_NOW_MS, 1, 5),
	          ETC01 = RIGHT(@ls_NOW_MS,6),
	          ETC02 = SUBSTRING(CONVERT(VARCHAR(20),@ls_NOW_DATETIME, 120), 1, 10)
        WHERE MCD		= 'ZA'
            AND SCD		= '01'
    END
  ------------------------------------------------------------------
  -- STEP-04
  -- 	가동률 계산  
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
  WHERE PROD_YMD	= @ls_PROD_YMD AND PROD_SHIFT = @ls_PROD_SHIFT

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
  
  if @ls_DEBUG = 'TRUE'
    BEGIN
      ------ 데이타 검증용으로 추가함 2011.12.26
      -- create history data
      INSERT INTO ORMS.dbo.TH_HISTORY_STOCK
      (CreateDate,ModelCode,ModelName,PlanQty,ProdQty
      ,WorkRate,BofRate,TargetRate,InputMan,CycleTime,CdName,Remark,Etc01)
      VALUES(@ls_NOW_DATETIME,@ls_MODEL_CODE,@ls_MODEL_NAME,
      ISNULL(@li_PLAN_QTY,0),ISNULL(@li_PROD_QTY,0),
      ROUND(ISNULL(@li_WORK_RATE,0),1),
      ROUND(ISNULL(@li_BOF_RATE,0),1),
      ROUND(ISNULL(@li_TARGET_RATE,0),1),
      ROUND(ISNULL(@li_INPUT_MAN,0),1),
      ISNULL(@li_CYCLE_TIME,0),@ls_CDNAME,@ls_BOF_HHMM,@ls_ETC01)
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
 	 CEILING (ISNULL(@li_CYCLE_TIME,0))		AS CYCLE_TIME		-- CYCLE TIME (현재모델) 

  SET NOCOUNT OFF  

END











GO

