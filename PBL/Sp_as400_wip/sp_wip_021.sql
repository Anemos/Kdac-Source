--file name     : pbwip.sp_wip_021.sql
--system        : kdac system
--proc name     : sp_wip_021
--initial       : 2003.03.21
--author        : kim ki sub
--desc          : Vendor quator sheet creation

create procedure pbwip.sp_wip_021
(in a_cmcd char(2),
 in a_yyyy char(4),
 in a_mm   char(2),
 in a_inptid char(6),
 in a_inptdt char(8))
language sql
begin
declare sqlcode integer default 0;
declare p_yy01 char(4);
declare p_mm01 char(2);
declare p_yy02 char(4);
declare p_mm02 char(2);
declare p_cmcd char(2);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_itno char(15);
declare p_orct char(5);
declare p_chkorct char(5);
declare p_part char(1);
declare p_itnm char(50);
declare p_serl char(5);
declare p_count integer;
declare p_vndr char(10);
declare p_vndnm char(30);
declare p_addr char(100);
declare p_prnm char(20);
declare p_unit char(2);
declare p_convqty numeric(13,4);
declare p_bgqt numeric(15,4);
declare p_inqt numeric(15,4);
declare p_usqt2 numeric(15,4);
declare p_usqt7 numeric(15,4);
declare p_ohqt numeric(15,4);
declare at_end int default 0;
declare not_found condition for '02000';

declare wip008_cur cursor for
  select wfcmcd,wfplant,wfdvsn,wfitno,wfvsrno,
  wfbgqt,wfinqt,wfusqt2,wfusqt7,wfohqt
  from pbwip.wip008
  where wfcmcd = a_cmcd and wfyear = a_yyyy and
        wfpart = p_part
  order by wfvsrno,wfitno;

declare continue handler for not_found
set at_end = 1;

case a_mm
  when '03' then
    set p_part = '1';
    set p_yy01 = a_yyyy;
    set p_mm01 = '01';
    set p_yy02 = a_yyyy;
    set p_mm02 = '02';
  when '06' then
    set p_part = '2';
    set p_yy01 = a_yyyy;
    set p_mm01 = '04';
    set p_yy02 = a_yyyy;
    set p_mm02 = '05';
  when '09' then
    set p_part = '3';
    set p_yy01 = a_yyyy;
    set p_mm01 = '07';
    set p_yy02 = a_yyyy;
    set p_mm02 = '08';
  when '12' then
    set p_part = '4';
    set p_yy01 = a_yyyy;
    set p_mm01 = '10';
    set p_yy02 = a_yyyy;
    set p_mm02 = '11';
  else
    set at_end = 1;
end case;

set p_chkorct = '9999';
set p_count = 0;
open wip008_cur;
inc_loop:
loop
fetch wip008_cur into p_cmcd,p_plant,p_dvsn,p_itno,p_orct,p_bgqt,
      p_inqt,p_usqt2,p_usqt7,p_ohqt;
if at_end = 1 or sqlcode <> 0 then
   leave inc_loop;
end if;
--vendor check
if p_orct <> p_chkorct then
  select vndr,vndnm,addr,prnm
    into p_vndr,p_vndnm,p_addr,p_prnm
  from pbpur.pur101
  where comltd = p_cmcd and scgubun = 'S' and
        vsrno = p_orct;
  if sqlcode <> 0 then
    set p_vndr = ' ';
    set p_vndnm = ' ';
    set p_addr = ' ';
    set p_prnm = ' ';
    set p_orct = ' ';
  else
    set p_chkorct = p_orct;
  end if;
end if;
-- get data inv101, inv002
select aa.itnm,bb.xunit,bb.convqty
  into p_itnm,p_unit,p_convqty
from pbinv.inv002 aa, pbinv.inv101 bb
where aa.comltd = bb.comltd and aa.itno = bb.itno and
      bb.comltd = p_cmcd and bb.xplant = p_plant and
      bb.div = p_dvsn and bb.itno = p_itno;
if sqlcode <> 0 then
  goto inc_loop;
end if;
set p_inqt = p_inqt / p_convqty;
set p_bgqt = p_bgqt / p_convqty;
set p_usqt2 = p_usqt2 / p_convqty;
set p_usqt7 = p_usqt7 / p_convqty;
set p_ohqt = p_ohqt / p_convqty;
set p_count = p_count + 1;
set p_serl = trim(pbwip.sf_wip_002(p_count,5));

update pbwip.wip008
set wfserl = p_serl, wfvndr = p_vndr,
    wfvndnm = p_vndnm, wfaddr = p_addr,
    wfprnm = p_prnm, wfitnm = p_itnm,
    wfunit = p_unit, wfbgqt = p_bgqt,
    wfinqt = p_inqt, wfusqt2 = p_usqt2,
    wfusqt7 = p_usqt7, wfohqt = p_ohqt
where wfcmcd = p_cmcd and wfyear = p_yy01 and
      wfpart = p_part and wfplant = p_plant and
      wfdvsn = p_dvsn and wfvsrno = p_orct and
      wfitno = p_itno;
end loop;
close wip008_cur;
end
