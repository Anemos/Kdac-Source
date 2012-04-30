/*
  file name : sp_wo_schedule_monsum.sql
  system    : cmms system
  procedure name  : sp_wo_schedule_monsum
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_schedule_monsum]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_schedule_monsum]
go

/*
execute sp_wo_schedule_monsum
*/

create PROCEDURE [dbo].[sp_wo_schedule_monsum]
@PS_FROM  VARCHAR(8),
@PS_TO    VARCHAR(8),
@PS_area  VARCHAR(1),
@PS_factory   VARCHAR(1)
AS
BEGIN -- BEGIN PROCEDURE
CREATE TABLE #TEMP_RESULT (
  WOSTATCODE  VARCHAR(30) NULL,
  WOCOUNT   INT  NULL,
  sorder int null)

SELECT wostatcode= WO_STATe_CODE,
      wocount= COUNT(WO_code),
sorder = 3
into #temp1
  FROM WO
 WHERE CONVERT(VARCHAR(8), wo_float_date, 112) >= @PS_FROM
   AND CONVERT(VARCHAR(8), wo_float_date, 112) <= @PS_TO
   AND WO_STATe_CODE = '계획' and factory_code = @PS_factory and area_code = @PS_area
 GROUP BY WO_STATe_CODE
if not exists(select 1 from #temp1)
begin
  INSERT INTO #temp1(wostatcode, WOCOUNT,sorder)
  values ('계획',0,3)
end
SELECT wostatcode=status_code,
       wocount=COUNT(task_code),
sorder=3
into #temp2
  FROM task
 WHERE CONVERT(VARCHAR(8), exam_date, 112) >= @PS_FROM
   AND CONVERT(VARCHAR(8), exam_date, 112) <= @PS_TO
   AND status_code = '계획' and factory_code = @PS_factory and area_code = @PS_area
 GROUP BY status_code
if not exists(select 1 from #temp2)
begin
  INSERT INTO #temp2 (wostatcode, WOCOUNT,sorder)
  values ('계획',0,3)
end
INSERT INTO #TEMP_RESULT (wostatcode, WOCOUNT,sorder)
SELECT wostatcode = 'd'+A.wostatcode,
       WOCOUNT = isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0),
sorder=3
  FROM #temp1 A, #temp2 b


SELECT wostatcode='마감',
      wocount=COUNT(WO_code),
sorder=2
into #temp3
  FROM WO_HIST
 WHERE (CONVERT(VARCHAR(8), wo_float_date, 112) BETWEEN @PS_FROM AND @PS_TO)
   AND WO_STATe_CODE = '완료' and factory_code = @PS_factory and area_code = @PS_area
if not exists(select 1 from #temp3)
begin
  INSERT INTO #temp3 (wostatcode, WOCOUNT,sorder)
  values ('마감',0,2)
end
SELECT wostatcode='마감',
      wocount=COUNT(task_code),
sorder=3
into #temp4
  FROM task_HIST
 WHERE (CONVERT(VARCHAR(8), exam_date, 112) BETWEEN @PS_FROM AND @PS_TO)
   AND status_code = '완료' and factory_code = @PS_factory and area_code = @PS_area
if not exists(select 1 from #temp4)
begin
  INSERT INTO #temp4 (wostatcode, WOCOUNT,sorder)
  values ('마감',0,2)
end
INSERT INTO #TEMP_RESULT (wostatcode, WOCOUNT,sorder)
SELECT wostatcode ='b'+ A.wostatcode,
       WOCOUNT = isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0),
sorder=2
  FROM #temp3 A, #temp4 b


SELECT wostatcode='진행중',
       wocount=COUNT(WO_code),
sorder=4
into #temp5
  FROM WO
 WHERE (CONVERT(VARCHAR(8), wo_float_date, 112) BETWEEN @PS_FROM AND @PS_TO)
   AND WO_STATe_CODE = '진행중'
   AND wo_START_DATE IS NOT NULL and factory_code = @PS_factory and area_code = @PS_area
if not exists(select 1 from #temp5)
begin
  INSERT INTO #temp5 (wostatcode, WOCOUNT,sorder)
  values ('진행중',0,4)
end
SELECT wostatcode=status_code,
       wocount=COUNT(task_code),
sorder=4
into #temp6
  FROM task
 WHERE (CONVERT(VARCHAR(8), exam_date, 112) BETWEEN @PS_FROM AND @PS_TO)
   AND status_code = '진행중' and factory_code = @PS_factory and area_code = @PS_area
 GROUP BY status_code
if not exists(select 1 from #temp6)
begin
  INSERT INTO #temp6 (wostatcode, WOCOUNT,sorder)
  values ('진행중',0,4)
end
INSERT INTO #TEMP_RESULT (wostatcode, WOCOUNT,sorder)
SELECT wostatcode = 'c'+A.wostatcode,
       WOCOUNT = isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0),
sorder=4
  FROM #temp5 A, #temp6 b


SELECT wostatcode='지연',
  wocount=COUNT(WO_code),
sorder=1
into #temp7
  FROM WO
 WHERE ( CONVERT(VARCHAR(8), wo_ESTEND_DATE, 112) < CONVERT(VARCHAR(8), GETDATE(), 112) )
   AND WO_STATe_CODE IN ('계획', '진행중') and factory_code = @PS_factory and area_code = @PS_area
if not exists(select 1 from #temp7)
begin
  INSERT INTO #temp7 (wostatcode, WOCOUNT,sorder)
  values ('지연',0,1)
end
SELECT wostatcode='지연',
  wocount=COUNT(task_code),
sorder=1
into #temp8
  FROM task
 WHERE ( CONVERT(VARCHAR(8), exam_date, 112) < CONVERT(VARCHAR(8), GETDATE(), 112) )
   AND status_code IN ('계획', '진행중') and factory_code = @PS_factory and area_code = @PS_area
if not exists(select 1 from #temp7)
begin
  INSERT INTO #temp7 (wostatcode, WOCOUNT,sorder)
  values ('지연',0,1)
end
INSERT INTO #TEMP_RESULT (wostatcode, WOCOUNT,sorder)
SELECT wostatcode = 'a'+A.wostatcode,
       WOCOUNT = isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0),
sorder=1
  FROM #temp7 A, #temp8 b
--SELECT wostatcode='완료',
--     wocount=COUNT(WO_code)
--into #temp9
--  FROM WO
-- WHERE (CONVERT(VARCHAR(8), wo_END_DATE, 112) BETWEEN @PS_FROM AND @PS_TO)
--   AND WO_STATe_CODE = '완료' and factory_code = @PS_factory and area_code = @PS_area
--if not exists(select 1 from #temp9)
--begin
--  INSERT INTO #temp9 (wostatcode, WOCOUNT)
--  values ('완료',0)
--end
--SELECT wostatcode='완료',
--      wocount=COUNT(task_code)
--into #temp10
--  FROM task
-- WHERE (CONVERT(VARCHAR(8), END_DATE, 112) BETWEEN @PS_FROM AND @PS_TO)
--   AND status_code = '완료' and factory_code = @PS_factory and area_code = @PS_area
--if not exists(select 1 from #temp10)
--begin
--  INSERT INTO #temp10 (wostatcode, WOCOUNT)
--  values ('완료',0)
--end
--INSERT INTO #TEMP_RESULT (wostatcode, WOCOUNT)
--SELECT wostatcode = A.wostatcode,
--      WOCOUNT = isnull(a.WOCOUNT,0)+isnull(b.WOCOUNT,0)
--  FROM #temp9 A, #temp10 b
-- RETURN RESULT SET
SELECT WOSTATCODE, WOCOUNT,sorder
  FROM #TEMP_RESULT
order by sorder
RETURN
END -- END PROCEDURE