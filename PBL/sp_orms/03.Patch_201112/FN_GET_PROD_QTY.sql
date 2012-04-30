USE [ORMS]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_PROD_QTY]    Script Date: 01/17/2011 10:15:05 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[FN_GET_PROD_QTY]')
        And OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  Drop FUNCTION [dbo].[FN_GET_PROD_QTY]
GO

/*
--------------------------------------------------------------------
TITLE     : 해당시간에 생산된 생산수량 계산
DATE    : 2011.12.23
CREATOR : DISC
DESCRIPTION :
  SELECT dbo.FN_GET_PROD_QTY('20111222','08:00','19:00','1','2011-12-22 08:30:12.000', '2011-12-22 17:30:12.000')
--------------------------------------------------------------------
*/
CREATE      FUNCTION  [dbo].[FN_GET_PROD_QTY]
(
  @parm_PROD_YMD CHAR(8),  -- 작업일자
  @parm_STD_HHMM AS CHAR(5),  --주간시작
  @parm_END_HHMM AS CHAR(5),  --야간시작
  @parm_PROD_SHIFT 	AS CHAR(1),   -- 주/야 쉬프트
  @parm_SHIFT_DATETIME 	AS DATETIME,		-- 작업시작일시
  @parm_NOW_DATETIME  AS DATETIME   -- 작업완료일시
)

RETURNS INT AS

