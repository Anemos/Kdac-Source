CREATE TRIGGER PBIPIS.T_SLE401AU
   AFTER UPDATE OF DCQTY, stcd ON PBSLE.SLE401
   REFERENCING OLD ROW AS OR
               NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
  WHEN
   ((NR.DCQTY <> OR.DCQTY) or (nr.stcd <> or.stcd))
BEGIN
  IF SUBSTR(NR.CUSTCD,1,1) = 'E' THEN
     IF NR.STCD = 'C' AND OR.STCD <> 'C' then
        INSERT INTO PBIPIS.PDSLE401 (CHGDATE, CHGCD, SADT, XPLANT,
                                     DIV,     CSRNO, SLNO, DCQTY,
                                     STSCD,      DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'A',
                                     NR.SADT, NR.XPLANT,
                                     NR.DIV,  NR.CSRNO,  NR.SLNO,
                                     NR.DCQTY, 'N', ' ') ;
     end if ;
     IF NR.STCD <> 'C' AND OR.STCD = 'C' then
        INSERT INTO PBIPIS.PDSLE401 (CHGDATE, CHGCD, SADT, XPLANT,
                                     DIV,     CSRNO, SLNO, DCQTY,
                                     STSCD,      DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'D',
                                     NR.SADT, NR.XPLANT,
                                     NR.DIV,  NR.CSRNO,  NR.SLNO,
                                     NR.DCQTY, 'N', ' ') ;
     END IF;
  END IF;
  IF SUBSTR(NR.CUSTCD,1,1) <> 'E' THEN
     IF NR.DCQTY > 0 and or.dcqty = 0 then
        INSERT INTO PBIPIS.PDSLE401 (CHGDATE, CHGCD, SADT, XPLANT,
                                     DIV,     CSRNO, SLNO, DCQTY,
                                     STSCD,      DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'A',
                                     NR.SADT, NR.XPLANT,
                                     NR.DIV,  NR.CSRNO,  NR.SLNO,
                                     NR.DCQTY, 'N', ' ') ;
     end if ;
     IF NR.DCQTY = 0 and or.dcqty <> 0 then
        INSERT INTO PBIPIS.PDSLE401 (CHGDATE, CHGCD, SADT, XPLANT,
                                     DIV,     CSRNO, SLNO, DCQTY,
                                     STSCD,      DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'D',
                                     NR.SADT, NR.XPLANT,
                                     NR.DIV,  NR.CSRNO,  NR.SLNO,
                                     NR.DCQTY, 'N', ' ') ;
     END IF;
  END IF ;
END


