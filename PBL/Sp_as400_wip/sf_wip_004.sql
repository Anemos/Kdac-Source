-- file name : sf_wip_004
-- procedure name : pbwip.sf_wip_004
-- desc : return exchange cost

drop function pbwip.sf_wip_004;
create function pbwip.sf_wip_004 (
a_cmcd varchar(2),
a_year varchar(4),
a_mont varchar(2),
a_plant varchar(1),
a_dvsn varchar(1),
a_itno varchar(15))
returns numeric(11,3)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_cost numeric(11,3);

select acost into p_cost
from pbpdm.bom010
where acmcd = a_cmcd and ayear = a_year and
      amont = a_mont and aplant = a_plant and
      advsn = a_dvsn and aitno = a_itno;
      
if sqlcode = 0 then
  return p_cost;
else
  return 0;
end if;
end
