--file name     : pbwip.sp_wip_022.sql
--system        : kdac system
--proc name     : sp_wip_022
--initial       : 2003.06.30
--author        : kim ki sub
--desc          : Vendorsheet creation(After Final)

create procedure pbwip.sp_wip_022
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

declare wipchk_cur cursor for
  select ifnull(count(*),0)
  from pbwip.wip008
  where wfcmcd = a_cmcd and wfyear = a_yyyy and
        wfpart = p_part;

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

open wipchk_cur;
fetch wipchk_cur into p_count;

if p_count = 0 then
insert into pbwip.wip008
(wfcmcd,wfyear,wfpart,wfserl,wfpage,wfplant,wfdvsn,
 wfvsrno,wfvndr,wfvndnm,wfaddr,wfprnm,wfitno,
 wfitnm,wfunit,wfscrp,wfretn,wfbgqt,wfinqt,
 wfusqt2,wfusqt7,wfohqt,wfinptid,wfinptdt)
select wbcmcd,a_yyyy,p_part,' ',' ',wbplant,
 wbdvsn,wborct,' ',' ',' ',' ',wbitno,
 ' ',' ',
 decimal(sum(case wbmonth
    when a_mm then wbscrp
    else 0 end),5,2),
 decimal(sum(case wbmonth
    when a_mm then wbretn
    else 0 end),5,2),
 decimal(sum(case wbmonth
    when p_mm01 then wbbgqt
    else 0
    end),15,4),
 decimal(sum(wbinqt - wbusqt3),15,4),
 decimal(sum(wbusqt2),15,4),
 decimal(sum(wbusqt7),15,4),
 decimal(sum(case wbmonth
    when a_mm then
    (wbbgqt + wbinqt - (wbusqt1 + wbusqt2 + wbusqt3 +
    wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7 + wbusqt8 +
    wbusqta)) else 0
    end),15,4),a_inptid,a_inptdt
  from pbwip.wip002
  where wbcmcd = a_cmcd and
        wbyear = a_yyyy and
        wbmonth >= p_mm01 and
        wbmonth <= a_mm and
        wbiocd = '2' and
        not (wbbgqt = 0 and wbinqt = 0 and wbusqt1 = 0 and
        wbusqt2 = 0 and wbusqt3 = 0 and wbusqt4 = 0 and
        wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
        wbusqt8 = 0) and
        not (wbbgqt = 0 and wbinqt = wbusqt3 and
        wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
        wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
        wbusqt8 = 0)
  group by wbcmcd,wbplant,wbdvsn,wborct,wbitno;
end if;
close wipchk_cur;

end
