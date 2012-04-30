USE [ORMS]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_DATE_SHIFT]    Script Date: 01/17/2011 10:13:57 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[FN_GET_DATE_SHIFT]')
        And OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  Drop FUNCTION [dbo].[FN_GET_DATE_SHIFT]
GO

/*
--------------------------------------------------------------------
TITLE 		: 생산일시로 생산일자.SHIFT 조회
DATE		: 2010.06.01
CREATOR	: FIT
DESCRIPTION	: 
	SELECT dbo.FN_GET_DATE_SHIFT(getdate())
--------------------------------------------------------------------
*/
CREATE  	FUNCTION  [dbo].[FN_GET_DATE_SHIFT]
(
  @parm_DATE 	AS DATETIME		-- 생산일시    
)

RETURNS varchar(10) AS  

BEGIN 


  DECLARE @ls_SHIFT_DAY_START		AS VARCHAR(10)
  DECLARE @ls_SHIFT_DAY_END		AS VARCHAR(10)
  DECLARE @ls_SHIFT_NIGHT_START	AS VARCHAR(10)
  DECLARE @ls_SHIFT_NIGHT_END		AS VARCHAR(10)

  DECLARE @ls_PROD_YMD		AS VARCHAR(8)
  DECLARE @ls_PROD_SHIFT		AS VARCHAR(1)

  -------------------------------------------------------------------
  -- SHIFT 시간정보를 조회 
  -------------------------------------------------------------------

  -- 주간 시작.종료
  -- 
  SELECT @ls_SHIFT_DAY_START 		= LEFT(REMARK,5),
	 @ls_SHIFT_DAY_END 		= RIGHT(REMARK,5)
     FROM TM_CODE
   WHERE MCD 	= '10'
        AND SCD  	= '1'
 
  -- 야간 시작.종료
  -- 
  SELECT @ls_SHIFT_NIGHT_START 	= LEFT(REMARK,5),
	 @ls_SHIFT_NIGHT_END		= RIGHT(REMARK,5)
     FROM TM_CODE
   WHERE MCD 	= '10'
        AND SCD  	= '2'


  IF (substring(CONVERT(VARCHAR(20), @parm_DATE, 120),12,5) < @ls_SHIFT_DAY_START)
  BEGIN
	-- 주간 시작시간(예, 08:00) 이전이면
	--	전일 생산일자로 처리 
	SET @parm_DATE = DATEADD(day, -1, @parm_DATE)
  END

  -- 생산일자
  --   
  SELECT @ls_PROD_YMD = CONVERT(VARCHAR(8), @parm_DATE, 112)

  -- SHIFT
  --   
  IF (substring(CONVERT(VARCHAR(20), @parm_DATE, 120),12,5) >= @ls_SHIFT_DAY_START)
      AND (substring(CONVERT(VARCHAR(20), @parm_DATE, 120),12,5) < @ls_SHIFT_DAY_END)
	SET @ls_PROD_SHIFT = '1'	-- 주간 
  ELSE
	SET @ls_PROD_SHIFT = '2'	-- 야간 


  RETURN @ls_PROD_YMD + '-' + @ls_PROD_SHIFT

END



GO

