--file name     : pbwip.sp_wip_02.sql
--system        : kdac system
--proc name     : sp_wip_02
--initial       : 2003.03.21
--author        : kim ki sub
--desc          : Vendorsheet creation(Before Final)

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
select aaa.wbcmcd,p_yy01,p_part,' ',' ',aaa.wbplant,
 aaa.wbdvsn,aaa.wborct,' ',' ',' ',' ',aaa.wbitno,
 ' ',' ',ccc.wascrp,ccc.waretn,
  aaa.wbbgqt,bbb.wbinqt + aaa.wbinqt + ccc.wainqt,
  bbb.wbusqt2 + aaa.wbusqt2 + ccc.wausqt2,
  bbb.wbusqt7 + aaa.wbusqt7 + ccc.wausqt7,
  ccc.waohqt,a_inptid,a_inptdt
  from pbwip.wip002 aaa, pbwip.wip002 bbb,
       pbwip.wip001 ccc
  where aaa.wbcmcd = bbb.wbcmcd and
        aaa.wbplant = bbb.wbplant and
        aaa.wbdvsn = bbb.wbdvsn and
        aaa.wborct = bbb.wborct and
        aaa.wbitno = bbb.wbitno and
        aaa.wbiocd = bbb.wbiocd and
        bbb.wbcmcd = ccc.wacmcd and
        bbb.wbplant = ccc.waplant and
        bbb.wbdvsn = ccc.wadvsn and
        bbb.wborct = ccc.waorct and
        bbb.wbitno = ccc.waitno and
        bbb.wbiocd = ccc.waiocd and
        aaa.wbiocd = '2' and
        aaa.wbcmcd = a_cmcd and
        aaa.wbyear = p_yy01 and
        aaa.wbmonth = p_mm01 and
        bbb.wbyear = p_yy02 and
        bbb.wbmonth = p_mm02 and
        not (bbb.wbbgqt = 0 and bbb.wbinqt = 0 and
        aaa.wbbgqt = 0 and aaa.wbinqt = 0 and
        ccc.wainqt = 0 and bbb.wbusqt2 = 0 and
        aaa.wbusqt2 = 0 and ccc.wausqt2 = 0 and
        bbb.wbusqt7 = 0 and aaa.wbusqt7 = 0 and
        ccc.wausqt7 = 0) and
        not ((aaa.wbusqt2 = 0 and bbb.wbusqt2 = 0 and
        ccc.wausqt2 = 0 ) and
        ((aaa.wbusqt3 <> 0 or aaa.wbusat3 <> 0) or
        (bbb.wbusqt3 <> 0 or bbb.wbusat3 <> 0) or
        (ccc.wausqt3 <> 0 or ccc.wausat3 <> 0)));

insert into pbwip.wip008
(wfcmcd,wfyear,wfpart,wfserl,wfpage,wfplant,wfdvsn,
 wfvsrno,wfvndr,wfvndnm,wfaddr,wfprnm,wfitno,
 wfitnm,wfunit,wfscrp,wfretn,wfbgqt,wfinqt,
 wfusqt2,wfusqt7,wfohqt,wfinptid,wfinptdt)
select aaa.wbcmcd,p_yy01,p_part,' ',' ',aaa.wbplant,
  aaa.wbdvsn,aaa.wborct,' ',' ',' ',' ',aaa.wbitno,
  ' ',' ',ccc.wascrp,ccc.waretn,0,
  aaa.wbinqt + ccc.wainqt, aaa.wbusqt2 + ccc.wausqt2,
  aaa.wbusqt7 + ccc.wausqt7, ccc.waohqt,
  a_inptid,a_inptdt
  from pbwip.wip002 aaa, pbwip.wip001 ccc
  where aaa.wbcmcd = ccc.wacmcd and
        aaa.wbplant = ccc.waplant and
        aaa.wbdvsn = ccc.wadvsn and
        aaa.wborct = ccc.waorct and
        aaa.wbitno = ccc.waitno and
        aaa.wbiocd = ccc.waiocd and
        aaa.wbcmcd = a_cmcd and
        aaa.wbyear = p_yy02 and
        aaa.wbmonth = p_mm02 and
        aaa.wbiocd = '2' and
  (not exists (select * from pbwip.wip002 bbb
  		where aaa.wbcmcd = bbb.wbcmcd and
      aaa.wbplant = bbb.wbplant and
      aaa.wbdvsn = bbb.wbdvsn and
      aaa.wborct = bbb.wborct and
      aaa.wbitno = bbb.wbitno and
      aaa.wbiocd = bbb.wbiocd and
      bbb.wbcmcd = '01' and
      bbb.wbyear = p_yy01 and
      bbb.wbmonth = p_mm01 and
      bbb.wbiocd = '2' )) and
        not (aaa.wbbgqt = 0 and aaa.wbinqt = 0 and
        ccc.wainqt = 0 and aaa.wbusqt2 = 0 and
        ccc.wausqt2 = 0 and aaa.wbusqt7 = 0 and
        ccc.wausqt7 = 0 ) and
        not ((aaa.wbusqt2 = 0 and ccc.wausqt2 = 0 ) and
        ((aaa.wbusqt3 <> 0 or aaa.wbusat3 <> 0) or
        (ccc.wausqt3 <> 0 or ccc.wausat3 <> 0)));

insert into pbwip.wip008
(wfcmcd,wfyear,wfpart,wfserl,wfpage,wfplant,wfdvsn,
 wfvsrno,wfvndr,wfvndnm,wfaddr,wfprnm,wfitno,
 wfitnm,wfunit,wfscrp,wfretn,wfbgqt,wfinqt,
 wfusqt2,wfusqt7,wfohqt,wfinptid,wfinptdt)
select distinct ccc.wacmcd,p_yy01,p_part,' ',' ',
  ccc.waplant, ccc.wadvsn,ccc.waorct,' ',' ',' ',' ',
  ccc.waitno,' ',' ', ccc.wascrp, ccc.waretn,
  0,ccc.wainqt, ccc.wausqt2, ccc.wausqt7,
  ccc.waohqt,a_inptid,a_inptdt
  from pbwip.wip001 ccc, pbinv.inv101 ddd
  where ccc.wacmcd = ddd.comltd and
        ccc.waplant = ddd.xplant and
        ccc.wadvsn = ddd.div and
        ccc.waitno = ddd.itno and
        ccc.wacmcd = '01' and
        ccc.waiocd = '2' and
        ddd.srce in ('10','40','50') and
  (not exists ( select * from pbwip.wip002 bbb
  where ccc.wacmcd = bbb.wbcmcd and
        ccc.waplant = bbb.wbplant and
        ccc.wadvsn = bbb.wbdvsn and
        ccc.waorct = bbb.wborct and
        ccc.waitno = bbb.wbitno and
        bbb.wbcmcd = a_cmcd and
        bbb.wbyear = p_yy02 and
        bbb.wbmonth = p_mm02 and
        bbb.wbiocd = '2' )) and
        not (ccc.wabgqt = 0 and ccc.wainqt = 0 and
             ccc.wausqt2 = 0 and ccc.wausqt7 = 0 ) and
        not (ccc.wausqt2 = 0 and
        (ccc.wausqt3 <> 0 or ccc.wausat3 <> 0));
end if;
close wipchk_cur;

end
