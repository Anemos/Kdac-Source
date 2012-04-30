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
  -- 	계획수량.집계수량 으로  
  --  		모델별 가동율 계산 
  -------------------------------------------------------------------
  DECLARE Cur_Data CURSOR        
  LOCAL        
  FORWARD_ONLY        
  STATIC 
  READ_ONLY        
  FOR        
	SELECT 
		MODEL,
		WORK_QTY,
		PLAN_QTY
	   FROM TH_DATA_MODEL
	 WHERE PROD_YMD	= @parm_YMD

  OPEN Cur_Data        
        
  FETCH NEXT FROM Cur_Data INTO @ls_MODEL, @li_WORK_QTY, @li_PLAN_QTY           
  WHILE (@@FETCH_STATUS=0)
  BEGIN        

	IF (@li_PLAN_QTY = 0)
		SELECT @li_WORK_RATE = 0
	ELSE 
		SELECT @li_WORK_RATE = ROUND(CONVERT(FLOAT,@li_WORK_QTY) / CONVERT(FLOAT, @li_PLAN_QTY) * 100, 1)


	UPDATE TH_DATA_MODEL
	      SET  WORK_RATE	= @li_WORK_RATE
	 WHERE  PROD_YMD	= @parm_YMD
	      AND  MODEL		= @ls_MODEL

	FETCH NEXT FROM Cur_Data INTO @ls_MODEL, @li_WORK_QTY, @li_PLAN_QTY  
  END        

  CLOSE Cur_Data                
  DEALLOCATE Cur_Data    


  SET NOCOUNT OFF


END










GO

