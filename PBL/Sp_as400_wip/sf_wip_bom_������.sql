-- file name : sf_wip_rev
-- procedure name : pbwip.sf_wip_rev
-- desc : bom explosion
drop function pbwip.sf_wip_rev;
create function pbwip.sf_wip_rev (
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
declare p_serl      char(600);
declare p_rtnserl   varchar(10);
declare p_level integer;
declare p_lev01 integer;
declare p_chkcnt integer;
declare p_qty    numeric(8,3);
declare p_qty1   numeric(8,3);
declare at_end integer default 0;
declare not_found condition for '02000';
-- BOMCHK_CUR01 : Find child item
declare bomchk_cur01 cursor for
  select plant,pdvsn,ppitn from pbpdm.bom001
where pcmcd = a_comltd AND plant = p_beforeplant AND
pdvsn = p_beforedvsn AND pcitn = p_pitno AND
(( pedte = ' '  and pedtm <= a_date ) or
( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ));
-- BOMCHK_CUR02 : Deploy Item Level
declare bomchk_cur02 cursor for
  select wbplant,wbdvsn,wbprno
  from qtemp.bomtemp05
  where tlevel = p_level;

declare continue handler for not_found
        set at_end = 1;
declare continue handler for sqlstate '42704'

-- create qtemp.bomtemp01
 create table qtemp.bomtemp05 (wbcmcd char(2) not null,
 wbplant char(1) not null, wbdvsn char(1) not null,
 wbitno char(15) not null,
 wbprno char(15) not null,tlevel numeric(2,0) not null);

delete from qtemp.bomtemp05;

set p_beforeplant = a_plant;
set p_beforedvsn = a_dvsn;
set p_pitno = trim(a_itno);

select srce, cls into p_srce, p_itcl from pbinv.inv101
  where comltd = a_comltd and xplant = a_plant and
  div = a_dvsn and itno = p_pitno;
if sqlcode <> 0 then
  return 'N';
end if;
select count(*) into p_chkcnt from pbpdm.bom001
where pcmcd = a_comltd AND plant = a_plant AND
pdvsn = a_dvsn AND pcitn = a_itno AND
(( pedte = ' '  and pedtm <= a_date ) or
( pedte <> ' ' and pedtm <= a_date
                and pedte >= a_date ));
if sqlcode <> 0 or p_chkcnt < 1 then
  return 'N';
end if;

set p_level = 1;
set p_qty = 1;
set p_chkcnt = 0;

open bomchk_cur01;
inc_loop:
loop
fetch bomchk_cur01 into p_plant,p_dvsn,p_citno;

if at_end = 1 or sqlcode <> 0 then
   leave inc_loop;
end if;

set p_beforeplant = p_plant;
set p_beforedvsn = p_dvsn;

insert into qtemp.bomtemp05(wbcmcd,wbplant,wbdvsn,wbitno,wbprno,tlevel)
values(a_comltd,p_plant,p_dvsn,p_pitno,p_citno,p_level);

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
 fetch bomchk_cur02 into p_plant,p_dvsn,p_citno;
 if at_end = 1 and p_chkcnt = 0 then
    close bomchk_cur02;
    leave inc_loop01;
 elseif at_end = 1 and p_chkcnt > 0 then
    set at_end = 0;
    close bomchk_cur02;
    leave inc_loop01;
 end if;
 
 set p_pitno = p_citno;
 set p_qty1 = p_qty;
 set p_popcd = p_chgchk;
 
 set p_beforeplant = p_plant;
 set p_beforedvsn = p_dvsn;

 open bomchk_cur01;
 inc_loop02:
 loop
 fetch bomchk_cur01 into p_plant,p_dvsn,p_citno;
 if at_end = 1 or sqlcode <> 0 then
    leave inc_loop02;
 end if;
 set p_chkcnt = p_chkcnt + 1;
 
 set p_lev01 = p_level + 1;
 
 insert into qtemp.bomtemp05(wbcmcd,wbplant,wbdvsn,wbitno,wbprno,tlevel)
 values(a_comltd,a_plant,a_dvsn,p_pitno,p_citno,p_lev01);
 
 end loop;
 close bomchk_cur01;
 set at_end = 0;
end loop;
end while;

insert into pbwip.wip015
select * from qtemp.bomtemp05;

return 'Y';
end
