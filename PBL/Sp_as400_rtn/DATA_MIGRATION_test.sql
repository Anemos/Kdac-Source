-- 대체/유사품번 마이그레이션
DELETE FROM "PBRTN"."RTN011";
INSERT INTO "PBRTN"."RTN011"  
         ( "RACMCD",   
           "RAPLANT",   
           "RADVSN",   
           "RAITNO",   
           "RAITNO1",   
           "RACHTIME",   
           "RAEDFM",   
           "RAEPNO",   
           "RAIPAD",   
           "RASYDT",   
           "RAINEMP",   
           "RAINCHK",   
           "RAINTIME",   
           "RAPLEMP",   
           "RAPLCHK",   
           "RAPLTIME",   
           "RADLEMP",   
           "RADLCHK",   
           "RADLTIME",   
           "RAFLAG" )
SELECT "PBRTN"."RTN001"."RACMCD",   
         "PBRTN"."RTN001"."RAPLANT",   
         "PBRTN"."RTN001"."RADVSN",   
         TRIM("PBRTN"."RTN001"."RAITNO"),
         TRIM("PBRTN"."RTN001"."RAITNO1"),
         '2008-08-07 00:00:00',
         "PBRTN"."RTN001"."RAEDFM",   
         "PBRTN"."RTN001"."RAEPNO",   
         "PBRTN"."RTN001"."RAIPAD",   
         "PBRTN"."RTN001"."RASYDT",
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         'A'
    FROM "PBRTN"."RTN001"  
WHERE "PBRTN"."RTN001"."RACMCD" = '01' AND   
  "PBRTN"."RTN001"."RAPLANT" = 'D' AND   
  "PBRTN"."RTN001"."RADVSN" =  'A' AND   
  "PBRTN"."RTN001"."RAITNO" = '10492329';

-- 대체라인 정보 마이그레이션
DELETE FROM "PBRTN"."RTN012";
INSERT INTO "PBRTN"."RTN012"  
         ( "RBCMCD",   
           "RBPLANT",   
           "RBDVSN",   
           "RBLINE1",   
           "RBLINE2",   
           "RBLNMN",   
           "RBLCTN",   
           "RBVEND",   
           "RBFLAG",   
           "RBEPNO",   
           "RBIPAD",   
           "RBUPDT",   
           "RBSYDT" )
SELECT "PBRTN"."RTN002"."RBCMCD",   
         "PBRTN"."RTN002"."RBPLANT",   
         "PBRTN"."RTN002"."RBDVSN",   
         TRIM("PBRTN"."RTN002"."RBLINE1"),   
         TRIM("PBRTN"."RTN002"."RBLINE2"),   
         TRIM("PBRTN"."RTN002"."RBLNMN"),   
         "PBRTN"."RTN002"."RBLCTN",   
         "PBRTN"."RTN002"."RBVEND",   
         "PBRTN"."RTN002"."RBFLAG",   
         "PBRTN"."RTN002"."RBEPNO",   
         "PBRTN"."RTN002"."RBIPAD",   
         "PBRTN"."RTN002"."RBUPDT",   
         "PBRTN"."RTN002"."RBSYDT"  
FROM "PBRTN"."RTN002"  ;

-- 라우팅 세부정보 마이그레이션
DELETE FROM "PBRTN"."RTN013";
INSERT INTO "PBRTN"."RTN013"  
         ( "RCCMCD",   
           "RCPLANT",   
           "RCDVSN",   
           "RCITNO",   
           "RCLINE1",   
           "RCLINE2",   
           "RCOPNO",   
           "RCCHTIME",   
           "RCEDFM",   
           "RCOPNM",   
           "RCOPSQ",   
           "RCLINE3",   
           "RCGRDE",   
           "RCMCYN",   
           "RCBMTM",   
           "RCBLTM",   
           "RCBSTM",   
           "RCNVCD",   
           "RCNVMC",   
           "RCNVLB",   
           "RCLBCNT",   
           "RCFLAG",   
           "RCEPNO",   
           "RCIPAD",   
           "RCUPDT",   
           "RCSYDT",   
           "RCINEMP",   
           "RCINCHK",   
           "RCINTIME",   
           "RCPLEMP",   
           "RCPLCHK",   
           "RCPLTIME",   
           "RCDLEMP",   
           "RCDLCHK",   
           "RCDLTIME" )
