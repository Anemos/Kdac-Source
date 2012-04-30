-- file name : sf_bom_exp
-- procedure name : pbpdm.sf_bom_exp
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

drop function pbpdm.sf_bom_exp;
create function pbpdm.sf_bom_exp (
a_comltd varchar(2),
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
declare p_opchk     char(1);
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
declare p_comcd  char(1);
declare p_calculate  char(1);
declare p_parentcal  char(1);
declare p_outamt  numeric(10,3);
declare p_moveamt numeric(10,3);
declare p_inputamt numeric(10,3);
declare p_outcost  numeric(15,6);
declare p_movecost numeric(15,6);
declare p_inputcost numeric(15,6);
declare p_convqty  numeric(13,4);
declare p_xyear  char(6);
declare at_end integer default 0;
declare not_found condition for '02000';

-- BOMCHK_CUR01 : Find child item
declare bomchk_cur01 cursor for
select a.plant,a.pdvsn,a.pcitn,a.pwkct,a.poscd,a.pedtm,a.pedte,
 a.pqtym,a.pexplant,a.pexdv,b.cls,b.srce,
 (case when b.convqty = 0 then 1 else b.convqty end),b.comcd
from pbpdm.bom001 a inner join pbinv.inv101 b
  on a.pcmcd = b.comltd and a.plant = b.xplant and
    a.pdvsn = b.div and a.pcitn = b.itno
where a.pcmcd = a_comltd AND a.plant = p_beforeplant AND
a.pdvsn = p_beforedvsn AND a.ppitn = p_pitno AND
(( a.pedte = ' '  and a.pedtm <= a_date ) or
( a.pedte <> ' ' and a.pedtm <= a_date
                and a.pedte >= a_date ))
order by a.plant,a.pdvsn,a.pcitn;

-- BOMCHK_CUR02 : Deploy Item Level
declare bomchk_cur02 cursor for
  select tplnt,tdvsn,tcitn,twkct,tqty1,texplant,
         texdv,topchk,tserl,tcalculate
  from qtemp.tmp_bom
  where tlevel = p_level
  order by tplnt,tdvsn,tcitn;

declare continue handler for not_found
        set at_end = 1;
declare continue handler for sqlstate '42704'
-- create qtemp.tmp_bom
 create table qtemp.tmp_bom (tcmcd char(2) not null,
 tplnt char(1) not null, tdvsn char(1) not null,
 tmodl varchar(15) not null, toption varchar(15) not null,
 tlevel numeric(2,0) not null, tpitn varchar(15) not null,
 tcitn varchar(15) not null, tqtym numeric(8,3) not null,
 tqty1 numeric(8,3) not null, twkct char(4) not null,
 tedtm char(8) not null, tedte char(8) not null,
 topcd char(1) not null, texplant char(1) not null,
 texdv char(1) not null, toscd char(1) not null,
 tcalculate char(1) not null,tcomcd char(1) not null,
 tserl varchar(600) not null,toutamt numeric(10,3) not null,
 tmoveamt numeric(10,3) not null,tinputamt numeric(10,3) not null,
 toutcost numeric(15,6) not null,tmovecost numeric(15,6) not null,
 tinputcost numeric(15,6) not null,tsubpaycd char(1) not null,
 topchk char(1) not null);

delete from qtemp.tmp_bom;

set p_pitno = trim(a_itno);
set p_beforeplant = a_plant;
set p_beforedvsn = a_dvsn;
set p_xyear = substring(a_date,1,6);

select srce, cls into p_srce, p_itcl from pbinv.inv101
  where comltd = a_comltd and xplant = a_plant and
  div = a_dvsn and itno = p_pitno;
if sqlcode <> 0 then
  return 'N';
end if;
select count(*) into p_chkcnt from pbpdm.bom001
where pcmcd = a_comltd AND plant = a_plant AND
pdvsn = a_dvsn AND ppitn = a_itno AND
(( pedte = ' '  and pedtm <= a_date ) or
( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ));
if sqlcode <> 0 or p_chkcnt < 1 then
  return 'N';
end if;
if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or
     a_chk = 'H' or a_chk = 'J' then
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
set p_option = pbpdm.f_bom_02(a_comltd,a_plant,
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
set p_qty = 1;
set p_chkcnt = 0;
open bomchk_cur01;
inc_loop:
loop
fetch bomchk_cur01 into p_plant,p_dvsn,p_citno,p_wkct,
      p_oscd,p_edtm,p_edte,p_qty1,p_explant,p_exdvsn,
      p_itcl,p_srce,p_convqty,p_comcd;
if at_end = 1 or sqlcode <> 0 then
   leave inc_loop;
end if;

set p_option = pbpdm.f_bom_02(a_comltd,p_plant,
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
if p_opcd = '2' then
   set p_opchk = p_opcd;
else
   set p_opchk = '';
end if;
if p_wkct = '8888' or p_opcd = '2' then
  set p_calculate = 'N';
else
  set p_calculate = 'Y';
end if;

-- check customer cost item
if p_opcd = '2' and p_comcd = 'Y' then
  select count(*) into p_selcnt
  from pbinv.inv101
  where comltd = a_comltd and xplant = p_plant and
   div = p_dvsn and itno = p_option and comcd = 'Y';

  if p_selcnt > 0 then
    set p_comcd = 'N';
  end if;
end if;
--calculate product cost
select decimal(truncate(
  CASE WHEN b.srce NOT IN ('05','03',' ') THEN b.costls
  ELSE 0.000000 END / p_convqty,6),15,6),
decimal(truncate(
CASE WHEN b.srce NOT IN ('05','03',' ') THEN
  CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
  ELSE 0.000000 END / p_convqty,6),15,6),
decimal(truncate(
CASE WHEN b.srce NOT IN ('05','03',' ') THEN
  CASE WHEN b.outqty <> 0
       THEN abs(B.OUTAMT / B.OUTQTY)
       ELSE B.COSTLS END
  ELSE 0.000000 END / p_convqty,6),15,6)
into p_inputcost,p_movecost,p_outcost
from pbinv.inv402 b
where b.comltd = a_comltd and b.xplant = p_plant and
  b.div = p_dvsn and b.itno = p_citno and
  b.xyear = p_xyear;

if at_end = 1 then
   set p_inputcost = 0;
   set p_movecost = 0;
   set p_outcost = 0;
   set at_end = 0;
end if;
if p_inputcost = 0 then
   set p_inputcost = p_movecost;
end if;
if p_outcost = 0 then
   set p_outcost = p_movecost;
end if;
set p_inputamt = decimal(truncate(p_qty1 * p_inputcost,3),10,3);
set p_moveamt = decimal(truncate(p_qty1 * p_movecost,3),10,3);
set p_outamt = decimal(truncate(p_qty1 * p_outcost,3),10,3);

set p_chkcnt = p_chkcnt + 1;
set p_rtnserl = trim(pbwip.sf_wip_002(p_chkcnt,3));
insert into qtemp.tmp_bom(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl,toutamt,tmoveamt,tinputamt,
       toutcost,tmovecost,tinputcost,tsubpaycd,topchk)
values(a_comltd,p_plant,p_dvsn,p_pitno,
       p_option,p_level,p_pitno,p_citno,p_qty,p_qty1,p_wkct,
       p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,p_oscd,p_calculate,
       p_comcd,p_rtnserl,p_outamt,p_moveamt,p_inputamt,
       p_outcost,p_movecost,p_inputcost,'N',p_opchk);
end loop;
close bomchk_cur01;

-- Down Deploy Logic
set at_end = 0;
set p_level = 0;
-- Loop Until Deploy End.
while at_end = 0 do
set p_chkcnt = 0;
set p_level = p_level + 1;
open bomchk_cur02;
-- Get Each Level Item
inc_loop01:
loop
 fetch bomchk_cur02 into p_plant,p_dvsn,p_citno,p_wkct,
   p_qty,p_explant,p_exdvsn,p_popcd,p_serl,p_parentcal;
 if at_end = 1 and p_chkcnt = 0 then
    close bomchk_cur02;
    leave inc_loop01;
 elseif at_end = 1 and p_chkcnt > 0 then
    set at_end = 0;
    close bomchk_cur02;
    leave inc_loop01;
 end if;

 set p_beforeplant = p_plant;
 set p_beforedvsn = p_dvsn;
 set p_pitno = p_citno;
 set p_qty1 = p_qty;

 select srce into p_srce from pbinv.inv101
 where comltd = '01' and xplant = p_beforeplant and
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

 open bomchk_cur01;
 inc_loop02:
 loop
 fetch bomchk_cur01 into p_plant,p_dvsn,p_citno,p_wkct,
      p_oscd,p_edtm,p_edte,p_qty,p_explant,p_exdvsn,
      p_itcl,p_srce,p_convqty,p_comcd;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop02;
 end if;
 set p_chkcnt = p_chkcnt + 1;
 set p_option = pbpdm.f_bom_02(a_comltd,p_plant,
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

 if p_wkct  = '8888' or p_opcd = '2' or p_parentcal = 'N' then
   set p_calculate = 'N';
   if p_wkct = '8888' then
     update qtemp.tmp_bom
     set tsubpaycd = 'Y'
     where tcmcd = a_comltd and tplnt = p_plant and
       tdvsn = p_dvsn and tcitn = p_pitno;
   end if;
 else
   set p_calculate = 'Y';
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

-- check customer cost item
if p_opcd = '2' and p_comcd = 'Y' then
  select count(*) into p_selcnt
  from pbinv.inv101
  where comltd = a_comltd and xplant = p_plant and
    div = p_dvsn and itno = p_option and comcd = 'Y';

  if p_selcnt > 0 then
    set p_comcd = 'N';
  end if;
end if;
--calculate product cost
select decimal(truncate(
  CASE WHEN b.srce NOT IN ('05','03',' ') THEN b.costls
  ELSE 0.000000 END / p_convqty,6),15,6),
decimal(truncate(
CASE WHEN b.srce NOT IN ('05','03',' ') THEN
  CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
  ELSE 0.000000 END / p_convqty,6),15,6),
decimal(truncate(
CASE WHEN b.srce NOT IN ('05','03',' ') THEN
  CASE WHEN b.outqty <> 0
       THEN abs(B.OUTAMT / B.OUTQTY)
       ELSE B.COSTLS END
  ELSE 0.000000 END / p_convqty,6),15,6)
into p_inputcost,p_movecost,p_outcost
from pbinv.inv402 b
where b.comltd = a_comltd and b.xplant = p_plant and
  b.div = p_dvsn and b.itno = p_citno and
  b.xyear = p_xyear;

 if at_end = 1 then
   set p_inputcost = 0;
   set p_movecost = 0;
   set p_outcost = 0;
   set at_end = 0;
 end if;
 if p_inputcost = 0 then
   set p_inputcost = p_movecost;
 end if;
 if p_outcost = 0 then
   set p_outcost = p_movecost;
 end if;
 if p_popcd <> '2' and p_opcd = '2' then
   set p_opchk = p_opcd;
 else
   set p_opchk = p_popcd;
 end if;
 set p_qty = p_qty1 * p_qty;
 set p_lev01 = p_level + 1;
 set p_rtnserl = concat(trim(p_serl), pbwip.sf_wip_002(p_chkcnt,3));
 set p_inputamt = decimal(truncate(p_qty * p_inputcost,3),10,3);
 set p_moveamt = decimal(truncate(p_qty * p_movecost,3),10,3);
 set p_outamt = decimal(truncate(p_qty * p_outcost,3),10,3);

 insert into qtemp.tmp_bom(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl,toutamt,tmoveamt,tinputamt,
       toutcost,tmovecost,tinputcost,tsubpaycd,topchk)
 values(a_comltd,p_plant,p_dvsn,a_itno,
       p_option,p_lev01,p_pitno,p_citno,p_qty1,p_qty,p_wkct,
       p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,p_oscd,p_calculate,
       p_comcd,p_rtnserl,p_outamt,p_moveamt,p_inputamt,
       p_outcost,p_movecost,p_inputcost,'N',p_opchk);
 end loop;
 close bomchk_cur01;
 set at_end = 0;
end loop;
end while;
return 'Y';
end
