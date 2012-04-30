select distinct aa.wbplant,aa.wbdvsn,aa.wbpdcd,dd.prname,aa.wbitno,aa.wbdesc,
		aa.wborct,aa.wbitcl,aa.wbsrce,aa.wbunit,
		cc.vndr,cc.vndnm,aa.wbscrp,aa.wbretn
from pbwip.wip002 aa, pbpur.pur101 cc, pbcommon.dac007 dd
where aa.wbcmcd = cc.comltd and cc.comltd = dd.comltd and 
		aa.wbcmcd = '01' and aa.wbpdcd = dd.prprcd and
		aa.wborct = cc.vsrno and aa.wbyear||aa.wbmonth >= '200201' and
      aa.wbyear||aa.wbmonth <= '200302' and aa.wbiocd = '2' and
      not exists (select * from pbwip.wip002 bb
		where aa.wbcmcd = bb.wbcmcd and aa.wbplant = bb.wbplant and
		aa.wbdvsn = bb.wbdvsn and aa.wborct = bb.wborct and
		aa.wbitno = bb.wbitno and bb.wbmonth = '03' and 
		bb.wbyear = '2003' and bb.wbiocd = '2');
