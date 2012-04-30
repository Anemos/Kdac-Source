DROP TRIGGER PBIPIS.T_INV201AU;

CREATE TRIGGER PBIPIS.T_INV201AU
   AFTER UPDATE OF XPLANT, DIV, SLNO, DCKDT, VNDR, ITNO, DCKQT,
                   EXTD ON PBINV.INV201
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
    (NR.XPLANT <> OR.XPLANT OR NR.DIV   <> OR.DIV OR
     NR.SLNO   <> OR.SLNO   OR NR.DCKDT <> OR.DCKDT or
     NR.VNDR   <> OR.VNDR   OR NR.ITNO  <> OR.ITNO  or
     NR.DCKQT  <> OR.DCKQT  OR NR.EXTD  <> OR.EXTD)
BEGIN
  DECLARE SQLCODE  INTEGER default 0 ;
  DECLARE SQLSTATE CHAR(5) default '00000' ;
  DECLARE L_N_DCKQT NUMERIC(11,1) DEFAULT 0 ;
  DECLARE l_s_cls  CHAR(2) ;
  SELECT SUM(DCKQT) INTO L_N_DCKQT FROM PBINV.INV201
            WHERE COMLTD = '01' AND SLNO = NR.SLNO AND
                  ITNO   = NR.ITNO ;
  SELECT CLS INTO L_S_CLS FROM PBINV.INV101
  WHERE COMLTD = '01' AND XPLANT = NR.XPLANT AND DIV = NR.DIV
        and ITNO = NR.ITNO ;
  IF SQLCODE <> 0 THEN
     SET l_s_cls = ' ' ;
  END IF;
  if l_s_cls = '10' or L_S_CLS = '20' or l_s_cls = '35' or
     l_s_cls = '40' or L_S_CLS = '50' then
     INSERT INTO PBIPIS.PDINV201 (CHGDATE, CHGCD, XPLANT, DIV,
                                  SLNO,    DCKDT, VNDR,  ITNO,
                                  QCCD, DCKQT,
                                  DCAMT, BLNO, FOBAMT,
                                  STSCD, DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'R', nr.XPLANT, nr.DIV,
                                  nr.SLNO,  NR.DCKDT, nr.VNDR, nr.ITNO,
                                  SUBSTR(NR.EXTD,1,1), L_N_DCKQT,
                                  nr.DCAMT, nr.BLNO, nr.FOBAMT,
                                  'N', ' ')  ;
 end if ;
END


