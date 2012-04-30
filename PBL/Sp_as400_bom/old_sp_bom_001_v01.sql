-- file name : pbpdm.sp_bom_001
-- procedure name : pbpdm.sp_bom_001
-- desc : Creation BOM009, 고객사유상사급제외 재료비
-- a_chk : 전사 ('A') to 'D', 공장별('C') to 'E'
--         Create BOM013 'K'

drop procedure pbpdm.sp_bom_001;
create procedure pbpdm.sp_bom_001 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_applydate char(8),
in a_createdate char(8),
in a_chk char(1))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_itno varchar(15);
declare p_yyyymm char(6);
declare p_pdcd char(2);
declare p_cls char(2);
declare p_srce char(2);
declare p_costdiv char(1);
declare p_fromdate char(8);
declare p_fttcnt integer;
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Product item
declare bom_001 Cursor for
 select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
   b.cls,b.srce,b.costdiv
 from pbpdm.bom001 a inner join pbinv.inv101 b
  on a.pcmcd = b.comltd and a.plant = b.xplant and
    a.pdvsn = b.div and a.ppitn = b.itno
 where a.pcmcd = a_comltd and a.plant = a_plant and
 a.pdvsn = a_dvsn and b.cls = '30' and
  (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
  ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ));

declare bom_002 Cursor for
 select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
    b.cls,b.srce,b.costdiv
  from pbinv.inv401 a inner join pbinv.inv101 b
  on a.comltd = b.comltd and a.xplant = b.xplant and
    a.div = b.div and a.itno = b.itno
  where a.comltd = a_comltd and a.xplant = a_plant and
    a.div = a_dvsn and
    ( (b.cls = '10' and b.srce = '03' and
    (a.sliptype = 'RM' or a.sliptype = 'SA' or
     a.sliptype = 'SR' or a.sliptype = 'IW'))
    or (( b.cls = '10' or b.cls = '35' or
      b.cls = '40' or b.cls = '50' ) and
    ( b.srce = '01' or b.srce = '02' or b.srce = '04' ) and
    (a.sliptype = 'SA' or a.sliptype = 'SR'))) and
  a.tdte4 >= p_fromdate and a.tdte4 <= a_applydate;

declare continue handler for not_found
  set at_end = 1;

if a_chk <> 'A' and a_chk <> 'C' and a_chk = 'K' then
  return;
end if;

set p_yyyymm = substring(a_applydate,1,6);
set p_fromdate = concat(p_yyyymm,'01');

if a_chk = 'A' then
  select count(*) into p_fttcnt
  from pbpdm.bom009
  where fcmcd = a_comltd AND fdate = p_yyyymm and
    fplant = a_plant and fdvsn = a_dvsn and
    (fgubun = 'D' or fgubun = 'E');
  if p_fttcnt > 0 then
    delete from pbpdm.bom009
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      (fgubun = 'D' or fgubun = 'E');
  end if;
end if;
if a_chk = 'C' then
  select count(*) into p_fttcnt
  from pbpdm.bom009
  where fcmcd = a_comltd AND fdate = p_yyyymm and
    fplant = a_plant and fdvsn = a_dvsn and
    fgubun = 'E';
  if p_fttcnt > 0 then
    delete from pbpdm.bom009
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun = 'E';
  end if;
end if;
if a_chk = 'K' then
  select count(*) into p_fttcnt
  from pbpdm.bomt13
  where zcmcd = a_comltd and zdate = p_yyyymm and
    zplant = a_plant and zdvsn = a_dvsn;
  if p_fttcnt > 0 then
    delete from pbpdm.bomt13
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdvsn = a_dvsn;
  end if;
end if;

open bom_001;
inc_loop:
loop
  fetch bom_001 into p_plant,p_dvsn,p_itno,p_pdcd,
    p_cls,p_srce,p_costdiv;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- First Step
  if p_srce = '01' or p_srce = '02' then
    set p_rtn = 'N';
  else
    set p_rtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,a_chk);
  end if;

  if a_chk = 'A' then
    set p_rtn = pbpdm.sf_bom_001(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_rtn);
  end if;
  set p_rtn = pbpdm.sf_bom_002(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_rtn);
end loop;
close bom_001;

set at_end = 0;
open bom_002;
inc_loop2:
loop
  fetch bom_002 into p_plant,p_dvsn,p_itno,p_pdcd,
    p_cls,p_srce,p_costdiv;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop2;
  end if;

  -- First Step
  if p_srce = '01' or p_srce = '02' then
    set p_rtn = 'N';
  else
    set p_rtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,a_chk);
  end if;

  if a_chk = 'A' then
    set p_rtn = pbpdm.sf_bom_001(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_rtn);
  end if;
  set p_rtn = pbpdm.sf_bom_002(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_rtn);
end loop;
close bom_002;
end
