-- file name : sf_wip_003
-- procedure name : pbwip.sf_wip_003
-- desc : bom explosion data -> line add(wip002)

drop function pbwip.sf_wip_003;

create function pbwip.sf_wip_003 (
a_comltd varchar(2),
a_prsrty varchar(2),
a_prsrno varchar(8),
a_prsrno1 varchar(2),
a_prsrno2 varchar(2),
a_iocd   varchar(1),
a_plant  varchar(1),
a_dvsn   varchar(1),
a_pitno  varchar(15),
a_citno  varchar(15),
a_slno   varchar(12),
a_xuse   varchar(2),
a_rtngub varchar(2),
a_prdpt  varchar(5),
a_chdpt  varchar(5),
a_tqty4   numeric(11,1),
a_chqt   numeric(15,4),
a_tdte4   varchar(8),
a_opcd   varchar(1),
a_continue varchar(1),
a_ipaddr varchar(30),
a_macaddr varchar(30),
a_inptid varchar(6),
a_inptdt varchar(8),
a_inpttm varchar(6),
a_adjdt varchar(6),
a_nextdt varchar(6))
returns numeric(15,4)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_adjyy char(4);
declare p_adjmm char(2);
declare p_nextyy char(4);
declare p_nextmm char(2);
declare p_usqt1 numeric(15,4);
declare p_usqt2 numeric(15,4);
declare p_usqt3 numeric(15,4);
declare p_usqt7 numeric(15,4);
declare p_ohqt numeric(15,4);
declare p_chkrow char(1);
declare p_usge char(2);
declare p_srno char(10);
declare p_chqt numeric(15,4);
declare p_rtnqt numeric(15,4);

--Set date
set p_adjyy = substr(a_adjdt,1,4);
set p_adjmm = substr(a_adjdt,5,2);
set p_nextyy = substr(a_nextdt,1,4);
set p_nextmm = substr(a_nextdt,5,2);
--Get reference data
select wbusqt1,wbusqt2,wbusqt3,wbusqt7
 into p_usqt1,p_usqt2,p_usqt3,p_usqt7
 from pbwip.wip002
 where wbcmcd = a_comltd and wbplant = a_plant and
       wbdvsn = a_dvsn and wborct = a_chdpt and
       wbitno = a_citno and wbyear = p_adjyy and
       wbmonth = p_adjmm;
if sqlcode <> 0 then
   set p_ohqt = 0;
   set p_usqt1 = 0;
   set p_usqt2 = 0;
   set p_usqt3 = 0;
   set p_usqt7 = 0;
   set p_chkrow = 'N';
else
  select wbbgqt into p_ohqt
  from pbwip.wip002
  where wbcmcd = a_comltd and wbplant = a_plant and
        wbdvsn = a_dvsn and wborct = a_chdpt and
        wbitno = a_citno and wbyear = p_nextyy and
        wbmonth = p_nextmm;
  set p_chkrow = 'Y';
end if;

--Check Wip_Usage
case a_prsrty
 when 'RP' then
   set p_usge = '02';
   set p_chqt = a_chqt;
 when 'RS' then
   if a_xuse = '04' then
      if a_rtngub = '02' then
         set p_usge = '00';
      else
         set p_usge = '02';
         set p_chqt = -1 * a_chqt;
      end if;
    else
      if a_rtngub = '02' then
         set p_usge = '00';
         set p_chqt = a_chqt;
      else
         set p_usge = '03';
         set p_chqt = -1 * a_chqt;
      end if;
    end if;
 when 'IS' then
    if a_xuse = '04' then
       set p_usge = '02';
       set p_chqt = a_chqt;
    else
       set p_usge = '03';
       set p_chqt = a_chqt;
    end if;
 when 'RM' then
    set p_usge = '01';
    set p_chqt = a_chqt;
 when 'SM' then
    set p_usge = '01';
    set p_chqt = -1 * a_chqt;
 else
    set p_usge = '00';
end case;

if p_usge = '00' then
   return -999999;
end if;

-- Update wip002
if a_opcd = '2' and a_continue = 'Y' then
  set p_rtnqt = p_ohqt - p_chqt;
  if p_rtnqt < 0 then
     set p_rtnqt = p_chqt - p_ohqt;
     set p_chqt = p_ohqt;
  else
     set p_rtnqt = 0;
  end if;
else
  set p_rtnqt = 0;
end if;

case p_usge
   when '01' then
     set p_usqt1 = p_usqt1 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
   when '02' then
     set p_usqt2 = p_usqt2 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
   when '03' then
     set p_usqt3 = p_usqt3 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
   when '07' then
     set p_usqt7 = p_usqt7 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