SELECT "PBRTN"."RTN003"."RCCMCD",   
         "PBRTN"."RTN003"."RCPLANT",   
         "PBRTN"."RTN003"."RCDVSN",   
         trim("PBRTN"."RTN003"."RCITNO"),   
         trim("PBRTN"."RTN003"."RCLINE1"),   
         "PBRTN"."RTN003"."RCLINE2",   
         "PBRTN"."RTN003"."RCOPNO",
         '2008-08-07 00:00:00',
         "PBRTN"."RTN003"."RCEDFM",   
         "PBRTN"."RTN003"."RCOPNM",   
         "PBRTN"."RTN003"."RCOPSQ",   
         trim("PBRTN"."RTN003"."RCLINE3"),   
         "PBRTN"."RTN003"."RCGRDE",   
         "PBRTN"."RTN003"."RCMCYN",   
         "PBRTN"."RTN003"."RCBMTM",   
         "PBRTN"."RTN003"."RCBLTM",   
         "PBRTN"."RTN003"."RCBSTM",   
         "PBRTN"."RTN003"."RCNVCD",   
         "PBRTN"."RTN003"."RCNVMC",   
         "PBRTN"."RTN003"."RCNVLB",   
         "PBRTN"."RTN003"."RCLBCNT",   
         'A',   
         "PBRTN"."RTN003"."RCEPNO",   
         "PBRTN"."RTN003"."RCIPAD",   
         "PBRTN"."RTN003"."RCUPDT",   
         "PBRTN"."RTN003"."RCSYDT",
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00'
FROM "PBRTN"."RTN003"  
WHERE "PBRTN"."RTN003"."RCCMCD" = '01' AND   
  "PBRTN"."RTN003"."RCPLANT" = 'D' AND   
  "PBRTN"."RTN003"."RCDVSN" = 'A' AND   
  "PBRTN"."RTN003"."RCITNO" = '10492329';
  
-- 부대작업 정보 마이그레이션
DELETE FROM "PBRTN"."RTN014";
INSERT INTO "PBRTN"."RTN014"  
         ( "RDCMCD",   
           "RDPLANT",   
           "RDDVSN",   
           "RDITNO",   
           "RDLINE1",   
           "RDLINE2",   
           "RDOPNO",   
           "RDNVMO",   
           "RDMCNO",   
           "RDTERM",   
           "RDMCTM",   
           "RDLBTM",   
           "RDREMK",   
           "RDFLAG",   
           "RDEPNO",   
           "RDEDFM",   
           "RDIPAD",   
           "RDUPDT",   
           "RDSYDT" )  
SELECT "PBRTN"."RTN004"."RDCMCD",   
         "PBRTN"."RTN004"."RDPLANT",   
         "PBRTN"."RTN004"."RDDVSN",   
         trim("PBRTN"."RTN004"."RDITNO"),   
         trim("PBRTN"."RTN004"."RDLINE1"),   
         "PBRTN"."RTN004"."RDLINE2",   
         "PBRTN"."RTN004"."RDOPNO",   
         "PBRTN"."RTN004"."RDNVMO",   
         "PBRTN"."RTN004"."RDMCNO",   
         "PBRTN"."RTN004"."RDTERM",   
         "PBRTN"."RTN004"."RDMCTM",   
         "PBRTN"."RTN004"."RDLBTM",   
         "PBRTN"."RTN004"."RDREMK",   
         "PBRTN"."RTN004"."RDFLAG",   
         "PBRTN"."RTN004"."RDEPNO",   
         "PBRTN"."RTN004"."RDEDFM",   
         "PBRTN"."RTN004"."RDIPAD",   
         "PBRTN"."RTN004"."RDUPDT",   
         "PBRTN"."RTN004"."RDSYDT"  
FROM "PBRTN"."RTN004"  
WHERE "PBRTN"."RTN004"."RDCMCD" = '01' AND   
  "PBRTN"."RTN004"."RDPLANT" = 'D' AND   
  "PBRTN"."RTN004"."RDDVSN" = 'A' AND   
  "PBRTN"."RTN004"."RDITNO" = '10492329';

