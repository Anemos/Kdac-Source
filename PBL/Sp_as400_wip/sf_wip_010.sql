-- file name : sf_wip_010
-- procedure name : pbwip.sf_wip_010
-- desc : return wip002ds yesterday ohat1,ohat2,ohat3,ohat4,ohat5,ohat6
-- gubun : 공제전('A'),공제분('B'),공제후('C')
--         이체공제전('D'), 이체공제분('E'), 이체공제후('F')

drop function pbwip.sf_wip_010;
create function pbwip.sf_wip_010 (
a_cmcd varchar(2),
a_yymmdd varchar(8),
a_plant varchar(1),
a_dvsn varchar(1),
a_orct varchar(5),
a_itno varchar(15),
a_iocd varchar(1),
a_gubun varchar(1) )
returns numeric(15,0)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_cost numeric(15,0) default 0;

select CASE WHEN a_gubun = 'A' THEN wbohat1
  WHEN a_gubun = 'B' THEN wbohat2
  WHEN a_gubun = 'C' THEN wbohat3
  WHEN a_gubun = 'D' THEN wbohat4
  WHEN a_gubun = 'E' THEN wbohat5
  WHEN a_gubun = 'F' THEN wbohat6
  ELSE 0 END
into p_cost
from pbwip.wip002ds
where wbcmcd = a_cmcd and wbyymmdd = a_yymmdd and
  wbplant = a_plant and
  wbdvsn = a_dvsn and wborct = a_orct and
  wbitno = a_itno and wbiocd = a_iocd ;

if sqlcode = 0 then
  return p_cost;
else
  return 0;
end if;
end
