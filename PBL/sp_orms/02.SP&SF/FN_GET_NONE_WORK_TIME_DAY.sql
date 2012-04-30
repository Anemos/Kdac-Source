USE [ORMS]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_NONE_WORK_TIME_DAY]    Script Date: 01/17/2011 10:15:05 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[FN_GET_NONE_WORK_TIME_DAY]')
        And OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  Drop FUNCTION [dbo].[FN_GET_NONE_WORK_TIME_DAY]
GO

/*
--------------------------------------------------------------------
TITLE     : 시간대가 가동/비가동 여부를 조회
DATE    : 2010.06.01
CREATOR : FIT
DESCRIPTION :
  SELECT dbo.FN_GET_NONE_WORK_TIME_DAY('12:30')
--------------------------------------------------------------------
*/
CREATE      FUNCTION  [dbo].[FN_GET_NONE_WORK_TIME_DAY]
(
  @parm_TIME  AS VARCHAR(5)   -- 예, 10:01
)

RETURNS INT AS

BEGIN

  DECLARE @ls_SCD AS VARCHAR(2)
  DECLARE @li_CNT AS INT

  -- 비가동시간 적용유형 조회
  --  상반기.하반기.혹서기 중에서 사용자가 미리설정
  --
  SELECT @ls_SCD  = CDNAME
     FROM TM_CODE
   WHERE MCD    = '90'
        AND SCD     = '01'

  -- 해당 시간대가 비가동 시간대 안에 있는지 조회
  --
  SELECT @li_CNT = SUM(ISNULL(TMP.CAL_MIN,0))
FROM (
-- 08시전 ~ 08시후 휴식
SELECT
 DATEDIFF(MI,DATEADD(MI,-1,CAST( '1900-01-01 ' + '08:00' AS DATETIME)),
  CAST( '1900-01-01 ' + RIGHT(CDNAME,5) AS DATETIME)) AS CAL_MIN
FROM TM_CODE
WHERE MCD = @ls_SCD AND SCD <> '00' AND LEFT(CDNAME,5) < '08:00'
AND RIGHT(CDNAME,5) >= '08:00' AND LEFT(CDNAME,5) >= @parm_TIME
AND RIGHT(CDNAME,5) <= @parm_TIME

  UNION ALL

-- 08시후 ~ 해당시간 사이 휴식
SELECT
 DATEDIFF(MI,DATEADD(MI,-1,CAST( '1900-01-01 ' + LEFT(CDNAME,5) AS DATETIME)),
  CAST( '1900-01-01 ' + RIGHT(CDNAME,5) AS DATETIME)) AS CAL_MIN
FROM TM_CODE
WHERE MCD = @ls_SCD AND SCD <> '00' AND LEFT(CDNAME,5) >= '08:00' AND RIGHT(CDNAME,5) < '17:00'
AND RIGHT(CDNAME,5) < @parm_TIME

  UNION ALL

-- 휴식시간내 시간계산
SELECT
 DATEDIFF(MI,DATEADD(MI,-1,CAST( '1900-01-01 ' + LEFT(CDNAME,5) AS DATETIME)),
  CAST( '1900-01-01 ' + @parm_TIME AS DATETIME)) AS CAL_MIN
FROM TM_CODE
WHERE MCD = @ls_SCD AND SCD <> '00' AND LEFT(CDNAME,5) < '17:00'
  AND LEFT(CDNAME,5) <= @parm_TIME AND RIGHT(CDNAME,5) >= @parm_TIME

  UNION ALL

-- 17시전 ~ 17시후 휴식
SELECT
 DATEDIFF(MI,DATEADD(MI,-1,CAST( '1900-01-01 ' + LEFT(CDNAME,5) AS DATETIME)),
  CAST( '1900-01-01 ' + '17:00' AS DATETIME)) AS CAL_MIN
FROM TM_CODE
WHERE MCD = @ls_SCD AND SCD <> '00' AND LEFT(CDNAME,5) < '17:00'
AND RIGHT(CDNAME,5) >= '17:00' AND LEFT(CDNAME,5) >= @parm_TIME
AND RIGHT(CDNAME,5) < @parm_TIME

  UNION ALL

SELECT
 CASE WHEN '17:00' <= @parm_TIME AND '22:59' >= @parm_TIME THEN
  0
 ELSE 0 END  AS CAL_MIN ) TMP


  RETURN @li_CNT

END



GO

