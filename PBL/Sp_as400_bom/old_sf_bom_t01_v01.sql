-- file name : sf_bom_t01
-- procedure name : pbpdm.sf_bom_t01
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
--       = 'J' --> Plant(Planing)(10/05 NotDeploy, 원재료이체품 Deploy)

drop function pbpdm.sf_bom_t01;
create function pbpdm.sf_bom_t01 (
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
declare p_scoutcost  numeric(15,6);
declare p_scmovecost numeric(15,6);
declare p_scinputcost numeric(15,6);
declare p_outcost  numeric(15,6);
declare p_movecost numeric(15,6);
declare p_inputcost numeric(15,6);
declare p_convqty  numeric(13,4);
declare p_xyear  char(6);
declare p_currentmonth varchar(60);
declare p_ygchk  char(1);
declare p_ygcst decimal(15,6);
declare p_oplant char(1);
declare p_odvsn char(1);
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
         texdv,topchk,tserl,tcalculate,tsubpaycd
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
 tinputcost numeric(15,6) not null,
 tscoutamt numeric(10,3) not null,
 tscmoveamt numeric(10,3) not null,tscinputamt numeric(10,3) not null,
 tscoutcost numeric(15,6) not null,tscmovecost numeric(15,6) not null,
 tscinputcost numeric(15,6) not null,tsubpaycd char(1) not null,
 topchk char(1) not null, toplant char(1) not null,
 todvsn char(1) not null);

delete from qtemp.tmp_bom;

set p_pitno = trim(a_itno);
set p_beforeplant = a_plant;
set p_beforedvsn = a_dvsn;
set p_xyear = substring(a_date,1,6);
set p_qty = 1;
set p_qty1 = 1;

set p_currentmonth = substring(concat(year(curdate()),
  concat(right(concat('0',month(curdate())),2),
  right(concat('0',day(curdate())),2))),1,6);

select srce, cls, case when convqty = 0 then 1 else convqty end
into p_srce, p_itcl, p_convqty
from pbinv.inv101
  where comltd = a_comltd and xplant = a_plant and
  div = a_dvsn and itno = p_pitno;
if sqlcode <> 0 then
  return 'N';
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

-- insert zero level
-- check running or history
if p_xyear = p_currentmonth then
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
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sccostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6)
  into p_inputcost,p_movecost,p_outcost,
    p_scinputcost,p_scmovecost,p_scoutcost
  from pbinv.inv101 b left outer join pbinv.inv101a c
    on b.comltd = c.comltd and b.xplant = c.xplant and
      b.div = c.div and b.itno = c.itno
  where b.comltd = a_comltd and b.xplant = p_beforeplant and
    b.div = p_beforedvsn and b.itno = p_pitno;
else
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
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sccostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6)
  into p_inputcost,p_movecost,p_outcost,
    p_scinputcost,p_scmovecost,p_scoutcost
  from pbinv.inv402 b left outer join pbinv.inv402a c
    on b.comltd = c.comltd and b.xyear = c.xyear and
      b.xplant = c.xplant and b.div = c.div and
      b.itno = c.itno
  where b.comltd = a_comltd and b.xplant = p_beforeplant and
    b.div = p_beforedvsn and b.itno = p_pitno and
    b.xyear = p_xyear;
end if;

select count(*) into p_chkcnt
from pbpdm.bom001
where pcmcd = a_comltd AND plant = a_plant AND
pdvsn = a_dvsn AND ppitn = a_itno AND
(( pedte = ' '  and pedtm <= a_date ) or
( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ));

