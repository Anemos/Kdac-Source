/*
  file name : sp_wo_mttr.sql
  system    : cmms system
  procedure name  : sp_wo_mttr
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_mttr]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_mttr]
go

-- MTTR / MTBF 조회
-- exec sp_wo_mttr 17, 'D', 'A', '2003.10.01', '2003.10.20'

create PROCEDURE [dbo].[sp_wo_mttr]
@wo_day   int,
@area_code    varchar(1),
@factory_code   varchar(1),
@equip_div    varchar(1),
@start_date varchar(10),
@end_date varchar(10)

AS
BEGIN

select a.cc_code, c.cc_name , a.equip_code , a.equip_name, a.line_code,
  convert(varchar(30),isnull( @wo_day * 1170 / 60 , 0 ) )
  + ':' +
  convert(varchar(30),isnull( @wo_day * 1170 % 60, 0 ) )
  as work_time,
  convert(varchar(30), convert( int, isnull( sum(b.wo_firm_time_hour), 0) * 60
  + isnull( sum( b.wo_firm_time_minute ), 0) ) / 60 )
  + ':' +
     convert(varchar(30), convert( int, isnull( sum(b.wo_firm_time_hour), 0) * 60
  + isnull( sum( b.wo_firm_time_minute ), 0) ) % 60 )
  as firm_time,
  convert(varchar(30), convert( int, isnull( sum(b.wo_time_hour), 0) * 60
  + isnull( sum( b.wo_time_minute ), 0) ) / 60 )
  +':' +
  convert(varchar(30), convert( int, isnull( sum(b.wo_time_hour), 0) * 60
     + isnull( sum( b.wo_time_minute ), 0) ) % 60 )
  as wo_time,
  count(b.wo_code) as wo_count,
  -- MTTR1 : 총부동시간분 / 고장횟수
  convert(varchar(30), convert( int, ( isnull( sum(b.wo_firm_time_hour), 0) * 60
  + isnull( sum(b.wo_firm_time_minute), 0)) / count(b.wo_code) ) / 60)
  + ':' +
  convert(varchar(30), convert( int, (isnull( sum(b.wo_firm_time_hour), 0) * 60
  + isnull( sum(b.wo_firm_time_minute), 0)) / count(b.wo_code) ) % 60 )
  as mttr1,
  -- MTTR2 : 총정비시간분 / 고장횟수
  convert(varchar(30), convert( int, (isnull( sum(b.wo_time_hour), 0) * 60
  + isnull( sum(b.wo_time_minute), 0)) / count(b.wo_code) ) / 60 )
  + ':' +
  convert(varchar(30),convert( int, (isnull( sum(b.wo_time_hour), 0) * 60
  + isnull( sum( b.wo_time_minute), 0)) / count(b.wo_code) ) % 60 )
  as mttr2 ,
  convert(varchar(30),convert( int, isnull( (@wo_day * 19.5 * 60
    - ( isnull( sum(b.wo_firm_time_hour), 0) * 60
      + isnull( sum(b.wo_firm_time_minute), 0) ) ) / count(b.wo_code) , 0) ) / 60 )
  + ':' +
  convert(varchar(30),convert( int, isnull( (@wo_day * 19.5 * 60
    - ( isnull( sum(b.wo_firm_time_hour), 0) * 60
      + isnull( sum(b.wo_firm_time_minute), 0) ) ) / count(b.wo_code) , 0) ) % 60 )
  as mtbf
--  convert(varchar(30),convert(int,isnull( (@wo_day*19.5*k.equip_count*60 - k.firm_time)/k.wo_count , 0))/60) +':'+convert(varchar(30),convert(int,isnull( (@wo_day*19.5*k.equip_count*60 - k.firm_time)/k.wo_count , 0))%60) as mtbf,
    from equip_master a, wo_hist b, cc_master c
    where a.equip_code=b.equip_code and a.area_code=b.area_code and a.factory_code=b.factory_code 
      and a.cc_code=c.cc_code and a.area_code=@area_code and a.factory_code=@factory_code
      and convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date  and a.equip_div_code=@equip_div and b.wo_code like '%B%'
    group by a.cc_code, c.cc_name, a.equip_code, a.equip_name, a.line_code

END