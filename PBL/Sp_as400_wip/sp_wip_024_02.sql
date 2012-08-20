-- file name : sp_wip_024
-- procedure name : pbwip.sp_wip_024
-- desc : Final Bungi QtyCheck Process
--      잉여재공(Loss율반영)이월 2012.07

drop procedure pbwip.sp_wip_024;
create procedure pbwip.sp_wip_024 (
in a_cmcd   varchar(2),
in a_currdt  varchar(6),
in a_nextdt  varchar(6),
in a_ipaddr varchar(30),
in a_macaddr varchar(30),
in a_inptdt varchar(8),
in a_updtdt varchar(8))
language sql
begin
declare sqlcode integer default 0;
declare sqlstate char(5) default '00000';
declare p_curryy   char(4);
declare p_currmm   char(2);
declare p_nextyy   char(4);
declare p_nextmm   char(2);
declare p_nextdate char(8);
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_itno     char(15);
declare p_vendor   char(5);
declare p_scrp     numeric(5,2);
declare p_retn     numeric(5,2);
declare p_phqt     numeric(15,4);
declare p_phat     numeric(15,0);
declare p_ohqt     numeric(15,4);
declare p_ohat     numeric(15,0);
declare p_clqt     numeric(15,4);
declare p_clat     numeric(15,0);
declare p_defqt    numeric(15,4);
declare p_defat    numeric(15,0);
declare p_srno     char(10);
declare p_continue char(1);
declare retcode    integer;

--Get Vendor Item Data
declare cur_wip009 cursor for
  select wfplant, wfdvsn, wfvendor, wfitno, wfscrp,
    wfretn, wfphqt, wfphat, wfdefqt, wfdefat,
    wfohqt, wfohat, case when wfunit = 'EA' then CEILING(wfclqt)
    else wfclqt end, wfclat
  from pbwip.wip009
  where wfyear = p_curryy and wfmonth = p_currmm;

declare continue handler for sqlexception
  set retcode=sqlcode;
declare continue handler for sqlwarning
  set retcode=sqlcode;
declare continue handler for not found
  set retcode=1;

set p_curryy = substring( a_currdt, 1, 4);
set p_currmm = substring( a_currdt, 5, 2);
set p_nextyy = substring( a_nextdt, 1, 4);
set p_nextmm = substring( a_nextdt, 5, 2);
set p_nextdate = concat(a_nextdt,'01');

-- Data Default
update pbwip.wip002
  set wbusqta = 0, wbusata = 0
  where wbcmcd  = a_cmcd and  wbiocd = '2' and
        wbyear = p_curryy and wbmonth = p_currmm;
        
update pbwip.wip002
  set wbbgqt = 0, wbbgat1 = 0
  where wbcmcd  = a_cmcd and wbiocd = '2' and
        wbyear = p_nextyy and wbmonth = p_nextmm;
        
update pbwip.wip001
  set wabgqt = 0, wabgat1 = 0
  where wacmcd = a_cmcd and  waiocd = '2';

delete from pbwip.wip005
where wecmcd = '01' and weslty = 'WX' and
  wesrno in ( select wdsrno from pbwip.wip004
    where wdcmcd = '01' and wdslty = 'WX' and
      wddate = p_nextdate and wdinptid = 'system' );

delete from pbwip.wip004
where wdcmcd = '01' and wdslty = 'WX' and
  wddate = p_nextdate and wdinptid = 'system';

set retcode = 0;

