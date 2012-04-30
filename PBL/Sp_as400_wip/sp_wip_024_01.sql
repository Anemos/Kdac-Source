-- file name : sp_wip_024
-- procedure name : pbwip.sp_wip_024
-- desc : Final Bungi QtyCheck Process

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
declare p_plant    char(1);
declare p_dvsn     char(1);
declare p_itno     char(15);
declare p_vendor   char(5);
declare p_scrp     numeric(5,2);
declare p_retn     numeric(5,2);
declare p_phqt     numeric(15,4);
declare p_phat     numeric(15,0);
declare p_defqt    numeric(15,4);
declare p_defat    numeric(15,0);
declare p_continue char(1);
declare retcode    integer;

--Get Vendor Item Data
declare cur_wip009 cursor for
  select wfplant, wfdvsn, wfvendor, wfitno, wfscrp,
    wfretn, wfphqt, wfphat, wfdefqt, wfdefat
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

-- Cursor Start
open cur_wip009;
inc_loop:
loop
  fetch cur_wip009 into p_plant, p_dvsn, p_vendor, p_itno,
    p_scrp, p_retn, p_phqt, p_phat, p_defqt, p_defat;
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
  update pbwip.wip001
    set waretn = p_retn, wascrp = p_scrp,
        wabgqt = p_phqt, wabgat1 = p_phat,
        waohqt = p_phqt + wainqt - ( wausqt1 + wausqt2 + wausqt3
          + wausqt4 + wausqt5 + wausqt6 + wausqt7 + wausqt8 )
      where wacmcd = a_cmcd and waplant = p_plant and
            wadvsn = p_dvsn and waorct = p_vendor and
            waitno = p_itno and waiocd = '2';
  if retcode <> 0 then
    leave inc_loop;
  end if;
end loop;
close cur_wip009;
end
