-- file name : sp_wip_21
-- procedure name : pbwip.sp_wip_21
-- desc : Final Line Anual QtyCheck Process

drop procedure pbwip.sp_wip_21;
create procedure pbwip.sp_wip_21 (
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
declare p_phqt     numeric(15,4);
declare p_phat     numeric(15,0);
declare p_defqt    numeric(15,4);
declare p_defat    numeric(15,0);
declare p_continue char(1);
declare retcode    integer;

--Get Line Item Data
declare cur_wip006 cursor for
SELECT AA.WBPLANT, AA.WBDVSN, AA.WBITNO,
  DECIMAL((( AA.WBBGQT + AA.WBINQT - ( AA.WBUSQT1 + AA.WBUSQT2 +
    AA.WBUSQT3 + AA.WBUSQT4 + AA.WBUSQT5 + AA.WBUSQT6 + AA.WBUSQT7 +
    AA.WBUSQT8 )) - AA.WFPHQT),15,4)
    AS DIFFQTA,
  DECIMAL(((( AA.WBBGQT + AA.WBINQT - ( AA.WBUSQT1 + AA.WBUSQT2 +
    AA.WBUSQT3 + AA.WBUSQT4 + AA.WBUSQT5 + AA.WBUSQT6 + AA.WBUSQT7 +
    AA.WBUSQT8 )) * AA.WBAVRG1) - (AA.WFPHQT  * AA.WBAVRG1 )), 15,0)
    AS DIFFATA,
  DECIMAL( AA.WFPHQT, 15, 4) AS BET_QTY,
  DECIMAL( AA.WFPHQT * AA.WBAVRG1, 15, 0) AS BET_AMT
FROM
( SELECT WBCMCD,WBPLANT,WBDVSN,WBITNO,WFDEPT,WBPDCD,
      WBAVRG1,WBBGQT,WBBGAT1,WBINQT,WBINAT1,WBINAT2,WBINAT3,
      WBUSQT1,WBUSAT1,WBUSQT2,WBUSAT2,WBUSQT3,WBUSAT3,WBUSQT4,WBUSAT4,
      WBUSQT5,WBUSAT5,WBUSQT6,WBUSAT6,WBUSQT7,WBUSAT7,WBUSQT8,WBUSAT8,
      WBUSAT9,WFPHQT
  FROM PBWIP.WIP002, PBWIP.WIP006
  WHERE WBCMCD = WFCMCD   AND WBPLANT = WFPLANT AND
        WBDVSN = WFDVSN   AND WBYEAR = WFYEAR AND
        WBMONTH = WFMONTH AND WBITNO = WFITNO AND
        WBORCT = WFDEPT AND WFSERIAL = 0 AND
        WBCMCD = a_cmcd  AND WBYEAR = p_curryy AND
        WBMONTH = p_currmm AND WBORCT = '9999' AND
  NOT (WBBGQT = 0 AND WBINQT = 0 AND WBUSQT1 = 0 AND WBUSQT2 = 0 AND
       WBUSQT3 = 0 AND WBUSQT4 = 0 AND WBUSQT5 = 0 AND WBUSQT6 = 0 AND
       WBUSQT7 = 0 AND WBUSQT8 = 0 AND WBUSQTA = 0 AND WFPHQT = 0 ) ) AA;

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
  where wbcmcd  = a_cmcd and  wborct  = '9999' and
        wbyear = p_curryy and wbmonth = p_currmm;
update pbwip.wip002
  set wbbgqt = 0, wbbgat1 = 0
  where wbcmcd  = a_cmcd and wborct  = '9999' and
        wbyear = p_nextyy and wbmonth = p_nextmm;
update pbwip.wip001
  set wabgqt = 0, wabgat1 = 0
  where wacmcd = a_cmcd and  waorct = '9999';

-- Cursor Start
open cur_wip006;
inc_loop:
loop
  fetch cur_wip006 into p_plant, p_dvsn, p_itno,
    p_defqt, p_defat, p_phqt, p_phat;
  if retcode = 1 then
    leave inc_loop;
  end if;
  -- update current month
  update pbwip.wip002
    set wbusqta = p_defqt, wbusata = p_defat
      where wbcmcd  = a_cmcd and wbplant = p_plant and
            wbdvsn = p_dvsn and wborct  = '9999' and
            wbitno  = p_itno  and wbyear = p_curryy and
            wbmonth = p_currmm;
  if retcode <> 0 then
    leave inc_loop;
  end if;
  -- update next month
  update pbwip.wip002
    set wbbgqt = p_phqt, wbbgat1 = p_phat
      where wbcmcd  = a_cmcd and wbplant = p_plant and
            wbdvsn = p_dvsn and wborct  = '9999' and
            wbitno  = p_itno  and wbyear = p_nextyy and
            wbmonth = p_nextmm;
  if retcode <> 0 then
    leave inc_loop;
  end if;
  -- update wip001
  update pbwip.wip001
    set wabgqt = p_phqt, wabgat1 = p_phat
      where wacmcd = a_cmcd and waplant = p_plant and
            wadvsn = p_dvsn and waorct = '9999' and
            waitno = p_itno;
  if retcode <> 0 then
    leave inc_loop;
  end if;
end loop;
close cur_wip006;
end
