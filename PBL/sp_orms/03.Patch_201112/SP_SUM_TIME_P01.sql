USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_SUM_TIME]    Script Date: 01/17/2011 10:13:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO



If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_SUM_TIME]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_SUM_TIME]
GO




/*
--------------------------------------------------------------------
TITLE     : 시간대별 가동율 집계처리
DATE    : 2010.06.01
CREATOR : FIT
DESCRIPTION :
  EXEC SP_SUM_TIME  '20111214', 'N'
--------------------------------------------------------------------
*/
CREATE                     PROCEDURE [dbo].[SP_SUM_TIME]
(
  @parm_YMD   varchar(8), -- 생산일자
  @parm_TYPE    varchar(1)  -- 구분자 (N:08시 집계시, T:사용자 실시간 집계시)
)
AS
BEGIN

  SET NOCOUNT ON

  DECLARE @li_WORK_QTY      AS INT
  DECLARE @li_WORK_RATE   AS FLOAT
  DECLARE @ls_MODEL     AS VARCHAR(10)
  DECLARE @ls_PROD_HH     AS VARCHAR(3)
  DECLARE @ls_TIME_ZONE   AS VARCHAR(12)
  DECLARE @li_CYCLE_TIME    AS NUMERIC(12,1)
  DECLARE @li_TARGET_QTY    AS INT
  DECLARE @li_WORK_TIME   AS INT
  DECLARE @ls_PROD_SHIFT    AS VARCHAR(1)
  DECLARE @li_SEQ     AS INT
  DECLARE @ls_TIME      AS VARCHAR(20)
  DECLARE @li_RecordID      AS INT
  DECLARE @ls_HH      AS VARCHAR(3)


  -------------------------------------------------------------------
  -- STEP-01
  --  주간 SHIFT 기준시각을 조회
  -------------------------------------------------------------------
  SELECT @ls_TIME = REMARK
     FROM TM_CODE
   WHERE MCD    = '10'
        AND SCD     = '1'


  -------------------------------------------------------------------
  -- STEP-02
  --  이전 계산된 자료를 삭제
  -------------------------------------------------------------------
  DELETE FROM TH_DATA_TIME
    WHERE PROD_YMD = @parm_YMD


  -------------------------------------------------------------------
  -- STEP-03
  --  시간대별 가동시간을 계산
  -------------------------------------------------------------------
  EXEC SP_SUM_WORK_TIME


  -------------------------------------------------------------------
  -- STEP-04
  --  INTERFACE 된 생산정보로
  --        가동율 계산
  -------------------------------------------------------------------
  DECLARE Cur_Data CURSOR
  LOCAL
  FORWARD_ONLY
  STATIC
  READ_ONLY
  FOR
  SELECT  MODEL,
    PROD_HH,
    SUM(PROD_QTY),
    AVG(CYCLE_TIME)
                 FROM  TH_INF_DATA
   WHERE  PROD_YMD  = @parm_YMD
   GROUP BY  PROD_HH, MODEL
     ORDER BY PROD_HH

  OPEN Cur_Data

  FETCH NEXT FROM Cur_Data INTO @ls_MODEL, @ls_PROD_HH, @li_WORK_QTY, @li_CYCLE_TIME
  WHILE (@@FETCH_STATUS=0)
  BEGIN

  -- 시간대의 가동시간을 초단위로 조회
  --
  SET @li_WORK_TIME = 0
  SELECT @li_WORK_TIME  = WORK_TIME
     FROM TH_WORK_TIME
   WHERE HH   = @ls_PROD_HH


  -- 계획수량
  --
  IF (@li_CYCLE_TIME = 0)
    SET @li_TARGET_QTY = 0
  ELSE
    SET @li_TARGET_QTY = FLOOR(@li_WORK_TIME / @li_CYCLE_TIME)

  -- 가동율
  --
  IF (@li_TARGET_QTY = 0)
    SET @li_WORK_RATE = 0
  ELSE
    SET @li_WORK_RATE = CONVERT(FLOAT, @li_WORK_QTY) / CONVERT(FLOAT, @li_TARGET_QTY) * 100


  IF (@li_WORK_RATE < 0)
    SET @li_WORK_RATE = 0

  -- TIME ZONE 처리
  --
  IF RIGHT(@ls_PROD_HH,1) = '1'
    SET @ls_TIME_ZONE = LEFT(@ls_PROD_HH,2) + ':00~' + LEFT(@ls_PROD_HH,2) + ':29'
  ELSE
    SET @ls_TIME_ZONE = LEFT(@ls_PROD_HH,2) + ':30~' + LEFT(@ls_PROD_HH,2) + ':59'

  IF (@ls_PROD_HH < SUBSTRING(@ls_TIME,1,2) OR @ls_PROD_HH > SUBSTRING(@ls_TIME,7,2))
    SET @ls_PROD_SHIFT = '2'
  ELSE
    SET @ls_PROD_SHIFT = '1'

  INSERT INTO TH_DATA_TIME
    (PROD_YMD, MODEL, TIME_ZONE,  WORK_QTY, WORK_RATE,
     PROD_SHIFT, SEQ)
  VALUES
    (@parm_YMD, @ls_MODEL, @ls_TIME_ZONE, @li_WORK_QTY, @li_WORK_RATE,
     @ls_PROD_SHIFT, dbo.FN_GET_TIME_SEQ(@ls_PROD_HH))


  FETCH NEXT FROM Cur_Data INTO @ls_MODEL, @ls_PROD_HH, @li_WORK_QTY, @li_CYCLE_TIME
  END


  CLOSE Cur_Data
  DEALLOCATE Cur_Data


  -------------------------------------------------------------------
  -- STEP-05
  --  빈 시간대는 기본값으로 등록
  -------------------------------------------------------------------
  DECLARE Cur_Data_Space CURSOR
  LOCAL
  FORWARD_ONLY
  STATIC
  READ_ONLY
  FOR
  SELECT  RecordID,
    HH
  FROM  TH_WORK_TIME
  ORDER BY  RecordID

  OPEN Cur_Data_Space

  FETCH NEXT FROM Cur_Data_Space INTO @li_RecordID, @ls_HH
  WHILE (@@FETCH_STATUS=0)
  BEGIN
  -- TIME ZONE 처리
  --
  IF (RIGHT(@ls_HH, 1) = '1')
    SET @ls_TIME_ZONE = LEFT(@ls_HH,2) + ':00~' + LEFT(@ls_HH,2) + ':29'
  ELSE
    SET @ls_TIME_ZONE = LEFT(@ls_HH,2) + ':30~' + LEFT(@ls_HH,2) + ':59'


  -- SHIFT 처리
  --
  IF (@ls_HH < SUBSTRING(@ls_TIME,1,2) OR @ls_HH > SUBSTRING(@ls_TIME,7,2))
    SET @ls_PROD_SHIFT = '2'
  ELSE
    SET @ls_PROD_SHIFT = '1'


  IF NOT EXISTS (SELECT *
      FROM TH_DATA_TIME
                            WHERE  PROD_YMD = @parm_YMD
                    AND   TIME_ZONE = @ls_TIME_ZONE)
  BEGIN
    INSERT INTO TH_DATA_TIME
      (PROD_YMD, MODEL, TIME_ZONE,  WORK_QTY, WORK_RATE,
       PROD_SHIFT, SEQ)
    VALUES
      (@parm_YMD, '', @ls_TIME_ZONE, 0, 0,
       @ls_PROD_SHIFT, @li_RecordID)
  END

  FETCH NEXT FROM Cur_Data_Space INTO @li_RecordID, @ls_HH
  END


  CLOSE Cur_Data_Space
  DEALLOCATE Cur_Data_Space


  SET NOCOUNT OFF


END












GO

