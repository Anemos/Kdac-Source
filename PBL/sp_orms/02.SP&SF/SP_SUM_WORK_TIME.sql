USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_SUM_WORK_TIME]    Script Date: 01/17/2011 10:13:41 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_SUM_WORK_TIME]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_SUM_WORK_TIME]
GO




/*
--------------------------------------------------------------------
TITLE 		: 시간대별 가동시간을 초단위로 계산   
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_SUM_WORK_TIME   
--------------------------------------------------------------------
*/
CREATE             PROCEDURE [dbo].[SP_SUM_WORK_TIME]  
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ls_START_TIME		AS VARCHAR(2)
  DECLARE @i				AS INT 
  DECLARE @li_START_TIME		AS INT 
  DECLARE @ls_TIME			AS VARCHAR(20)
  DECLARE @ls_ETC_TIME			AS VARCHAR(20)
  DECLARE @ls_SCD			AS VARCHAR(10)
  DECLARE @li_RT_MIN			AS INT 
  DECLARE @li_WK_SEC			AS INT 


  -------------------------------------------------------------------
  -- STEP-01
  -- 	이전 계산된 자료를 삭제 
  -------------------------------------------------------------------
  TRUNCATE TABLE TH_WORK_TIME 


  -- 비가동시간 적용유형 조회   
  -- 	상반기.하반기.혹서기 중에서 사용자가 미리설정
  -- 
  SELECT @ls_SCD	= CDNAME 
     FROM TM_CODE
   WHERE MCD 		= '90'
        AND SCD 		= '01'


  -------------------------------------------------------------------
  -- STEP-02
  -- 	시간대별 기본 시간을 등록 
  --		(초 단위로 계산)
  -------------------------------------------------------------------

  -- 주간조 시작시간을 조회    
  -- 
  SELECT @ls_START_TIME 	= LEFT(REMARK,2) 
     FROM TM_CODE
   WHERE MCD 			= '10'
        AND SCD 			= '1'

  -- 시간대별 기본 자료를 등록     
  -- 
  SET @i = 0
  WHILE(@i <= 23)		
  BEGIN
	SET @li_START_TIME = convert(int, @ls_START_TIME) + @i

	IF (@li_START_TIME >= 24)
	BEGIN
		SET @li_START_TIME = @li_START_TIME - 24
	END 

	SET @ls_TIME = RIGHT('00'+LTRIM(CONVERT(VARCHAR(2),@li_START_TIME)),2)	
	SET @i = @i + 1

	INSERT INTO TH_WORK_TIME
		(HH, WORK_TIME)
	VALUES 	(@ls_TIME + '1', 1800)

	INSERT INTO TH_WORK_TIME
		(HH, WORK_TIME)
	VALUES 	(@ls_TIME + '2', 1800)
  END


  -------------------------------------------------------------------
  -- STEP-03
  -- 	시간대별 비가동 시간을 계산
  -- 		(초 단위로 계산)
  -------------------------------------------------------------------
  DECLARE Cur_Data CURSOR        
  LOCAL        
  FORWARD_ONLY        
  STATIC 
  READ_ONLY        
  FOR     
	-- 적용중인 비가동 시간을 조회 
	-- 
	SELECT CDNAME 
	   FROM TM_CODE
	WHERE MCD 		= @ls_SCD
	     AND SCD 		<> '00'
	ORDER BY CONVERT(INT, SCD)
   
  OPEN Cur_Data        
        
  FETCH NEXT FROM Cur_Data INTO @ls_TIME           
  WHILE (@@FETCH_STATUS=0)
  BEGIN        
	-- 동일 시간대
	-- 
	IF (SUBSTRING(@ls_TIME,1,2) = SUBSTRING(@ls_TIME,7,2)) 
	    BEGIN
		-- 전반 30분
		-- 
		IF (SUBSTRING(@ls_TIME,10,2) < '30')  
		    BEGIN
			SET @li_RT_MIN = CONVERT(INT, SUBSTRING(@ls_TIME,10,2)) - CONVERT(INT, SUBSTRING(@ls_TIME,4,2))
			SET @li_WK_SEC = (@li_RT_MIN + 1) * 60
	 
			UPDATE TH_WORK_TIME
			      SET WORK_TIME 	= WORK_TIME - @li_WK_SEC
			 WHERE HH		= SUBSTRING(@ls_TIME,1,2) + '1' 
		    END
		ELSE IF (SUBSTRING(@ls_TIME,4,2) > '30')
		    BEGIN
			SET @li_RT_MIN = CONVERT(INT, SUBSTRING(@ls_TIME,10,2)) - CONVERT(INT, SUBSTRING(@ls_TIME,4,2))
			SET @li_WK_SEC = (@li_RT_MIN + 1) * 60
	 
			UPDATE TH_WORK_TIME
			      SET WORK_TIME 	= WORK_TIME - @li_WK_SEC
			 WHERE HH		= SUBSTRING(@ls_TIME,1,2) + '2' 
		    END
		ELSE 
		-- 후반 30분
		-- 
		    BEGIN
			SET @li_RT_MIN = CONVERT(INT, '29') - CONVERT(INT, SUBSTRING(@ls_TIME,4,2))
			SET @li_WK_SEC = (@li_RT_MIN + 1) * 60
	 
			UPDATE TH_WORK_TIME
			      SET WORK_TIME 	= WORK_TIME - @li_WK_SEC
			 WHERE HH		= SUBSTRING(@ls_TIME,1,2) + '1' 

			SET @li_RT_MIN = CONVERT(INT, SUBSTRING(@ls_TIME,10,2)) - CONVERT(INT, '30')
			SET @li_WK_SEC = (@li_RT_MIN + 1) * 60
	 
			UPDATE TH_WORK_TIME
			      SET WORK_TIME 	= WORK_TIME - @li_WK_SEC
			 WHERE HH		= SUBSTRING(@ls_TIME,1,2) + '2' 
		    END

	    END
	ELSE
	-- 다른 시간대
	-- 
	    BEGIN
		SET @li_RT_MIN = 59 - CONVERT(INT, SUBSTRING(@ls_TIME,4,2))
		SET @li_WK_SEC = (@li_RT_MIN + 1) * 60

		UPDATE TH_WORK_TIME
		      SET WORK_TIME 	= WORK_TIME - @li_WK_SEC
		 WHERE HH		= SUBSTRING(@ls_TIME,1,2) + '2'


		SET @li_RT_MIN = CONVERT(INT, SUBSTRING(@ls_TIME,10,2))
		SET @li_WK_SEC = (@li_RT_MIN + 1) * 60

		UPDATE TH_WORK_TIME
		      SET WORK_TIME 	= WORK_TIME - @li_WK_SEC
		 WHERE HH		= SUBSTRING(@ls_TIME,7,2) + '1' 		
	    END

	FETCH NEXT FROM Cur_Data INTO @ls_TIME
  END        

  CLOSE Cur_Data                
  DEALLOCATE Cur_Data    


  -------------------------------------------------------------------
  -- STEP-04
  -- 	OT.조출에 따른 기본작업 시간 외의 부분을 Clear 처리 
  -------------------------------------------------------------------

  -- 주간 2시간 OT
  -- 
  IF EXISTS (
	  SELECT * 
	     FROM TM_CODE
	   WHERE MCD		= '50'
	        AND SCD		= '01'
	        AND ETC01		= 'N')
  BEGIN
	UPDATE TH_WORK_TIME
	      SET WORK_TIME	= 0
	 WHERE LEFT(HH,2)	IN ('17', '18')
  END

  -- 야간 4시간 조출 
  -- 
  IF EXISTS (
	  SELECT * 
	     FROM TM_CODE
	   WHERE MCD		= '50'
	        AND SCD		= '02'
	        AND ETC01		= 'N')
  BEGIN
	UPDATE TH_WORK_TIME
	      SET WORK_TIME	= 0
	 WHERE LEFT(HH,2)	IN ('19', '20', '21', '22')
  END


  SET NOCOUNT OFF 

END










GO

