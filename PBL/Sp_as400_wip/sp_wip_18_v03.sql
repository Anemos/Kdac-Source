-- file name : sp_wip_18
-- procedure name : pbwip.sp_wip_18
-- desc : Anual Check Item Creation

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
declare p_date      char(8);

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

set p_date = concat(a_year,'0101');

-- First Step : 10, 40, 50
INSERT INTO qtemp.wiptemp180(twyear,twmonth,twcmcd,twplant,twdvsn,
  twitno,twcls,twsrce,twitnm,twpdcd,twkct)
SELECT DISTINCT a_year,a_month,AA.COMLTD,AA.XPLANT,AA.DIV,AA.ITNO,
  AA.CLS,AA.SRCE,CC.ITNM,SUBSTRING(AA.PDCD,1,2),IFNULL(DD.PWKCT,'')
  FROM PBINV.INV101 AA INNER JOIN (
      SELECT DISTINCT WBCMCD,WBPLANT,WBDVSN,WBITNO
      FROM PBWIP.WIP002
      WHERE WBCMCD = a_cmcd AND WBPLANT = a_plant AND WBDVSN = a_dvsn
        AND WBYEAR = a_year AND WBORCT = '9999'
        AND NOT (WBBGQT = 0 AND WBINQT = 0 AND WBUSQT1 = 0 AND
          WBUSQT2 = 0 AND WBUSQT3 = 0 AND WBUSQT4 = 0 AND
          WBUSQT5 = 0 AND WBUSQT6 = 0 AND WBUSQT7 = 0 AND
          WBUSQT8 = 0 AND WBUSQTA = 0 ) ) BB
    ON AA.COMLTD = BB.WBCMCD AND AA.XPLANT = BB.WBPLANT AND
        AA.DIV = BB.WBDVSN AND AA.ITNO = BB.WBITNO
      INNER JOIN PBINV.INV002 CC
    ON AA.COMLTD = CC.COMLTD AND AA.ITNO = CC.ITNO
    LEFT OUTER JOIN PBPDM.BOM001 DD
    ON AA.COMLTD = DD.PCMCD AND AA.XPLANT = DD.PLANT AND
      AA.DIV = DD.PDVSN AND AA.ITNO = DD.PCITN AND
      (( DD.PEDTE = ' '  AND DD.PEDTM <= a_applydate ) OR
      ( DD.PEDTE <> ' ' AND DD.PEDTM <= a_applydate
        AND DD.PEDTE >= a_applydate )) AND
      DD.PWKCT <> '9999' AND DD.PWKCT <> '8888'
  WHERE AA.COMLTD = a_cmcd AND AA.XPLANT = a_plant AND
    AA.DIV = a_dvsn AND AA.CLS IN ('10','40','50') AND
    AA.SRCE <> '03';

-- Second Step : 30, 10/03
INSERT INTO qtemp.wiptemp180(twyear,twmonth,twcmcd,twplant,twdvsn,
  twitno,twcls,twsrce,twitnm,twpdcd,twkct)
SELECT DISTINCT a_year,a_month,AA.COMLTD,AA.XPLANT,AA.DIV,AA.ITNO,
  AA.CLS,AA.SRCE,CC.ITNM,SUBSTRING(AA.PDCD,1,2),IFNULL(BB.PWKCT,'')
  FROM PBINV.INV101 AA INNER JOIN PBINV.INV002 CC
  ON AA.COMLTD = CC.COMLTD AND AA.ITNO = CC.ITNO
  LEFT OUTER JOIN PBPDM.BOM001 BB
  ON AA.COMLTD = BB.PCMCD AND AA.XPLANT = BB.PLANT AND
    AA.DIV = BB.PDVSN AND AA.ITNO = BB.PCITN AND
   (( BB.PEDTE = ' '  AND BB.PEDTM <= a_applydate ) OR
    ( BB.PEDTE <> ' ' AND BB.PEDTM <= a_applydate
        AND BB.PEDTE >= a_applydate )) AND
    BB.PWKCT <> '9999' AND BB.PWKCT <> '8888'
  WHERE AA.COMLTD = a_cmcd AND AA.XPLANT = a_plant AND
    AA.DIV = a_dvsn AND ( AA.CLS = '30' OR AA.SRCE = '03' );

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

