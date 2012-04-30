USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_DATA_PROCESS]    Script Date: 01/17/2011 10:12:02 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_DATA_PROCESS]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_DATA_PROCESS]
GO



/*
--------------------------------------------------------------------
TITLE 		: 생산실적  INTERFACE 처리  
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_JOB_DATA_PROCESS   
--------------------------------------------------------------------
*/
CREATE           PROCEDURE [dbo].[SP_JOB_DATA_PROCESS] 
AS
BEGIN


  DECLARE @li_RecordID			AS INT 
  DECLARE @ls_PROD_YMD		AS VARCHAR(8)
  DECLARE @ls_PROD_SHIFT		AS VARCHAR(1)
  DECLARE @ls_PROD_HH			AS VARCHAR(3)
  DECLARE @ls_PROD_HH_TYPE		AS VARCHAR(1)
  DECLARE @ld_INF_TIME			AS DATETIME 
  DECLARE @ls_MODEL			AS VARCHAR(10)
  DECLARE @li_CYCLE_TIME		AS INT 
  DECLARE @ls_DATE_SHIFT 		AS VARCHAR(20) 
  DECLARE @li_PROD_QTY			AS INT 
  DECLARE @ls_17_19_OT			AS VARCHAR(1)
  DECLARE @ls_19_23_OT			AS VARCHAR(1)


  -------------------------------------------------------------------
  -- STEP-01
  -- 	OT.조출 정보를 조회 
  -------------------------------------------------------------------

  -- 주간 2시간 OT 여부 
  -- 
  SELECT @ls_17_19_OT	= ETC01 
     FROM TM_CODE
   WHERE MCD		= '50'
        AND SCD		= '01'

  -- 야간 4시간 조출 여부 
  -- 
  SELECT @ls_19_23_OT	= ETC01 
     FROM TM_CODE
   WHERE MCD		= '50'
        AND SCD		= '02'


  -------------------------------------------------------------------
  -- STEP-02
  -- 	INTERFACE 된 생산정보로
  --  		생산일자.SHIFT.시간을 반영
  -------------------------------------------------------------------
  DECLARE Cur_Data CURSOR        
  LOCAL        
  FORWARD_ONLY        
  STATIC 
  READ_ONLY        
  FOR        
	SELECT  RecordID,
		INF_TIME,
		MODEL,
		PROD_QTY
                 FROM  TH_INF_DATA 
	 WHERE  ISNULL(FLAG,'')		= ''
	 ORDER BY  RecordID
        
  OPEN Cur_Data        
        
  FETCH NEXT FROM Cur_Data INTO @li_RecordID, @ld_INF_TIME, @ls_MODEL, @li_PROD_QTY
  WHILE (@@FETCH_STATUS=0)
  BEGIN        
	SELECT @ls_DATE_SHIFT = dbo.FN_GET_DATE_SHIFT(@ld_INF_TIME)

	-- 생산일자  
	-- 
	SET @ls_PROD_YMD = LEFT(@ls_DATE_SHIFT, 8)

	-- 생산 근무조 
	-- 
	SET @ls_PROD_SHIFT = RIGHT(@ls_DATE_SHIFT, 1)

	-- 생산시각 
	-- 
	SET @ls_PROD_HH = substring(CONVERT(VARCHAR(20), @ld_INF_TIME, 120),12,2)
	IF (substring(CONVERT(VARCHAR(20), @ld_INF_TIME, 120),15,2) < 30)
		SET @ls_PROD_HH_TYPE = '1'
	ELSE
		SET @ls_PROD_HH_TYPE = '2'
	SET @ls_PROD_HH = @ls_PROD_HH + @ls_PROD_HH_TYPE

	-- 현재 사용자가 지정한 모델의 CYCLE TIME 조회 
	-- 
	SELECT @li_CYCLE_TIME 	= CYCLE_TIME
	   FROM  TM_MODEL_CYCLE
	 WHERE  MODEL 		= @ls_MODEL 
	      AND  FLAG		= 'Y'

	
	------------------------------------------------------------------
	-- STEP-01
	--	반영 UPDATE 처리  
	------------------------------------------------------------------
	UPDATE TH_INF_DATA
	      SET  PROD_YMD	= @ls_PROD_YMD,
		PROD_SHIFT	= @ls_PROD_SHIFT,
		PROD_HH	= @ls_PROD_HH,
		CYCLE_TIME	= @li_CYCLE_TIME, 
		FLAG		= 'Y'
	 WHERE RecordID	= @li_RecordID   

	
	------------------------------------------------------------------
	-- STEP-02
	--	모델별 생산수량 UPDATE 
	------------------------------------------------------------------

	IF (@ls_17_19_OT = 'N')
	BEGIN
		IF (LEFT(@ls_PROD_HH, 2) >= '17') AND (LEFT(@ls_PROD_HH, 2) < '19') 	
			SET @li_PROD_QTY	= 0
	END
	IF (@ls_19_23_OT = 'N')
	BEGIN
		IF (LEFT(@ls_PROD_HH, 2) >= '19') AND (LEFT(@ls_PROD_HH, 2) < '23') 	
			SET @li_PROD_QTY	= 0
	END
	

	IF EXISTS 
		(SELECT *
		    FROM TH_DATA_MODEL
		  WHERE PROD_YMD	= @ls_PROD_YMD
		       AND MODEL		= @ls_MODEL)
	    BEGIN
		UPDATE TH_DATA_MODEL
		      SET  WORK_QTY	= WORK_QTY + @li_PROD_QTY
		  WHERE PROD_YMD	= @ls_PROD_YMD
		       AND MODEL		= @ls_MODEL
	    END
	ELSE
	    BEGIN
		INSERT INTO TH_DATA_MODEL
			(PROD_YMD, MODEL, WORK_QTY, WORK_RATE, PLAN_QTY)
		VALUES
			(@ls_PROD_YMD, @ls_MODEL, @li_PROD_QTY, 0, 0)
	    END


	FETCH NEXT FROM Cur_Data INTO @li_RecordID, @ld_INF_TIME, @ls_MODEL, @li_PROD_QTY         
  END        

  CLOSE Cur_Data                
  DEALLOCATE Cur_Data    


END











GO