set p_explant = '';
set p_exdvsn = '';
if sqlcode <> 0 or p_chkcnt < 1 then
  select pexplant,pexdv
  into p_explant, p_exdvsn
  from pbpdm.bom001
  where pcmcd = a_comltd AND plant = a_plant AND
    pdvsn = a_dvsn AND pcitn = a_itno AND
    (( pedte = ' '  and pedtm <= a_date ) or
    ( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ))
  order by pexdv desc
  fetch first 1 row only;

  if sqlcode <> 0 then
    insert into qtemp.tmp_bom(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl,toutamt,tmoveamt,tinputamt,
       toutcost,tmovecost,tinputcost,
       tscoutamt,tscmoveamt,tscinputamt,
       tscoutcost,tscmovecost,tscinputcost,tsubpaycd,topchk,
       toplant,todvsn)
    values(a_comltd,a_plant,a_dvsn,p_pitno,
       p_option,0,p_pitno,p_pitno,1,1,'9999',
       '','',p_opcd,'','','','Y',
       '','000',
       decimal(truncate(p_qty1 * p_outcost,3),10,3),
       decimal(truncate(p_qty1 * p_movecost,3),10,3),
       decimal(truncate(p_qty1 * p_inputcost,3),10,3),
       p_outcost,p_movecost,p_inputcost,
       decimal(truncate(p_qty1 * p_scoutcost,3),10,3),
       decimal(truncate(p_qty1 * p_scmovecost,3),10,3),
       decimal(truncate(p_qty1 * p_scinputcost,3),10,3),
       p_scoutcost,p_scmovecost,p_scinputcost,p_ygchk,'',
       a_plant,a_dvsn);
    return 'N';
  else
    if trim(p_exdvsn) <> '' then
      set p_beforeplant = p_explant;
      set p_beforedvsn = p_exdvsn;
    end if;
  end if;
end if;

-- check osp(outside processing)
select case when count(*) > 0 then 'Y' else 'N' end
into p_ygchk
from pbpdm.bom001 c
where c.pcmcd = a_comltd and c.plant = p_beforeplant and
      c.pdvsn = p_beforedvsn and c.ppitn = p_pitno and
      c.pwkct = '8888' and
      (( c.pedte = ' '  and c.pedtm <= a_date ) or
      ( c.pedte <> ' ' and c.pedtm <= a_date
                and c.pedte >= a_date ));

set p_oplant = p_beforeplant;
set p_odvsn = p_beforedvsn;

  insert into qtemp.tmp_bom(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl,toutamt,tmoveamt,tinputamt,
       toutcost,tmovecost,tinputcost,
       tscoutamt,tscmoveamt,tscinputamt,
       tscoutcost,tscmovecost,tscinputcost,tsubpaycd,topchk,
       toplant,todvsn)
  values(a_comltd,a_plant,a_dvsn,p_pitno,
       p_option,0,p_pitno,p_pitno,1,1,'9999',
       '','',p_opcd,p_explant,p_exdvsn,'','Y',
       '','000',
       decimal(truncate(p_qty1 * p_outcost,3),10,3),
       decimal(truncate(p_qty1 * p_movecost,3),10,3),
       decimal(truncate(p_qty1 * p_inputcost,3),10,3),
       p_outcost,p_movecost,p_inputcost,
       decimal(truncate(p_qty1 * p_scoutcost,3),10,3),
       decimal(truncate(p_qty1 * p_scmovecost,3),10,3),
       decimal(truncate(p_qty1 * p_scinputcost,3),10,3),
       p_scoutcost,p_scmovecost,p_scinputcost,p_ygchk,'',
       p_oplant,p_odvsn);

if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or
     a_chk = 'H' or a_chk = 'J' then
   if p_srce = '05' then
      return 'N';
   else
     if p_srce = '06' and p_ygchk = 'N' then
       return 'N';
     end if;
   end if;
end if;
-- Check Product or Sub-Assem
if a_chk = 'E' or a_chk = 'F' or a_chk = 'G' or a_chk = 'H' then
   if p_itcl <> '30'  and p_srce <> '03' then
      return 'N';
   end if;
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

if p_opcd = '2' then
   set p_opchk = p_opcd;
else
   set p_opchk = '';
end if;
if p_opcd = '2' or p_wkct = '8888' then
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

-- check osp(outside processing)
if trim(p_exdvsn) <> '' then
  select case when count(*) > 0 then 'Y' else 'N' end
  into p_ygchk
  from pbpdm.bom001 c
  where c.pcmcd = a_comltd and c.plant = p_explant and
      c.pdvsn = p_exdvsn and c.ppitn = p_citno and
      c.pwkct = '8888' and
      (( c.pedte = ' '  and c.pedtm <= a_date ) or
      ( c.pedte <> ' ' and c.pedtm <= a_date
                and c.pedte >= a_date ));
else
  select case when count(*) > 0 then 'Y' else 'N' end
  into p_ygchk
  from pbpdm.bom001 c
  where c.pcmcd = a_comltd and c.plant = p_plant and
      c.pdvsn = p_dvsn and c.ppitn = p_citno and
      c.pwkct = '8888' and
      (( c.pedte = ' '  and c.pedtm <= a_date ) or
      ( c.pedte <> ' ' and c.pedtm <= a_date
                and c.pedte >= a_date ));
