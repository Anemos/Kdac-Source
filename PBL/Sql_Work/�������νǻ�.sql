SELECT AA.WBPLANT,
      AA.WBDVSN,
      SUM(( AA.WBBGQT + AA.WBINQT - ( AA.WBUSQT1 + AA.WBUSQT2 + AA.WBUSQT3 +
        AA.WBUSQT4 + AA.WBUSQT5 + AA.WBUSQT6 + AA.WBUSQT7 + AA.WBUSQT8 )
        )) AS CUR_QTY,
      SUM(( AA.WBBGAT1 + AA.WBINAT1 + AA.WBINAT2 + AA.WBINAT3 - ( AA.WBUSAT1 +
        AA.WBUSAT2 + AA.WBUSAT3 + AA.WBUSAT4 + AA.WBUSAT5 + AA.WBUSAT6 +
        AA.WBUSAT7 + AA.WBUSAT8 + AA.WBUSAT9 ))) AS CUR_AMT,
      SUM(AA.WFPHQT) AS BET_QTY,
      SUM(DECIMAL( AA.WFPHQT * AA.WBAVRG1, 15, 0)) AS BET_AMT,
		SUM(( ( AA.WBBGQT + AA.WBINQT - ( AA.WBUSQT1 + AA.WBUSQT2 + AA.WBUSQT3 +
        AA.WBUSQT4 + AA.WBUSQT5 + AA.WBUSQT6 + AA.WBUSQT7 + AA.WBUSQT8 )
        ) - AA.WFPHQT )) AS DIFFQTA,
      SUM(DECIMAL(( ( AA.WBBGAT1 + AA.WBINAT1 + AA.WBINAT2 + AA.WBINAT3 - ( AA.WBUSAT1 +
        AA.WBUSAT2 + AA.WBUSAT3 + AA.WBUSAT4 + AA.WBUSAT5 + AA.WBUSAT6 +
        AA.WBUSAT7 + AA.WBUSAT8 + AA.WBUSAT9 )) - (AA.WFPHQT * AA.WBAVRG1)), 15,0)) AS DIFFATA
		
FROM
( SELECT WBCMCD,WBYEAR,WBMONTH,WBPLANT,WBDVSN,WBITNO,WBORCT,WBPDCD,WBITCL,WBSRCE,WBSCRP,WBRETN,
  		WBAVRG1,WBBGQT,WBBGAT1,WBINQT,WBINAT1,WBINAT2,WBINAT3,
  		WBUSQT1,WBUSAT1,WBUSQT2,WBUSAT2,WBUSQT3,WBUSAT3,WBUSQT4,WBUSAT4,
  		WBUSQT5,WBUSAT5,WBUSQT6,WBUSAT6,WBUSQT7,WBUSAT7,WBUSQT8,WBUSAT8,
  		WBUSAT9,IFNULL(TMP_006.WFPHQT,0) AS WFPHQT
	FROM PBWIP.WIP002 LEFT OUTER JOIN 
	  ( SELECT WFCMCD,WFPLANT,WFDVSN,WFYEAR,WFMONTH,WFITNO,WFDEPT,WFPHQT
      FROM PBWIP.WIP006 INNER JOIN PBINV.INV101
        ON WFCMCD = COMLTD AND WFPLANT = XPLANT AND WFDVSN = DIV 
          AND WFITNO = ITNO AND CLS <> '30' AND CLS <> '50' 
          AND SRCE <> '03' ) TMP_006
    	ON WBCMCD = TMP_006.WFCMCD   AND WBPLANT = TMP_006.WFPLANT AND
        WBDVSN = TMP_006.WFDVSN   AND WBYEAR = TMP_006.WFYEAR AND
        WBMONTH = TMP_006.WFMONTH AND WBITNO = TMP_006.WFITNO AND 
        WBORCT = TMP_006.WFDEPT
	WHERE WBCMCD = '01'  AND WBYEAR = '2005' AND
      	WBMONTH = '12'  AND WBORCT = '9999' ) AA
	INNER JOIN PBINV.INV101 BB
	ON AA.WBCMCD = BB.COMLTD AND AA.WBPLANT = BB.XPLANT AND
      AA.WBDVSN = BB.DIV    AND AA.WBITNO  = BB.ITNO
	INNER JOIN PBINV.INV002 CC
	ON AA.WBCMCD = CC.COMLTD AND AA.WBITNO = CC.ITNO
	LEFT OUTER JOIN PBWIP.WIP013 DD
	ON AA.WBCMCD = DD.WBCMCD AND AA.WBPLANT = DD.WBPLANT AND
		AA.WBDVSN = DD.WBDVSN AND AA.WBYEAR = DD.WBYEAR AND
		AA.WBMONTH = DD.WBMONTH AND AA.WBITNO = DD.WBITNO
GROUP BY AA.WBPLANT,AA.WBDVSN
ORDER BY AA.WBPLANT,AA.WBDVSN;

-- 재공이월DB에 존재하지 않는 데이타 생성하기
insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
			 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
			 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
			 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
			 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
			 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
			 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
			 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
			 wbmacaddr,wbinptdt,wbupdtdt)