BEGIN

  DECLARE @ls_STD_OT AS DATETIME
  DECLARE @ls_END_OT AS DATETIME
  DECLARE @ls_NONE_HHMM_MAX AS CHAR(5)
  DECLARE @ls_SCD AS CHAR(2)
  DECLARE @ls_CDNAME VARCHAR(60)
  DECLARE @li_OT_QTY AS INT
  DECLARE @li_PROD_QTY AS INT
  
  -- 총생산수량 계산, OT적용시간별로 생산수량 계산하여 제외
  
  SELECT @li_PROD_QTY		= SUM(PROD_QTY)
     FROM TH_INF_DATA
   WHERE PROD_YMD		= @parm_PROD_YMD
        AND PROD_SHIFT		= @parm_PROD_SHIFT
        AND INF_TIME >= @parm_SHIFT_DATETIME
        AND INF_TIME <= @parm_NOW_DATETIME
  
  SET @ls_SCD = '00'
  
  WHILE @@ERROR = 0
  BEGIN
    SELECT @ls_SCD = SCD, @ls_CDNAME = CDNAME
     FROM TM_CODE
     WHERE MCD		= '50'
        AND SCD		<> '00' AND SCD > @ls_SCD AND ETC01 <> 'N'
        AND LEFT(CDNAME,5) >= SUBSTRING(CONVERT(VARCHAR(30),@parm_SHIFT_DATETIME,121),12,5)
        AND RIGHT(CDNAME,5) <= SUBSTRING(CONVERT(VARCHAR(30),@parm_NOW_DATETIME,121),12,5)
    ORDER BY SCD
    
    IF @@rowcount = 0 
      BREAK
    
    -- OT시작일시
    IF @parm_PROD_SHIFT = '1'
      BEGIN
        SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
      END
    ELSE
      BEGIN
       IF (LEFT(@ls_CDNAME,5) <= @parm_STD_HHMM)  -- 오전 00:00~08:00
        BEGIN
          SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_NOW_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
          SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_NOW_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        END
       ELSE IF (LEFT(@ls_CDNAME,5) >= @parm_END_HHMM AND RIGHT(@ls_CDNAME,5) <= @parm_STD_HHMM)  -- 오후 19:00 ~ 오전 08:00
        BEGIN
          SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
          SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_NOW_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        END
       ELSE
        BEGIN
          SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
          SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        END
      END
    
    SELECT @li_OT_QTY		= SUM(PROD_QTY)
     FROM TH_INF_DATA
    WHERE PROD_YMD		= @parm_PROD_YMD
        AND PROD_SHIFT		= @parm_PROD_SHIFT
        AND INF_TIME >= @ls_STD_OT
        AND INF_TIME <= @ls_END_OT
    
    SET @li_OT_QTY = ISNULL(@li_OT_QTY,0)
    SET @li_PROD_QTY = @li_PROD_QTY - @li_OT_QTY
  END
  
  -- 현재시간이 걸치는 경우
  SELECT @ls_SCD = SCD, @ls_CDNAME = CDNAME
     FROM TM_CODE
     WHERE MCD		= '50'
        AND SCD		<> '00' AND ETC01 <> 'N'
        AND LEFT(CDNAME,5) <= SUBSTRING(CONVERT(VARCHAR(30),@parm_NOW_DATETIME,121),12,5)
        AND RIGHT(CDNAME,5) >= SUBSTRING(CONVERT(VARCHAR(30),@parm_NOW_DATETIME,121),12,5)
        
  IF @@rowcount <> 0
   BEGIN
      -- OT시작일시
    IF @parm_PROD_SHIFT = '1'
      BEGIN
        SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        SET @ls_END_OT = @parm_NOW_DATETIME
      END
    ELSE
      BEGIN
       IF (LEFT(@ls_CDNAME,5) <= @parm_STD_HHMM)  -- 오전 00:00~08:00
        BEGIN
          SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_NOW_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
          SET @ls_END_OT = @parm_NOW_DATETIME
        END
       ELSE
        BEGIN
          SET @ls_STD_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + LEFT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
          SET @ls_END_OT = @parm_NOW_DATETIME
        END
      END
    
    SELECT @li_OT_QTY		= SUM(PROD_QTY)
     FROM TH_INF_DATA
    WHERE PROD_YMD		= @parm_PROD_YMD
        AND PROD_SHIFT		= @parm_PROD_SHIFT
        AND INF_TIME >= @ls_STD_OT
        AND INF_TIME <= @ls_END_OT
    SET @li_OT_QTY = ISNULL(@li_OT_QTY,0)
    SET @li_PROD_QTY = @li_PROD_QTY - @li_OT_QTY
   END
   
  -- 시작시간 걸치는 시간
  SELECT @ls_SCD = SCD, @ls_CDNAME = CDNAME
     FROM TM_CODE
     WHERE MCD		= '50'
        AND SCD		<> '00' AND ETC01 <> 'N'
        AND LEFT(CDNAME,5) <= SUBSTRING(CONVERT(VARCHAR(30),@parm_SHIFT_DATETIME,121),12,5)
        AND RIGHT(CDNAME,5) >= SUBSTRING(CONVERT(VARCHAR(30),@parm_SHIFT_DATETIME,121),12,5)
        
  IF @@rowcount <> 0
   BEGIN
      -- OT시작일시
    IF @parm_PROD_SHIFT = '1'
      BEGIN
        SET @ls_STD_OT = @parm_SHIFT_DATETIME
        SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
      END
    ELSE
      BEGIN
       IF (LEFT(@ls_CDNAME,5) <= @parm_STD_HHMM)  -- 오전 00:00~08:00
        BEGIN
          SET @ls_STD_OT = @parm_SHIFT_DATETIME
          SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_NOW_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        END
       ELSE
        BEGIN
          SET @ls_STD_OT = @parm_SHIFT_DATETIME
          SET @ls_END_OT = CAST( SUBSTRING(CONVERT(VARCHAR(20),@parm_SHIFT_DATETIME, 120), 1, 11) + RIGHT(@ls_CDNAME,5) + ':00.000'  AS DATETIME)
        END
      END
    
    SELECT @li_OT_QTY		= SUM(PROD_QTY)
     FROM TH_INF_DATA
    WHERE PROD_YMD		= @parm_PROD_YMD
        AND PROD_SHIFT		= @parm_PROD_SHIFT
        AND INF_TIME >= @ls_STD_OT
        AND INF_TIME <= @ls_END_OT
    SET @li_OT_QTY = ISNULL(@li_OT_QTY,0)
    SET @li_PROD_QTY = @li_PROD_QTY - @li_OT_QTY
   END

  RETURN @li_PROD_QTY

END



GO

