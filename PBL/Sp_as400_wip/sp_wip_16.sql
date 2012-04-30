-- file name : sp_wip_16
-- procedure name : pbwip.sp_wip_16
-- desc : bom explosion

drop procedure pbwip.sp_wip_16;
create procedure pbwip.sp_wip_16 (
in a_comltd varchar(2),
in a_plant varchar(1),
in a_dvsn varchar(1),
in a_itno varchar(15),
in a_date varchar(8),
in a_chk varchar(1),
in a_delchk varchar(1))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
set p_rtn = pbwip.sf_wip_006(a_comltd,a_plant,a_dvsn,
            a_itno,a_date,a_chk,a_delchk);
if p_rtn = 'Y' then
   set sqlcode = 0;
else
   set sqlcode = -1;
end if;
end
