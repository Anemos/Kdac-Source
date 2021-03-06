/*
  file name : sp_wo_schedule_calendar.sql
  system    : cmms system
  procedure name  : sp_wo_schedule_calendar
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_schedule_calendar]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_schedule_calendar]
go

/*
execute sp_wo_schedule_calendar
*/

create PROCEDURE [dbo].[sp_wo_schedule_calendar]
@PS_YYYYMM VARCHAR(6),
@PS_WOSTATCODE  VARCHAR(30),
@PS_AREA  VARCHAR(1),
@PS_FACTORY VARCHAR(1)
AS
BEGIN -- BEGIN PROCEDURE
CREATE TABLE #TEMP_RESULT
( DDATE DATETIME NULL,
  IWEEKDAY INT NULL,
  WOCOUNT INT NULL
)
IF @PS_WOSTATCODE = '��ȹ'
BEGIN
  INSERT INTO #TEMP_RESULT (DDATE, IWEEKDAY, WOCOUNT)
  SELECT DDATE = A.DDATE,
         IWEEKDAY = A.IWEEKDAY,
         WOCOUNT = 0
    FROM TMSTCALENDAR A
   WHERE A.AREA_CODE = @PS_AREA AND A.FACTORY_CODE = @PS_FACTORY AND A.YYYYMM = @PS_YYYYMM
  SELECT  DDATE = A.DDATE,
    WOCOUNT = ISNULL(COUNT(b.wo_code),0)
    INTO #TEMP_PLAN1
    FROM TMSTCALENDAR A, wo B
    WHERE A.AREA_CODE = B.AREA_CODE AND A.FACTORY_CODE = B.FACTORY_CODE AND
        A.YYYYMM = @PS_YYYYMM and
        ( A.YYYYMMDD BETWEEN CONVERT(VARCHAR(8),B.wo_float_DATE, 112) AND CONVERT(VARCHAR(8),B.wo_ESTEND_DATE, 112) )  AND
      B.WO_STATe_CODE = '��ȹ' AND B.AREA_CODE = @PS_AREA AND B.FACTORY_CODE=@PS_FACTORY
    GROUP BY A.DDATE
  SELECT  DDATE = A.DDATE,
    WOCOUNT = ISNULL(COUNT(b.task_code),0)
    INTO #TEMP_PLAN2
    FROM TMSTCALENDAR A, task b
    WHERE A.AREA_CODE = B.AREA_CODE AND A.FACTORY_CODE = B.FACTORY_CODE AND
      A.YYYYMM = @PS_YYYYMM and
       ( A.YYYYMMDD = CONVERT(VARCHAR(8),B.exam_date, 112) )  AND
      B.status_code = '��ȹ'  AND B.AREA_CODE =@PS_AREA AND B.FACTORY_CODE=@PS_FACTORY
    GROUP BY A.DDATE
  UPDATE #TEMP_RESULT SET WOCOUNT =isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0)
    FROM #TEMP_PLAN1 a, #TEMP_PLAN2 b
    WHERE #TEMP_RESULT.DDATE *= a.DDATE and  #TEMP_RESULT.DDATE *= b.DDATE
END
ELSE IF @PS_WOSTATCODE = '������'
BEGIN
  INSERT INTO #TEMP_RESULT (DDATE, IWEEKDAY, WOCOUNT)
  SELECT DDATE = A.DDATE,
         IWEEKDAY = A.IWEEKDAY,
         WOCOUNT = 0
    FROM TMSTCALENDAR A
   WHERE A.AREA_CODE = @PS_AREA AND A.FACTORY_CODE = @PS_FACTORY AND A.YYYYMM = @PS_YYYYMM
  SELECT DDATE = A.DDATE,
         IWEEKDAY = A.IWEEKDAY,
         WOCOUNT = ISNULL(COUNT(b.wo_code), 0)
    INTO #TEMP_M1
    FROM TMSTCALENDAR A, wo b
   WHERE A.AREA_CODE = B.AREA_CODE AND A.FACTORY_CODE = B.FACTORY_CODE AND A.YYYYMM = @PS_YYYYMM
           AND ( A.YYYYMMDD BETWEEN CONVERT(VARCHAR(8),B.wo_ESTEND_DATE, 112) and CONVERT(VARCHAR(8),B.wo_START_DATE, 112))
     AND B.WO_STATe_CODE = '������'
           AND B.wo_START_DATE IS NOT NULL  AND B.AREA_CODE =@PS_AREA AND B.FACTORY_CODE=@PS_FACTORY
   GROUP BY A.DDATE, A.IWEEKDAY

  SELECT  DDATE = A.DDATE,
     IWEEKDAY = A.IWEEKDAY,
    WOCOUNT = ISNULL(COUNT(b.task_code),0)
    INTO #TEMP_M2
    FROM TMSTCALENDAR A, task b
    WHERE A.AREA_CODE = B.AREA_CODE AND A.FACTORY_CODE = B.FACTORY_CODE AND A.YYYYMM = @PS_YYYYMM and
       ( A.YYYYMMDD = CONVERT(VARCHAR(8),B.exam_date, 112) )  AND
      B.status_code = '������'  AND B.AREA_CODE = @PS_AREA AND B.FACTORY_CODE=@PS_FACTORY
    GROUP BY A.DDATE,A.IWEEKDAY
  UPDATE #TEMP_RESULT
     SET WOCOUNT = isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0)
    FROM #TEMP_M1 a, #TEMP_M2 b
   WHERE #TEMP_RESULT.DDATE *= a.DDATE and #TEMP_RESULT.DDATE *= b.DDATE
END
-- RESULT SET
SELECT DDATE,
       IWEEKDAY,
       WOCOUNT
  FROM #TEMP_RESULT
  ORDER BY DDATE
END  -- END PROCEDURE