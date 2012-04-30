-- file name : sp_wip_15
-- procedure name : pbwip.sp_wip_15
-- desc : Creation Low Level to inv002

create procedure pbwip.sp_wip_15 (
in a_comltd varchar(2),
in a_plant varchar(1),
in a_dvsn varchar(1),
in a_pitno varchar(15),
in a_fromdate varchar(8),
in a_todate varchar(8),
in a_chk varchar(1))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
declare p_serl char(600);
declare p_lolevel numeric(2,0);
declare p_tlevel numeric(2,0);
declare p_pitno char(15);
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Main Item at Qtemp.bomtemp01
declare bom_001 Cursor for
  select tcitn,tlevel
  from qtemp.bomtemp01;

declare continue handler for not_found
  set at_end = 1;

-- First Step
set p_rtn = pbwip.sf_wip_005(a_comltd,a_plant,a_dvsn,
            a_pitno,a_fromdate,a_todate,a_chk);
if p_rtn <> 'Y' then
   set at_end = 1;
end if;

open bom_001;
inc_loop:
loop
  fetch bom_001 into p_pitno,p_tlevel;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  select ifnull(lolevel,0) into p_lolevel
  from pbinv.inv002
  where comltd = a_comltd and itno = p_pitno;

  if sqlcode <> 0 then
     goto inc_loop;
  end if;

  if p_lolevel < p_tlevel then
     update pbinv.inv002
     set lolevel = p_tlevel
     where comltd = a_comltd and
           itno = p_pitno;
  end if;
end loop;
close bom_001;
if sqlcode <> 0 then
   set sqlcode = -1;
else
   set sqlcode = 0;
end if;
end
