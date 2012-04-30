/*
  file name : sp_get_group_cause.sql
  system    : cmms system
  procedure name  : sp_get_group_cause
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_get_group_cause]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_get_group_cause]
go

/*
execute sp_get_group_cause
*/

create procedure [dbo].[sp_get_group_cause]
@area_code varchar(1),
@factory_code varchar(1),
@fromdate varchar(10),
@todate varchar(10)

AS
BEGIN

DECLARE @total_cnt integer

set @total_cnt = (select count(*)
from wo_hist bb inner join equip_div_b aa
        on aa.area_code = bb.area_code and
           aa.factory_code = bb.factory_code and
           aa.equip_div_a_code = bb.cause_code_a and
           aa.equip_div_b_code = bb.cause_code_b
where bb.area_code = @area_code and
      bb.factory_code = @factory_code and
      (convert(varchar(10),bb.wo_float_date,120) between @fromdate and @todate))

if @total_cnt <> 0
  select aa.equip_div_a_code,
         aa.equip_div_b_code,
         aa.equip_div_b_name,
         bb.cause_cnt,
         ( bb.cause_cnt / @total_cnt ) * 100 as cause_percent
  from equip_div_b aa, ( select area_code,factory_code, cause_code_a, cause_code_b,
                        count(*) as cause_cnt
                       from wo_hist
                       where area_code = @area_code and
                             factory_code = @factory_code and
                             (convert(varchar(10),wo_float_date,120) between @fromdate and @todate)
                       group by area_code, factory_code, cause_code_a, cause_code_b ) bb
  where aa.area_code = bb.area_code and
        aa.factory_code = bb.factory_code and
        aa.equip_div_a_code = bb.cause_code_a and
        aa.equip_div_b_code = bb.cause_code_b
  order by aa.equip_div_a_code, aa.equip_div_b_code
else
  select aa.equip_div_a_code,
         aa.equip_div_b_code,
         aa.equip_div_b_name,
         0,
         0
  from equip_div_b aa
  where aa.area_code = @area_code and aa.factory_code = @factory_code
  order by aa.equip_div_a_code, aa.equip_div_b_code

END