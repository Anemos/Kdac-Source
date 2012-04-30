CREATE TRIGGER PBIPIS.T_SLE304AD
   AFTER DELETE ON PBSLE.SLE304
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  DECLARE ls_UPDT  CHAR(8) ;
   IF LENGTH(OR.UPDTDT) > 8 THEN
      SET LS_UPDT = SUBSTR(OR.UPDTDT,1,4)||SUBSTR(OR.UPDTDT,6,2)||
          SUBSTR(OR.UPDTDT,9,2) ;
   ELSE
      SET LS_UPDT = OR.UPDTDT ;
   END IF ;
   INSERT INTO PBIPIS.PDSLE304 (CHGDATE,   CHGCD,    CSRNO, XPLANT,
                                DIV,       STYPE,    SRNO,
                                CITNO,     SUSE,     ORDNO,
                                PDCD,      ITNO,     SRQTY,
                                SAQTY,     CAQTY,    SRDT,
                                KITCD,     PSRNO,    STSCD,
                                DOWNDATE)
     VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.CSRNO, OR.XPLANT,
                                OR.DIV,    OR.STYPE, OR.SRNO,
                                OR.CITNO,  OR.SUSE,  OR.ORDNO,
                                OR.PDCD,   OR.ITNO,  OR.SRQTY,
                                OR.SAQTY,  OR.CAQTY, LS_UPDT,
                                OR.KITCD,  OR.PSRNO,
                                  'N',     ' ') ;
END


