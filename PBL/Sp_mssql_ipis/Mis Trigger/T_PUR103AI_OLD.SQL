CREATE TRIGGER PBIPIS.T_PUR103AI
   AFTER INSERT ON PBPUR.PUR103
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  DECLARE L_N_COUNT INTEGER DEFAULT 0 ;
  IF NR.DEPT = 'D' THEN
     SELECT COUNT(*) INTO L_N_COUNT FROM PBPUR.PUR103
            WHERE COMLTD = '01' AND VSRC = 'D' AND DEPT <> 'D' AND
                  ITNO   = NR.ITNO and vsrno = nr.vsrno;
    IF L_N_COUNT = 0 THEN
     INSERT INTO PBIPIS.PDPUR103 (CHGDATE, CHGCD, VSRNO, ITNO, DADJDT,
                                  DCOST,   XSTOP,
                                  STSCD,   DOWNDATE)
     VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.VSRNO, NR.ITNO, NR.DADJDT,
                                  NR.DCOST, NR.XSTOP,
                                  'N', ' ') ;
    else
     INSERT INTO PBIPIS.PDPUR103 (CHGDATE, CHGCD, VSRNO, ITNO, DADJDT,
                                  DCOST,   XSTOP,
                                  STSCD,   DOWNDATE)
     VALUES (CHAR(CURRENT TIMESTAMP), 'R', NR.VSRNO, NR.ITNO, NR.DADJDT,
                                  NR.DCOST, NR.XSTOP,
                                  'N', ' ') ;
    end if;
  ELSE
     SELECT COUNT(*) INTO L_N_COUNT FROM PBPUR.PUR103
            WHERE COMLTD = '01' AND VSRC = 'D' AND DEPT = 'D' AND
                  ITNO   = NR.ITNO and vsrno = nr.vsrno ;
     IF L_N_COUNT = 0 THEN
      INSERT INTO PBIPIS.PDPUR103 (CHGDATE, CHGCD, VSRNO, ITNO, DADJDT,
                                   DCOST,   XSTOP,
                                   STSCD,   DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.VSRNO, NR.ITNO, NR.DADJDT,
                                 NR.DCOST, NR.XSTOP,
                                 'N', ' ') ;
     END IF;
 END IF;
END


