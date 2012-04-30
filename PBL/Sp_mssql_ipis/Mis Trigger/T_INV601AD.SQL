CREATE TRIGGER PBIPIS.T_INV601AD
   AFTER DELETE ON PBINV.INV601
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  IF (OR.GUBUN = 'A' AND OR.STCD > '2') OR
     (OR.GUBUN = 'A' AND OR.STCD = 'A') THEN
     INSERT INTO PBIPIS.PDINV601 (CHGDATE, CHGCD, SRNO, XPLANT, DIV,
                                  PDCD,    ITNO,  DUDT, REQQT,  CLS,
                                  SRC,     LOT,   SLNO, XPLANT1,
                                  DIV1,    ISTSCD,
                                  STSCD, DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.SRNO, OR.XPLANT, OR.DIV,
                                  OR.PDCD, OR.ITNO, OR.DUDT, OR.REQQT,
                                  OR.CLS, OR.SRCE, OR.LOT, OR.SLNO,
                                  OR.XPLANT1, OR.DIV1, OR.ISTCD,
                                  'N', ' ');
  END IF;
END


