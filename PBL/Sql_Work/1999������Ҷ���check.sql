//SELECT ITNO,(BGQT+ INQT -(USQT1 + USQT2 + USQT3 + USQT4 + USQT5 + USQT6)), OHQT,
//(BGAT1 + INAT - (USAT1 + USAT2 + USAT3 + USAT4 + USAT5 + USAT6)),OHAT
////select *
// FROM PBWIP.WIP999
//WHERE IOCD = '1' AND (((BGQT+ INQT -(USQT1 + USQT2 + USQT3 + USQT4 + USQT5 + USQT6)) <> OHQT) OR
//((BGAT1 + INAT - (USAT1 + USAT2 + USAT3 + USAT4 + USAT5 + USAT6)) <> OHAT))
//;

select wcbat1,wcbat1 + wcinata1 + wcinatb1 - ( wcusata1 + wcusatb1 + wcusatc1 + wcusatd1 +
wcusate1 + wcusatf1 ),
wcbat2, wcbat2 + wcinata2 + wcinatb2 - ( wcusata2 + wcusatb2 + wcusatc2 + wcusatd2 +
wcusate2 + wcusatf2 ),
wcbat3, wcbat3 + wcinata3 + wcinatb3 - ( wcusata3 + wcusatb3 + wcusatc3 + wcusatd3 +
wcusate3 + wcusatf3 ),
wcbat4, wcbat4 + wcinata4 + wcinatb4 - ( wcusata4 + wcusatb4 + wcusatc4 + wcusatd4 +
wcusate4 + wcusatf4 ),
wcbat5, wcbat5 + wcinata5 + wcinatb5 - ( wcusata5 + wcusatb5 + wcusatc5 + wcusatd5 +
wcusate5 + wcusatf5 ),
wcbat6, wcbat6 + wcinata6 + wcinatb6 - ( wcusata6 + wcusatb6 + wcusatc6 + wcusatd6 +
wcusate6 + wcusatf6 ),
wcbat7, wcbat7 + wcinata7 + wcinatb7 - ( wcusata7 + wcusatb7 + wcusatc7 + wcusatd7 +
wcusate7 + wcusatf7 ),
wcbat8, wcbat8 + wcinata8 + wcinatb8 - ( wcusata8 + wcusatb8 + wcusatc8 + wcusatd8 +
wcusate8 + wcusatf8 ),
wcbat9, wcbat9 + wcinata9 + wcinatb9 - ( wcusata9 + wcusatb9 + wcusatc9 + wcusatd9 +
wcusate9 + wcusatf9 ),
wcbat10, wcbat10 + wcinata10 + wcinatb10 - ( wcusata10 + wcusatb10 + wcusatc10 + wcusatd10 +
wcusate10 + wcusatf10 ),
wcbat11, wcbat11 + wcinata11 + wcinatb11 - ( wcusata11 + wcusatb11 + wcusatc11 + wcusatd11 +
wcusate11 + wcusatf11 ),
wcbat12, wcbat12 + wcinata12 + wcinatb12 - ( wcusata12 + wcusatb12 + wcusatc12 + wcusatd12 +
wcusate12 + wcusatf12 )
FROM PBTEST.WIPDAW aa
WHERE aa.WCDIV = 'A' AND aa.WCYEARC = '19' AND aa.WCYEARY = '99' AND aa.WCIOCD = '1'
AND aa.WCITNO = 'AR0005';

//SELECT wcbat1,(aa.wcinata1 + aa.wcinatb1 + aa.wcinata2
//  + aa.wcinatb2 + aa.wcinata3 + aa.wcinatb3
//  + aa.wcinata4 + aa.wcinatb4 + aa.wcinata5 + aa.wcinatb5
//  + aa.wcinata6 + aa.wcinatb6
//  + aa.wcinata7 + aa.wcinatb7 + aa.wcinata8 + aa.wcinatb8
//  + aa.wcinata9 + aa.wcinatb9
//  + aa.wcinata10 + aa.wcinatb10 + aa.wcinata11 + aa.wcinatb11
//  + aa.wcinata12 + aa.wcinatb12) AS INAT,
//(aa.wcusata1 + aa.wcusata2 + aa.wcusata3
//  + aa.wcusata4 + aa.wcusata5
//  + aa.wcusata6 + aa.wcusata7 + aa.wcusata8 + aa.wcusata9 + aa.wcusata10
//  + aa.wcusata11 + aa.wcusata12 ) AS USAT1,
//(aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3
//  + aa.wcusatb4 + aa.wcusatb5
//  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10
//  + aa.wcusatb11 + aa.wcusatb12 ) AS USAT2,
// (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3
//  + aa.wcusatb4 + aa.wcusatb5
//  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10
//  + aa.wcusatb11 + aa.wcusatc12 ) AS USAT3,
//(aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3
//  + aa.wcusatb4 + aa.wcusatb5
//  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10
//  + aa.wcusatb11 + aa.wcusatd12 ) AS USAT4,
//(aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3
//  + aa.wcusatb4 + aa.wcusatb5
//  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10
//  + aa.wcusatb11 + aa.wcusate12 ) AS USAT5,
//(aa.wcusatf1 + aa.wcusatf2 + aa.wcusatf3
//  + aa.wcusatf4 + aa.wcusatf5
//  + aa.wcusatf6 + aa.wcusatf7 + aa.wcusatf8 + aa.wcusatf9 + aa.wcusatf10
//  + aa.wcusatf11 + aa.wcusatf12 ) AS USAT6
//
//FROM PBTEST.WIPDAW aa
//WHERE aa.WCDIV = 'A' AND aa.WCYEARC = '19' AND aa.WCYEARY = '99' AND aa.WCIOCD = '1'
//AND aa.WCITNO = 'AR0005';