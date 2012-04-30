select distinct tmp.wbplant, tmp.wbdvsn,tmp.wbitno,tmp.wbdesc,cc.pdcd,dd.wascrp,
tmp.wborct, bb.vndnm,cc.cls,cc.srce
from ( select distinct aa.wbcmcd as wbcmcd,aa.wbplant as wbplant,aa.wbdvsn as wbdvsn,
  aa.wborct as wborct,aa.wbitno as wbitno,aa.wbdesc as wbdesc,
	aa.wbsrce as wbsrce
  from ( select wbcmcd,wbplant,wbdvsn,
  			wborct,wbitno,wbdesc,
  			wbsrce
  			from pbwip.wip002
  			where wbcmcd = '01' and wbyear = '2007' and wbmonth >= '01' and
        		wbiocd = '2' and wbplant = 'D' and wbdvsn = 'A' and
        		not (wbbgqt = 0 and wbinqt = wbusqt3 and
          		wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          		wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          		wbusqt8 = 0 )
			union all
			select wbcmcd,wbplant,wbdvsn,
  				wborct,wbitno,wbdesc,
  				wbsrce
  				from pbwip.wip002
  			where wbcmcd = '01' and wbyear = '2008' and wbmonth <= '07' and
        		wbiocd = '2' and wbplant = 'D' and wbdvsn = 'A' and
        		not (wbbgqt = 0 and wbinqt = wbusqt3 and
          		wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
          		wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
          		wbusqt8 = 0 )
		) aa
	 ) tmp
	left outer join pbpur.pur101 bb
	on tmp.wbcmcd = bb.comltd and tmp.wborct = bb.vsrno
	left outer join pbinv.inv101 cc
	on cc.comltd = '01' and cc.xplant = tmp.wbplant and
		cc.div = tmp.wbdvsn and cc.itno = tmp.wbitno
	left outer join pbwip.wip001 dd
	on dd.wacmcd = tmp.wbcmcd and dd.waplant = tmp.wbplant and
		dd.wadvsn = tmp.wbdvsn and dd.waorct = tmp.wborct and
		dd.waitno = tmp.wbitno
	//유무상자재구분
	inner join pbinv.inv108 ee
	on ee.comltd = tmp.wbcmcd and ee.xplant = tmp.wbplant and
		ee.div = tmp.wbdvsn and ee.vsrno = tmp.wborct and
		ee.itno = tmp.wbitno and ee.gubun = 'Y'
  ;
