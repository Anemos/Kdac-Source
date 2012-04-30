-- file name : f_wip_bom1
-- procedure name : pbwip.f_wip_bom1
-- desc : bom explosion

create function pbwip.f_wip_bom1 (
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
declare p_itno   varchar(15);
declare p_pitno     char(15);
declare p_citno     char(15);
declare p_itcl      char(2);
declare p_srce      char(2);
declare p_edtm      char(8);
declare p_edte      char(8);
declare p_opcd      char(1);
declare p_popcd     char(1);
declare p_oscd      char(1);
declare p_wkct      char(4);
declare p_chgchk    char(1);
declare p_level integer;
declare p_lev01 integer;
declare p_chkcnt integer;
declare p_qty    numeric(8,3);
declare p_qty1   numeric(8,3);
declare at_end integer default 0;
declare not_found condition for '02000';
-- BOMCHK_CUR01 : Find child item
declare bomchk_cur01 cursor for
  select plant,pdvsn,pcitn,pwkct,
     poscd,pedtm,pedte,
  pqtym,pexplant,pexdv from pbpdm.bom001
where pcmcd = a_comltd AND plant = p_beforeplant AND
pdvsn = p_beforedvsn AND ppitn = p_pitno AND
(( pedte = ' '  and pedtm <= a_date ) or
( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ));
-- BOMCHK_CUR02 : Deploy Item Level
declare bomchk_cur02 cursor for
  select tplnt,tdvsn,tcitn,twkct,tqtym,texplant,
         texdv,tchgchk
  from qtemp.bomtemp
  where tlevel = p_level;

declare continue handler for not_found
        set at_end = 1;
declare continue handler for sqlstate '42704'
-- create qtemp.bomtemp
 create table qtemp.bomtemp (tcmcd char(2) not null,
 tplnt char(1) not null, tdvsn char(1) not null,
 tmodl char(15) not null, toption char(15) not null,
 tlevel numeric(5,0) not null, tpitn char(15) not null,
 tcitn char(15) not null, tqtym numeric(8,3) not null,
 tqty1 numeric(8,3) not null, twkct char(4) not null,
 tedtm char(8) not null, tedte char(8) not null,
 topcd char(1) not null, texplant char(1) not null,
 texdv char(1) not null, toscd char(1) not null,
 tchgchk char(1) not null);

delete from qtemp.bomtemp;

set p_pitno = trim(a_itno);
set p_beforeplant = a_plant;
set p_beforedvsn = a_dvsn;

select srce, cls into p_srce, p_itcl from pbinv.inv101
  where comltd = a_comltd and xplant = a_plant and
  div = a_dvsn and itno = p_pitno;

if a_chk = 'C' or a_chk = 'D'
   or a_chk = 'G' or a_chk = 'H' then
   if p_srce = '05' or p_srce = '06' then
      return 'N';
   end if;
end if;
-- Check Product or Sub-Assem
if a_chk = 'E' or a_chk = 'F' or
   a_chk = 'G' or a_chk = 'H' then
   if p_itcl <> '30'  and p_srce <> '03' then
      return 'N';
   end if;
end if;
-- Check Option Item
set p_itno = pbpdm.f_bom_02(a_comltd,a_plant,
a_dvsn,p_pitno,a_date);
if p_itno = '*' then
   set p_opcd = '1';
elseif length(trim(p_itno)) > 1 then
   set p_opcd = '2';
else
   set p_opcd = ' ';
end if;
if a_chk = 'B' or a_chk = 'D' or
   a_chk = 'F' or a_chk = 'H' then
   if p_opcd = '2' then
      return 'N';
   end if;
end if;

set p_level = 1;
set p_qty = 1;
open bomchk_cur01;
inc_loop:
loop
fetch bomchk_cur01 into p_plant,p_dvsn,p_citno,p_wkct,
      p_oscd,p_edtm,p_edte,p_qty1,p_explant,p_exdvsn;
if at_end = 1 or sqlcode <> 0 then
   leave inc_loop;
end if;
set p_chgchk = ' ';
set p_itno = pbpdm.f_bom_02(a_comltd,p_plant,
               p_dvsn,trim(p_citno),a_date);
if p_itno = '*' then
   set p_opcd = '1';
elseif length(trim(p_itno)) > 1 then
   set p_opcd = '2';
   set p_chgchk = 'Y';
else
   set p_opcd = ' ';
end if;
-- 10/03 Item check
select srce, cls into p_srce, p_itcl from pbinv.inv101
  where comltd = a_comltd and xplant = p_plant and
  div = p_dvsn and itno = p_citno;
if p_srce = '03' and p_opcd = '2' and a_chk = 'G' then
  goto inc_loop;
end if;
-- p_explant or p_exdvsn setting
if length(trim(p_explant)) < 1 then
   set p_explant = p_plant;
end if;
if length(trim(p_exdvsn)) < 1 then
   set p_exdvsn = p_dvsn;
end if;
insert into qtemp.bomtemp(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tchgchk)
values(a_comltd,p_plant,p_dvsn,p_pitno,
       p_itno,p_level,p_pitno,p_citno,
       p_qty,p_qty1,
       p_wkct,p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,
       p_oscd,p_chgchk );
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
                p_qty,p_explant,p_exdvsn,p_chgchk;
 if at_end = 1 and p_chkcnt = 0 then
    close bomchk_cur02;
    leave inc_loop01;
 elseif at_end = 1 and p_chkcnt > 0 then
    set at_end = 0;
    close bomchk_cur02;
    leave inc_loop01;
 end if;
 if p_plant <> p_explant or p_dvsn <> p_exdvsn then
    goto inc_loop01;
 end if;
 set p_beforeplant = p_plant;
 set p_beforedvsn = p_dvsn;
 set p_pitno = p_citno;
 set p_qty1 = p_qty;
 set p_popcd = p_chgchk;

 select srce, cls into p_srce, p_itcl
    from pbinv.inv101
    where comltd = a_comltd and xplant = p_plant and
          div = p_dvsn and itno = p_pitno;

 if a_chk = 'C' or a_chk = 'D'
    or a_chk = 'G' or a_chk = 'H' then
    if p_srce = '05' or p_srce = '06' then
       goto inc_loop01;
    end if;
 end if;
 if a_chk = 'E' or a_chk = 'F' or
    a_chk = 'G' or a_chk = 'H' or a_chk = 'I' then
    if p_itcl <> '30'  and p_srce <> '03' then
       goto inc_loop01;
    end if;
 end if;
 if a_chk = 'I' and p_chgchk <> 'Y' then
    goto inc_loop01;
 end if;

 open bomchk_cur01;
 inc_loop02:
 loop
 fetch bomchk_cur01 into p_plant,p_dvsn,p_citno,p_wkct,
      p_oscd,p_edtm,p_edte,p_qty,p_explant,p_exdvsn;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop02;
 end if;
 set p_chkcnt = p_chkcnt + 1;
 set p_itno = pbpdm.f_bom_02(a_comltd,p_plant,
              p_dvsn,p_citno,a_date);
 if p_itno = '*' then
    set p_opcd = '1';
 elseif length(trim(p_itno)) > 1 then
    set p_opcd = '2';
    set p_chgchk = 'Y';
 else
    set p_opcd = ' ';
 end if;
 if a_chk = 'B' or a_chk = 'D' or
    a_chk = 'F' or a_chk = 'H' then
    if p_opcd = '2' then
       goto inc_loop02;
    end if;
 end if;
 -- 10/03 Item check
 select srce, cls into p_srce, p_itcl from pbinv.inv101
  where comltd = a_comltd and xplant = p_plant and
  div = p_dvsn and itno = p_citno;
 if p_srce = '03' and p_opcd = '2' and a_chk = 'G' then
   goto inc_loop02;
 end if;
 -- pexplant or p_exdvsn setting
 if length(trim(p_explant)) < 1 then
    set p_explant = p_plant;
 end if;
 if length(trim(p_exdvsn)) < 1 then
    set p_exdvsn = p_dvsn;
 end if;
 set p_qty = p_qty1 * p_qty;
 set p_lev01 = p_level + 1;
 insert into qtemp.bomtemp(tcmcd,tplnt,tdvsn,tmodl,
       toption,tlevel,tpitn,tcitn,tqtym,tqty1,twkct,
       tedtm,tedte,topcd,texplant,texdv,toscd,tchgchk)
 values(a_comltd,p_plant,p_dvsn,a_itno,
       p_itno,p_lev01,p_pitno,p_citno,
       p_qty1,p_qty,
       p_wkct,p_edtm,p_edte,p_opcd,p_explant,p_exdvsn,
       p_oscd,p_chgchk );
 end loop;
 close bomchk_cur01;
 set at_end = 0;
end loop;
end while;
return 'Y';
end
