SELECT distinct comltd,xplant,div,itno
   FROM pbinv.inv101, pbpdm.bom001
   WHERE pcmcd = comltd and plant = xplant and
			pdvsn = div and ppitn = itno and
			comltd = :a_cmcd and xplant = :a_plant and 
			div = :a_dvsn and cls = '30'

UNION ALL

SELECT DISTINCT TMP.COMLTD,TMP.XPLANT,TMP.DIV,TMP.ITNO
FROM (SELECT distinct comltd,xplant,div,itno
   					FROM pbinv.inv101, pbpdm.bom001
   					WHERE pcmcd = comltd and plant = xplant and
								pdvsn = div and ppitn = itno and
								comltd = :a_cmcd and xplant = :a_plant and
								div = :a_dvsn and cls = '10' AND SRCE = '03') TMP
WHERE NOT EXISTS (SELECT * FROM PBPDM.BOM001 BB
				WHERE BB.PCMCD = TMP.COMLTD AND BB.PLANT = TMP.XPLANT AND
						BB.PDVSN = TMP.DIV AND BB.PCITN = TMP.ITNO )