CREATE TRIGGER PBIPIS.T_SLE307AI
   AFTER INSERT ON PBSLE.SLE307
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  INSERT INTO PBIPIS.PDSLE307 (CHGDATE,    CHGCD,    COGUBUN,  COCODE,
                               DESC1,      DESC2,    DESC3,    DESC4,
                               EXTD,     STSCD,    DOWNDATE, DESC5)
    VALUES (CHAR(CURRENT TIMESTAMP), 'A',
                               NR.COGUBUN, NR.COCODE,
                               NR.DESC1,NR.DESC2, NR.DESC3, NR.DESC4,
                               NR.EXTD, 'N',        ' ', NR.DESC5) ;
END


