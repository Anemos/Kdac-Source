-- file name : sf_bpm_exp
-- procedure name : pbbpm.sf_bpm_exp
-- desc : bom explosion
-- a_chk = 'A' --> ALL(10/05,10/06 Deploy),Not Main, Not InvUnit
--       = 'B' --> ALL(10/05,10/06 Deploy),Main Deploy, Not InvUnit
--       = 'C' --> Plant(10/05,10/06 Not Deploy),Not Main, Not InvUnit
--       = 'D' --> Plant(10/05,10/06 Not Deploy),Main Deploy, Not InvUnit
--       = 'E' --> ALL(10/05,10/06 Deploy),Not Main, InvUnit
--       = 'F' --> ALL(10/05,10/06 Deploy),Main Deploy, InvUnit
--       = 'G' --> Plant(10/05,10/06 Not Deploy),Not Main, InvUnit
--       = 'H' --> Plant(10/05,10/06 Not Deploy),Main Deploy, InvUnit
--       = 'I' --> Plant(10/05,10/06 Not Deploy),Single Deploy,InvUnit
--       = 'J' --> Plant(Planing)(10/05 NotDeploy,10/06 Deploy)

drop function pbbpm.sf_bpm_exp;
create function pbbpm.sf_bpm_exp (
a_comltd varchar(2),
a_xyear varchar(4),
a_plant varchar(1),
a_dvsn varchar(1),
a_itno   varchar(15),
a_date  varchar(8),
a_chk    varchar(1))
returns char(1)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_plant    char(1);
declare p_beforeplant varchar(1);
declare p_dvsn     char(1);
declare p_beforedvsn  varchar(1);
declare p_explant char(1);
declare p_exdvsn char(1);
declare p_option   varchar(15);
declare p_pitno     varchar(15);
declare p_citno     varchar(15);
declare p_itcl      char(2);
declare p_srce      char(2);
declare p_edtm      char(8);
declare p_edte      char(8);
declare p_opcd      char(1);
declare p_popcd     char(1);
declare p_oscd      char(1);
declare p_wkct      char(4);
declare p_chgchk    char(1);
declare p_serl      varchar(600);
declare p_rtnserl   varchar(600);
declare p_level integer;
declare p_lev01 integer;
declare p_chkcnt integer;
declare p_selcnt integer;
declare p_qty    numeric(8,3);
declare p_qty1   numeric(8,3);
declare p_qtym   numeric(8,3);
declare p_comcd  char(1);
declare p_calculate  char(1);
declare p_parentcal  char(1);
declare p_convqty  numeric(13,4);
declare p_xyear  char(6);
declare at_end integer default 0;
declare not_found condition for '02000';

-- bpmchk_cur01 : Find child item
declare bpmchk_cur01 cursor for
select a.plant,a.pdvsn,a.pcitn,a.pwkct,a.poscd,a.pedtm,a.pedte,
 a.pqtym,a.pexplant,a.pexdv,b.cls,b.srce,
 (case when b.convqty = 0 then 1 else b.convqty end),b.comcd
from pbbpm.bpm504 a inner join pbbpm.bpm503 b
  on a.pcmcd = b.comltd and a.plant = b.xplant and
    a.pdvsn = b.div and a.pcitn = b.itno and
    a.xyear = b.xyear and a.xyear = a_xyear
where a.pcmcd = a_comltd AND a.plant = p_beforeplant AND
a.pdvsn = p_beforedvsn AND a.ppitn = p_pitno AND
(( a.pedte = ' '  and a.pedtm <= a_date ) or
( a.pedte <> ' ' and a.pedtm <= a_date
                and a.pedte >= a_date ))
order by a.plant,a.pdvsn,a.pcitn;

-- bpmchk_cur02 : Deploy Item Level
declare bpmchk_cur02 cursor for
  select tplnt,tdvsn,tcitn,twkct,tqty1,texplant,
         texdv,topcd,tserl,tcalculate
  from qtemp.tmp_bpm
  where tlevel = p_level
  order by tplnt,tdvsn,tcitn;

declare continue handler for not_found
        set at_end = 1;
declare continue handler for sqlstate '42704'
-- create qtemp.tmp_bpm
 create table qtemp.tmp_bpm (tcmcd char(2) not null,
 tplnt char(1) not null, tdvsn char(1) not null,
 tmodl char(15) not null, toption char(15) not null,
 tlevel numeric(2,0) not null, tpitn char(15) not null,
 tcitn char(15) not null, tqtym numeric(8,3) not null,
 tqty1 numeric(8,3) not null, twkct char(4) not null,
 tedtm char(8) not null, tedte char(8) not null,
 topcd char(1) not null, texplant char(1) not null,
 texdv char(1) not null, toscd char(1) not null,
 tcalculate char(1) not null,tcomcd char(1) not null,
 tserl varchar(600) not null);

