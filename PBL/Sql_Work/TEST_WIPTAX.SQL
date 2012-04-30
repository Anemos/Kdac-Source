//INSERT INTO "PBWIP"."WIP050"  
//( "WBCMCD", "WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV", "WBIOCD",   
//  "WBITCL","WBSRCE", "WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
//  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1", "WBINAT2",   
//  "WBINAT3","WBINAT4","WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3",   
//  "WBUSQT4","WBUSAT4","WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7",   
//  "WBUSQT8","WBUSAT8","WBUSAT9","WBUSQTA","WBUSATA","WBPLAN","WBIPADDR",   
//  "WBMACADDR","WBINPTDT","WBUPDTDT" )  
//select '01','D',AAA.wbplant,AAA.wbdvsn,AAA.wborct,AAA.wbitno,AAA.wbyear,
//  AAA.wbmonth,AAA.wbrev,AAA.wbiocd,
//  AAA.wbitcl,AAA.wbsrce,AAA.wbpdcd,AAA.wbunit,AAA.wbtype,AAA.wbdesc,AAA.wbspec,
//  AAA.wbscrp,AAA.wbretn,
//  AAA.wbavrg1,AAA.wbavrg2,AAA.wbbgqt,AAA.wbbgat1,AAA.wbbgat2,AAA.wbinqt,
//  AAA.wbinat1,AAA.wbinat2,
//  AAA.wbinat3,AAA.wbinat4,BBB.usqt1, 0, BBB.usqt2, 0, AAA.wbusqt3, AAA.wbusat3, 
//  AAA.wbusqt4, AAA.wbusat4, 
//  AAA.wbusqt5, AAA.wbusat5, AAA.wbusqt6, AAA.wbusat6, AAA.wbusqt7, AAA.wbusat7, 
//  AAA.wbusqt8, AAA.wbusat8, 
//  AAA.wbusat9, AAA.wbusqta , AAA.wbusata, ' ', ' ',' ',' ',' '
//from pbwip.wip002 AAA, ( select wtdiv,wtitno,wtdtmm,
//     sum(pbcommon.f_if(wtusge,'01',sum(wtqty2),0)),
//     sum(pbcommon.f_if(wtusge,'02',sum(wtqty2),0)) 
//	  from deinvo.wiptax
//     where wtdiv = 'M' AND WTIOCD = '1' AND WTDTYY = '02' AND
//           WTDTMM >= '01' AND WTDTMM <= '11' AND SUBSTR(WTSRNO,1,2) = 'WC'
//     GROUP BY WTDIV,WTITNO,WTDTMM) BBB
//           