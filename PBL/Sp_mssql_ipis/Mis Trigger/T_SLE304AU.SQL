CREATE TRIGGER PBIPIS.T_SLE304AU
   AFTER UPDATE OF CAQTY ON PBSLE.SLE304
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
   WHEN (NR.CAQTY <> OR.CAQTY)
BEGIN
  DECLARE LS_OUPDT  CHAR(8) ;
  DECLARE LS_NUPDT  CHAR(8) ;
   IF LENGTH(OR.UPDTDT) > 8 THEN
      SET LS_OUPDT = SUBSTR(OR.UPDTDT,1,4)||SUBSTR(OR.UPDTDT,6,2)||
          SUBSTR(OR.UPDTDT,9,2) ;
   ELSE
      SET LS_OUPDT = OR.UPDTDT ;
   END IF ;
   IF LENGTH(NR.UPDTDT) > 8 THEN
      SET LS_NUPDT = SUBSTR(NR.UPDTDT,1,4)||SUBSTR(NR.UPDTDT,6,2)||
          SUBSTR(NR.UPDTDT,9,2) ;
   ELSE
      SET LS_NUPDT = NR.UPDTDT ;
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
                                OR.SAQTY,  OR.CAQTY, LS_OUPDT,
                                OR.KITCD,  OR.PSRNO,
                                  'N',     ' ') ;
   INSERT INTO PBIPIS.PDSLE304 (CHGDATE,   CHGCD,    CSRNO, XPLANT,
                                DIV,       STYPE,    SRNO,
                                CITNO,     SUSE,     ORDNO,
                                PDCD,      ITNO,     SRQTY,
                                SAQTY,     CAQTY,    SRDT,
                                KITCD,     PSRNO,    STSCD,
                                DOWNDATE)
     VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.CSRNO, NR.XPLANT,
                                NR.DIV,    NR.STYPE, NR.SRNO,
                                NR.CITNO,  NR.SUSE,  NR.ORDNO,
                                NR.PDCD,   NR.ITNO,  NR.SRQTY,
                                NR.SAQTY,  NR.CAQTY, LS_NUPDT,
                                NR.KITCD,  NR.PSRNO,
                                  'N',     ' ') ;
END


