select distinct tmp.wbplant, tmp.wbdvsn,tmp.wbitno,tmp.wbdesc,
aa.vsrno, bb.vndnm,tmp.wbsrce,cc.costav,cc.xunit,
ff.pqtym, dd.wascrp,
ff.wdprno, ff.itnm, ff.prname, ff.costav, ff.vsrno, ff.vndnm
from ( select distinct aa.wbcmcd as wbcmcd,aa.wbplant as wbplant,aa.wbdvsn as wbdvsn,
  aa.wborct as wborct,bb.vndnm as vndnm,aa.wbitno as wbitno,aa.wbdesc as wbdesc,
	aa.wbsrce as wbsrce
  from ( select wbcmcd,wbplant,wbdvsn,
  			wborct,wbitno,wbdesc,
  			wbsrce
  			from pbwip.wip002
  			where wbcmcd = '01' and wbyear = '2005' and wbmonth >= '08' and
        		wbiocd = '2' and wbplant = 'D' and wbdvsn = 'M' and
        		not (wbbgqt = 0 and wbinqt = wbusqt3 and
          		wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          		wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          		wbusqt8 = 0 )
			union all
			select wbcmcd,wbplant,wbdvsn,
  				wborct,wbitno,wbdesc,
  				wbsrce
  				from pbwip.wip002
  			where wbcmcd = '01' and wbyear = '2006' and wbmonth <= '07' and
        		wbiocd = '2' and wbplant = 'D' and wbdvsn = 'M' and
        		not (wbbgqt = 0 and wbinqt = wbusqt3 and
          		wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          		wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          		wbusqt8 = 0 )
		) aa inner join pbpur.pur101 bb
	on aa.wbcmcd = bb.comltd and aa.wborct = bb.vsrno
	 ) tmp
	left outer join pbpur.pur103 aa
	on tmp.wbcmcd = aa.comltd and tmp.wbitno = aa.itno and aa.xstop <> 'X'
	left outer join pbpur.pur101 bb
	on aa.comltd = bb.comltd and aa.vsrno = bb.vsrno
	left outer join pbinv.inv101 cc
	on cc.comltd = '01' and cc.xplant = tmp.wbplant and
		cc.div = tmp.wbdvsn and cc.itno = tmp.wbitno
	left outer join pbwip.wip001 dd
	on dd.wacmcd = tmp.wbcmcd and dd.waplant = tmp.wbplant and
		dd.wadvsn = tmp.wbdvsn and dd.waorct = tmp.wborct and
		dd.waitno = tmp.wbitno
	left outer join ( select aa.wdplant as wdplant,aa.wddvsn as wddvsn,
		aa.wditno as wditno,aa.wdchdpt as wdchdpt,aa.wdprno as wdprno,
		bb.pqtym as pqtym, cc.itnm as itnm, cc.spec as spec, dd.vsrno as vsrno,
		ee.vndnm as vndnm, kk.costav as costav, pp.prname as prname
		from (select distinct wdplant,wddvsn, wditno, wdchdpt, wdprno
			from pbwip.wip004
			where wdcmcd = '01' and wdiocd = '2' and wdplant = 'D' and
			wddvsn = 'M' and wddate >= '20050801' and wddate <= '20060731') aa
		inner join pbpdm.bom001 bb
		on aa.wdplant = bb.plant and aa.wddvsn = bb.pdvsn and
			aa.wdprno = bb.ppitn and aa.wditno = bb.pcitn
		inner join pbinv.inv002 cc
		on cc.comltd = '01' and cc.itno = aa.wdprno 
		inner join pbinv.inv101 kk
		on kk.comltd = '01' and kk.xplant = aa.wdplant and
			kk.div = aa.wddvsn and kk.itno = aa.wdprno
		inner join pbcommon.dac007 pp
		on pp.comltd = kk.comltd and pp.prprcd = kk.pdcd
		left outer join pbpur.pur103 dd
		on dd.comltd = '01' and aa.wdprno = dd.itno and dd.xstop <> 'X'
		left outer join pbpur.pur101 ee
		on ee.comltd = '01' and dd.vsrno = ee.vsrno ) ff
	on tmp.wbplant = ff.wdplant and tmp.wbdvsn = ff.wddvsn and 
		tmp.wborct = ff.wdchdpt and tmp.wbitno = ff.wditno
  ;
