
//수작업 데이타(2010.12) - 기초금액유지
//SELECT * FROM PBWIP.WIP002
//WHERE WBCMCD = '01' AND WBPLANT = 'B' AND WBDVSN = 'H' AND WBITNO = '25877358' AND WBYEAR = '2011' AND
//WBMONTH IN ('03','04');

//SELECT * FROM PBWIP.WIP001
//WHERE WACMCD = '01' AND WAPLANT = 'B' AND WADVSN = 'H' AND WAITNO = '25877358';

//SELECT WBPLANT,WBDVSN,WBIOCD,SUM(wbbgqt + wbinqt - (wbusqt1 + wbusqt2 +
//       wbusqt3 + wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7 +
//       wbusqt8 + wbusqta)),
//SUM( wbbgat1 + wbinat1 + wbinat2 +
//       wbinat3 + wbinat4 -
//       (wbusat1 + wbusat2 + wbusat3 + wbusat4 + wbusat5 +
//       wbusat6 + wbusat7 + wbusat8 + wbusat9 + wbusata))
//FROM PBWIP.WIP002
//WHERE WBCMCD = '01' AND WBYEAR = '2012' AND WBMONTH = '07'
//GROUP BY WBPLANT,WBDVSN,WBIOCD
//ORDER BY WBIOCD,WBPLANT,WBDVSN;

SELECT WBPLANT,WBDVSN,WBIOCD,SUM(wbbgqt),
SUM( wbbgat1)
FROM PBWIP.WIP002
WHERE WBCMCD = '01' AND WBYEAR = '2012' AND WBMONTH = '08'
GROUP BY WBPLANT,WBDVSN,WBIOCD
ORDER BY WBIOCD,WBPLANT,WBDVSN;
//
//분기 확인
//SELECT WFPLANT,WFDVSN,SUM(WFBGQT + WFINQT - (WFUSQT1 + WFUSQT2 + WFUSQT3)),
//SUM(WFBGAT + WFINAT - (WFUSAT1 + WFUSAT2 + WFUSAT3)),SUM(WFOHQT),SUM(WFOHAT),
//SUM(WFPHQT),SUM(WFPHAT)
//FROM PBWIP.WIP009
//WHERE WFYEAR = '2012' AND WFMONTH = '06'
//GROUP BY WFPLANT,WFDVSN
//ORDER BY WFPLANT,WFDVSN;

//분기데이타검증
//SELECT AA.WBPLANT,AA.WBDVSN,AA.WBORCT,AA.WBITNO,AA.WBBGQT,AA.WBBGAT1,BB.WFOHQT,BB.WFOHAT
//FROM PBWIP.WIP002 AA INNER JOIN PBWIP.WIP009 BB
//	ON AA.WBCMCD = BB.WFCMCD AND AA.WBPLANT = BB.WFPLANT AND
//	AA.WBDVSN = BB.WFDVSN AND AA.WBORCT = BB.WFVENDOR AND
//	AA.WBITNO = BB.WFITNO
//WHERE AA.WBCMCD = '01' AND AA.WBYEAR = '2006' AND AA.WBMONTH = '07' AND AA.WBIOCD = '2' AND
//	BB.WFYEAR = '2006' AND BB.WFMONTH = '06' AND
//	(AA.WBBGQT <> BB.WFOHQT OR
//	AA.WBBGAT1 <> BB.WFOHAT);
//
//잉여(-)재공 이월 검증
//SELECT A.WAPLANT,A.WADVSN,A.WAORCT,A.WAITNO,A.WAUSQT8,B.WFCLQT
//FROM PBWIP.WIP001 A  INNER JOIN PBWIP.WIP009 B
//	ON A.WACMCD = B.WFCMCD AND A.WAPLANT = B.WFPLANT AND
//		A.WADVSN = B.WFDVSN AND A.WAORCT = B.WFVENDOR AND
//		A.WAITNO = B.WFITNO AND A.WAIOCD = '2' AND
//		B.WFYEAR = '2012' AND B.WFMONTH = '06'
//WHERE B.WFCMCD = '01' AND B.WFOHQT < 0 AND B.WFPHQT = 0;
//
//SELECT COUNT(*) FROM PBWIP.WIP004
//WHERE WDCMCD = '01' AND WDSLTY = 'WX' AND WDDATE = '20120701' AND WDINPTID = 'system';