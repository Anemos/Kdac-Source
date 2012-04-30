  SELECT "PBWIP"."WIP998"."PLANT",   
         "PBWIP"."WIP998"."DVSN",   
         "PBWIP"."WIP998"."PDCD",   
         "PBWIP"."WIP998"."PDNM",      
         "PBWIP"."WIP998"."ITNO",      
         "PBWIP"."WIP998"."DESC",   
         "PBWIP"."WIP998"."SPEC",   
         "PBWIP"."WIP998"."ITCL",   
         "PBWIP"."WIP998"."SRCE",   
         "PBWIP"."WIP998"."UNIT",   
         SUM ( DECIMAL(( CASE MMDT
  		      WHEN '01' THEN "PBWIP"."WIP998"."AVRG1"
  		      ELSE 0 END ),15,5)) AS AVRG1,
         SUM ( DECIMAL(( CASE MMDT
  		      WHEN '01' THEN "PBWIP"."WIP998"."BGQT"
  		      ELSE 0 END ), 15, 4)) AS BGQT,  
         SUM( CASE MMDT
            WHEN '01' THEN "PBWIP"."WIP998"."BGAT1"
            ELSE 0 END ) AS BGAT,   
         SUM( "PBWIP"."WIP998"."INQT" ) AS INQT,   
         SUM( "PBWIP"."WIP998"."INAT" ) AS INAT,   
         SUM( "PBWIP"."WIP998"."USQT1" ) AS USQT1,   
         SUM( "PBWIP"."WIP998"."USAT1" ) AS USAT1,   
         SUM( "PBWIP"."WIP998"."USQT2" ) AS USQT2,   
         SUM( "PBWIP"."WIP998"."USAT2" ) AS USAT2,   
         SUM( "PBWIP"."WIP998"."USQT3" ) AS USQT3,   
         SUM( "PBWIP"."WIP998"."USAT3" ) AS USAT3,   
         SUM( "PBWIP"."WIP998"."USQT4" ) AS USQT4,   
         SUM( "PBWIP"."WIP998"."USAT4" ) AS USAT4,   
         SUM( "PBWIP"."WIP998"."USQT5" ) AS USQT5,   
         SUM( "PBWIP"."WIP998"."USAT5" ) AS USAT5,   
         SUM( "PBWIP"."WIP998"."USQT6" ) AS USQT6,   
         SUM( "PBWIP"."WIP998"."USAT6" ) AS USAT6,   
         SUM( DECIMAL(( CASE MMDT
            WHEN '03' THEN "PBWIP"."WIP998"."OHQT"
            ELSE 0 END ), 15, 4)) AS OHQT,   
         SUM( CASE MMDT
            WHEN '03' THEN "PBWIP"."WIP998"."OHAT"
            ELSE 0 END ) AS OHAT 
    FROM "PBWIP"."WIP998"  
   WHERE ( "PBWIP"."WIP998"."YYDT" = '1999' ) AND  
         ( "PBWIP"."WIP998"."MMDT" BETWEEN '01' AND '03') AND  
         ( "PBWIP"."WIP998"."ORCT" = 'D0994' ) AND  
         ( "PBWIP"."WIP998"."IOCD" = '2' )
			AND NOT (BGQT = 0 AND BGAT1 = 0 AND INQT = 0 AND INAT = 0 AND USQT1 = 0 AND USAT1 = 0 AND
	USQT2 = 0 AND USAT2 = 0 AND USQT3 = 0 AND USAT3 = 0 AND USQT4 = 0 AND USAT4 = 0 AND
	USQT5 = 0 AND USAT5 = 0 AND USQT6 = 0 AND USAT6 = 0 AND OHQT = 0 AND OHAT = 0 )
GROUP BY "PBWIP"."WIP998"."PLANT",   
         "PBWIP"."WIP998"."DVSN",   
         "PBWIP"."WIP998"."PDCD",   
         "PBWIP"."WIP998"."PDNM",      
         "PBWIP"."WIP998"."ITNO",      
         "PBWIP"."WIP998"."DESC",   
         "PBWIP"."WIP998"."SPEC",   
         "PBWIP"."WIP998"."ITCL",   
         "PBWIP"."WIP998"."SRCE",   
         "PBWIP"."WIP998"."UNIT"
