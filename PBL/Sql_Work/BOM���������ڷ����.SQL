  SELECT "PBPDM"."BOM013"."ZDATE",   
         "PBPDM"."BOM013"."ZPLANT", 
A.COITNAME AS PLANTNAME,  
         "PBPDM"."BOM013"."ZDIV", 
  B.COITNAME AS DIVNAME,
         "PBPDM"."BOM013"."ZMDCD",   
"PBCOMMON"."DAC007"."PRNAME",
         "PBPDM"."BOM013"."ZMDNO",   
         "PBPDM"."BOM013"."ZSERIAL",   
         "PBPDM"."BOM013"."ZLEVEL",   
         "PBPDM"."BOM013"."ZITNO",      
         "PBPDM"."BOM013"."ZDESC",   
         "PBPDM"."BOM013"."ZSPEC",
			"PBINV"."INV402"."CLS",   
         "PBINV"."INV402"."SRCE",      
         "PBPDM"."BOM013"."ZUNIT1",   
         "PBPDM"."BOM013"."ZUNITQTY",   
         "PBPDM"."BOM013"."ZCVTFACT",   
         "PBPDM"."BOM013"."ZUNIT2",   
         "PBPDM"."BOM013"."ZMOVCOST",   
         "PBPDM"."BOM013"."ZRCPCOST",   
         "PBPDM"."BOM013"."ZWKCT",     
         "PBPDM"."BOM013"."ZFMDT",   
         "PBPDM"."BOM013"."ZTODT",   
         "PBPDM"."BOM013"."ZCALC"
    FROM "PBPDM"."BOM013",   
         "PBINV"."INV402",
         "PBCOMMON"."DAC007",  
         "PBCOMMON"."DAC002" A, 
         "PBCOMMON"."DAC002" B  
   WHERE ( "PBPDM"."BOM013"."ZCMCD" 	= "PBINV"."INV402"."COMLTD" ) and  
         ( "PBPDM"."BOM013"."ZPLANT" 	= "PBINV"."INV402"."XPLANT" ) and  
         ( "PBPDM"."BOM013"."ZDIV" 		= "PBINV"."INV402"."DIV" ) and  
         ( "PBPDM"."BOM013"."ZITNO" 	= "PBINV"."INV402"."ITNO" ) and  
         ( "PBPDM"."BOM013"."ZDATE" 	= "PBINV"."INV402"."XYEAR" ) and   
         ( "PBPDM"."BOM013"."ZCMCD" 	= "PBCOMMON"."DAC007"."COMLTD" ) and  
         ( "PBPDM"."BOM013"."ZMDCD" 	= "PBCOMMON"."DAC007"."PRPRCD" ) and 
         ( ( "PBPDM"."BOM013"."ZCMCD" = '01' ) AND  
         ( "PBPDM"."BOM013"."ZDATE" = '201207' ) AND  
         ( "PBPDM"."BOM013"."ZPLANT" = 'D' ) AND  
         ( "PBPDM"."BOM013"."ZDIV" like '%' ) AND  
         ( trim("PBPDM"."BOM013"."ZMDCD") like '%' ) AND  
         ( trim("PBPDM"."BOM013"."ZMDNO") like '%' ) )  AND
         ( "PBPDM"."BOM013"."ZCMCD" = A.COMLTD AND "PBPDM"."BOM013"."ZPLANT" = TRIM(A.COCODE) AND A.COGUBUN = 'SLE220' ) AND
			( "PBPDM"."BOM013"."ZCMCD" = B.COMLTD AND "PBPDM"."BOM013"."ZDIV"   = TRIM(B.COCODE) AND B.COGUBUN = 'EIS040' ) 
ORDER BY  "PBPDM"."BOM013"."ZPLANT",  
         "PBPDM"."BOM013"."ZDIV", 
         "PBPDM"."BOM013"."ZMDCD",   
         "PBPDM"."BOM013"."ZMDNO",   
         "PBPDM"."BOM013"."ZSERIAL";