end case;
if p_chkrow = 'Y' then
   update pbwip.wip002
   set wbusqt1 = p_usqt1,wbusqt2 = p_usqt2,
       wbusqt3 = p_usqt3,wbusqt7 = p_usqt7
   where wbcmcd = a_comltd and
         wbplant = a_plant and
         wbdvsn = a_dvsn and
         wborct = a_chdpt and
         wbitno = a_citno and
         wbyear = p_adjyy and
         wbmonth = p_adjmm;
   update pbwip.wip002
   set wbbgqt = p_ohqt
   where wbcmcd = a_comltd and
         wbplant = a_plant and
         wbdvsn = a_dvsn and
         wborct = a_chdpt and
         wbitno = a_citno and
         wbyear = p_nextyy and
         wbmonth = p_nextmm;
else
  insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
  wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,wbunit,wbtype,
  wbdesc,wbspec,wbscrp,wbretn,wbavrg1,wbavrg2,wbbgqt,wbbgat1,wbbgat2,
  wbinqt,wbinat1,wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
  wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,wbusat5,wbusqt6,
  wbusat6,wbusqt7,wbusat7,wbusqt8,wbusat8,wbusat9,wbusqta,wbusata,
  wbplan,wbipaddr,wbmacaddr,wbinptdt,wbupdtdt)
  select a_comltd, a_plant, a_dvsn, a_chdpt,a_citno,p_adjyy,
  p_adjmm,aa.rvno,a_iocd,bb.cls,bb.srce,substr(pdcd,1,2),bb.xunit,
  aa.xtype,aa.itnm,aa.spec, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, p_usqt1, 0, p_usqt2,
  0, p_usqt3, 0, 0, 0, 0, 0, 0,
  0, p_usqt7, 0, 0, 0, 0, 0, 0,
  ' ',a_ipaddr,a_macaddr,a_inptdt,' '
  from pbinv.inv002 aa, pbinv.inv101 bb
  where aa.comltd = bb.comltd and aa.itno = bb.itno and
        bb.comltd = a_comltd and bb.xplant = a_plant and
        bb.div = a_dvsn and bb.itno = a_citno;

  insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
  wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,wbunit,wbtype,
  wbdesc,wbspec,wbscrp,wbretn,wbavrg1,wbavrg2,wbbgqt,wbbgat1,wbbgat2,
  wbinqt,wbinat1,wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
  wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,wbusat5,wbusqt6,
  wbusat6,wbusqt7,wbusat7,wbusqt8,wbusat8,wbusat9,wbusqta,wbusata,
  wbplan,wbipaddr,wbmacaddr,wbinptdt,wbupdtdt)
  select a_comltd, a_plant, a_dvsn, a_chdpt,a_citno,p_nextyy,
  p_nextmm,aa.rvno,a_iocd,bb.cls,bb.srce,substr(pdcd,1,2),bb.xunit,
  aa.xtype,aa.itnm,aa.spec, 0, 0, 0, 0, p_ohqt, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0,
  ' ',a_ipaddr,a_macaddr,a_inptdt,' '
  from pbinv.inv002 aa, pbinv.inv101 bb
  where aa.comltd = bb.comltd and aa.itno = bb.itno and
        bb.comltd = a_comltd and bb.xplant = a_plant and
        bb.div = a_dvsn and bb.itno = a_citno;
end if;
set p_srno = pbwip.sf_wip_000(a_comltd);
if p_srno = '0000000000' then
   return -999999;
end if;

-- Insert wip004
insert into pbwip.wip004(wdcmcd,wdslty,wdsrno,wdplant,wddvsn,
 wdiocd,wditno,wdrvno,wddesc,wdspec,wdunit,wditcl,wdsrce,wdusge,
 wdpdcd,wdslno,wdprsrty,wdprsrno,wdprsrno1,wdprsrno2,wdprno,
 wdprdpt,wdchdpt,wddate,wdprqt,wdchqt,wdipaddr,wdmacaddr,
 wdinptid,wdupdtid,wdinptdt,wdinpttm,wdupdtdt)
select a_comltd,'WC', p_srno, a_plant, a_dvsn, a_iocd, a_citno,
 aa.rvno, aa.itnm, aa.spec, bb.xunit, bb.cls,bb.srce,p_usge,
 substr(pdcd,1,2),a_slno,a_prsrty,a_prsrno,a_prsrno1,a_prsrno2,
 a_pitno, a_prdpt,a_chdpt, a_tdte4, a_tqty4, p_chqt, a_ipaddr,
 a_macaddr,a_inptid,' ',a_inptdt,a_inpttm, ' '
from pbinv.inv002 aa, pbinv.inv101 bb
where aa.comltd = bb.comltd and aa.itno = bb.itno and
      bb.comltd = a_comltd and bb.xplant = a_plant and
      bb.div = a_dvsn and bb.itno = a_citno;

return p_rtnqt;
end