-- Cursor Start
open cur_wip009;
inc_loop:
loop
  fetch cur_wip009 into p_plant, p_dvsn, p_vendor, p_itno,
    p_scrp, p_retn, p_phqt, p_phat, p_defqt, p_defat,
    p_ohqt, p_ohat, p_clqt, p_clat;
  if retcode = 1 then
    leave inc_loop;
  end if;
  -- update current month
  update pbwip.wip002
    set wbretn = p_retn, wbscrp = p_scrp,
        wbusqta = p_defqt, wbusata = p_defat
      where wbcmcd  = a_cmcd and wbplant = p_plant and
            wbdvsn = p_dvsn and wborct  = p_vendor and
            wbitno  = p_itno  and wbyear = p_curryy and
            wbmonth = p_currmm and wbiocd = '2';
  if retcode <> 0 then
    leave inc_loop;
  end if;
  -- update next month
  update pbwip.wip002
    set wbretn = p_retn, wbscrp = p_scrp,
        wbbgqt = p_phqt, wbbgat1 = p_phat
      where wbcmcd  = a_cmcd and wbplant = p_plant and
            wbdvsn = p_dvsn and wborct  = p_vendor and
            wbitno  = p_itno  and wbyear = p_nextyy and
            wbmonth = p_nextmm and wbiocd = '2';
  if retcode <> 0 then
    leave inc_loop;
  end if;
  -- update wip001
  if p_phqt = 0 and p_ohqt < 0 then
    -- wausqt8 add ohqt
    set p_srno = pbwip.sf_wip_000(a_cmcd);

    -- Insert wip004
    insert into pbwip.wip004(wdcmcd,wdslty,wdsrno,wdplant,wddvsn,
      wdiocd,wditno,wdrvno,wddesc,wdspec,wdunit,wditcl,wdsrce,wdusge,
      wdpdcd,wdslno,wdprsrty,wdprsrno,wdprsrno1,wdprsrno2,wdprno,
      wdprdpt,wdchdpt,wddate,wdprqt,wdchqt,wdipaddr,wdmacaddr,
      wdinptid,wdupdtid,wdinptdt,wdinpttm,wdupdtdt)
    select a_cmcd,'WX', p_srno, p_plant, p_dvsn, '2', p_itno,
      aa.rvno, aa.itnm, aa.spec, bb.xunit, bb.cls,bb.srce,'08',
      substr(pdcd,1,2), '', '', '', '', '',
      '', '', p_vendor, p_nextdate, 0, (-1) * p_clqt, '',
      '', 'system', '', '', '', ''
    from pbinv.inv002 aa, pbinv.inv101 bb
    where aa.comltd = bb.comltd and aa.itno = bb.itno and
        bb.comltd = a_cmcd and bb.xplant = p_plant and
        bb.div = p_dvsn and bb.itno = p_itno;

    --insert wip005
    insert into pbwip.wip005 (wecmcd, weslty, wesrno, weremk)
    values ( a_cmcd, 'WX', p_srno, '무상사급정산 잉여재공이월') ;

    --insert wip001
    update pbwip.wip001
    set waretn = p_retn, wascrp = p_scrp,
        wabgqt = p_phqt, wabgat1 = p_phat,
        wausqt8 = wausqt8 + ((-1) * p_clqt),
        wausat8 = wausat8 + ((-1) * p_clat),
        waohqt = p_phqt + wainqt - ( wausqt1 + wausqt2 + wausqt3
          + wausqt4 + wausqt5 + wausqt6 + wausqt7 + wausqt8
          + ((-1) * p_clqt)),
        waohat1 = p_phat + wainat1 + wainat2 + wainat3 + wainat4
          - ( wausat1 + wausat2 + wausat3
          + wausat4 + wausat5 + wausat6 + wausat7 + wausat8 + wausat9 +
          + ((-1) * p_clat))
    where wacmcd = a_cmcd and waplant = p_plant and
          wadvsn = p_dvsn and waorct = p_vendor and
          waitno = p_itno and waiocd = '2';
  else
    update pbwip.wip001
    set waretn = p_retn, wascrp = p_scrp,
        wabgqt = p_phqt, wabgat1 = p_phat,
        waohqt = p_phqt + wainqt - ( wausqt1 + wausqt2 + wausqt3
          + wausqt4 + wausqt5 + wausqt6 + wausqt7 + wausqt8 ),
        waohat1 = p_phat + wainat1 + wainat2 + wainat3 + wainat4
          - ( wausat1 + wausat2 + wausat3
          + wausat4 + wausat5 + wausat6 + wausat7 + wausat8 + wausat9)
    where wacmcd = a_cmcd and waplant = p_plant and
          wadvsn = p_dvsn and waorct = p_vendor and
          waitno = p_itno and waiocd = '2';
  end if;

  if retcode <> 0 then
    leave inc_loop;
  end if;
end loop;
close cur_wip009;
end