delete from qtemp.tmp_bpm;

set p_pitno = trim(a_itno);
set p_beforeplant = a_plant;
set p_beforedvsn = a_dvsn;
set p_xyear = substring(a_date,1,6);

select srce, cls into p_srce, p_itcl from pbbpm.bpm503
  where comltd = a_comltd and xplant = a_plant and
  div = a_dvsn and itno = p_pitno and xyear = a_xyear;
if sqlcode <> 0 then
  return 'N';
end if;
select count(*) into p_chkcnt from pbbpm.bpm504
where pcmcd = a_comltd AND plant = a_plant AND
pdvsn = a_dvsn AND ppitn = a_itno AND xyear = a_xyear and
(( pedte = ' '  and pedtm <= a_date ) or
( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ));
if sqlcode <> 0 or p_chkcnt < 1 then
  return 'N';
end if;
if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or 
      a_chk = 'H'  or a_chk = 'J' then
   if p_srce = '05' or p_srce = '06' then
      return 'N';
   end if;
end if;
-- Check Product or Sub-Assem
if a_chk = 'E' or a_chk = 'F' or a_chk = 'G' or a_chk = 'H' then
   if p_itcl <> '30'  and p_srce <> '03' then
      return 'N';
   end if;
end if;
-- Check Option Item
set p_option = pbbpm.sf_bpm_001(a_comltd,a_xyear,a_plant,
a_dvsn,p_pitno,a_date);
if p_option = '*' then
   set p_opcd = '1';
elseif length(trim(p_option)) > 1 then
   set p_opcd = '2';
else
   set p_opcd = ' ';
end if;
if a_chk = 'B' or a_chk = 'D' or a_chk = 'F' or a_chk = 'H' then
   if p_opcd = '2' then
      return 'N';
   end if;
end if;

set at_end = 0;
set p_level = 1;
set p_chkcnt = 0;
open bpmchk_cur01;
inc_loop:
loop
fetch bpmchk_cur01 into p_plant,p_dvsn,p_citno,p_wkct,
      p_oscd,p_edtm,p_edte,p_qty,p_explant,p_exdvsn,
      p_itcl,p_srce,p_convqty,p_comcd;
if at_end = 1 or sqlcode <> 0 then
   leave inc_loop;
end if;

set p_option = pbbpm.sf_bpm_001(a_comltd,a_xyear,a_plant,
               p_dvsn,trim(p_citno),a_date);
if p_option = '*' then
   set p_opcd = '1';
elseif length(trim(p_option)) > 1 then
   set p_opcd = '2';
else
   set p_opcd = ' ';
end if;

if a_chk = 'B' or a_chk = 'D' or a_chk = 'F' or a_chk = 'H' then
   if p_opcd = '2' then
      goto inc_loop;
   end if;
end if;

if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or 
    a_chk = 'H' or a_chk = 'J' then
  if a_chk = 'J' and p_srce = '06' and trim(p_exdvsn) <> '' then
     set p_plant = p_explant;
     set p_dvsn = p_exdvsn;
  else
    set p_plant = p_plant;
    set p_dvsn = p_dvsn;
  end if;
else
  if p_srce = '05' or p_srce  = '06' then
    set p_plant = p_explant;
    set p_dvsn = p_exdvsn;
  end if;
end if;

if p_wkct = '8888' or p_opcd = '2' then
  set p_calculate = 'N';
else
  set p_calculate = 'Y';
end if;

-- check customer cost item
if p_opcd = '2' and p_comcd = 'Y' then
  select count(*) into p_selcnt
  from pbbpm.bpm503
  where comltd = a_comltd and xyear = a_xyear and xplant = p_plant and
   div = p_dvsn and itno = p_option and comcd = 'Y';

  if p_selcnt > 0 then
    set p_comcd = 'N';
  end if;
end if;

set p_qtym = p_qty;
set p_chkcnt = p_chkcnt + 1;
set p_rtnserl = trim(pbwip.sf_wip_002(p_chkcnt,3));
insert into qtemp.tmp_bpm(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl)
values(a_comltd,p_plant,p_dvsn,p_pitno,
       p_option,p_level,p_pitno,p_citno,p_qtym,p_qty,p_wkct,
       p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,p_oscd,p_calculate,
       p_comcd,p_rtnserl);
