-- file name : sf_wip_007
-- procedure name : pbwip.sf_wip_007
-- desc : return wcitcl, wcsrce

drop function pbwip.sf_wip_007;
create function pbwip.sf_wip_007 (
a_comltd varchar(2),
a_plant varchar(1),
a_dvsn varchar(1),
a_itno   varchar(15),
a_date  varchar(8),
a_chk    varchar(2))
returns char(2)
language sql
modifies sql data
begin

declare sqlcode integer default 0;
declare p_rtn       char(2);
declare p_year      char(4);
declare p_month     char(2);

set p_rtn  = ' ';
set p_year = substring(a_date,1,4);
set p_month = substring(a_date,5,2);

case a_chk
   when '01' then
     select wcitcl into p_rtn
      from pbwip.wip003
      where wccmcd = a_comltd and wcplant = a_plant and
            wcdvsn = a_dvsn   and wcitno  = a_itno and
            wcyear = p_year   and wcmonth = p_month;
   when '02' then
     select wcsrce into p_rtn
      from pbwip.wip003
      where wccmcd = a_comltd and wcplant = a_plant and
            wcdvsn = a_dvsn   and wcitno  = a_itno and
            wcyear = p_year   and wcmonth = p_month;
end case;

return p_rtn;

end
