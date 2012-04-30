--file name     : pbwip.sp_wip_01.sql
--system                : kdac system
--procedure name        : sp_wip_01
--initial       : 2003.02.10
--author                : kim ki sub
--desc          : wip001 -> wip002

create procedure pbwip.sp_wip_01
(in a_yy01 varchar(4),
 in a_mm01   varchar(2),
 in a_yy02 varchar(4),
 in a_mm02 varchar(2),
 in a_ipaddr varchar(30),
 in a_macaddr varchar(30),
 in a_inptdt varchar(8),
 in a_updtdt varchar(8))
language sql
begin
declare sqlcode integer default 0;
declare p_chkqty01 decimal(18,4);
declare p_chkamt01 decimal(18,0);
declare p_chkamt02 decimal(18,0);
declare p_chkqty02 decimal(18,4);
declare p_chkamt03 decimal(18,0);
declare p_chkamt04 decimal(18,0);
declare at_end int default 0;
declare not_found condition for '02000';

--check bgqty,bgamt
select ifnull(sum(wabgqt),0),ifnull(sum(wabgat1),0),
       ifnull(sum(wabgat2),0)
into p_chkqty01,p_chkamt01,p_chkamt02
from pbwip.wip001, pbinv.inv101
where wacmcd = comltd and waplant = xplant and
      wadvsn = div and waitno = itno and waiocd in ('1','2') and
      waplant <> 'Y' and cls in ('10','40','50');

select ifnull(sum(wbbgqt),0),ifnull(sum(wbbgat1),0),
       ifnull(sum(wbbgat2),0)
into p_chkqty02,p_chkamt03,p_chkamt04
from pbwip.wip002
where wbcmcd = '01' and wbplant <> 'Y' and wbiocd in ('1','2') and
      wbyear = a_yy01 and wbmonth = a_mm01;

if p_chkqty01 = p_chkqty02 and p_chkamt01 = p_chkamt03 and
   p_chkamt02 = p_chkamt04 then
--delete data current month
delete from pbwip.wip001
where wacmcd = '01' and waplant = 'Y' and waiocd <> '3';

delete from pbwip.wip002
where wbcmcd = '01' and wbyear = a_yy01 and
      wbmonth = a_mm01;

--insert data current month
insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
       wbmacaddr,wbinptdt,wbupdtdt)
select aa.wacmcd,aa.waplant,aa.wadvsn,aa.waorct,aa.waitno,
       a_yy01,a_mm01,dd.rvno,aa.waiocd,dd.cls,dd.srce,
       substr(dd.pdcd,1,2),dd.xunit,dd.xtype,dd.itnm,
       dd.spec,aa.wascrp,aa.waretn,aa.waavrg1,0,aa.wabgqt,aa.wabgat1,
       aa.wabgat2,aa.wainqt,aa.wainat1,aa.wainat2,aa.wainat3,
       aa.wainat4,aa.wausqt1,aa.wausat1,aa.wausqt2,aa.wausat2,
       aa.wausqt3,aa.wausat3,aa.wausqt4,aa.wausat4,aa.wausqt5,
       aa.wausat5,aa.wausqt6,aa.wausat6,aa.wausqt7,aa.wausat7,
       aa.wausqt8,aa.wausat8,aa.wausat9,0,0,' ',a_ipaddr,
       a_macaddr,a_inptdt,a_updtdt
from pbwip.wip001 aa,(select cc.comltd,cc.xplant,cc.div,
       cc.itno,bb.itnm,bb.spec,cc.xunit,bb.rvno,bb.xtype,
       cc.cls,cc.srce,cc.pdcd
       from pbinv.inv002 bb, pbinv.inv101 cc
       where bb.comltd = cc.comltd and
             bb.itno = cc.itno and
             cc.comltd = '01' ) dd
where aa.wacmcd = dd.comltd and aa.waplant = dd.xplant and
      aa.wadvsn = dd.div and aa.waitno = dd.itno and
      dd.cls in ('10','40','50');
--delete data next month
delete from pbwip.wip002
where wbcmcd = '01' and wbyear = a_yy02 and
      wbmonth = a_mm02;
--insert data next month
insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
       wbmacaddr,wbinptdt,wbupdtdt)
select wbcmcd,wbplant,wbdvsn,wborct,wbitno,
       a_yy02,a_mm02,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt + wbinqt - (wbusqt1 + wbusqt2 +
       wbusqt3 + wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7 +
       wbusqt8 + wbusqta), wbbgat1 + wbinat1 + wbinat2 +
       wbinat3 + wbinat4 -
       (wbusat1 + wbusat2 + wbusat3 + wbusat4 + wbusat5 +
       wbusat6 + wbusat7 + wbusat8 + wbusat9 + wbusata),
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,' ',a_ipaddr,a_macaddr,a_inptdt,a_updtdt
from pbwip.wip002
where wbcmcd = '01' and wbyear = a_yy01 and
      wbmonth = a_mm01;
else
 set sqlcode = -1;
end if;
end