end loop;
close bpmchk_cur01;

-- Down Deploy Logic
set at_end = 0;
set p_level = 0;
-- Loop Until Deploy End.
while at_end = 0 do
set p_chkcnt = 0;
set p_level = p_level + 1;
open bpmchk_cur02;
-- Get Each Level Item
inc_loop01:
loop
 fetch bpmchk_cur02 into p_plant,p_dvsn,p_citno,p_wkct,
   p_qty,p_explant,p_exdvsn,p_popcd,p_serl,p_parentcal;
 if at_end = 1 and p_chkcnt = 0 then
    close bpmchk_cur02;
    leave inc_loop01;
 elseif at_end = 1 and p_chkcnt > 0 then
    set at_end = 0;
    close bpmchk_cur02;
    leave inc_loop01;
 end if;

 set p_beforeplant = p_plant;
 set p_beforedvsn = p_dvsn;
 set p_pitno = p_citno;
 set p_qty1 = p_qty;

 select srce into p_srce from pbbpm.bpm503
 where comltd = '01' and xyear = a_xyear and xplant = p_beforeplant and
  div = p_beforedvsn and itno = p_pitno;

 if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or 
       a_chk = 'H' or a_chk = 'J' then
    if p_srce = '05' or p_srce = '06' then
       if a_chk = 'J' and p_srce = '06' then
         set p_srce = '06';
       else
         goto inc_loop01;
       end if;
    end if;
 end if;
 if a_chk = 'E' or a_chk = 'F' or a_chk = 'G' or
    a_chk = 'H' or a_chk = 'I' then
    if p_itcl <> '30'  and p_srce <> '03' then
       goto inc_loop01;
    end if;
 end if;
 if a_chk = 'I' then
    goto inc_loop01;
 end if;

 open bpmchk_cur01;
 inc_loop02:
 loop
 fetch bpmchk_cur01 into p_plant,p_dvsn,p_citno,p_wkct,
      p_oscd,p_edtm,p_edte,p_qty,p_explant,p_exdvsn,
      p_itcl,p_srce,p_convqty,p_comcd;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop02;
 end if;
 set p_chkcnt = p_chkcnt + 1;
 set p_option = pbbpm.sf_bpm_001(a_comltd,a_xyear,p_plant,
              p_dvsn,p_citno,a_date);
 if p_option = '*' then
    set p_opcd = '1';
 elseif length(trim(p_option)) > 1 then
    set p_opcd = '2';
 else
    set p_opcd = ' ';
 end if;
 if a_chk = 'B' or a_chk = 'D' or a_chk = 'F' or a_chk = 'H' then
    if p_opcd = '2' then
       goto inc_loop02;
    end if;
 end if;
 if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or 
      a_chk = 'H' or a_chk = 'J' then
   if a_chk = 'J' and p_srce = '06' and trim(p_exdvsn) <> '' then
     set p_plant = p_explant;
     set p_dvsn = p_exdvsn;
   else
     set p_plant = p_plant;
     set p_dvsn = p_dvsn;
   end if;
 else
   if p_srce = '05' or p_srce = '06' then
     set p_plant = p_explant;
     set p_dvsn = p_exdvsn;
   end if;
 end if;

 if p_wkct  = '8888' or p_opcd = '2' or p_parentcal = 'N' then
   set p_calculate = 'N';
 else
   set p_calculate = 'Y';
 end if;

-- check customer cost item
if p_opcd = '2' and p_comcd = 'Y' then
  select count(*) into p_selcnt
  from pbbpm.bpm503
  where comltd = a_comltd and xyear = a_xyear and xplant = p_plant and
    div = p_dvsn and itno = p_option and comcd = 'Y';

  if p_selcnt > 0 then
    set p_comcd = 'N';
  end if;
end if;

 set p_qtym = p_qty;
 set p_qty = p_qty1 * p_qty;
 set p_lev01 = p_level + 1;
 set p_rtnserl = concat(trim(p_serl), pbwip.sf_wip_002(p_chkcnt,3));

 insert into qtemp.tmp_bpm(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl)
 values(a_comltd,p_plant,p_dvsn,a_itno,
       p_option,p_lev01,p_pitno,p_citno,p_qtym,p_qty,p_wkct,
       p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,p_oscd,p_calculate,
       p_comcd,p_rtnserl);
 end loop;
 close bpmchk_cur01;
 set at_end = 0;
end loop;
end while;
return 'Y';
end
