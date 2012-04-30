  SELECT "PBWIP"."WIP006"."WFYEAR",   
         "PBWIP"."WIP006"."WFMONTH",   
         "PBWIP"."WIP006"."WFCMCD",   
         "PBWIP"."WIP006"."WFPLANT",   
         "PBWIP"."WIP006"."WFDVSN",   
         "PBWIP"."WIP006"."WFSERIAL",   
         "PBWIP"."WIP006"."WFITNO",   
         "PBWIP"."WIP006"."WFITNM",   
         "PBWIP"."WIP006"."WFSPEC",   
         "PBWIP"."WIP006"."WFPDCD",   
         "PBWIP"."WIP006"."WFPDNM",   
         "PBWIP"."WIP006"."WFUNIT",   
         "PBWIP"."WIP006"."WFOHQT",   
         "PBWIP"."WIP006"."WFPHQT",   
         "PBWIP"."WIP006"."WFSTSCD",   
         "PBWIP"."WIP006"."WFEXTD",   
         "PBWIP"."WIP006"."WFIPADDR",   
         "PBWIP"."WIP006"."WFMACADDR",   
         "PBWIP"."WIP006"."WFINPTDT",   
         "PBWIP"."WIP006"."WFUPDTDT",   
         "PBINV"."INV101"."CLS",   
         "PBINV"."INV101"."SRCE",   
         "PBINV"."INV101"."CONVQTY",
			DECIMAL("PBWIP"."WIP006"."WFOHQT" / "PBINV"."INV101"."CONVQTY",11,4) AS OHQT,
			DECIMAL("PBWIP"."WIP006"."WFPHQT" / "PBINV"."INV101"."CONVQTY",11,4) AS PHQT,
			DECIMAL( IF (("PBWIP"."WIP006"."WFOHQT" - "PBWIP"."WIP006"."WFPHQT") > 0)
						THEN ("PBWIP"."WIP006"."WFOHQT" - "PBWIP"."WIP006"."WFPHQT") / "PBINV"."INV101"."CONVQTY"
						ELSE 0 END IF,11,4) AS OVERQT,
			DECIMAL( IF (("PBWIP"."WIP006"."WFOHQT" - "PBWIP"."WIP006"."WFPHQT") < 0)
						THEN ("PBWIP"."WIP006"."WFOHQT" - "PBWIP"."WIP006"."WFPHQT") / "PBINV"."INV101"."CONVQTY"
						ELSE 0 END IF,11,4) AS DOWNQT,
			DECIMAL(("PBWIP"."WIP006"."WFOHQT" - "PBWIP"."WIP006"."WFPHQT") / "PBINV"."INV101"."CONVQTY",11,4) AS DIFFQT 
    FROM "PBINV"."INV101",   
         "PBWIP"."WIP006"  
   WHERE ( "PBINV"."INV101"."COMLTD" = "PBWIP"."WIP006"."WFCMCD" ) and  
         ( "PBINV"."INV101"."XPLANT" = "PBWIP"."WIP006"."WFPLANT" ) and  
         ( "PBINV"."INV101"."DIV" = "PBWIP"."WIP006"."WFDVSN" ) and  
         ( "PBINV"."INV101"."ITNO" = "PBWIP"."WIP006"."WFITNO" ) and  
         ( ( "PBWIP"."WIP006"."WFYEAR" = :ag_year ) AND  
         ( "PBWIP"."WIP006"."WFMONTH" = :ag_month ) AND  
         ( "PBWIP"."WIP006"."WFCMCD" = :ag_cmcd ) AND  
         ( "PBWIP"."WIP006"."WFPLANT" = :ag_plant ) AND  
         ( "PBWIP"."WIP006"."WFDVSN" = :ag_dvsn ) )    

