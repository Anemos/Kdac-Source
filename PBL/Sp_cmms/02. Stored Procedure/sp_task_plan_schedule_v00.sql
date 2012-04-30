/*
  file name : sp_task_plan_schedule.sql
  system    : cmms system
  procedure name  : sp_task_plan_schedule
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_task_plan_schedule]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_task_plan_schedule]
go

/*
execute sp_task_plan_schedule 'D','A','2012-03-01','2012-05-31'
*/

create PROCEDURE [dbo].[sp_task_plan_schedule]
                  @PS_AREA      VARCHAR(1),
                  @PS_FACTORY   VARCHAR(1),
                  @PS_YYMMDD_A    DATETIME,
                  @PS_YYMMDD_B  DATETIME

AS

BEGIN -- BEGIN PROCEDURE

  DECLARE @EQUIP_CODE   VARCHAR(30)
  DECLARE @CLASS_DIV  VARCHAR(30)
  DECLARE @CLASS_SPOT   VARCHAR(50)
  DECLARE @CLASS_ITEM   VARCHAR(64)
  DECLARE @CLASS_CYCLE  FLOAT
  DECLARE @CYCLE_CODE   VARCHAR(30)
  DECLARE @NEXT_DATE  DATETIME
  DECLARE @li_Serial    INT
  DECLARE @li_TotCnt    INT

  TRUNCATE TABLE SCHEDULE_NEXT

  CREATE TABLE #TASK_GEN
      ( SERIAL INT IDENTITY(1,1) NOT NULL,
        EQUIP_CODE VARCHAR(9) NOT NULL,
        CLASS_DIV VARCHAR(30) NULL,
        CLASS_SPOT VARCHAR(50) NULL,
          CLASS_ITEM VARCHAR(64) NULL,
        CLASS_CYCLE NUMERIC(7,0) NULL,
        CYCLE_CODE VARCHAR(30) NULL,
        CLASS_EST_DATE DATETIME NULL)

  INSERT INTO #TASK_GEN
      (EQUIP_CODE, CLASS_DIV, CLASS_SPOT, CLASS_ITEM, CLASS_CYCLE, CYCLE_CODE, CLASS_EST_DATE)
  SELECT DISTINCT A.EQUIP_CODE, A.CLASS_DIV, A.CLASS_SPOT, A.CLASS_ITEM,
          A.CLASS_CYCLE, A.CYCLE_CODE, A.CLASS_EST_DATE
  FROM (
      SELECT * FROM EQUIP_CLASS
      WHERE AREA_CODE = @PS_AREA AND FACTORY_CODE = @PS_FACTORY AND
        ISNULL(CLASS_CYCLE, '') <> '' AND ISNULL(CYCLE_CODE, '') <> '' ) A,
    ( SELECT * FROM PART_MASTER
      WHERE AREA_CODE = @PS_AREA AND FACTORY_CODE = @PS_FACTORY) B,
    ( SELECT * FROM EQUIP_MASTER
      WHERE AREA_CODE = @PS_AREA AND FACTORY_CODE = @PS_FACTORY) C
  WHERE A.PART_CODE *= B.PART_CODE AND A.EQUIP_CODE = C.EQUIP_CODE
      AND A.CLASS_DIV <> '04' AND C.EQUIP_DIV_CODE NOT IN ('3', '8', '9', 'X')
      AND A.CLASS_EST_DATE IS NOT NULL

  SELECT @li_Serial = 0, @li_TotCnt = @@ROWCOUNT
  IF ( @li_TotCnt = 0 ) RETURN

  WHILE @li_Serial < @li_TotCnt
  BEGIN
    SELECT TOP 1
        @li_Serial = AA.SERIAL,
        @EQUIP_CODE = AA.EQUIP_CODE,
        @CLASS_DIV = AA.CLASS_DIV,
        @CLASS_SPOT = AA.CLASS_SPOT,
        @CLASS_ITEM = AA.CLASS_ITEM,
        @CLASS_CYCLE = AA.CLASS_CYCLE,
        @CYCLE_CODE = AA.CYCLE_CODE,
        @NEXT_DATE = AA.CLASS_EST_DATE
    FROM #TASK_GEN AA
    WHERE AA.SERIAL > @li_Serial
    ORDER BY AA.SERIAL

    IF (@CYCLE_CODE NOT IN ('일','주','월','분기','반기','년'))
      CONTINUE
    
    WHILE (@NEXT_DATE <= @PS_YYMMDD_B)
    BEGIN

      IF((@NEXT_DATE >= @PS_YYMMDD_A) AND (@NEXT_DATE <= @PS_YYMMDD_B))
      BEGIN
        INSERT INTO SCHEDULE_NEXT
            (EQUIP_CODE, CLASS_DIV, CLASS_SPOT, CLASS_ITEM, CLASS_BASIS, CLASS_PROCESS,
              CLASS_CYCLE, CYCLE_CODE, CLASS_EST_DATE, CLASS_EST_TIME_HOUR, CLASS_EST_TIME_MIN,
              PART_CODE, PART_NAME, PART_SPEC, CLASS_QTY, AREA_CODE, FACTORY_CODE)
        SELECT A.EQUIP_CODE, A.CLASS_DIV, A.CLASS_SPOT, A.CLASS_ITEM, A.CLASS_BASIS,  A.CLASS_PROCESS,
            A.CLASS_CYCLE,  A.CYCLE_CODE, @NEXT_DATE, A.CLASS_EST_TIME_HOUR, A.CLASS_EST_TIME_MIN,
            A.PART_CODE, B.PART_NAME, B.PART_SPEC, A.CLASS_QTY, A.AREA_CODE, A.FACTORY_CODE
        FROM EQUIP_CLASS A,
          ( SELECT * FROM PART_MASTER
            WHERE AREA_CODE = @PS_AREA AND FACTORY_CODE = @PS_FACTORY) B
        WHERE A.AREA_CODE = B.AREA_CODE AND A.FACTORY_CODE = B.FACTORY_CODE
            AND A.PART_CODE *= B.PART_CODE AND A.EQUIP_CODE=@EQUIP_CODE
            AND A.CLASS_DIV=@CLASS_DIV AND A.CLASS_SPOT=@CLASS_SPOT
            AND A.CLASS_ITEM=@CLASS_ITEM AND A.CLASS_DIV<>'04'

        SELECT @NEXT_DATE =
          CASE @CYCLE_CODE
            WHEN '일' THEN DATEADD(DAY, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '주' THEN DATEADD(WEEK, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '월' THEN DATEADD(MONTH, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '분기' THEN DATEADD(MONTH, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '반기' THEN DATEADD(MONTH, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '년' THEN DATEADD(YEAR, @CLASS_CYCLE, @NEXT_DATE)
            ELSE DATEADD(YEAR, 1, @PS_YYMMDD_B) END

      END

      IF (@NEXT_DATE < @PS_YYMMDD_A)
      BEGIN
        SELECT @NEXT_DATE =
          CASE @CYCLE_CODE
            WHEN '일' THEN DATEADD(DAY, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '주' THEN DATEADD(WEEK, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '월' THEN DATEADD(MONTH, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '분기' THEN DATEADD(MONTH, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '반기' THEN DATEADD(MONTH, @CLASS_CYCLE, @NEXT_DATE)
            WHEN '년' THEN DATEADD(YEAR, @CLASS_CYCLE, @NEXT_DATE)
            ELSE DATEADD(YEAR, 1, @PS_YYMMDD_B) END
      END

    END
  END

  DROP TABLE #TASK_GEN
  SELECT 1

END -- END PROCEDURE