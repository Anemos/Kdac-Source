--file name     : pbwip.sp_wip_19.sql
--system                : kdac system
--procedure name        : sp_wip_19
--initial       : 2004.01.07
--author                : kim ki sub
--desc          : inv101 & wip003 in '04'

drop procedure pbwip.sp_wip_19;
create procedure pbwip.sp_wip_19
(in a_cmcd   char(2),
 in a_yy01   char(4),
 in a_mm01   char(2),
 in a_yy02   char(4),
 in a_mm02   char(2))
language sql
begin
declare sqlcode integer default 0;
declare at_end int default 0;
declare not_found condition for '02000';

INSERT INTO PBWIP.WIP003
 ( WCCMCD,WCPLANT,WCDVSN,WCITNO,WCYEAR,WCMONTH,WCITCL,WCSRCE,WCPDCD,
   WCAVRG1,WCAVRG2,WCBGAT1,WCBGAT2,WCINQT,WCINAT1,WCINAT2,
   WCUSQT1,WCUSAT1,WCUSQT2,WCUSAT2,WCUSQT3,WCUSAT3,WCUSQT4,WCUSAT4,
   WCUSQT5,WCUSAT5,WCUSQT6,WCUSAT6,WCUSAT7,WCUSQT8,WCUSAT8,WCUSAT9,
   WCIPADDR,WCMACADDR,WCINPTDT,WCUPDTDT )
SELECT COMLTD, XPLANT, DIV, ITNO, a_yy01, a_mm01, CLS, SRCE,
  SUBSTRING(PDCD,1,2),
  0,      0,      0,        0,      0,      0,      0,
  0,      0,      0,        0,      0,      0,      0,      0,
  0,      0,      0,        0,      0,      0,      0,      0,
  ' ',  ' ', ' ', ' '
FROM PBINV.INV101
WHERE ( COMLTD = a_cmcd ) AND  ( SRCE = '04' ) AND
      NOT EXISTS (SELECT * FROM PBWIP.WIP003
          WHERE WCCMCD = COMLTD AND WCPLANT = XPLANT AND
                WCDVSN = DIV AND WCITNO = ITNO AND
                WCYEAR = a_yy01 AND WCMONTH = a_mm01 );

DELETE FROM PBWIP.WIP003
   WHERE WCCMCD = a_cmcd  AND
         WCYEAR = a_yy02 AND WCMONTH = a_mm02 ;

INSERT INTO PBWIP.WIP003
( WCCMCD,WCPLANT,WCDVSN,WCITNO,WCYEAR,WCMONTH,WCITCL,WCSRCE,WCPDCD,
  WCAVRG1,WCAVRG2,WCBGAT1,WCBGAT2,WCINQT,WCINAT1,WCINAT2,
  WCUSQT1,WCUSAT1,WCUSQT2,WCUSAT2,WCUSQT3,WCUSAT3,WCUSQT4,WCUSAT4,
  WCUSQT5,WCUSAT5,WCUSQT6,WCUSAT6,WCUSAT7,WCUSQT8,WCUSAT8,WCUSAT9,
  WCIPADDR,WCMACADDR,WCINPTDT,WCUPDTDT )
SELECT COMLTD, XPLANT, DIV,  ITNO,   a_yy02,  a_mm02, CLS,   SRCE,
      SUBSTRING(PDCD,1,2),
      0,      0,      0,        0,      0,      0,      0,
      0,      0,      0,        0,      0,      0,      0,      0,
      0,      0,      0,        0,      0,      0,      0,      0,
      ' ', ' ', ' ', ' '
    FROM PBINV.INV101
   WHERE ( COMLTD = a_cmcd ) AND ( SRCE = '04' ) ;

end
