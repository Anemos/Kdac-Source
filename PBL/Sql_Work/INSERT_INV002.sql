//SELECT WCPLANT,WCDVSN,WCITNO,SUM(WCBGAT1 + WCINAT1 - ( WCUSAT1 + WCUSAT2 + WCUSAT3 +
//WCUSAT4 + WCUSAT5 + WCUSAT6 + WCUSAT7 + WCUSAT8 + WCUSAT9))
//FROM PBWIP.WIP003
//WHERE WCCMCD = '01' AND WCYEAR = '2006' AND WCMONTH = '01'  AND WCPLANT = 'J' AND WCDVSN = 'H'
//GROUP BY WCPLANT,WCDVSN,WCITNO
//ORDER BY WCPLANT,WCDVSN,WCITNO;
//SELECT WCPLANT,WCDVSN,WCITNO,SUM(WCBGAT1)
//FROM PBWIP.WIP003
//WHERE WCCMCD = '01' AND WCYEAR = '2006' AND WCMONTH = '02' AND WCPLANT = 'J' AND WCDVSN = 'H'
//GROUP BY WCPLANT,WCDVSN,WCITNO
//ORDER BY WCPLANT,WCDVSN,WCITNO;

//SELECT * FROM PBIPIS.PDINV002
//WHERE ITNO = '615929V';

INSERT INTO "PBINV"."INV002"  
( "COMLTD",   "ITNO",   "ITNM",   "SPEC",   "XUNIT",   
  "MAKER",   "GUBUN",   "XPLAN",   "RVNO",   
  "XTYPE",   "ITNO1",   "LOLEVEL",   "RROGB",   "FIXGB",   
  "BKDESN01",   "BKDESN02",   "XSTOP",   "INL",   "FST",   
  "SND",   "THD",   "EXTD",   "INPTID",   "INPTDT",   "UPDTID",   
  "UPDTDT",   "IPADDR",   "MACADDR" )  
  VALUES ( '01',   
           '615929V',   
           'A/C-M(V250-LHD-ATC)',   
           'V250-LHD-ATC',   
           'EA',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           '2',   
           ' ',   
           0,   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ',   
           ' ' )  ;