end if;

-- check running or history
if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or
     a_chk = 'H' or a_chk = 'J' then
  set p_oplant = p_plant;
  set p_odvsn = p_dvsn;
else
  if trim(p_exdvsn) <> '' then
    set p_oplant = p_explant;
    set p_odvsn = p_exdvsn;
  else
    set p_oplant = p_plant;
    set p_odvsn = p_dvsn;
  end if;
end if;

if p_xyear = p_currentmonth then
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
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sccostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6)
  into p_inputcost,p_movecost,p_outcost,
    p_scinputcost,p_scmovecost,p_scoutcost
  from pbinv.inv101 b left outer join pbinv.inv101a c
    on b.comltd = c.comltd and b.xplant = c.xplant and
      b.div = c.div and b.itno = c.itno
  where b.comltd = a_comltd and b.xplant = p_oplant and
    b.div = p_odvsn and b.itno = p_citno;
else
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
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sccostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6)
  into p_inputcost,p_movecost,p_outcost,
    p_scinputcost,p_scmovecost,p_scoutcost
  from pbinv.inv402 b left outer join pbinv.inv402a c
    on b.comltd = c.comltd and b.xyear = c.xyear and
      b.xplant = c.xplant and b.div = c.div and
      b.itno = c.itno
  where b.comltd = a_comltd and b.xplant = p_oplant and
    b.div = p_odvsn and b.itno = p_citno and
    b.xyear = p_xyear;
end if;

if at_end = 1 then
   set p_inputcost = 0;
   set p_movecost = 0;
   set p_outcost = 0;
   set p_scinputcost = 0;
   set p_scmovecost = 0;
   set p_scoutcost = 0;
   set at_end = 0;
end if;
if p_inputcost = 0 then
   set p_inputcost = p_movecost;
   set p_scinputcost = p_scmovecost;
end if;

set p_chkcnt = p_chkcnt + 1;
set p_rtnserl = trim(pbwip.sf_wip_002(p_chkcnt,3));
insert into qtemp.tmp_bom(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl,toutamt,tmoveamt,tinputamt,
       toutcost,tmovecost,tinputcost,
       tscoutamt,tscmoveamt,tscinputamt,
       tscoutcost,tscmovecost,tscinputcost,tsubpaycd,topchk,
       toplant,todvsn)
values(a_comltd,p_plant,p_dvsn,p_pitno,
       p_option,p_level,p_pitno,p_citno,p_qty,p_qty1,p_wkct,
       p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,p_oscd,p_calculate,
       p_comcd,p_rtnserl,
       decimal(truncate(p_qty1 * p_outcost,3),10,3),
       decimal(truncate(p_qty1 * p_movecost,3),10,3),
       decimal(truncate(p_qty1 * p_inputcost,3),10,3),
       p_outcost,p_movecost,p_inputcost,
       decimal(truncate(p_qty1 * p_scoutcost,3),10,3),
       decimal(truncate(p_qty1 * p_scmovecost,3),10,3),
       decimal(truncate(p_qty1 * p_scinputcost,3),10,3),
       p_scoutcost,p_scmovecost,p_scinputcost,p_ygchk,p_opchk,
       p_oplant,p_odvsn);
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
   p_qty,p_explant,p_exdvsn,p_popcd,p_serl,p_parentcal,p_ygchk;
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
   if p_srce = '05' then
     goto inc_loop01;
   else
     if trim(p_exdvsn) <> '' and p_ygchk = 'Y' then
       set p_beforeplant = p_explant;
       set p_beforedvsn = p_exdvsn;
     end if;
   end if;
 else
   if trim(p_exdvsn) <> '' then
     set p_beforeplant = p_explant;
     set p_beforedvsn = p_exdvsn;
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

 if p_opcd = '2' or p_parentcal = 'N' or p_wkct = '8888' then
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

-- check osp(outside processing)
if trim(p_exdvsn) <> '' then
  select case when count(*) > 0 then 'Y' else 'N' end
  into p_ygchk
  from pbpdm.bom001 c
  where c.pcmcd = a_comltd and c.plant = p_explant and
      c.pdvsn = p_exdvsn and c.ppitn = p_citno and
      c.pwkct = '8888' and
      (( c.pedte = ' '  and c.pedtm <= a_date ) or
      ( c.pedte <> ' ' and c.pedtm <= a_date
                and c.pedte >= a_date ));
