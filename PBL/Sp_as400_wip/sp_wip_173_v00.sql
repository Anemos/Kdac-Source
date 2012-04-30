-- file name : sp_wip_173
-- procedure name : pbwip.sp_wip_173
-- desc : Data Cross Check Between wip006 and wip002

drop procedure pbwip.sp_wip_173;
create procedure pbwip.sp_wip_173 (
in a_cmcd     char(2),
in a_year     char(4),
in a_month    char(2),
in a_yyyy02   char(4),
in a_mm02     char(2))
language sql
begin
declare sqlcode integer default 0;
declare p_chkint  integer;

select count(*) into p_chkint
from pbwip.wip006 aa inner join pbinv.inv101 bb
  on aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno
where aa.wfyear = a_year and aa.wfmonth = a_month and
      aa.wfcmcd = a_cmcd and aa.wfdept = '9999' and
      bb.cls = '10' and bb.srce <> '03' and aa.wfphqt <> 0 and
      not exists ( select cc.wbitno from pbwip.wip002 cc
        where aa.wfyear = cc.wbyear and aa.wfmonth = cc.wbmonth and
          aa.wfplant = cc.wbplant and aa.wfdvsn = cc.wbdvsn and
          aa.wfcmcd = cc.wbcmcd and aa.wfitno = cc.wbitno and
          cc.wborct = '9999' );
if p_chkint < 1 then
  return;
end if;
-- Check Data Cross Check Between wip006 and wip002
-- Next Month
insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
  wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
  wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
  wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
  wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
  wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
  wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
  wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
  wbmacaddr,wbinptdt,wbupdtdt)
select aa.wfcmcd,aa.wfplant,aa.wfdvsn,aa.wfdept,aa.wfitno,
  a_yyyy02,a_mm02,' ','1',bb.cls,bb.srce,substring(bb.pdcd,1,2),
  bb.xunit,' ',aa.wfitnm,aa.wfspec,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,' ',' ',' ',' ',' '
from pbwip.wip006 aa inner join pbinv.inv101 bb
  on aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno
where aa.wfyear = a_year and aa.wfmonth = a_month and
      aa.wfcmcd = a_cmcd and aa.wfdept = '9999' and
      bb.cls = '10' and bb.srce <> '03' and aa.wfphqt <> 0 and
      not exists ( select cc.wbitno from pbwip.wip002 cc
        where aa.wfyear = cc.wbyear and aa.wfmonth = cc.wbmonth and
          aa.wfplant = cc.wbplant and aa.wfdvsn = cc.wbdvsn and
          aa.wfcmcd = cc.wbcmcd and aa.wfitno = cc.wbitno and
          cc.wborct = '9999' );
-- Current Balance
insert into pbwip.wip001(wacmcd,waplant,wadvsn,waorct,
waitno,waiocd,waavrg1,waavrg2,wabgqt,wabgat1,wabgat2,
wainqt,wainat1,wainat2,wainat3,wainat4,wausqt1,wausat1,
wausqt2,wausat2,wausqt3,wausat3,wausqt4,wausat4,
wausqt5,wausat5,wausqt6,wausat6,wausqt7,wausat7,
wausqt8,wausat8,wausat9,waohqt,waohat1,waohat2,wascrp,
waretn,waplan,waipaddr,wamacaddr,wainptdt,waupdtdt)
select aa.wfcmcd,aa.wfplant,aa.wfdvsn,aa.wfdept,aa.wfitno,
  '1',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,' ',
  ' ',' ',' ',' '
from pbwip.wip006 aa inner join pbinv.inv101 bb
  on aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno
where aa.wfyear = a_year and aa.wfmonth = a_month and
      aa.wfcmcd = a_cmcd and aa.wfdept = '9999' and
      bb.cls = '10' and bb.srce <> '03' and aa.wfphqt <> 0 and
      not exists ( select cc.wbitno from pbwip.wip002 cc
        where aa.wfyear = cc.wbyear and aa.wfmonth = cc.wbmonth and
          aa.wfplant = cc.wbplant and aa.wfdvsn = cc.wbdvsn and
          aa.wfcmcd = cc.wbcmcd and aa.wfitno = cc.wbitno and
          cc.wborct = '9999' );
-- Working Month
insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
  wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
  wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
  wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
  wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
  wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
  wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
  wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
  wbmacaddr,wbinptdt,wbupdtdt)
select aa.wfcmcd,aa.wfplant,aa.wfdvsn,aa.wfdept,aa.wfitno,
  aa.wfyear,aa.wfmonth,' ','1',bb.cls,bb.srce,substring(bb.pdcd,1,2),
  bb.xunit,' ',aa.wfitnm,aa.wfspec,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,0,0,
    0,0,0,0,' ',' ',' ',' ',' '
from pbwip.wip006 aa inner join pbinv.inv101 bb
  on aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno
where aa.wfyear = a_year and aa.wfmonth = a_month and
      aa.wfcmcd = a_cmcd and aa.wfdept = '9999' and
      bb.cls = '10' and bb.srce <> '03' and aa.wfphqt <> 0 and
      not exists ( select cc.wbitno from pbwip.wip002 cc
        where aa.wfyear = cc.wbyear and aa.wfmonth = cc.wbmonth and
          aa.wfplant = cc.wbplant and aa.wfdvsn = cc.wbdvsn and
          aa.wfcmcd = cc.wbcmcd and aa.wfitno = cc.wbitno and
          cc.wborct = '9999' );
end
