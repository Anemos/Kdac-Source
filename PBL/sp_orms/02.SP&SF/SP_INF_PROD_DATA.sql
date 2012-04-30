USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_INF_PROD_DATA]    Script Date: 01/17/2011 10:10:54 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_INF_PROD_DATA]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_INF_PROD_DATA]
GO



/*
--------------------------------------------------------------------
TITLE 		: (INTERFACE) 생산실적 등록 
DATE		: 2010.06.01 
CREATOR	: FIT
DESCRIPTION	: 
	EXEC SP_INF_PROD_DATA '51', 1, ''
--------------------------------------------------------------------
*/
CREATE         PROCEDURE [dbo].[SP_INF_PROD_DATA] 
(
  @parm_MODEL		varchar(10),			-- 모델정보	 
  @parm_PROD_QTY	int, 				-- 생산수량 	
  @parm_RTN_MSG	varchar(100) OUTPUT	 	-- 처리 메시지 	
)
AS
BEGIN


  DECLARE @ls_MODEL	AS VARCHAR(10)

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
	SET @parm_RTN_MSG = 'NG-미등록 모델입니다.'
	SET NOCOUNT OFF 
	RETURN
  END
	

  --------------------------------------------------
  -- STEP-02
  -- 	생산수량이 숫자인지 인지 CHECK
  --------------------------------------------------
  IF (ISNUMERIC(@parm_PROD_QTY) = 0)
  BEGIN
	SET @parm_RTN_MSG = 'NG-수량이 정수가 아닙니다.'
	SET NOCOUNT OFF 
	RETURN
  END


  --------------------------------------------------
  -- STEP-03
  -- 	자료등록 
  --------------------------------------------------
  INSERT INTO TH_INF_DATA 
	(INF_TIME, MODEL, PROD_QTY,  
	PROD_YMD, PROD_SHIFT, PROD_HH, FLAG)
  VALUES 
	(getdate(), @parm_MODEL,  @parm_PROD_QTY, 
	'', '', '', '')

  IF (@@ROWCOUNT > 0)
	SET @parm_RTN_MSG = 'OK-정상적으로 반영되었습니다.'
  ELSE
	SET @parm_RTN_MSG = 'NG-자료등록시 오류발생.'


END






GO

