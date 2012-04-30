/*
  file name : sp_wo_total_old.sql
  system    : cmms system
  procedure name  : sp_wo_total_old
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_total_old]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_total_old]
go

-- 정비현황분석 리포트
-- exec sp_wo_total 17, 'D', 'A', '2003-10-01','2003-10-17'

create PROCEDURE [dbo].[sp_wo_total_old]
@wo_day   int,
@area_code    varchar(1),
@factory_code   varchar(1),
@start_date varchar(10),
@end_date varchar(10)



AS
BEGIN
declare @TEMP_VARCHAR VARCHAR(30)

DROP TABLE TEMP_CC_EQUIP_TIME

-- CC별 부동시간 집계
select a.cc_code, @TEMP_VARCHAR as equip_code, max((isnull(b.wo_firm_time_hour,0) *60 + isnull(b.wo_firm_time_minute,0))) as firm_time, a.area_code, a.factory_code
  into temp_cc_equip_time
  from equip_master a, wo_hist b
  where a.area_code = b.area_code and a.factory_code = b.factory_code
      and a.equip_code=b.equip_code and A.AREA_CODE=@area_code and a.factory_code=@factory_code
      and  convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date
      and a.equip_div_code='1'
  group by a.cc_code, a.area_code, a.factory_code

update temp_cc_equip_time
  set equip_code=x.equip_code
  from
  (
    select a.cc_code ,a.equip_code,max((isnull(b.wo_firm_time_hour,0) *60 + isnull(b.wo_firm_time_minute,0))) as firm_time, a.area_code, a.factory_code
    from equip_master a, wo_hist b
    where a.area_code = b.area_code and a.factory_code = b.factory_code
      and a.equip_code=b.equip_code and A.AREA_CODE=@area_code and a.factory_code=@factory_code
      and convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date
      and a.equip_div_code='1'
    group by a.cc_code,a.equip_code, a.area_code, a.factory_code
  ) x,
  (
    select a.cc_code, a.cc_code as equip_code, max((isnull(b.wo_firm_time_hour,0) *60 + isnull(b.wo_firm_time_minute,0))) as firm_time, a.area_code, a.factory_code
    from equip_master a, wo_hist b
    where a.area_code = b.area_code and a.factory_code = b.factory_code
    and a.equip_code=b.equip_code and A.AREA_CODE=@area_code and a.factory_code=@factory_code
    and  convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date
    and a.equip_div_code='1'
    group by a.cc_code, a.area_code, a.factory_code

  ) y
  where x.firm_time = y.firm_time and x.cc_code = y.cc_code  and x.area_code=@area_code and x.factory_code=@factory_code

select  k.cc_code,
  isnull(l.cc_name, n.comp_name) as cc_name,
  isnull(k.equip_count,0) as equip_count,
  convert(varchar(30),isnull(@wo_day * 1170 * k.equip_count / 60,0)) +':'+convert(varchar(30),isnull(@wo_day*1170*k.equip_count%60,0)) as work_time,
  convert(varchar(30),convert(int,isnull(k.firm_time,0))/60) +':'+convert(varchar(30),convert(int,isnull(k.firm_time,0))%60)as firm_time,
  convert(varchar(30),convert(int,isnull(k.wo_time,0))/60) +':'+convert(varchar(30),convert(int,isnull(k.wo_time,0))%60)as wo_time,
  k.wo_count,
  convert(varchar(30),convert(int,isnull( (@wo_day*19.5*k.equip_count*60 - k.firm_time)/k.wo_count , 0))/60) +':'+convert(varchar(30),convert(int,isnull( (@wo_day*19.5*k.equip_count*60 - k.firm_time)/k.wo_count , 0))%60) as mtbf,
  convert(varchar(30),convert(int,isnull(k.firm_time/k.wo_count,0))/60)+':'+convert(varchar(30),convert(int,isnull(k.firm_time/k.wo_count,0))%60) as mttr1,
  convert(varchar(30),convert(int,isnull(k.wo_time/k.wo_count,0))/60)+':'+convert(varchar(30),convert(int,isnull(k.wo_time/k.wo_count,0))%60) as mttr2,
  k.equip_code,
  m.equip_name,
  convert(varchar(30),convert(int,isnull(k.firm_time2,0))/60) +':'+convert(varchar(30),convert(int,isnull(k.firm_time2,0))%60)as firm_time2,
  convert(int,isnull(@wo_day*1170 * k.equip_count / 60 ,0)) as aaa,
  convert(int,isnull(@wo_day*1170 * k.equip_count % 60 ,0)) as bbb,
  convert(int,isnull(k.firm_time, 0))/60  as ccc,
  convert(int,isnull(k.firm_time, 0))%60  as ddd,
  convert(int,isnull(k.wo_time, 0))/60 as eee,
  convert(int,isnull(k.wo_time, 0))%60 as fff,
  'Y' as chkflag
from
(
  select a.cc_code, c.equip_count, sum(b.wo_firm_time_hour)*60+sum(b.wo_firm_time_minute) as firm_time,
    sum(b.wo_time_hour)*60+sum(b.wo_time_minute) as wo_time, count(b.wo_code) as wo_count, d.firm_time as firm_time2, d.equip_code as equip_code
  from
  -- CC별 장비대수 가져오기
  (
    select c.cc_code, count(c.equip_code) as equip_count
    from equip_master c
    where area_code=@area_code and factory_code= @factory_code and c.equip_div_code='1'
    group by c.cc_code

  ) c,
  -- CC별 부동시간의 합 가져오기
  (
    select cc_code, equip_code, firm_time
    from temp_cc_equip_time
  ) d,
  equip_master a, wo_hist b

  where a.area_code = b.area_code and a.factory_code = b.factory_code
    and a.equip_code *= b.equip_code and A.AREA_CODE =  @area_code and a.factory_code=@factory_code
    and a.cc_code = c.cc_code and a.cc_code = d.cc_code and
    convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date
    and a.equip_div_code='1' and b.wo_code like '%B%'
  group by a.cc_code, c.equip_count, d.firm_time,d.equip_code

  union all

  select a.cc_code, c.equip_count, sum(b.wo_firm_time_hour)*60+sum(b.wo_firm_time_minute) as firm_time,
    sum(b.wo_time_hour)*60+sum(b.wo_time_minute) as wo_time, count(b.wo_code) as wo_count , 0 as firm_time2, '' as equip_code
  from
  (
    select c.cc_code, count(c.equip_code) as equip_count
    from equip_master c
    where area_code=@area_code and factory_code= @factory_code and c.equip_div_code='1'
    group by c.cc_code
  ) c,
  equip_master a, wo_hist b

  where a.area_code = b.area_code and a.factory_code = b.factory_code
    and a.equip_code *= b.equip_code and A.AREA_CODE = @area_code and a.factory_code = @factory_code
    and a.cc_code=c.cc_code and
    convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date and a.equip_div_code='1'
    and b.wo_code like '%B%'
  group by a.cc_code, c.equip_count
  having count(b.wo_code) < 1
) k,
cc_master l, equip_master m, comp_master n
where k.cc_code *= l.cc_code and  k.cc_code *= n.comp_code and k.equip_code *= m.equip_code



END