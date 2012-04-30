SELECT  AAA."WDPRSRTY", AAA."WDPRSRNO", AAA."WDPRSRNO1", AAA."WDPRSRNO2" 
    FROM { (SELECT "WDPRSRTY","WDPRSRNO","WDPRSRNO1","WDPRSRNO2"
				FROM "PBWIP"."WIP004"
				WHERE ( ( "PBWIP"."WIP004"."WDCMCD" = :a_cmcd ) AND  
         			( "PBWIP"."WIP004"."WDPRSRTY" in ('RM','SM','IS','RS','RP') ) AND  
         			( "PBWIP"."WIP004"."WDPLANT" like :a_plant ) AND  
         			( "PBWIP"."WIP004"."WDDVSN" like :a_div ) AND  
         			( "PBWIP"."WIP004"."WDITCL" in ('10','30','40','50') ) AND  
         			( {fn substring("PBWIP"."WIP004"."WDDATE",1,6)} = :a_curmonth ) )  ) AAA
				EXCEPTION JOIN (SELECT "SLIPTYPE","SRNO","SRNO1","SRNO2" 
										FROM  ( "PBINV"."INV401"."COMLTD" = :a_cmcd ) AND
												( "PBINV"."INV401"."XPLANT" = :a_plant ) AND
												( "PBINV"."INV401"."DIV" = :a_div ) AND
												( "PBINV"."INV401"."TDTE4" = :a_cmcd ) AND
												( { fn substring("PBINV"."INV401"."COMLTD",1,6) } = :a_curmonth ) ) BBB }
							ON AAA."WDPRSRTY" = BBB."SLIPTYPE" AND
								AAA."WDPRSRNO" = BBB."SRNO" AND
								AAA."WDPRSRNO1" = BBB."SRNO1" AND
								AAA."WDPRSRNO2" = BBB."SRNO2" }  
GROUP BY WDPRSRTY, WDPRSRNO, WDPRSRNO1,WDPRSRNO2   