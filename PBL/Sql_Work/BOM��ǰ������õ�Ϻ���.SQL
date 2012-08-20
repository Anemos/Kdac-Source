SELECT TMP_BOM.XPLANT,TMP_BOM.DIV, COUNT(*)
FROM ( select distinct bb.xplant,bb.div,bb.itno,bb.itnm,bb.spec,bb.cls,bb.srce
 from pbpdm.bom001 a inner join ( select distinct b.comltd,b.xplant,b.div,b.itno,c.itnm,c.spec,b.cls,b.srce
	  from pbinv.inv401 a inner join pbinv.inv101 b
	  on a.comltd = b.comltd and a.xplant = b.xplant and
		 a.div = b.div and a.itno = b.itno
		inner join pbinv.inv002 c
		on b.comltd = c.comltd and b.itno = c.itno
	  where a.comltd = '01' and 
		 ( b.cls = '30' or b.srce = '03' ) and
		 (a.sliptype = 'RM' or a.sliptype = 'SA' or
		  a.sliptype = 'SR' or a.sliptype = 'IW') and
		 a.tdte4 >= '20120701' and a.tdte4 <= '20120731' ) bb
	on a.pcmcd = bb.comltd and a.plant = bb.xplant and
    a.pdvsn = bb.div and a.ppitn = bb.itno
 where (( a.pedte = ' '  and a.pedtm <= '20120731' ) or
  ( a.pedte <> ' ' and a.pedtm <= '20120731'
                and a.pedte >= '20120731' )) ) TMP_BOM
WHERE EXISTS ( SELECT * FROM ( 
		SELECT DISTINCT RHPLANT,RHDVSN,RHITNO1
		FROM PBRTN.RTN018
		WHERE RHEDTO >= '20120808' AND
				RHEDFM <= RHEDTO AND NOT EXISTS ( SELECT DISTINCT REITNO
		      FROM PBRTN.RTN015
		      WHERE RHPLANT = REPLANT AND RHDVSN = REDVSN AND RHITNO1 = REITNO AND REEDTO >= '20120808' AND
				    REEDFM <= REEDTO  )
		) TMP_RTN
	WHERE TMP_BOM.XPLANT = TMP_RTN.RHPLANT AND TMP_BOM.DIV = TMP_RTN.RHDVSN AND
			TMP_BOM.ITNO = TMP_RTN.RHITNO1 )
GROUP BY TMP_BOM.XPLANT,TMP_BOM.DIV 
ORDER BY TMP_BOM.XPLANT,TMP_BOM.DIV ;

SELECT TMP_BOM.XPLANT,TMP_BOM.DIV, COUNT(*)
FROM ( select distinct bb.xplant,bb.div,bb.itno,bb.itnm,bb.spec,bb.cls,bb.srce
 from pbpdm.bom001 a inner join ( select distinct b.comltd,b.xplant,b.div,b.itno,c.itnm,c.spec,b.cls,b.srce
	  from pbinv.inv401 a inner join pbinv.inv101 b
	  on a.comltd = b.comltd and a.xplant = b.xplant and
		 a.div = b.div and a.itno = b.itno
		inner join pbinv.inv002 c
		on b.comltd = c.comltd and b.itno = c.itno
	  where a.comltd = '01' and 
		 ( b.cls = '30' or b.srce = '03' ) and
		 (a.sliptype = 'RM' or a.sliptype = 'SA' or
		  a.sliptype = 'SR' or a.sliptype = 'IW') and
		 a.tdte4 >= '20120701' and a.tdte4 <= '20120731' ) bb
	on a.pcmcd = bb.comltd and a.plant = bb.xplant and
    a.pdvsn = bb.div and a.ppitn = bb.itno
 where (( a.pedte = ' '  and a.pedtm <= '20120731' ) or
  ( a.pedte <> ' ' and a.pedtm <= '20120731'
                and a.pedte >= '20120731' )) ) TMP_BOM
WHERE EXISTS ( SELECT * FROM ( 
		SELECT DISTINCT REPLANT,REDVSN,REITNO
		FROM PBRTN.RTN015
		WHERE REEDTO >= '20120808' AND
				REEDFM <= REEDTO 
		) TMP_RTN
	WHERE TMP_BOM.XPLANT = TMP_RTN.REPLANT AND TMP_BOM.DIV = TMP_RTN.REDVSN AND
			TMP_BOM.ITNO = TMP_RTN.REITNO )
GROUP BY TMP_BOM.XPLANT,TMP_BOM.DIV 
ORDER BY TMP_BOM.XPLANT,TMP_BOM.DIV ;

-- 리스트 출력
SELECT TMP_BOM.xplant,TMP_BOM.div,TMP_BOM.itno,TMP_BOM.itnm,TMP_BOM.spec,TMP_BOM.cls,TMP_BOM.srce
FROM ( select distinct bb.xplant,bb.div,bb.itno,bb.itnm,bb.spec,bb.cls,bb.srce
 from pbpdm.bom001 a inner join ( select distinct b.comltd,b.xplant,b.div,b.itno,c.itnm,c.spec,b.cls,b.srce
	  from pbinv.inv401 a inner join pbinv.inv101 b
	  on a.comltd = b.comltd and a.xplant = b.xplant and
		 a.div = b.div and a.itno = b.itno
		inner join pbinv.inv002 c
		on b.comltd = c.comltd and b.itno = c.itno
	  where a.comltd = '01' and 
		 ( b.cls = '30' or b.srce = '03' ) and
		 (a.sliptype = 'RM' or a.sliptype = 'SA' or
		  a.sliptype = 'SR' or a.sliptype = 'IW') and
		 a.tdte4 >= '20120701' and a.tdte4 <= '20120731' ) bb
	on a.pcmcd = bb.comltd and a.plant = bb.xplant and
    a.pdvsn = bb.div and a.ppitn = bb.itno
 where (( a.pedte = ' '  and a.pedtm <= '20120731' ) or
  ( a.pedte <> ' ' and a.pedtm <= '20120731'
                and a.pedte >= '20120731' )) ) TMP_BOM
WHERE EXISTS ( SELECT * FROM ( 
		SELECT DISTINCT RHPLANT,RHDVSN,RHITNO
		FROM PBRTN.RTN018
		WHERE RHEDTO >= '20120808' AND
				RHEDFM <= RHEDTO 
		) TMP_RTN
	WHERE TMP_BOM.XPLANT = TMP_RTN.RHPLANT AND TMP_BOM.DIV = TMP_RTN.RHDVSN AND
			TMP_BOM.ITNO = TMP_RTN.RHITNO );