-- file name : sf_wip_002
-- procedure name : pbwip.sf_wip_002
-- desc : return format '000000~'

drop function pbwip.sf_wip_002;
create function pbwip.sf_wip_002 (
a_value integer,
a_index integer)
returns varchar(10)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_zero char(1);
declare p_rtncd varchar(10);
declare p_serial numeric(10,0);
declare p_difflen integer;

set p_zero = '0';
set p_rtncd = trim(cast(a_value as char(10)));
set p_difflen = a_index - length(p_rtncd);

if p_difflen < 0 then
   return '0000000000';
end if;
while p_difflen <> 0 do
  set p_rtncd = concat(p_zero,p_rtncd);
  set p_difflen = p_difflen - 1;
end while;
return TRIM(p_rtncd);
end

