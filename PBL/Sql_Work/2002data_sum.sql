select aa.wbplant,aa.wbdvsn,aa.wborct,cc.vndnm,aa.wbitno, aa.wbdesc, aa.wbspec,aa.wbitcl,
aa.wbsrce,aa.wbpdcd, bb.bgqt, bb.bgat, bb.inqt,bb.inat, bb.usqt1,bb.usat1,
bb.usqt2,bb.usat2,bb.usqt3,bb.usat3,bb.usqt4,bb.usat4,bb.usqt5,bb.usat5,
bb.usqt6,bb.usat6,bb.usqt7,bb.usat7,bb.usqt8,bb.usat8,bb.usqta,bb.usata,
aa.wbbgqt, aa.wbbgat1
from pbwip.wip002 aa,pbpur.pur101 cc, (select wbplant,wbdvsn,wborct,wbitno,
	sum(pbcommon.f_if(wbmonth,'01',wbbgqt / convqty,0)) as bgqt,
   sum(pbcommon.f_if(wbmonth,'01',wbbgat1,0)) as bgat,
	sum(wbinqt / convqty) as inqt, 
   sum(wbinat1) as inat,
   sum(wbusqt1 / convqty) as usqt1, 
   sum(wbusqt1 * wbavrg1) as usat1,
	sum(wbusqt2 / convqty) as usqt2,
   sum(wbusqt2 * wbavrg1) as usat2,
   sum(wbusqt3 / convqty) as usqt3,
	sum(wbusat3) as usat3,
	sum(wbusqt4 / convqty) as usqt4,
	sum(wbusat4) as usat4,   
	sum(wbusqt5 / convqty) as usqt5,
	sum(wbusat5) as usat5,
	sum(wbusqt6 / convqty) as usqt6,
	sum(wbusat6) as usat6,
   sum(wbusqt7 / convqty) as usqt7,
	sum(wbusat7) as usat7,
	sum(wbusqt8 / convqty) as usqt8,
	sum(wbusat8) as usat8,
   sum(wbusqta / convqty) as usqta,
	sum(wbusata) as usata
 	from pbwip.wip050 , pbinv.inv101
	where wbcmcd = comltd and wbplant = xplant and wbdvsn = div and
         wbitno = itno and wbiocd = '2' and
         wbcmcd = '01' and wbplant = 'D' and wbdvsn = 'S'
   group by wbplant,wbdvsn,wborct,wbitno) bb
where aa.wbcmcd = '01' and aa.wbplant = bb.wbplant and 
      aa.wbdvsn = bb.wbdvsn and aa.wborct = bb.wborct and
      aa.wbitno = bb.wbitno and 
      cc.comltd = '01' and cc.vsrno = aa.wborct and
      cc.scgubun = 'S' and aa.wbmonth = '01' and aa.wbyear = '2003'
order by aa.wborct,aa.wbpdcd,aa.wbitno;