--공정상세정보 이력마이그레이션
DELETE FROM "PBRTN"."RTN015" ;
INSERT INTO "PBRTN"."RTN015"  
         ( "RECMCD",   
           "REPLANT",   
           "REDVSN",   
           "REITNO",   
           "RELINE1",   
           "RELINE2",   
           "REOPNO",   
           "REEDFM",   
           "REEDTO",
           "REOPNM",   
           "REOPSQ",   
           "RELINE3",   
           "REGRDE",   
           "REMCYN",   
           "REBMTM",   
           "REBLTM",   
           "REBSTM",   
           "RENVCD",   
           "RENVMC",   
           "RENVLB",   
           "RELBCNT",   
           "REFLAG",   
           "REEPNO",   
           "REIPAD",   
           "REUPDT",   
           "RESYDT",   
           "REINEMP",   
           "REINCHK",   
           "REINTIME",   
           "REPLEMP",   
           "REPLCHK",   
           "REPLTIME",   
           "REDLEMP",   
           "REDLCHK",   
           "REDLTIME" )
SELECT "PBRTN"."RTN003"."RCCMCD",   
         "PBRTN"."RTN003"."RCPLANT",   
         "PBRTN"."RTN003"."RCDVSN",   
         trim("PBRTN"."RTN003"."RCITNO"),   
         trim("PBRTN"."RTN003"."RCLINE1"),   
         "PBRTN"."RTN003"."RCLINE2",   
         "PBRTN"."RTN003"."RCOPNO",
         "PBRTN"."RTN003"."RCEDFM",   
         '99991231',
         "PBRTN"."RTN003"."RCOPNM",   
         "PBRTN"."RTN003"."RCOPSQ",   
         trim("PBRTN"."RTN003"."RCLINE3"),   
         "PBRTN"."RTN003"."RCGRDE",   
         "PBRTN"."RTN003"."RCMCYN",   
         "PBRTN"."RTN003"."RCBMTM",   
         "PBRTN"."RTN003"."RCBLTM",   
         "PBRTN"."RTN003"."RCBSTM",   
         "PBRTN"."RTN003"."RCNVCD",   
         "PBRTN"."RTN003"."RCNVMC",   
         "PBRTN"."RTN003"."RCNVLB",   
         "PBRTN"."RTN003"."RCLBCNT",   
         'A',   
         "PBRTN"."RTN003"."RCEPNO",   
         "PBRTN"."RTN003"."RCIPAD",   
         "PBRTN"."RTN003"."RCUPDT",   
         "PBRTN"."RTN003"."RCSYDT",
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00'
FROM "PBRTN"."RTN003"  
WHERE "PBRTN"."RTN003"."RCCMCD" = '01' AND   
  "PBRTN"."RTN003"."RCPLANT" = 'D' AND   
  "PBRTN"."RTN003"."RCDVSN" = 'A' AND   
  "PBRTN"."RTN003"."RCITNO" = '10492329';

-- 부대작업 이력 마이그레이션
DELETE FROM "PBRTN"."RTN016";
INSERT INTO "PBRTN"."RTN016"  
         ( "RFLOGID","RFCMCD",   
           "RFPLANT",   
           "RFDVSN",   
           "RFITNO",   
           "RFLINE1",   
           "RFLINE2",   
           "RFOPNO",   
           "RFNVMO",   
           "RFMCNO",   
           "RFTERM",   
           "RFMCTM",   
           "RFLBTM",   
           "RFREMK",   
           "RFFLAG",   
           "RFEPNO",   
           "RFEDFM",
           "RFEDTO",   
           "RFIPAD",   
           "RFUPDT",   
           "RFSYDT" )  
SELECT "PBRTN"."RTN014"."RDLOGID","PBRTN"."RTN014"."RDCMCD",   
         "PBRTN"."RTN014"."RDPLANT",   
         "PBRTN"."RTN014"."RDDVSN",   
         TRIM("PBRTN"."RTN014"."RDITNO"),   
         TRIM("PBRTN"."RTN014"."RDLINE1"),   
         "PBRTN"."RTN014"."RDLINE2",   
         "PBRTN"."RTN014"."RDOPNO",   
         "PBRTN"."RTN014"."RDNVMO",   
         "PBRTN"."RTN014"."RDMCNO",   
         "PBRTN"."RTN014"."RDTERM",   
         "PBRTN"."RTN014"."RDMCTM",   
         "PBRTN"."RTN014"."RDLBTM",   
         "PBRTN"."RTN014"."RDREMK",   
         "PBRTN"."RTN014"."RDFLAG",   
         "PBRTN"."RTN014"."RDEPNO",   
         "PBRTN"."RTN014"."RDEDFM",
         '99991231',   
         "PBRTN"."RTN014"."RDIPAD",   
         "PBRTN"."RTN014"."RDUPDT",   
         "PBRTN"."RTN014"."RDSYDT"  
