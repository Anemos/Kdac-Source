
SELECT WDPRSRTY, WDPRSRNO, WDPRSRNO1, WDPRSRNO2
FROM { PBWIP.WIP004 EXCEPTION JOIN (select sliptype, srno, srno1, srno2
		from pbinv.inv401
		where comltd = '01' AND 
				XPLANT = 'J' AND 
				DIV = 'S' AND 
				SUBSTR(TDTE4,1,6) = '200212') AAA ON WDPRSRTY = SLIPTYPE AND
								WDPRSRNO = SRNO AND WDPRSRNO1 = SRNO1 AND WDPRSRNO2 = SRNO2}
WHERE WDCMCD = '01' AND WDPLANT = 'J' AND WDDVSN = 'S' AND
		SUBSTR(WDDATE,1,6) = '200212'
GROUP BY WDPRSRTY, WDPRSRNO, WDPRSRNO1,WDPRSRNO2;


