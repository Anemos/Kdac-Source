-- file name : sp_wip_22
-- procedure name : pbwip.sp_wip_22
-- desc : creation bom list

drop procedure pbwip.sp_wip_22;
create procedure pbwip.sp_wip_22 (
in a_comltd varchar(2),
in a_date varchar(8),
in a_chk varchar(1))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_itno varchar(15);
declare p_year char(4);
declare p_month char(2);
declare at_end integer default 0;
declare not_found condition for '02000';

-- Find 10/05 item
declare wip030_cur01 cursor for
  select xplant,div,itno from pbinv.inv101
  where comltd = a_comltd and srce = '05';

declare continue handler for not_found
        set at_end = 1;

delete from pbwip.wip015;

set at_end = 0;
set p_year = substring(a_date,1,4);
set p_month = substring(a_date,5,2);
open wip030_cur01;
inc_loop:
loop
fetch wip030_cur01 into p_plant,p_dvsn,p_itno;

  if at_end = 1 or sqlcode <> 0 then
    leave inc_loop;
  end if;

  -- First Step
  set p_rtn = pbwip.sf_wip_rev(a_comltd,p_plant,p_dvsn,
            p_itno,a_date,a_chk);
  if p_rtn = 'Y' then
    insert into pbwip.wip015( tcmcd, tyear, tmonth, tplnt, tdvsn,
      tmodl, tlevel, tpitn, tcitn, tqtym, tqty1, twkct, tedtm, tedte,
      toption, topcd, texplant, texdv, toscd, tchgchk, tserl )
    select tcmcd, p_year, p_month, tplnt, tdvsn, 
      tmodl, tlevel, tpitn, tcitn, tqtym, tqty1, twkct, tedtm, tedte,
      toption, topcd, texplant, texdv, toscd, tchgchk, tserl
    from qtemp.bomtemp01;
  end if;
  set at_end = 0;
end loop;
close wip030_cur01;

end
