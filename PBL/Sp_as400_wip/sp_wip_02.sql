--file name     : pbwip.sp_wip_02.sql
--system        : kdac system
--proc name     : sp_wip_02
--initial       : 2003.03.21
--author        : kim ki sub
--desc          : Vendorsheet creation(Before Final)

drop procedure pbwip.sp_wip_02;
create procedure pbwip.sp_wip_02
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
select bb.wbcmcd,a_yyyy,p_part,' ',' ',bb.wbplant,
 bb.wbdvsn,bb.wborct,' ',' ',' ',' ',bb.wbitno,
 ' ',' ',aa.wascrp,aa.waretn,
 decimal(bb.bgqt,15,4),
 decimal((bb.inqt + aa.wainqt - aa.wausqt3 ),15,4),
 decimal((bb.usqt2 + aa.wausqt2),15,4),
 decimal((bb.usqt7 + aa.wausqt7),15,4),
 decimal(aa.waohqt ,15,4),a_inptid,a_inptdt
 from pbwip.wip001 aa,
  ( select wbcmcd,wbplant,wbdvsn,wborct,wbitno,
  decimal(sum(case wbmonth
    when p_mm01 then wbbgqt
    else 0
    end ),15,4) as bgqt,
  decimal(sum(wbinqt - wbusqt3 ),15,4) as inqt,
  decimal(sum(wbusqt2),15,4) as usqt2,
  decimal(sum(wbusqt7),15,4) as usqt7
  from pbwip.wip002
  where wbcmcd = '01' and
        wbyear = a_yyyy and
        wbmonth >= p_mm01 and
        wbmonth <= p_mm02 and
        wbiocd = '2' and
        not (wbbgqt = 0 and wbinqt = 0 and
        wbusqt2 = 0 and wbusqt7 = 0 and
        wbusqt8 = 0) and
        not (wbbgqt = 0 and wbinqt = wbusqt3 and
        wbusqt2 = 0 and wbusqt7 = 0)
  group by wbcmcd,wbplant,wbdvsn,wborct,wbitno ) bb
  where bb.wbcmcd = aa.wacmcd and bb.wbplant = aa.waplant and
        bb.wbdvsn = aa.wadvsn and bb.wbitno = aa.waitno and
        bb.wborct = aa.waorct and
        aa.waiocd = '2' ;

insert into pbwip.wip008
(wfcmcd,wfyear,wfpart,wfserl,wfpage,wfplant,wfdvsn,
 wfvsrno,wfvndr,wfvndnm,wfaddr,wfprnm,wfitno,
 wfitnm,wfunit,wfscrp,wfretn,wfbgqt,wfinqt,
 wfusqt2,wfusqt7,wfohqt,wfinptid,wfinptdt)
select wacmcd,a_yyyy,p_part,' ',' ',waplant,
  wadvsn,waorct,' ',' ',' ',' ',waitno,
  ' ',' ',wascrp,waretn,0,
  decimal(wainqt ,15,4),
  decimal(wausqt2 ,15,4),
  decimal(wausqt7 ,15,4),
  decimal(waohqt ,15,4),
  a_inptid,a_inptdt
  from pbwip.wip001
  where wacmcd = '01' and
        waiocd = '2' and
        not exists (select * from pbwip.wip002
          where wbcmcd = '01' and
            wbyear = a_yyyy and
            wbmonth = p_mm02 and
            wbiocd = '2' and
            not (wbbgqt = 0 and wbinqt = 0 and
            wbusqt2 = 0 and wbusqt7 = 0 and
            wausqt8 = 0)) and
            not (wabgqt = 0 and wainqt = 0 and
              wausqt2 = 0 and wausqt7 = 0 and
              wausqt8 = 0 ) and
            not (wabgqt = 0 and wainqt = wausqt3 and
            wausqt2 = 0 and wausqt7 = 0);
end if;
close wipchk_cur;

end
