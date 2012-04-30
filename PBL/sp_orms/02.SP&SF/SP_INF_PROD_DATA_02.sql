USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_INF_PROD_DATA_02]    Script Date: 01/17/2011 10:11:22 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO



If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_INF_PROD_DATA_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_INF_PROD_DATA_02]
GO



/*
--------------------------------------------------------------------
TITLE 		: (INTERFACE) 생산실적 등록 
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_INF_PROD_DATA_02 '51', 1, '2010-08-09 11:22:33' 
--------------------------------------------------------------------
*/
CREATE              PROCEDURE [dbo].[SP_INF_PROD_DATA_02] 
(
  @parm_MODEL		varchar(10),			-- 모델정보 	 
  @parm_PROD_QTY	int, 				-- 생산수량 	
  @parm_PROD_DATE	varchar(20)			-- 생산일시  	
)
AS
BEGIN


  DECLARE @ls_MODEL		AS VARCHAR(10)
  DECLARE @ls_ERR_MSG		AS VARCHAR(100)

  --------------------------------------------------
  -- STEP-01
  -- 	등록된 모델인지 CHECK
  --------------------------------------------------
  SET @ls_MODEL = ''
  SELECT @ls_MODEL	= MODEL 
     FROM TM_MODEL
    WHERE MODEL		= @parm_MODEL

  IF (@ls_MODEL IS NULL) 
	SET @ls_MODEL = ''

  IF (@parm_MODEL <> @ls_MODEL)
  BEGIN
	SET @ls_ERR_MSG = '모델확인-미등록:' + @parm_MODEL
	EXEC SP_ERR_LOG @ls_ERR_MSG
	RETURN
  END
	

  --------------------------------------------------
  -- STEP-02
  -- 	생산수량이 숫자인지 인지 CHECK
  --------------------------------------------------
  IF (ISNUMERIC(@parm_PROD_QTY) = 0)
  BEGIN
	SET @ls_ERR_MSG = '수량확인-숫자:' + @parm_PROD_QTY
	EXEC SP_ERR_LOG @ls_ERR_MSG
	RETURN
  END


  --------------------------------------------------
  -- STEP-03
  -- 	자료등록 
  --------------------------------------------------
  INSERT INTO TH_INF_DATA 
	(INF_TIME, MODEL, PROD_QTY,  
	PROD_YMD, PROD_SHIFT, PROD_HH, CYCLE_TIME, FLAG)
  VALUES 
	(@parm_PROD_DATE, @parm_MODEL,  @parm_PROD_QTY, 
	'', '', '', 0, '')


END







GO

