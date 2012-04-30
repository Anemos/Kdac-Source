CREATE TRIGGER PBIPIS.T_INV601AI
   AFTER INSERT ON PBINV.INV601
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  IF (NR.GUBUN = 'A' AND NR.STCD > '2') OR
     (NR.GUBUN = 'A' AND NR.STCD = 'A') THEN
     INSERT INTO PBIPIS.PDINV601 (CHGDATE, CHGCD, SRNO, XPLANT, DIV,
                                  PDCD,    ITNO,  DUDT, REQQT,  CLS,
                                  SRC,     LOT,   SLNO, XPLANT1,
                                  DIV1,    ISTSCD,
                                  STSCD, DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.SRNO, NR.XPLANT, NR.DIV,
                                  NR.PDCD, NR.ITNO, NR.DUDT, NR.REQQT,
                                  NR.CLS, NR.SRCE, NR.LOT, NR.SLNO,
                                  NR.XPLANT1, NR.DIV1, NR.ISTCD,
                                  'N', ' ');
  END IF;
END


