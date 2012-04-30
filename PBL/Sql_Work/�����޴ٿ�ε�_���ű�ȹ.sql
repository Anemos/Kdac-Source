select distinct tmp.wbplant, tmp.wbdvsn,tmp.wbitno,tmp.wbdesc,cc.costav,cc.xunit,
  tmp.wbsrce, tmp.inqt, aa.vsrno, bb.vndnm, tmp.wborct, tmp.vndnm, ff.pqtym, dd.xunit,
	ff.wdprno, ff.itnm, ff.spec, ff.vsrno, ff.vndnm, ff.xplan, ff.coitname
from ( select aa.wbcmcd as wbcmcd,aa.wbplant as wbplant,aa.wbdvsn as wbdvsn,
  aa.wborct as wborct,bb.vndnm as vndnm,aa.wbitno as wbitno,aa.wbdesc as wbdesc,
	aa.wbsrce as wbsrce, sum(DECIMAL(aa.wbinqt / cc.convqty,15,4) ) as inqt
  from pbwip.wip002 aa inner join pbpur.pur101 bb
	on aa.wbcmcd = bb.comltd and aa.wborct = bb.vsrno
	inner join pbinv.inv101 cc
	on aa.wbcmcd = cc.comltd and aa.wbplant = cc.xplant and
		aa.wbdvsn = cc.div and aa.wbitno = cc.itno
  where aa.wbcmcd = '01' and aa.wbyear >= '2005' and aa.wbyear <= '2006' and
        aa.wbiocd = '2' and aa.wbplant = 'D' and aa.wbdvsn = 'A' and
        not (aa.wbbgqt = 0 and aa.wbinqt = aa.wbusqt3 and
          aa.wbusqt1 = 0 and aa.wbusqt2 = 0 and aa.wbusqt4 = 0 and
          aa.wbusqt5 = 0 and aa.wbusqt6 = 0 and aa.wbusqt7 = 0 and
          aa.wbusqt8 = 0 )
  group by aa.wbcmcd,aa.wbplant ,aa.wbdvsn ,
  aa.wborct ,bb.vndnm ,aa.wbitno ,aa.wbdesc ,
	aa.wbsrce ) tmp
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
		ee.vndnm as vndnm, oo.xplan as xplan, pp.coitname as coitname
		from (select distinct wdcmcd,wdplant,wddvsn, wditno, wdchdpt, wdprno
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
		on ee.comltd = '01' and dd.vsrno = ee.vsrno
		left outer join pbinv.inv101 oo
		on aa.wdcmcd = oo.comltd and aa.wdplant = oo.xplant and
		aa.wddvsn = oo.div and aa.wdprno = oo.itno
		inner join pbcommon.dac002 pp
		on pp.comltd = oo.comltd and pp.cocode = oo.xplan and
		pp.cogubun = 'INV050' ) ff
	on tmp.wbplant = ff.wdplant and tmp.wbdvsn = ff.wddvsn and 
		tmp.wborct = ff.wdchdpt and tmp.wbitno = ff.wditno
  ;
