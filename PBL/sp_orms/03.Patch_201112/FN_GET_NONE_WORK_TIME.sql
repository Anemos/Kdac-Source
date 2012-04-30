USE [ORMS]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_NONE_WORK_TIME]    Script Date: 01/17/2011 10:15:05 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[FN_GET_NONE_WORK_TIME]')
        And OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  Drop FUNCTION [dbo].[FN_GET_NONE_WORK_TIME]
GO

/*
--------------------------------------------------------------------
TITLE     : 시간대가 가동/비가동 여부를 조회
DATE    : 2011.12.20
CREATOR : DISC
DESCRIPTION :
  SELECT dbo.FN_GET_NONE_WORK_TIME('12:30~12:59')
--------------------------------------------------------------------
*/
CREATE      FUNCTION  [dbo].[FN_GET_NONE_WORK_TIME]
(
  @parm_DATE 	AS DATETIME,		-- 생산일시
  @parm_TIME  AS VARCHAR(20)   -- 예, 10:01
)

RETURNS INT AS

BEGIN

  DECLARE @ls_STD_HHMM AS CHAR(5)
  DECLARE @ls_END_HHMM AS CHAR(5)
  DECLARE @ls_NONE_HHMM_MAX AS CHAR(5)
  DECLARE @ls_NONE_HHMM_MIN AS CHAR(5)
  DECLARE @li_NONE_TIME AS INT

  -- 비가동시간 적용유형 조회
  --  상반기.하반기.혹서기 중에서 사용자가 미리설정
  --
  SET @ls_STD_HHMM = LEFT(@parm_TIME,5)
  SET @ls_END_HHMM = RIGHT(@parm_TIME,5)
  
  SELECT @li_NONE_TIME = ISNULL(SUM(DATEDIFF(MI,CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_DATE, 120), 1, 11) + LEFT(CDNAME,5) + ':00.000'  AS DATETIME),
          CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_DATE,120), 1, 11) + RIGHT(CDNAME,5) + ':59.999' AS DATETIME)) ),0)
	    FROM TM_CODE
	    WHERE MCD		 	= 
			( SELECT CDNAME
			   FROM TM_CODE
			 WHERE MCD		= '90'
			      AND SCD		= '01'
			)
	      AND SCD			<> '00'
	      AND @ls_STD_HHMM		<= LEFT(CDNAME,5) 
	      AND @ls_END_HHMM		>= RIGHT(CDNAME,5)
  
  if @li_NONE_TIME > 0
    return @li_NONE_TIME
  
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
	      AND @ls_STD_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_STD_HHMM		<= RIGHT(CDNAME,5) 
	  )
	    BEGIN
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
	      AND @ls_STD_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_STD_HHMM		<= RIGHT(CDNAME,5) 
	      
	      RETURN DATEDIFF(MI,CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_DATE, 120), 1, 11) + @ls_STD_HHMM + ':00.000'  AS DATETIME),
          CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_DATE,120), 1, 11) + @ls_NONE_HHMM_MAX + ':59.999' AS DATETIME))
	    END
	    
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
	      AND @ls_END_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_END_HHMM		<= RIGHT(CDNAME,5) 
	  )
	    BEGIN
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
	      AND @ls_END_HHMM		>= LEFT(CDNAME,5) 
	      AND @ls_END_HHMM		<= RIGHT(CDNAME,5) 
	      
	      RETURN DATEDIFF(MI,CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_DATE, 120), 1, 11) + @ls_NONE_HHMM_MIN + ':00.000'  AS DATETIME),
          CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_DATE,120), 1, 11) + @ls_END_HHMM + ':59.999' AS DATETIME))
	    END


  RETURN 0

END



GO

