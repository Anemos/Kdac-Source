-- file name : sf_wip_009
-- procedure name : pbwip.sf_wip_009
-- desc : return customer wip cost-item material cost

create function pbwip.sf_wip_009 (
a_cmcd varchar(2),
a_date varchar(6),
a_plant varchar(1),
a_dvsn varchar(1),
a_itno varchar(15))
returns numeric(7,0)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_cost numeric(7,0) default 0;

SELECT FWCOST INTO p_cost
from pbpdm.bom016
where fcmcd = a_cmcd and fdate = a_date and
      fplant = a_plant and fdvsn = a_dvsn and
      fmdno = a_itno and fgubun = 'B';

if sqlcode = 0 then
  return p_cost;
else
  return 0;
end if;
end
