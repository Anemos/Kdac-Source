-- file name : sf_wip_001
-- procedure name : pbwip.sf_wip_001
-- desc : bom explosion data -> line add(wip001)

create function pbwip.sf_wip_001 (
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
a_inpttm varchar(6))
returns numeric(15,4)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
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

--Get waohqt
select wausqt1,wausqt2,wausqt3,wausqt7,waohqt
 into p_usqt1,p_usqt2,p_usqt3,p_usqt7,p_ohqt
 from pbwip.wip001
 where wacmcd = a_comltd and waplant = a_plant and
       wadvsn = a_dvsn and waiocd = a_iocd and
       waorct = a_chdpt and waitno = a_citno;
if sqlcode <> 0 then
   set p_ohqt = 0;
   set p_usqt1 = 0;
   set p_usqt2 = 0;
   set p_usqt3 = 0;
   set p_usqt7 = 0;
   set p_chkrow = 'N';
else
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

-- Update wip001
if a_opcd = '2' and a_continue = 'Y' then
  set p_rtnqt = p_ohqt - p_chqt;
  if p_ohqt > 0 then
  	if p_rtnqt < 0 then
     	set p_rtnqt = p_chqt - p_ohqt;
     	set p_chqt = p_ohqt;
    else
      set p_rtnqt = 0;
    end if;
  else
     set p_rtnqt = p_chqt;
     set p_chqt = 0;
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
   update pbwip.wip001
   set wausqt1 = p_usqt1,wausqt2 = p_usqt2,wausqt3 = p_usqt3,
       wausqt7 = p_usqt7,waohqt = p_ohqt
   where wacmcd = a_comltd and
         waplant = a_plant and
         wadvsn = a_dvsn and
         waorct = a_chdpt and
         waitno = a_citno;
else
  insert into pbwip.wip001(wacmcd,waplant,wadvsn,waorct,
  waitno,waiocd,waavrg1,waavrg2,wabgqt,wabgat1,wabgat2,
  wainqt,wainat1,wainat2,wainat3,wainat4,wausqt1,wausat1,
  wausqt2,wausat2,wausqt3,wausat3,wausqt4,wausat4,
  wausqt5,wausat5,wausqt6,wausat6,wausqt7,wausat7,
  wausqt8,wausat8,wausat9,waohqt,waohat1,waohat2,wascrp,
  waretn,waplan,waipaddr,wamacaddr,wainptdt,waupdtdt)
  values (a_comltd,a_plant,a_dvsn,a_chdpt,a_citno,
  a_iocd,0,0,0,0,0,0,0,0,0,0,p_usqt1,0,p_usqt2,0,p_usqt3,0,
  0,0,0,0,0,0,p_usqt7,0,0,0,0,p_ohqt,0,0,0,0,' ',
  a_ipaddr,a_macaddr,a_inptdt,' ');
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
