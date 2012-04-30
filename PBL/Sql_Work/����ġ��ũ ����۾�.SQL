SELECT aaa."WBYEAR",  
aaa."WBMONTH",
aaa."WBITNO",  
"PBINV"."INV101"."PDCD",
"PBCOMMON"."DAC007"."PRNAME",      
"PBINV"."INV002"."ITNM",   
"PBINV"."INV002"."SPEC",
"PBINV"."INV101"."CLS",   
"PBINV"."INV101"."SRCE",
"PBINV"."INV101"."XUNIT",  
"PBINV"."INV101"."CONVQTY",
DECIMAL( aaa."WBAVRG1" * "PBINV"."INV101"."CONVQTY" ,15,5 ) as avrg, 
SUM ( DECIMAL(aaa."WBBGQT" / "PBINV"."INV101"."CONVQTY",15,4) ) as bgqt, 
SUM ( aaa."WBBGAT1" ) as bgat,    
SUM ( DECIMAL( aaa."WBINQT" / "PBINV"."INV101"."CONVQTY",15,4) ) as inqt,  
SUM ( aaa."WBINAT1" + aaa."WBINAT2" + aaa."WBINAT3" ) as inat,   
SUM ( DECIMAL(aaa."WBUSQT1" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt1,   
SUM ( aaa."WBUSAT1" ) as usat1,   
SUM ( DECIMAL(aaa."WBUSQT2" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt2,   
SUM ( aaa."WBUSAT2" ) as usat2,   
SUM ( DECIMAL(aaa."WBUSQT3" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt3,   
SUM ( aaa."WBUSAT3" ) as usat3,   
SUM ( DECIMAL(aaa."WBUSQT4" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt4,   
SUM ( aaa."WBUSAT4" ) as usat4,   
SUM ( DECIMAL(aaa."WBUSQT5" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt5,   
SUM ( aaa."WBUSAT5" ) as usat5,   
SUM ( DECIMAL(aaa."WBUSQT6" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt6,   
SUM ( aaa."WBUSAT6" ) as usat6,   
SUM ( DECIMAL(aaa."WBUSQT7" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt7,   
SUM ( aaa."WBUSAT7" ) as usat7,   
SUM ( DECIMAL(aaa."WBUSQT8" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqt8,   
SUM ( aaa."WBUSAT8" ) as usat8,   
SUM ( aaa."WBUSAT9" ) as usat9,
SUM ( DECIMAL(aaa."WBUSQTA" / "PBINV"."INV101"."CONVQTY",15,4) ) as usqta,
SUM ( aaa."WBUSATA" ) as usata,
SUM ( DECIMAL(( aaa."WBBGQT" + aaa."WBINQT" - 
		(aaa."WBUSQT1" + aaa."WBUSQT2" + aaa."WBUSQT3" + aaa."WBUSQT4" + aaa."WBUSQT5" + 
		aaa."WBUSQT6" + aaa."WBUSQT7" + aaa."WBUSQT8" + aaa."WBUSQTA")) / "PBINV"."INV101"."CONVQTY",15,4)) as ohqt, 
SUM ( ( aaa."WBBGAT1" + aaa."WBINAT1" + aaa."WBINAT2" + aaa."WBINAT3" - 
		(aaa."WBUSAT1" + aaa."WBUSAT2" + aaa."WBUSAT3" + aaa."WBUSAT4" + aaa."WBUSAT5" + 
		aaa."WBUSAT6" + aaa."WBUSAT7" + aaa."WBUSAT8" + aaa."WBUSAT9" + aaa."WBUSATA")) ) as ohat

    FROM "PBWIP"."WIP002" aaa,    
         "PBINV"."INV002",   
         "PBINV"."INV101",
			"PBWIP"."WIP015",
         "PBCOMMON"."DAC007"
			
   WHERE ( aaa."WBCMCD" = "PBINV"."INV002"."COMLTD" ) and  
         ( aaa."WBITNO" = "PBINV"."INV002"."ITNO" ) and  
         ( aaa."WBCMCD" = "PBINV"."INV101"."COMLTD" ) and  
         ( aaa."WBPLANT" = "PBINV"."INV101"."XPLANT" ) and  
         ( aaa."WBDVSN" = "PBINV"."INV101"."DIV" ) and  
         ( aaa."WBITNO" = "PBINV"."INV101"."ITNO" ) and
			( aaa."WBCMCD" = "PBWIP"."WIP015"."TCMCD" ) and  
         ( aaa."WBPLANT" = "PBWIP"."WIP015"."TPLNT" ) and  
         ( aaa."WBDVSN" = "PBWIP"."WIP015"."TDVSN" ) and  
         ( aaa."WBITNO" = "PBWIP"."WIP015"."TCITN" ) and 
			( "PBWIP"."WIP015"."TLEVEL" = 0 ) and 
         ( aaa."WBCMCD" = "PBCOMMON"."DAC007"."COMLTD" ) and  
         ( "PBINV"."INV101"."PDCD" = "PBCOMMON"."DAC007"."PRPRCD" ) and  
         ( ( aaa."WBCMCD" = '01' ) AND 
			( aaa."WBYEAR" IN ('2005','2006','2007','2008') ) AND 
         ( aaa."WBPLANT" = 'D' ) AND  
         ( aaa."WBDVSN" = 'M' ) AND   
			( aaa."WBIOCD" <> '3' ) AND  
         NOT ( aaa."WBBGQT"= 0 AND aaa."WBBGAT1" = 0 AND aaa."WBINQT" = 0 AND aaa."WBINAT1" = 0 AND
           aaa."WBINAT2" = 0 AND aaa."WBINAT3" = 0 AND aaa."WBUSQT1" = 0 AND aaa."WBUSAT1" = 0 AND
           aaa."WBUSQT2" = 0 AND aaa."WBUSAT2" = 0 AND aaa."WBUSQT3" = 0 AND aaa."WBUSAT3" = 0 AND
           aaa."WBUSQT4" = 0 AND aaa."WBUSAT4" = 0 AND aaa."WBUSQT5" = 0 AND aaa."WBUSAT5" = 0 AND
           aaa."WBUSQT6" = 0 AND aaa."WBUSAT6" = 0 AND aaa."WBUSQT7" = 0 AND aaa."WBUSAT7" = 0 AND
           aaa."WBUSQT8" = 0 AND aaa."WBUSAT8" = 0 AND aaa."WBUSAT9" = 0 AND aaa."WBUSQTA" = 0 AND
           aaa."WBUSATA" = 0 ))
GROUP BY aaa."WBYEAR",  
aaa."WBMONTH",
aaa."WBITNO",  
"PBINV"."INV101"."PDCD",
"PBCOMMON"."DAC007"."PRNAME",      
"PBINV"."INV002"."ITNM",   
"PBINV"."INV002"."SPEC",
"PBINV"."INV101"."CLS",   
"PBINV"."INV101"."SRCE",
"PBINV"."INV101"."XUNIT",  
"PBINV"."INV101"."CONVQTY",
aaa."WBAVRG1"
ORDER BY aaa."WBYEAR",  
aaa."WBMONTH",
aaa."WBITNO";



SELECT WBYEAR,WBITNO, SUM(WBBGQT), SUM(WBBGAT1), SUM(WBINQT), SUM(WBUSQT2), SUM(WBUSAT2)
FROM PBWIP.WIP002 INNER JOIN PBWIP.WIP015
	ON WBCMCD = TCMCD AND WBPLANT = TPLNT AND WBDVSN = TDVSN AND
	WBITNO = TCITN AND TLEVEL = 0
WHERE WBCMCD = '01' AND WBPLANT = 'D' AND WBDVSN = 'M' AND 
WBYEAR IN ('2005','2006','2007','2008') AND WBITNO = '18027382'
GROUP BY WBYEAR,WBITNO
ORDER BY WBYEAR,WBITNO;
