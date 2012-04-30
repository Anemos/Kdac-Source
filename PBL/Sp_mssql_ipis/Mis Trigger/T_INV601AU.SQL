CREATE TRIGGER PBIPIS.T_INV601AU
   AFTER UPDATE OF STCD ON PBINV.INV601
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  IF (NR.GUBUN = 'A' AND OR.STCD < '3' AND NR.STCD = '3')
     OR ( NR.GUBUN = 'A' AND NR.STCD = 'A' ) THEN
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
  IF (NR.GUBUN = 'A' AND OR.STCD > '2' AND NR.STCD = '2') THEN
     INSERT INTO PBIPIS.PDINV601 (CHGDATE, CHGCD, SRNO, XPLANT, DIV,
                                  PDCD,    ITNO,  DUDT, REQQT,  CLS,
                                  SRC,     LOT,   SLNO, XPLANT1,
                                  DIV1,    ISTSCD,
                                  STSCD, DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'D', NR.SRNO, NR.XPLANT, NR.DIV,
                                  NR.PDCD, NR.ITNO, NR.DUDT, NR.REQQT,
                                  NR.CLS, NR.SRCE, NR.LOT, NR.SLNO,
                                  NR.XPLANT1, NR.DIV1, NR.ISTCD,
                                  'N', ' ');
  END IF;
END


