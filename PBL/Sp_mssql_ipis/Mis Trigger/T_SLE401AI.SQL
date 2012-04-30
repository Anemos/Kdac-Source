CREATE TRIGGER PBIPIS.T_SLE401AI
   AFTER INSERT ON PBSLE.SLE401
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  IF SUBSTR(NR.CUSTCD,1,1) = 'E' THEN
     IF NR.STCD = 'C' THEN
        INSERT INTO PBIPIS.PDSLE401 (CHGDATE, CHGCD, SADT, XPLANT,
                                     DIV,     CSRNO, SLNO, DCQTY,
                                     STSCD,      DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'A',
                                     NR.SADT, NR.XPLANT,
                                     NR.DIV,  NR.CSRNO,  NR.SLNO,
                                     NR.DCQTY, 'N', ' ') ;
     END IF;
  END IF;
  IF SUBSTR(NR.CUSTCD,1,1) <> 'E' THEN
     IF NR.DCQTY > 0 THEN
        INSERT INTO PBIPIS.PDSLE401 (CHGDATE, CHGCD, SADT, XPLANT,
                                     DIV,     CSRNO, SLNO, DCQTY,
                                     STSCD,      DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'A',
                                     NR.SADT, NR.XPLANT,
                                     NR.DIV,  NR.CSRNO,  NR.SLNO,
                                     NR.DCQTY, 'N', ' ') ;
     END IF;
  END IF;
END


