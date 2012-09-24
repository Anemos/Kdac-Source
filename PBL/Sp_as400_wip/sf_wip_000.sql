-- file name : sf_wip_000
-- procedure name : pbwip.sf_wip_000
-- desc : get serial no

drop function pbwip.sf_wip_000;
create function pbwip.sf_wip_000 (
a_comltd varchar(2))
returns char(10)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_zero char(1);
declare p_rtncd varchar(10);
declare p_serial numeric(10,0);
declare p_difflen integer;

-- get wip serial no
select max(wzserno) into p_serial
 from pbwip.wip090
 where wzcmcd = a_comltd and wzcttp = 'SERIAL';
if sqlcode <> 0 then
        return '0000000000';
end if;

update pbwip.wip090
        set wzserno = p_serial + 1
        where wzcmcd = a_comltd and wzcttp = 'SERIAL';
if sqlcode <> 0 then
        return '0000000000';
end if;

set p_zero = '0';
set p_serial = p_serial + 1;
set p_rtncd = trim(cast(p_serial as char(10)));
set p_difflen = 10 - length(p_rtncd);

while p_difflen <> 0 do
  set p_rtncd = concat(p_zero,p_rtncd);
  set p_difflen = p_difflen - 1;
end while;
return TRIM(p_rtncd);
end