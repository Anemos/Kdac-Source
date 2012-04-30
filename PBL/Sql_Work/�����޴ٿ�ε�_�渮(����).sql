select distinct tmp.vndnm,tmp.vndr,tmp.wbplant, tmp.wbdvsn,tmp.pdcd,tmp.prname,tmp.wbitno,tmp.wbdesc,tmp.wbitcl,tmp.wbsrce,
cc.xunit, ff.pdcd, ff.wdprno, ff.itnm, ff.xunit, ff.wdprqt
from ( select aa.wbcmcd as wbcmcd,aa.wbplant as wbplant,aa.wbdvsn as wbdvsn,
  aa.wborct as wborct,bb.vndnm as vndnm,bb.vndr as vndr,aa.wbitno as wbitno,aa.wbpdcd as pdcd,dd.prname as prname,aa.wbdesc as wbdesc,
	aa.wbsrce as wbsrce,aa.wbitcl as wbitcl, sum(DECIMAL(aa.wbinqt / cc.convqty,15,4) ) as inqt
  from pbwip.wip002 aa inner join pbpur.pur101 bb
	on aa.wbcmcd = bb.comltd and aa.wborct = bb.vsrno
	inner join pbinv.inv101 cc
	on aa.wbcmcd = cc.comltd and aa.wbplant = cc.xplant and
		aa.wbdvsn = cc.div and aa.wbitno = cc.itno
	left outer join pbcommon.dac007 dd
	on aa.wbcmcd = dd.comltd and aa.wbpdcd = dd.prprcd
  where aa.wbcmcd = '01' and aa.wbyear = '2009' and aa.wbmonth = '10' and
        aa.wbiocd = '2' and
        not (aa.wbbgqt = 0 and aa.wbinqt = aa.wbusqt3 and
          aa.wbusqt1 = 0 and aa.wbusqt2 = 0 and aa.wbusqt4 = 0 and
          aa.wbusqt5 = 0 and aa.wbusqt6 = 0 and aa.wbusqt7 = 0 and
          aa.wbusqt8 = 0 )
  group by aa.wbcmcd,aa.wbplant ,aa.wbdvsn ,
  aa.wborct ,bb.vndnm, bb.vndr,aa.wbitno ,aa.wbpdcd,dd.prname,aa.wbdesc ,
	aa.wbsrce, aa.wbitcl ) tmp
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
		bb.pqtym as pqtym, cc.itnm as itnm, cc.spec as spec, oo.xplan as xplan, 
		oo.pdcd as pdcd, oo.cls as cls, oo.srce as srce, oo.xunit as xunit, DECIMAL(aa.wdprqt,15,4) as wdprqt
		from (select a.wdcmcd as wdcmcd,a.wdplant as wdplant,a.wddvsn as wddvsn,a.wdchdpt as wdchdpt,
	      a.wditno as wditno,a.wdprno as wdprno, sum(a.wdprqt) as wdprqt
        from (select distinct wdcmcd,wdplant,wddvsn,wdchdpt,wditno,wdprno,wdprsrty,wdprsrno,wdprsrno1,wdprsrno2,wdprqt
          from pbwip.wip004
          where wdcmcd = '01' and wdslty = 'WC' and wdiocd = '2' and wddate >= '20091001' and wddate <= '20091031' ) a
        group by a.wdcmcd,a.wdplant,a.wddvsn,a.wdchdpt,a.wditno,a.wdprno) aa
		inner join pbpdm.bom001 bb
		on aa.wdplant = bb.plant and aa.wddvsn = bb.pdvsn and
			aa.wdprno = bb.ppitn and aa.wditno = bb.pcitn
		inner join pbinv.inv002 cc
		on cc.comltd = '01' and cc.itno = aa.wdprno 
		left outer join pbpur.pur103 dd
		on dd.comltd = '01' and aa.wdprno = dd.itno and dd.xstop <> 'X'
		left outer join pbinv.inv101 oo
		on aa.wdcmcd = oo.comltd and aa.wdplant = oo.xplant and
		aa.wddvsn = oo.div and aa.wdprno = oo.itno ) ff
	on tmp.wbplant = ff.wdplant and tmp.wbdvsn = ff.wddvsn and 
		tmp.wborct = ff.wdchdpt and tmp.wbitno = ff.wditno
  ;
