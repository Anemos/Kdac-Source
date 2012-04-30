CREATE TRIGGER PBIPIS.T_SLE307AU
   AFTER UPDATE ON PBSLE.SLE307
   REFERENCING OLD ROW AS OR
               NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
  WHEN
    (OR.DESC1 <> NR.DESC1 OR OR.DESC2 <> NR.DESC2 OR
     OR.DESC3 <> NR.DESC3 OR OR.DESC4 <> NR.DESC4 OR
     OR.EXTD <> NR.EXTD)
BEGIN
  INSERT INTO PBIPIS.PDSLE307 (CHGDATE,    CHGCD,    COGUBUN,  COCODE,
                               DESC1,      DESC2,    DESC3,    DESC4,
                               EXTD, STSCD,      DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'R',
                               NR.COGUBUN, NR.COCODE,
                               NR.DESC1,NR.DESC2, NR.DESC3, NR.DESC4,
                               NR.EXTD, 'N',        ' ') ;
END