else
  select case when count(*) > 0 then 'Y' else 'N' end
  into p_ygchk
  from pbpdm.bom001 c
  where c.pcmcd = a_comltd and c.plant = p_plant and
      c.pdvsn = p_dvsn and c.ppitn = p_citno and
      c.pwkct = '8888' and
      (( c.pedte = ' '  and c.pedtm <= a_date ) or
      ( c.pedte <> ' ' and c.pedtm <= a_date
                and c.pedte >= a_date ));
end if;

-- check running or history
if a_chk = 'C' or a_chk = 'D' or a_chk = 'G' or
     a_chk = 'H' or a_chk = 'J' then
  set p_oplant = p_plant;
  set p_odvsn = p_dvsn;
else
  if trim(p_exdvsn) <> '' then
    set p_oplant = p_explant;
    set p_odvsn = p_exdvsn;
  else
    set p_oplant = p_plant;
    set p_odvsn = p_dvsn;
  end if;
end if;

if p_xyear = p_currentmonth then
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
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sccostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6)
  into p_inputcost,p_movecost,p_outcost,
    p_scinputcost,p_scmovecost,p_scoutcost
  from pbinv.inv101 b left outer join pbinv.inv101a c
    on b.comltd = c.comltd and b.xplant = c.xplant and
      b.div = c.div and b.itno = c.itno
  where b.comltd = a_comltd and b.xplant = p_oplant and
    b.div = p_odvsn and b.itno = p_citno;
  set p_scoutcost = 0;
else
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
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sccostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6),
  decimal(truncate(
    CASE WHEN b.srce NOT IN ('05','03',' ') THEN
    CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
      ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
    ELSE 0.000000 END / p_convqty,6),15,6)
  into p_inputcost,p_movecost,p_outcost,
    p_scinputcost,p_scmovecost,p_scoutcost
  from pbinv.inv402 b left outer join pbinv.inv402a c
    on b.comltd = c.comltd and b.xyear = c.xyear and
      b.xplant = c.xplant and b.div = c.div and
      b.itno = c.itno
  where b.comltd = a_comltd and b.xplant = p_oplant and
    b.div = p_odvsn and b.itno = p_citno and
    b.xyear = p_xyear;
end if;

if at_end = 1 then
   set p_inputcost = 0;
   set p_movecost = 0;
   set p_outcost = 0;
   set p_scinputcost = 0;
   set p_scmovecost = 0;
   set p_scoutcost = 0;
   set at_end = 0;
end if;
if p_inputcost = 0 then
   set p_inputcost = p_movecost;
   set p_scinputcost = p_scmovecost;
end if;

 if p_popcd <> '2' and p_opcd = '2' then
   set p_opchk = p_opcd;
 else
   set p_opchk = p_popcd;
 end if;
 set p_qty = p_qty1 * p_qty;
 set p_lev01 = p_level + 1;
 set p_rtnserl = concat(trim(p_serl), pbwip.sf_wip_002(p_chkcnt,3));

 insert into qtemp.tmp_bom(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tcalculate,
       tcomcd,tserl,toutamt,tmoveamt,tinputamt,
       toutcost,tmovecost,tinputcost,
       tscoutamt,tscmoveamt,tscinputamt,
       tscoutcost,tscmovecost,tscinputcost,tsubpaycd,topchk,
       toplant,todvsn)
 values(a_comltd,p_plant,p_dvsn,a_itno,
       p_option,p_lev01,p_pitno,p_citno,p_qty1,p_qty,p_wkct,
       p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,p_oscd,p_calculate,
       p_comcd,p_rtnserl,
       decimal(truncate(p_qty1 * p_outcost,3),10,3),
       decimal(truncate(p_qty1 * p_movecost,3),10,3),
       decimal(truncate(p_qty1 * p_inputcost,3),10,3),
       p_outcost,p_movecost,p_inputcost,
       decimal(truncate(p_qty1 * p_scoutcost,3),10,3),
       decimal(truncate(p_qty1 * p_scmovecost,3),10,3),
       decimal(truncate(p_qty1 * p_scinputcost,3),10,3),
       p_scoutcost,p_scmovecost,p_scinputcost,p_ygchk,p_opchk,
       p_oplant,p_odvsn);
 end loop;
 close bomchk_cur01;
 set at_end = 0;
end loop;
end while;
return 'Y';
end