FROM "PBRTN"."RTN014"  
WHERE "PBRTN"."RTN014"."RDCMCD" = '01' AND   
  "PBRTN"."RTN014"."RDPLANT" = 'D' AND   
  "PBRTN"."RTN014"."RDDVSN" = 'A' AND   
  "PBRTN"."RTN014"."RDITNO" = '10492329';

-- 장비정보 마이그레이션
DELETE FROM "PBRTN"."RTN017";
INSERT INTO "PBRTN"."RTN017"  
         ( "RGCMCD",   
           "RGPLANT",   
           "RGDVSN",   
           "RGITNO",   
           "RGLINE1",   
           "RGLINE2",   
           "RGOPNO",   
           "RGMCNO",   
           "RGEDFM",   
           "RGFLAG",   
           "RGEPNO",   
           "RGIPAD",   
           "RGUPDT",   
           "RGSYDT" )
SELECT "PBRTN"."RTN007"."RGCMCD",   
         "PBRTN"."RTN007"."RGPLANT",   
         "PBRTN"."RTN007"."RGDVSN",   
         trim("PBRTN"."RTN007"."RGITNO"),   
         trim("PBRTN"."RTN007"."RGLINE1"),   
         "PBRTN"."RTN007"."RGLINE2",   
         "PBRTN"."RTN007"."RGOPNO",   
         "PBRTN"."RTN007"."RGEDFM",   
         "PBRTN"."RTN007"."RGMCNO",   
         "PBRTN"."RTN007"."RGFLAG",   
         "PBRTN"."RTN007"."RGEPNO",   
         "PBRTN"."RTN007"."RGIPAD",   
         "PBRTN"."RTN007"."RGUPDT",   
         "PBRTN"."RTN007"."RGSYDT"  
FROM "PBRTN"."RTN007"  
WHERE "PBRTN"."RTN007"."RGCMCD" = '01' AND   
  "PBRTN"."RTN007"."RGPLANT" = 'D' AND   
  "PBRTN"."RTN007"."RGDVSN" = 'A' AND   
  "PBRTN"."RTN007"."RGITNO" = '10492329';
  
-- 대체/유사품번 이력마이그레이션
DELETE FROM "PBRTN"."RTN018";
INSERT INTO "PBRTN"."RTN018"  
         ( "RHCMCD",   
           "RHPLANT",   
           "RHDVSN",   
           "RHITNO",   
           "RHITNO1",   
           "RHEDFM",   
           "RHEDTO",
           "RHEPNO",   
           "RHIPAD",   
           "RHSYDT",   
           "RHINEMP",   
           "RHINCHK",   
           "RHINTIME",   
           "RHPLEMP",   
           "RHPLCHK",   
           "RHPLTIME",   
           "RHDLEMP",   
           "RHDLCHK",   
           "RHDLTIME",   
           "RHFLAG" )
SELECT "PBRTN"."RTN001"."RACMCD",   
         "PBRTN"."RTN001"."RAPLANT",   
         "PBRTN"."RTN001"."RADVSN",   
         trim("PBRTN"."RTN001"."RAITNO"),
         trim("PBRTN"."RTN001"."RAITNO1"),
         "PBRTN"."RTN001"."RAEDFM",
         '99991231',   
         "PBRTN"."RTN001"."RAEPNO",   
         "PBRTN"."RTN001"."RAIPAD",   
         "PBRTN"."RTN001"."RASYDT",
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         '000030',
         'Y',
         '2008-08-07 00:00:00',
         'A'
    FROM "PBRTN"."RTN001"  
WHERE "PBRTN"."RTN001"."RACMCD" = '01' AND   
  "PBRTN"."RTN001"."RAPLANT" = 'D' AND   
  "PBRTN"."RTN001"."RADVSN" =  'A' AND   
  "PBRTN"."RTN001"."RAITNO" = '10492329';

