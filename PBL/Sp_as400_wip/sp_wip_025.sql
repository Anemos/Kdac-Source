-- file name : sp_wip_025
-- procedure name : pbwip.sp_wip_025
-- desc : WIP009 update with average,input, use, onhand

drop procedure pbwip.sp_wip_025;
create procedure pbwip.sp_wip_025 (
in a_cmcd   varchar(2),
in a_year   varchar(4),
in a_month  varchar(2),
in a_plant  varchar(1),
in a_dvsn   varchar(1),
in a_vendor varchar(5),
in a_ipaddr varchar(30),
in a_macaddr varchar(30),
in a_inptdt varchar(8),
in a_updtdt varchar(8))
language sql
begin
declare sqlcode integer default 0;
declare sqlstate char(5) default '00000';
declare p_itno     char(15);
declare p_mm01     char(2);
declare p_convqty  numeric(13,4);
declare p_avrg     numeric(15,5);
declare p_bgqt     numeric(15,4);
declare p_bgat     numeric(11,0);
declare p_inqt     numeric(15,4);
declare p_inat     numeric(11,0);
declare p_usqt2    numeric(15,4);
declare p_usat2    numeric(11,0);
declare p_usqt     numeric(15,4);
declare p_usat     numeric(11,0);
declare p_usqt7    numeric(15,4);
declare p_usat7    numeric(11,0);
declare p_ohqt     numeric(15,4);
declare p_ohat     numeric(11,0);
declare p_continue char(1);
declare retcode    integer;
declare p_cnt      integer;

--Get input, use, on hand data
declare wip_claim cursor for
  select wbitno,
  sum( case wbmonth when a_month then
    wbavrg1 else 0 end ),
  sum( case wbmonth when p_mm01 then
    wbbgqt else 0 end ),
  sum( case wbmonth when p_mm01 then
    wbbgat1 else 0 end ),
  sum(wbinqt - wbusqt3),
  sum( wbinat1 + wbinat2 + wbinat3 - wbusat3) ,
  sum( wbusqt2 ),
  sum( wbusat2 ),
  sum( wbusqt1 + wbusqt4 + wbusqt5 + wbusqt6 +
    wbusqt8 ),
  sum( wbusat1 + wbusat4 + wbusat5 + wbusat6 +
    wbusat8 + wbusat9),
  sum( wbusqt7 ),
  sum( wbusat7 ),
  sum( case wbmonth when a_month then
    wbbgqt + wbinqt - (wbusqt1 + wbusqt2 + wbusqt3 +
    wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7 + wbusqt8)
    else 0 end ),
  sum( case wbmonth when a_month then
    wbbgat1 + wbinat1 + wbinat2 + wbinat3 - (wbusat1 + wbusat2 +
    wbusat3 + wbusat4 + wbusat5 + wbusat6 + wbusat7 + wbusat8 +
    wbusat9)
    else 0 end )
  from pbwip.wip002
  where wbcmcd = a_cmcd and wbyear = a_year and
        wbplant = a_plant and wbdvsn = a_dvsn and
        wbiocd = '2' and wborct = a_vendor and
        wbmonth >= p_mm01 and wbmonth <= a_month and
        not (wbbgqt = 0 and wbinqt = wbusqt3 and
          wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          wbusqt8 = 0 )
  group by wbitno;

declare continue handler for sqlexception
  set retcode=sqlcode;
declare continue handler for sqlwarning
  set retcode=sqlcode;
declare continue handler for not found
  set retcode=1;

case a_month
  when '03' then
    set p_mm01 = '01';
  when '06' then
    set p_mm01 = '04';
  when '09' then
    set p_mm01 = '07';
  when '12' then
    set p_mm01 = '10';
end case;

--initialize data
update pbwip.wip009
  set wfavrg = 0, wfinqt = 0, wfinat = 0,
      wfusqt1 = 0, wfusat1 = 0,
      wfusqt2 = 0, wfusat2 = 0,
      wfusqt3 = 0, wfusat3 = 0,
      wfohqt = 0, wfohat = 0
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfplant = a_plant and
        wfdvsn = a_dvsn and wfvendor = a_vendor;

-- First Step
open wip_claim;
inc_loop:
loop
  fetch wip_claim into p_itno,p_avrg,p_bgqt,p_bgat,p_inqt,p_inat,
    p_usqt2,p_usat2,p_usqt,p_usat,p_usqt7,p_usat7,p_ohqt,p_ohat;
  if retcode = 1 then
    leave inc_loop;
  end if;

  select count(*) into p_cnt
  from pbwip.wip009
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfplant = a_plant and
        wfdvsn = a_dvsn and wfvendor = a_vendor and
        wfitno = p_itno;

  if p_cnt <> 0 then
    -- update wip009
    update pbwip.wip009
    set wfavrg = p_avrg, wfbgqt = p_bgqt, wfbgat = p_bgat,
        wfinqt = p_inqt, wfinat = p_inat,
        wfusqt1 = p_usqt2, wfusat1 = p_usat2,
        wfusqt2 = p_usqt, wfusat2 = p_usat,
        wfusqt3 = p_usqt7, wfusat3 = p_usat7,
        wfohqt = p_ohqt, wfohat = p_ohat,
        wfstscd = '2', wfipaddr = a_ipaddr,
        wfmacaddr = a_macaddr, wfupdtdt = a_updtdt
    where wfyear = a_year and wfmonth = a_month and
          wfcmcd = a_cmcd and wfplant = a_plant and
          wfdvsn = a_dvsn and wfvendor = a_vendor and
          wfitno = p_itno;
    if sqlcode <> 0 then
      leave inc_loop;
    end if;
  else
    -- insert wip009
    insert into pbwip.wip009
    (wfyear,wfmonth,wfcmcd,wfplant,wfdvsn,wfvendor,wfitno,
    wfunit,wfscrp,wfretn,wfavrg,wfbgqt,wfbgat,wfinqt,wfinat,
    wfusqt1,wfusat1,wfusqt2,wfusat2,wfusqt3,wfusat3,
    wfohqt,wfohat,wfphqt,wfphat,wfdefqt,wfdefat,wflautqt,
    wflautat,wfrautqt,wfrautat,wfclqt,wfclat,wfplan,wfstscd,
    wfipaddr,wfmacaddr,wfinptdt,wfupdtdt)
    select a_year,a_month,a_cmcd,a_plant,a_dvsn,a_vendor,p_itno,
    xunit, 0, 0, p_avrg, p_bgqt, p_bgat, p_inqt, p_inat,
    p_usqt2, p_usat2, p_usqt, p_usat, p_usqt7, p_usat7,
    p_ohqt, p_ohat, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, ' ', '2',
    a_ipaddr,a_macaddr,a_inptdt,' '
    from pbinv.inv101
    where comltd = a_cmcd and xplant = a_plant and
          div = a_dvsn and itno = p_itno;
    if sqlcode <> 0 then
      leave inc_loop;
    end if;
  end if;
end loop;
close wip_claim;

end
