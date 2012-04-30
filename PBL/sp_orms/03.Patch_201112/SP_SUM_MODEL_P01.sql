USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_SUM_MODEL]    Script Date: 01/17/2011 10:13:22 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO



If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_SUM_MODEL]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_SUM_MODEL]
GO




/*
--------------------------------------------------------------------
TITLE 		: 모델별 가동율 집계처리  
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_SUM_MODEL  '20100811'  
--------------------------------------------------------------------
*/
CREATE                PROCEDURE [dbo].[SP_SUM_MODEL]   
(
  @parm_YMD		varchar(8) 	-- 생산일자 	 
)
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @li_WORK_QTY			AS INT 
  DECLARE @li_PLAN_QTY			AS INT
  DECLARE @li_WORK_RATE		AS FLOAT 
  DECLARE @ls_MODEL			AS VARCHAR(10)


  -------------------------------------------------------------------
  -- STEP-01
  -- 	이전 계산된 자료를 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_DATA_MODEL  
    WHERE PROD_YMD = @parm_YMD


  -------------------------------------------------------------------
  -- STEP-02
  -- 	시간대별 집계자료로 
  --  		모델별 가동율 계산 
  --		(17:00 ~ 22:59 사이는 제외한다.) 
  -------------------------------------------------------------------
  DECLARE Cur_Data CURSOR        
  LOCAL        
  FORWARD_ONLY        
  STATIC 
  READ_ONLY        
  FOR        

	SELECT  a.MODEL,
		SUM(a.WORK_QTY), 
		AVG(a.WORK_RATE),
		SUM(CASE WHEN b.CYCLE_TIME <> 0 THEN FLOOR(a.PLAN_MM * 60 / b.CYCLE_TIME) ELSE 0 END)
	FROM
		(
		SELECT  MODEL,
			TIME_ZONE,
			SUM(WORK_QTY) as WORK_QTY, 
			SUM(WORK_RATE) as WORK_RATE,
			(29 - dbo.FN_GET_NONE_WORK_TIME(getdate(),time_zone)) as PLAN_MM
		   FROM TH_DATA_TIME
		 WHERE  PROD_YMD	= @parm_YMD
		      AND  LEFT(TIME_ZONE,2) NOT IN ('17', '18', '19', '20', '21', '22')
		      AND  (WORK_QTY <> 0 AND WORK_RATE <> 0)
		 GROUP BY  MODEL, TIME_ZONE
		) a, TM_MODEL_CYCLE b
	 WHERE a.MODEL = b.MODEL and b.FLAG = 'Y'
	 GROUP BY  a.MODEL


  OPEN Cur_Data        
        
  FETCH NEXT FROM Cur_Data INTO @ls_MODEL, @li_WORK_QTY, @li_WORK_RATE, @li_PLAN_QTY
  WHILE (@@FETCH_STATUS=0)
  BEGIN        

	INSERT INTO TH_DATA_MODEL
		(PROD_YMD, MODEL, WORK_QTY, WORK_RATE, PLAN_QTY)
	VALUES
		(@parm_YMD, @ls_MODEL, @li_WORK_QTY, @li_WORK_RATE, @li_PLAN_QTY)


	FETCH NEXT FROM Cur_Data INTO @ls_MODEL, @li_WORK_QTY, @li_WORK_RATE, @li_PLAN_QTY
  END        

  CLOSE Cur_Data                
  DEALLOCATE Cur_Data    



  SET NOCOUNT OFF


END










GO

