-- file name : sp_wip_027
-- procedure name : pbwip.sp_wip_027
-- desc : creation bgqt in wip009 in sale vendor item

drop procedure pbwip.sp_wip_027;

create procedure pbwip.sp_wip_027 (
in a_cmcd   varchar(2),
in a_year   varchar(4),
in a_month  varchar(2),
in a_ipaddr varchar(30),
in a_macaddr varchar(30),
in a_inptdt varchar(8),
in a_updtdt varchar(8))
language sql
begin
declare sqlcode integer default 0;
declare sqlstate char(5) default '00000';
declare p_mm01     char(2);
declare p_part     char(1);
declare p_iocd     char(1);
declare p_continue char(1);
declare retcode    integer;

declare continue handler for sqlexception
  set retcode=sqlcode;
declare continue handler for sqlwarning
  set retcode=sqlcode;
declare continue handler for not found
  set retcode=1;

case a_month
  when '03' then
    set p_part = '1';
    set p_mm01 = '01';
  when '06' then
    set p_part = '2';
    set p_mm01 = '01';
  when '09' then
    set p_part = '3';
    set p_mm01 = '01';
  when '12' then
    set p_part = '4';
    set p_mm01 = '01';
end case;

--initialize data
delete from pbwip.wip009
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfiocd = '3';

-- insert wip009
  insert into pbwip.wip009
    (wfyear,wfmonth,wfcmcd,wfplant,wfdvsn,wfiocd,wfvendor,wfitno,
    wfunit,wfscrp,wfretn,wfavrg,wfbgqt,wfbgat,wfinqt,wfinat,
    wfusqt1,wfusat1,wfusqt2,wfusat2,wfusqt3,wfusat3,
    wfohqt,wfohat,wfphqt,wfphat,wfdefqt,wfdefat,wflautqt,
    wflautat,wfrautqt,wfrautat,wfclqt,wfclat,wfplan,wfstscd,
    wfipaddr,wfmacaddr,wfinptdt,wfupdtdt)
  select a_year,a_month,a.wbcmcd,a.wbplant,a.wbdvsn,a.wbiocd,a.wborct,
  a.wbitno,b.xunit,
  a.wbscrp,
  a.wbretn,
  case when (b.cls = '50' or b.srce = '03') then
    a.wbavrg1 else decimal( b.costav / case when b.convqty = 0
      then 1 else b.convqty end ) end,
  a.wbbgqt,
  a.wbbgat1,
  0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,0,0,' ',' ',
  a_ipaddr,a_macaddr,a_inptdt,' '
  from (select wbcmcd,wbplant,wbdvsn,wbitno,wbiocd,wborct,
    sum( case wbmonth when a_month then
      wbscrp else 0 end ) as wbscrp,
    sum( case wbmonth when a_month then
      wbretn else 0 end ) as wbretn,
    sum( case wbmonth when a_month then
      wbavrg1 else 0 end ) as wbavrg1,
    sum( case wbmonth when p_mm01 then
      wbbgqt else 0 end ) as wbbgqt,
    sum( case wbmonth when p_mm01 then
      wbbgat1 else 0 end ) as wbbgat1,
    sum(wbinqt) as wbinqt,
    sum(wbusqt1) as wbusqt1,
    sum(wbusqt2) as wbusqt2,
    sum(wbusqt3) as wbusqt3,
    sum(wbusqt4) as wbusqt4,
    sum(wbusqt5) as wbusqt5,
    sum(wbusqt6) as wbusqt6,
    sum(wbusqt7) as wbusqt7,
    sum(wbusqt8) as wbusqt8
    from pbwip.wip002
    where wbcmcd = a_cmcd and wbyear = a_year and
        wbiocd = '3' and
        wbmonth >= p_mm01 and wbmonth <= a_month
    group by wbcmcd,wbplant,wbdvsn,wbitno,wbiocd,wborct) a, pbinv.inv101 b
  where a.wbcmcd = b.comltd and a.wbplant = b.xplant and
        a.wbdvsn = b.div and a.wbitno = b.itno and
        not (a.wbbgqt = 0 and a.wbinqt =0 and a.wbusqt3 = 0 and
          a.wbusqt1 = 0 and a.wbusqt2 = 0 and a.wbusqt4 = 0 and
          a.wbusqt5 = 0 and a.wbusqt6 = 0 and a.wbusqt7 = 0 and
          a.wbusqt8 = 0 ) ;
end
