-- file name : sp_wip_18
-- procedure name : pbwip.sp_wip_18
-- desc : Check Item Creation for two years past

drop procedure pbwip.sp_wip_18;
create procedure pbwip.sp_wip_18 (
in a_cmcd   varchar(2),
in a_plant  varchar(1),
in a_dvsn   varchar(1),
in a_year   varchar(4),
in a_month  varchar(2),
in a_applydate char(8) )
language sql
begin
declare sqlcode integer default 0;
declare p_year      char(4);
declare p_yearmm_start char(6);
declare p_yearmm_end char(6);

--create qtemp.wiptemp180
create table qtemp.wiptemp180(
  twyear  char(4),  twmonth char(2),
  twcmcd  char(2),
  twplant char(1),  twdvsn  char(1),
  twitno  char(12), twcls   char(2),
  twsrce  char(2),  twitnm  char(50),
  twpdcd  char(2),  twkct   char(4) );

--create qtemp.wiptemp181
create table qtemp.wiptemp181(
  twyear  char(4),  twmonth char(2),
  twcmcd  char(2),
  twplant char(1),  twdvsn  char(1),
  twitno  char(12), twcls   char(2),
  twsrce  char(2),  twitnm  char(50),
  twpdcd  char(2),  twkct   char(4),
  twchk   char(1) );

set p_year = CAST(CAST(a_year AS INTEGER) - 1 AS CHAR(4));
set p_yearmm_start = CONCAT(p_year,'01');
set p_yearmm_end = CONCAT(a_year,'12');

-- First Step : 10, 40, 50
INSERT INTO qtemp.wiptemp180(twyear,twmonth,twcmcd,twplant,twdvsn,
  twitno,twcls,twsrce,twitnm,twpdcd,twkct)
SELECT DISTINCT a_year,a_month,AA.COMLTD,AA.XPLANT,AA.DIV,AA.ITNO,
  AA.CLS,AA.SRCE,CC.ITNM,SUBSTRING(AA.PDCD,1,2),IFNULL(DD.PWKCT,'')
  FROM PBINV.INV101 AA INNER JOIN PBWIP.WIP002 BB
    ON AA.COMLTD = BB.WBCMCD AND AA.XPLANT = BB.WBPLANT AND
        AA.DIV = BB.WBDVSN AND AA.ITNO = BB.WBITNO
    INNER JOIN PBINV.INV002 CC
    ON AA.COMLTD = CC.COMLTD AND AA.ITNO = CC.ITNO
    LEFT OUTER JOIN ( SELECT PCMCD, PLANT,
      PDVSN, PCITN, MAX(PWKCT) AS PWKCT FROM PBPDM.BOM001
      WHERE PCMCD = a_cmcd AND PLANT = a_plant AND
        PDVSN = a_dvsn AND
      (( PEDTE = ' '  AND PEDTM <= a_applydate ) OR
      ( PEDTE <> ' ' AND PEDTM <= a_applydate
        AND PEDTE >= a_applydate )) AND
      PWKCT <> '9999' AND PWKCT <> '8888'
      GROUP BY PCMCD, PLANT, PDVSN, PCITN) DD
    ON AA.COMLTD = DD.PCMCD AND AA.XPLANT = DD.PLANT AND
      AA.DIV = DD.PDVSN AND AA.ITNO = DD.PCITN
  WHERE AA.COMLTD = a_cmcd AND AA.XPLANT = a_plant AND
    AA.DIV = a_dvsn AND AA.CLS IN ('10','50') AND
    AA.SRCE <> '03' AND
    BB.WBYEAR >= p_year AND BB.WBYEAR <= a_year AND BB.WBIOCD = '1'
        AND NOT (BB.WBBGQT = 0 AND BB.WBINQT = 0 AND BB.WBUSQT1 = 0 AND
          BB.WBUSQT2 = 0 AND BB.WBUSQT3 = 0 AND BB.WBUSQT4 = 0 AND
          BB.WBUSQT5 = 0 AND BB.WBUSQT6 = 0 AND BB.WBUSQT7 = 0 AND
          BB.WBUSQT8 = 0 AND BB.WBUSQTA = 0 );

-- Second Step : 30, 10/03
INSERT INTO qtemp.wiptemp180(twyear,twmonth,twcmcd,twplant,twdvsn,
  twitno,twcls,twsrce,twitnm,twpdcd,twkct)
SELECT DISTINCT a_year,a_month,AA.COMLTD,AA.XPLANT,AA.DIV,AA.ITNO,
  AA.CLS,AA.SRCE,CC.ITNM,SUBSTRING(AA.PDCD,1,2),IFNULL(BB.PWKCT,'')
  FROM PBINV.INV402 AA INNER JOIN PBINV.INV002 CC
  ON AA.COMLTD = CC.COMLTD AND AA.ITNO = CC.ITNO
  INNER JOIN PBINV.INV101 DD
  ON AA.COMLTD = DD.COMLTD AND AA.XPLANT = DD.XPLANT AND
    AA.DIV = DD.DIV AND AA.ITNO = DD.ITNO
  LEFT OUTER JOIN ( SELECT PCMCD, PLANT,
      PDVSN, PCITN, MAX(PWKCT) AS PWKCT FROM PBPDM.BOM001
      WHERE PCMCD = a_cmcd AND PLANT = a_plant AND
        PDVSN = a_dvsn AND
      (( PEDTE = ' '  AND PEDTM <= a_applydate ) OR
      ( PEDTE <> ' ' AND PEDTM <= a_applydate
        AND PEDTE >= a_applydate )) AND
      PWKCT <> '9999' AND PWKCT <> '8888'
      GROUP BY PCMCD, PLANT, PDVSN, PCITN) BB
  ON AA.COMLTD = BB.PCMCD AND AA.XPLANT = BB.PLANT AND
    AA.DIV = BB.PDVSN AND AA.ITNO = BB.PCITN
  WHERE AA.COMLTD = a_cmcd AND AA.XPLANT = a_plant AND
    AA.DIV = a_dvsn AND AA.XYEAR >= p_yearmm_start AND
    AA.XYEAR <= p_yearmm_end AND ( DD.CLS = '30' OR DD.SRCE = '03' ) AND
    (AA.BGUQTY <> 0 OR AA.INTQTY <> 0 OR AA.OUTQTY <> 0);

-- Third Step : Exception Join
INSERT INTO qtemp.wiptemp181(twyear,twmonth,twcmcd,twplant,twdvsn,
  twitno,twcls,twsrce,twitnm,twpdcd,twkct,twchk)
SELECT TWYEAR,TWMONTH,TWCMCD,TWPLANT,TWDVSN,TWITNO,
  TWCLS,TWSRCE, TWITNM, TWPDCD, TWKCT, IFNULL(WJPLANT,'X')
FROM QTEMP.WIPTEMP180 LEFT OUTER JOIN PBWIP.WIP011 ON
  TWYEAR = WJYEAR AND TWMONTH = WJMONTH AND
  TWCMCD = WJCMCD AND TWPLANT = WJPLANT AND
  TWDVSN = WJDVSN AND TWITNO  = WJITNO AND TWKCT = WJDEPT;

drop table qtemp.wiptemp180;

end

