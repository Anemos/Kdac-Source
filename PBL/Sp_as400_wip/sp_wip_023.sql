-- file name : sp_wip_023
-- procedure name : pbwip.sp_wip_023
-- desc : creation bgqt in wip009

create procedure pbwip.sp_wip_023 (
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
    set p_mm01 = '04';
  when '09' then
    set p_part = '3';
    set p_mm01 = '07';
  when '12' then
    set p_part = '4';
    set p_mm01 = '10';
end case;

--initialize data
delete from pbwip.wip009
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd;

-- insert wip009
  insert into pbwip.wip009
    (wfyear,wfmonth,wfcmcd,wfplant,wfdvsn,wfvendor,wfitno,
    wfunit,wfscrp,wfretn,wfavrg,wfbgqt,wfbgat,wfinqt,wfinat,
    wfusqt1,wfusat1,wfusqt2,wfusat2,wfusqt3,wfusat3,
    wfohqt,wfohat,wfphqt,wfphat,wfdefqt,wfdefat,wflautqt,
    wflautat,wfrautqt,wfrautat,wfclqt,wfclat,wfplan,wfstscd,
    wfipaddr,wfmacaddr,wfinptdt,wfupdtdt)
  select a_year,a_month,wbcmcd,wbplant,wbdvsn,wborct,
  wbitno,xunit,
  sum( case wbmonth when a_month then
    wbscrp else 0 end ),
  sum( case wbmonth when a_month then
    wbretn else 0 end ),
  sum( 0 ),
  sum( case wbmonth when p_mm01 then
    wbbgqt else 0 end ),
  sum( case wbmonth when p_mm01 then
    wbbgat1 else 0 end ),
  sum(0),sum(0),sum(0),sum(0),sum(0),sum(0),sum(0),sum(0),
  sum(0),sum(0),sum(0),sum(0),sum(0),sum(0),sum(0),sum(0),
  sum(0),sum(0),sum(0),sum(0),' ',' ',
  a_ipaddr,a_macaddr,a_inptdt,' '
  from pbwip.wip002, pbinv.inv101
  where wbcmcd = comltd and wbplant = xplant and
        wbdvsn = div and wbitno = itno and
        wbcmcd = a_cmcd and wbyear = a_year and
        wbiocd = '2' and
        wbmonth >= p_mm01 and wbmonth <= a_month and
        not (wbbgqt = 0 and wbinqt = wbusqt3 and
          wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          wbusqt8 = 0 )
  group by wbcmcd,wbplant,wbdvsn,wborct,
  wbitno,xunit;

-- insert wip008
	insert into pbwip.wip008
		(wfcmcd,wfyear,wfpart,wfserl,wfpage,wfplant,wfdvsn,
 		wfvsrno,wfvndr,wfvndnm,wfaddr,wfprnm,wfitno,
 		wfitnm,wfunit,wfscrp,wfretn,wfbgqt,wfinqt,
 		wfusqt2,wfusqt7,wfohqt,wfinptid,wfinptdt)
 	select wbcmcd,a_year,p_part,' ',' ',wbplant,wbdvsn,
  wborct,' ',' ',' ',' ',wbitno,' ',' ',
  sum( case wbmonth when a_month then
    wbscrp else 0 end ),
  sum( case wbmonth when a_month then
    wbretn else 0 end ),
  sum( case wbmonth when p_mm01 then
    wbbgqt else 0 end ),
  sum(0),sum(0),sum(0),sum(0),' ',a_inptdt
  from pbwip.wip002, pbinv.inv101
  where wbcmcd = comltd and wbplant = xplant and
        wbdvsn = div and wbitno = itno and
        wbcmcd = a_cmcd and wbyear = a_year and
        wbiocd = '2' and
        wbmonth >= p_mm01 and wbmonth <= a_month and
        not (wbbgqt = 0 and wbinqt = wbusqt3 and
          wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          wbusqt8 = 0 )
  group by wbcmcd,wbplant,wbdvsn,wborct,wbitno;
end