select bb.comltd,bb.xplant,bb.div,aa.wfdept,bb.itno,
			 aa.wfyear,aa.wfmonth,cc.rvno,'1',bb.cls,bb.srce,substring(bb.pdcd,1,2),
			 bb.xunit,cc.xtype,cc.itnm,cc.spec,0,0,bb.costav,
			 0,0, 0,
			 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,' ','','','',''
from pbwip.wip006 aa inner join pbinv.inv101 bb
      on aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and aa.wfdvsn = bb.div 
        and aa.wfitno = bb.itno and bb.cls <> '30' and bb.cls <> '50' 
        and bb.srce <> '03'
      inner join pbinv.inv002 cc
      on bb.comltd = cc.comltd and bb.itno = cc.itno
where aa.wfcmcd = '01' and aa.wfyear = '2008' and aa.wfmonth = '12' and 
  aa.wfdept = '9999' and aa.wfphqt <> 0 and
	not exists ( select * from pbwip.wip002
		where wbcmcd= aa.wfcmcd and wbyear = aa.wfyear and wbmonth = aa.wfmonth and
			wbplant = aa.wfplant and wbdvsn = aa.wfdvsn and wbitno = aa.wfitno and
			wborct = aa.wfdept )
;

-- 재공이월DB 미존제 데이타 이월하기
insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
			 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
			 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
			 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
			 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
			 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
			 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
			 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
			 wbmacaddr,wbinptdt,wbupdtdt)
select aa.wbcmcd,aa.wbplant,aa.wbdvsn,aa.wborct,aa.wbitno,
			 '2009','01',aa.wbrev,aa.wbiocd,aa.wbitcl,aa.wbsrce,aa.wbpdcd,
			 aa.wbunit,aa.wbtype,aa.wbdesc,aa.wbspec,aa.wbscrp,aa.wbretn,aa.wbavrg1,
			 aa.wbavrg2,aa.wbbgqt,aa.wbbgat1,aa.wbbgat2,aa.wbinqt,aa.wbinat1,
			 aa.wbinat2,aa.wbinat3,aa.wbinat4,aa.wbusqt1,aa.wbusat1,aa.wbusqt2,
			 aa.wbusat2,aa.wbusqt3,aa.wbusat3,aa.wbusqt4,aa.wbusat4,aa.wbusqt5,
			 aa.wbusat5,aa.wbusqt6,aa.wbusat6,aa.wbusqt7,aa.wbusat7,aa.wbusqt8,
			 aa.wbusat8,aa.wbusat9,aa.wbusqta,aa.wbusata,aa.wbplan,aa.wbipaddr,
			 aa.wbmacaddr,aa.wbinptdt,aa.wbupdtdt 
from pbwip.wip002 aa
where aa.wbcmcd = '01' and aa.wbyear = '2008' and aa.wbmonth = '12' and
aa.wbiocd = '1' and not exists ( select * from pbwip.wip002 bb
		where bb.wbcmcd = '01' and bb.wbyear = '2009' and bb.wbmonth = '01' and bb.wbiocd = '1' and
			aa.wbcmcd = bb.wbcmcd and aa.wbplant = bb.wbplant and aa.wbdvsn = bb.wbdvsn and
			aa.wbitno = bb.wbitno );
			
-- 현재 wip001 에 미존재하는 품번 생성하기
insert into pbwip.wip001(wacmcd,waplant,wadvsn,waorct,
  waitno,waiocd,waavrg1,waavrg2,wabgqt,wabgat1,wabgat2,
  wainqt,wainat1,wainat2,wainat3,wainat4,wausqt1,wausat1,
  wausqt2,wausat2,wausqt3,wausat3,wausqt4,wausat4,
  wausqt5,wausat5,wausqt6,wausat6,wausqt7,wausat7,
  wausqt8,wausat8,wausat9,waohqt,waohat1,waohat2,wascrp,
  waretn,waplan,waipaddr,wamacaddr,wainptdt,waupdtdt)
select aa.wbcmcd,aa.wbplant,aa.wbdvsn,aa.wborct,
  aa.wbitno,aa.wbiocd,aa.wbavrg1,aa.wbavrg2,aa.wbbgqt,aa.wbbgat1,aa.wbbgat2,
  aa.wbinqt,aa.wbinat1,aa.wbinat2,aa.wbinat3,aa.wbinat4,aa.wbusqt1,aa.wbusat1,
  aa.wbusqt2,aa.wbusat2,aa.wbusqt3,aa.wbusat3,aa.wbusqt4,aa.wbusat4,
  aa.wbusqt5,aa.wbusat5,aa.wbusqt6,aa.wbusat6,aa.wbusqt7,aa.wbusat7,
  aa.wbusqt8,aa.wbusat8,aa.wbusat9,aa.wbbgqt,aa.wbbgat1,0,0,
  0,aa.wbplan,aa.wbipaddr,aa.wbmacaddr,aa.wbinptdt,aa.wbupdtdt 
from pbwip.wip002 aa
where aa.wbcmcd = '01' and aa.wbyear = '2009' and aa.wbmonth = '01' and
aa.wbiocd = '1' and not exists ( select * from pbwip.wip001 bb
		where bb.wacmcd = '01' and bb.waiocd = '1' and
			aa.wbcmcd = bb.wacmcd and aa.wbplant = bb.waplant and aa.wbdvsn = bb.wadvsn and
			aa.wbitno = bb.waitno );