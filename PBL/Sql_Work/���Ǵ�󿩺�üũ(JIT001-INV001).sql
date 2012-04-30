//SELECT AA.XPLANT,AA.DIV,AA.ITNO
//FROM ( SELECT DISTINCT COMLTD,XPLANT,DIV,ITNO FROM PBIPIS.JIT001
//			WHERE COMLTD = '01' AND ITOUT <> 'C' ) AA
//WHERE EXISTS ( SELECT * FROM PBINV.INV101 BB
//		WHERE AA.COMLTD = BB.COMLTD AND AA.XPLANT = BB.XPLANT AND
//				AA.ITNO = BB.ITNO AND BB.KBCD <> 'K' )
//ORDER BY AA.XPLANT,AA.DIV,AA.ITNO
//;

//SELECT * FROM PBIPIS.JIT001
//WHERE COMLTD = '01' AND ITOUT <> 'C' AND
//
//SELECT XPLANT,DIV,ITNO,COUNT(*) FROM PBIPIS.JIT001
//GROUP BY XPLANT,DIV,ITNO
//HAVING COUNT(*) > 1;

//SELECT DD.XPLANT,DD.DIV,DD.ITNO FROM PBINV.INV101 DD
//WHERE DD.COMLTD = '01' AND DD.KBCD <> 'K' AND
//XPLANT||DIV||ITNO IN (
//     SELECT DISTINCT AA.XPLANT||AA.DIV||AA.ITNO AS CHK_ITNO
//     FROM PBIPIS.JIT001 aa,
//	   ( SELECT COMLTD,XPLANT,DIV,ITNO,COUNT(*) FROM PBIPIS.JIT001
//		GROUP BY COMLTD,XPLANT,DIV,ITNO
//		HAVING COUNT(*) > 1 ) tmp
//     	where AA.COMLTD = TMP.COMLTD AND AA.XPLANT = TMP.XPLANT AND
//     	AA.DIV = TMP.DIV AND AA.ITNO = TMP.ITNO AND AA.ITOUT <> 'C') ;

SELECT DD.XPLANT,DD.DIV,DD.ITNO FROM PBINV.INV101 DD
WHERE DD.COMLTD = '01' AND DD.KBCD = 'K' AND
DD.XPLANT||DD.DIV||DD.ITNO IN (
	SELECT tmp_01.chk_itno 
	FROM ( SELECT DISTINCT AA.XPLANT||AA.DIV||AA.ITNO AS CHK_ITNO
     			FROM PBIPIS.JIT001 aa,
	   			( SELECT COMLTD,XPLANT,DIV,ITNO,COUNT(*) FROM PBIPIS.JIT001
						GROUP BY COMLTD,XPLANT,DIV,ITNO
						HAVING COUNT(*) > 1 ) tmp
     			WHERE AA.COMLTD = TMP.COMLTD AND AA.XPLANT = TMP.XPLANT AND
     				AA.DIV = TMP.DIV AND AA.ITNO = TMP.ITNO ) tmp_01
	WHERE tmp_01.CHK_ITNO NOT IN (
     			SELECT DISTINCT AA.XPLANT||AA.DIV||AA.ITNO AS CHK_ITNO2
     			FROM PBIPIS.JIT001 aa,
	   		( SELECT COMLTD,XPLANT,DIV,ITNO,COUNT(*) FROM PBIPIS.JIT001
					GROUP BY COMLTD,XPLANT,DIV,ITNO
					HAVING COUNT(*) > 1 ) tmp
     			where AA.COMLTD = TMP.COMLTD AND AA.XPLANT = TMP.XPLANT AND
     			AA.DIV = TMP.DIV AND AA.ITNO = TMP.ITNO AND AA.ITOUT <> 'C'));


//SELECT KBCD FROM PBINV.INV101
//WHERE COMLTD = '01' AND XPLANT = 'D' AND DIV = 'A' AND ITNO = '25168854';

