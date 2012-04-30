CREATE TRIGGER PBIPIS.T_SLE304AI
   AFTER INSERT ON PBSLE.SLE304
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  DECLARE ls_UPDT  CHAR(8) ;
   IF LENGTH(NR.UPDTDT) > 8 THEN
      SET LS_UPDT = SUBSTR(NR.UPDTDT,1,4)||SUBSTR(NR.UPDTDT,6,2)||
          SUBSTR(NR.UPDTDT,9,2) ;
   ELSE
      SET LS_UPDT = NR.UPDTDT ;
   END IF ;
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
                                NR.SAQTY,  NR.CAQTY, LS_UPDT,
                                NR.KITCD,  NR.PSRNO,
                                  'N',     ' ') ;
END

