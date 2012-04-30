INSERT INTO PBWIP.WIP001BK
SELECT * FROM PBWIP.WIP001
WHERE WACMCD = '01' AND WAIOCD <> '3';

-- 데이타 조회건
select dd.plant,
  dd.dvsn,
  dd.orct,
  cc.vndnm,
  dd.itno,
  aa.itnm,
  aa.spec,
  bb.cls,
  bb.srce,
  decimal(sum(dd.avrg * bb.convqty),15,0) as avrg,
  decimal(sum(dd.bgqt / bb.convqty),15,4) as bgqt,
  decimal(sum(dd.inqt / bb.convqty),15,4) as inqt,
  decimal(sum(dd.usqt2 / bb.convqty),15,4) as usqt2,
  decimal(sum(dd.usqt3 / bb.convqty),15,4) as usqt3,
  decimal(sum(dd.usqt7 / bb.convqty),15,4) as usqt7,
  decimal(sum(dd.ohqt / bb.convqty),15,4) as ohqt
from pbinv.inv002 aa,   
     pbinv.inv101 bb,
		 pbpur.pur101 cc,  
( select wbplant as plant,
  wbdvsn as dvsn,
  wbitno as itno,
  wborct as orct,
  0 as avrg,
  case wbmonth when '11' then 0 else wbbgqt end as bgqt,
  wbinqt as inqt,
  wbusqt2 as usqt2,
  ( wbusqt3 + wbusqt4 + wbusqt5 + wbusqt6  + wbusqt8 ) as usqt3,
  wbusqt7 as usqt7,
  0 as ohqt
from pbwip.wip002
where wbcmcd = '01' and wbyear = '2007' and wbmonth in ('10','11')
  and wbiocd = '2' and 
  not ( wbbgqt = 0 AND wbbgat1 = 0 AND wbinqt = 0 AND wbinat1 = 0 AND
    wbinat2 = 0 AND wbinat3 = 0 AND wbusqt1 = 0 AND wbusat1 = 0 AND
    wbusqt2 = 0 AND wbusat2 = 0 AND wbusqt3 = 0 AND wbusat3 = 0 AND
    wbusqt4 = 0 AND wbusat4 = 0 AND wbusqt5 = 0 AND wbusat5 = 0 AND
    wbusqt6 = 0 AND wbusat6 = 0 AND wbusqt7 = 0 AND wbusat7 = 0 AND
    wbusqt8 = 0 AND wbusat8 = 0 )
union all
select waplant as plant,
  wadvsn as dvsn,
  waitno as itno,
  waorct as orct,
  waavrg1 as avrg,
  0 as bgqt,
  wainqt as inqt,
  wausqt2 as usqt2,
  ( wausqt3 + wausqt4 + wausqt5 + wausqt6  + wausqt8 ) as usqt3,
  wausqt7 as usqt7,
  waohqt as ohqt
from pbwip.wip001
where wacmcd = '01' and waiocd = '2' and 
  not ( wabgqt = 0 AND wabgat1 = 0 AND wainqt = 0 AND wainat1 = 0 AND
    wainat2 = 0 AND wainat3 = 0 AND wausqt1 = 0 AND wausat1 = 0 AND
    wausqt2 = 0 AND wausat2 = 0 AND wausqt3 = 0 AND wausat3 = 0 AND
    wausqt4 = 0 AND wausat4 = 0 AND wausqt5 = 0 AND wausat5 = 0 AND
    wausqt6 = 0 AND wausat6 = 0 AND wausqt7 = 0 AND wausat7 = 0 AND
    wausqt8 = 0 AND wausat8 = 0 ) ) dd
where aa.comltd = bb.comltd and aa.itno = bb.itno and
  bb.comltd = '01' and bb.xplant = dd.plant and bb.div = dd.dvsn and
  bb.itno = dd.itno and cc.comltd = '01' and cc.scgubun = 'S' and
  cc.vsrno = dd.orct
group by dd.plant,
  dd.dvsn,
  dd.orct,
  cc.vndnm,
  dd.itno,
  aa.itnm,
  aa.spec,
  bb.cls,
  bb.srce

