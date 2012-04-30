CREATE TRIGGER PBIPIS.T_INV101AD
   AFTER DELETE ON PBINV.INV101
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  INSERT INTO PBIPIS.PDINV101 (CHGDATE, CHGCD, XPLANT, DIV,
                               PDCD,    ITNO,  CLS,    SRCE,
                               XUNIT,   CONVQTY, SAUD,
                               ABCCD,   WLOC, XPLAN,
                               STSCD, DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.XPLANT, OR.DIV,
                               OR.PDCD, OR.ITNO, OR.CLS, OR.SRCE,
                               OR.XUNIT, OR.CONVQTY, OR.SAUD,
                               OR.ABCCD, OR.WLOC, OR.XPLAN,
                               'N', ' ');
END
