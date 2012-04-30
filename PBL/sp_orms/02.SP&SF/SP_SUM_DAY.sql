USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_SUM_DAY]    Script Date: 01/17/2011 10:13:13 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_SUM_DAY]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_SUM_DAY]
GO




/*
--------------------------------------------------------------------
TITLE 		: 일자별 가동율 집계처리  
DATE		: 2010.08.12  
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_SUM_DAY  '20100811'  
--------------------------------------------------------------------
*/
CREATE               PROCEDURE [dbo].[SP_SUM_DAY]   
(
  @parm_YMD		varchar(8) 	-- 생산일자 	 
)
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @li_WORK_QTY			AS INT 
  DECLARE @li_WORK_RATE		AS FLOAT 
  DECLARE @ls_PROD_SHIFT		AS VARCHAR(1)


  -------------------------------------------------------------------
  -- STEP-01
  -- 	이전 계산된 자료를 삭제 
  -------------------------------------------------------------------
  DELETE FROM TH_DATA_DAY 
    WHERE PROD_YMD = @parm_YMD


  -------------------------------------------------------------------
  -- STEP-02
  -- 	시간대별 집계자료로 
  --  		일자별 가동율 계산 
  --		(17:00 ~ 22:59 사이는 제외한다.) 
  -------------------------------------------------------------------
  DECLARE Cur_Data CURSOR        
  LOCAL        
  FORWARD_ONLY        
  STATIC 
  READ_ONLY        
  FOR        
	SELECT  a.PROD_SHIFT,
		SUM(a.WORK_QTY), 
		AVG(a.WORK_RATE)
	   FROM
		(
		SELECT  PROD_SHIFT,
			TIME_ZONE,
			SUM(WORK_QTY) as WORK_QTY, 
			SUM(WORK_RATE) as WORK_RATE
		   FROM TH_DATA_TIME
		 WHERE  PROD_YMD	= @parm_YMD
		      AND  LEFT(TIME_ZONE,2) NOT IN ('17', '18', '19', '20', '21', '22')
		      AND  (WORK_QTY <> 0 AND WORK_RATE <> 0)
		 GROUP BY  PROD_SHIFT, TIME_ZONE
		) a
	 GROUP BY  a.PROD_SHIFT


        
  OPEN Cur_Data        
        
  FETCH NEXT FROM Cur_Data INTO @ls_PROD_SHIFT, @li_WORK_QTY, @li_WORK_RATE           
  WHILE (@@FETCH_STATUS=0)
  BEGIN        

	INSERT INTO TH_DATA_DAY
		(PROD_YMD, PROD_SHIFT, WORK_QTY, WORK_RATE)
	VALUES
		(@parm_YMD, @ls_PROD_SHIFT, @li_WORK_QTY, @li_WORK_RATE)


	FETCH NEXT FROM Cur_Data INTO @ls_PROD_SHIFT, @li_WORK_QTY, @li_WORK_RATE 
  END        

  CLOSE Cur_Data                
  DEALLOCATE Cur_Data    



  SET NOCOUNT OFF


END









GO

