SELECT aaa."WBCMCD",  
aaa."WBPLANT",  
aaa."WBDVSN",
"PBINV"."INV101"."PDCD",
"PBCOMMON"."DAC007"."PRNAME",   
aaa."WBITNO",   
"PBINV"."INV002"."ITNM",   
"PBINV"."INV002"."SPEC",
"PBINV"."INV402"."CLS",   
"PBINV"."INV402"."SRCE",
aaa."WBITCL",
aaa."WBSRCE",
"PBINV"."INV101"."XUNIT",  
SUM ( DECIMAL(( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200405' THEN aaa."WBAVRG1"
		ELSE 0 END ) * "PBINV"."INV101"."CONVQTY",15,5) ) as avrg, 
SUM ( DECIMAL(( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200405' THEN aaa."WBBGQT"
		ELSE 0 END ) / "PBINV"."INV101"."CONVQTY",15,4) ) as bgqt, 
SUM ( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200405' THEN aaa."WBBGAT1"
		ELSE 0 END ) as bgat,    
SUM ( DECIMAL(( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200406' THEN 0
		ELSE aaa."WBINQT" END ) /"PBINV"."INV101"."CONVQTY",15,4) ) as inqt,  
SUM ( ( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200406' THEN 0
		ELSE aaa."WBINAT1" END ) ) as inat1,
SUM ( ( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200406' THEN 0
		ELSE aaa."WBINAT2" END ) ) as inat2,
SUM ( ( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200406' THEN 0
		ELSE aaa."WBINAT3" END ) ) as inat3,
SUM ( DECIMAL(( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200406' THEN aaa."WBBGQT"
		ELSE 0 END ) / "PBINV"."INV101"."CONVQTY",15,4)) as ohqt, 
SUM ( CASE aaa."WBYEAR"||aaa."WBMONTH"
		WHEN '200406' THEN aaa."WBBGAT1"
		ELSE 0 END ) as ohat

    FROM "PBWIP"."WIP002" aaa,    
         "PBINV"."INV002",   
         "PBINV"."INV101",
			"PBINV"."INV402",
         "PBCOMMON"."DAC007"
			
   WHERE ( aaa."WBCMCD" = "PBINV"."INV002"."COMLTD" ) and  
         ( aaa."WBITNO" = "PBINV"."INV002"."ITNO" ) and  
         ( aaa."WBCMCD" = "PBINV"."INV101"."COMLTD" ) and  
         ( aaa."WBPLANT" = "PBINV"."INV101"."XPLANT" ) and  
         ( aaa."WBDVSN" = "PBINV"."INV101"."DIV" ) and  
         ( aaa."WBITNO" = "PBINV"."INV101"."ITNO" ) and
			( aaa."WBCMCD" = "PBINV"."INV402"."COMLTD" ) and  
         ( aaa."WBPLANT" = "PBINV"."INV402"."XPLANT" ) and  
         ( aaa."WBDVSN" = "PBINV"."INV402"."DIV" ) and  
         ( aaa."WBITNO" = "PBINV"."INV402"."ITNO" ) and
			( "PBINV"."INV402"."XYEAR" = '200312' ) and  
         ( aaa."WBCMCD" = "PBCOMMON"."DAC007"."COMLTD" ) and  
         ( "PBINV"."INV101"."PDCD" = "PBCOMMON"."DAC007"."PRPRCD" ) and  
         ( ( aaa."WBCMCD" = '01' ) AND 
			( aaa."WBYEAR"||aaa."WBMONTH" >= '200405' ) AND 
			( aaa."WBYEAR"||aaa."WBMONTH" <= '200406' ) AND 
         ( aaa."WBPLANT" = 'D' ) AND  
         ( aaa."WBDVSN" = 'S' ) AND  
         ( aaa."WBORCT" = '9999' ) AND   
         NOT ( aaa."WBBGQT"= 0 AND aaa."WBBGAT1" = 0 AND aaa."WBINQT" = 0 AND aaa."WBINAT1" = 0 AND
           aaa."WBINAT2" = 0 AND aaa."WBINAT3" = 0 AND aaa."WBUSQT1" = 0 AND aaa."WBUSAT1" = 0 AND
           aaa."WBUSQT2" = 0 AND aaa."WBUSAT2" = 0 AND aaa."WBUSQT3" = 0 AND aaa."WBUSAT3" = 0 AND
           aaa."WBUSQT4" = 0 AND aaa."WBUSAT4" = 0 AND aaa."WBUSQT5" = 0 AND aaa."WBUSAT5" = 0 AND
           aaa."WBUSQT6" = 0 AND aaa."WBUSAT6" = 0 AND aaa."WBUSQT7" = 0 AND aaa."WBUSAT7" = 0 AND
           aaa."WBUSQT8" = 0 AND aaa."WBUSAT8" = 0 AND aaa."WBUSAT9" = 0 AND aaa."WBUSQTA" = 0 AND
           aaa."WBUSATA" = 0 ))
GROUP BY aaa."WBCMCD",  
         aaa."WBPLANT",  
         aaa."WBDVSN",
         "PBINV"."INV101"."PDCD",
         "PBCOMMON"."DAC007"."PRNAME",   
         aaa."WBITNO",   
         "PBINV"."INV002"."ITNM",   
         "PBINV"."INV002"."SPEC",   
         "PBINV"."INV402"."CLS",   
			"PBINV"."INV402"."SRCE",
         "PBINV"."INV101"."XUNIT"
ORDER BY aaa."WBCMCD",  
         aaa."WBPLANT",  
         aaa."WBDVSN",
			"PBINV"."INV101"."PDCD",
			aaa."WBITNO";
