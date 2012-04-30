SELECT "PBINV"."INV401"."COMLTD",   
         "PBINV"."INV401"."SLIPTYPE",   
         "PBINV"."INV401"."SRNO",   
         "PBINV"."INV401"."SRNO1",   
         "PBINV"."INV401"."SRNO2",   
         "PBINV"."INV401"."XPLANT",   
         "PBINV"."INV401"."DIV",   
         "PBINV"."INV401"."SLNO",   
         "PBINV"."INV401"."ITNO",   
         "PBINV"."INV401"."CLS",   
         "PBINV"."INV401"."SRCE",   
         "PBINV"."INV401"."XUSE",   
         "PBINV"."INV401"."RTNGUB",   
         "PBINV"."INV401"."VSRNO",   
         "PBINV"."INV401"."DEPT",   
         "PBINV"."INV401"."TDTE4",
			"PBINV"."INV401"."TQTY1",
			"PBINV"."INV401"."TQTY2",
			"PBINV"."INV401"."TQTY3",   
         "PBINV"."INV401"."TQTY4"     
    FROM "PBINV"."INV401"
   WHERE ("PBINV"."INV401"."COMLTD" = :a_cmcd) AND  
         ("PBINV"."INV401"."SLIPTYPE" in ('RM','SM','IS','RS','RP')) AND 
         ("PBINV"."INV401"."XPLANT" = :a_plant) AND  
         ("PBINV"."INV401"."DIV" = :a_div) AND
			({fn substring("PBINV"."INV401"."TDTE4",1,6)} = :a_curmonth)  AND
			NOT EXISTS (SELECT "PBWIP"."WIP004"."WDPRSRTY","PBWIP"."WIP004"."WDPRSRNO",
																	 "PBWIP"."WIP004"."WDPRSRNO1","PBWIP"."WIP004"."WDPRSRNO2"
																FROM "PBWIP"."WIP004"  
																WHERE ( "PBWIP"."WIP004"."WDCMCD" = :a_cmcd ) AND
																		( "PBWIP"."WIP004"."WDPLANT" = :a_plant ) AND
																		( "PBWIP"."WIP004"."WDDVSN" = :a_div ) AND
																		( "PBINV"."INV401"."SLIPTYPE" = "PBWIP"."WIP004"."WDPRSRTY") AND 
																		( "PBINV"."INV401"."SRNO" = "PBWIP"."WIP004"."WDPRSRNO") AND
																		( "PBINV"."INV401"."SRNO1" = "PBWIP"."WIP004"."WDPRSRNO1") AND
																		( "PBINV"."INV401"."SRNO2" = "PBWIP"."WIP004"."WDPRSRNO2") AND
																		({fn substring("PBWIP"."WIP004"."WDDATE",1,6)} = :a_curmonth) ) AND
			("PBINV"."INV401"."TQTY4" <> 0 ) AND  
         ("PBINV"."INV401"."CLS" in ('10','30','40','50')) AND
			(NOT ( ("PBINV"."INV401"."CLS" = '10') AND 
			("PBINV"."INV401"."SRCE" = '01' OR "PBINV"."INV401"."SRCE" = '02' OR
			 "PBINV"."INV401"."SRCE" = '05' OR "PBINV"."INV401"."SRCE" = '06'))) AND
			(NOT ( ("PBINV"."INV401"."SLIPTYPE" = 'IS' OR "PBINV"."INV401"."SLIPTYPE" = 'RS') AND 
			(("PBINV"."INV401"."CLS" = '10' OR "PBINV"."INV401"."CLS" = '40' OR "PBINV"."INV401"."CLS" = '50') AND 
			("PBINV"."INV401"."SRCE" = '04' OR "PBINV"."INV401"."SRCE" = '05' OR "PBINV"."INV401"."SRCE" = '06')))) 
          ;