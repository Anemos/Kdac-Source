select distinct tmp.wbplant, tmp.wbdvsn,tmp.wbitno,tmp.wbdesc,cc.costav,cc.xunit,
  tmp.wbsrce,aa.vsrno, bb.vndnm,tmp.wborct,tmp.vndnm,ff.pqtym,dd.xunit,
	ff.wdprno, ff.itnm, ff.spec, ff.vsrno, ff.vndnm
from (select distinct wbcmcd,wbplant,wbdvsn,
  wborct,vndnm,wbitno,wbdesc,wbsrce
  from pbwip.wip002, pbpur.pur101
  where wbcmcd = comltd and wborct = vsrno and
		wbcmcd = '01' and wbyear >= '2005' and wbyear <= '2006' and
        wbiocd = '2' and wbplant = 'D' and wbdvsn = 'A' and
        not (wbbgqt = 0 and wbinqt = wbusqt3 and
          wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          wbusqt8 = 0 )) tmp 
	left outer join pbpur.pur103 aa
	on tmp.wbcmcd = aa.comltd and tmp.wbitno = aa.itno and aa.xstop <> 'X'
	left outer join pbpur.pur101 bb
	on aa.comltd = bb.comltd and aa.vsrno = bb.vsrno
	left outer join pbinv.inv101 cc
	on cc.comltd = '01' and cc.xplant = tmp.wbplant and
		cc.div = tmp.wbdvsn and cc.itno = tmp.wbitno
	left outer join pbinv.inv002 dd
	on dd.comltd = '01' and dd.itno = tmp.wbitno
	left outer join ( select aa.wdplant as wdplant,aa.wddvsn as wddvsn,
		aa.wditno as wditno,aa.wdchdpt as wdchdpt,aa.wdprno as wdprno,
		bb.pqtym as pqtym, cc.itnm as itnm, cc.spec as spec, dd.vsrno as vsrno,
		ee.vndnm as vndnm
		from (select distinct wdplant,wddvsn, wditno, wdchdpt, wdprno
			from pbwip.wip004
			where wdcmcd = '01' and wdiocd = '2' and wdplant = 'D' and
			wddvsn = 'A' and wddate >= '20050701' and wddate <= '20060531') aa
		inner join pbpdm.bom001 bb
		on aa.wdplant = bb.plant and aa.wddvsn = bb.pdvsn and
			aa.wdprno = bb.ppitn and aa.wditno = bb.pcitn
		inner join pbinv.inv002 cc
		on cc.comltd = '01' and cc.itno = aa.wdprno 
		left outer join pbpur.pur103 dd
		on dd.comltd = '01' and aa.wdprno = dd.itno and dd.xstop <> 'X'
		left outer join pbpur.pur101 ee
		on ee.comltd = '01' and dd.vsrno = ee.vsrno ) ff
	on tmp.wbplant = ff.wdplant and tmp.wbdvsn = ff.wddvsn and 
		tmp.wborct = ff.wdchdpt and tmp.wbitno = ff.wditno
  ;
