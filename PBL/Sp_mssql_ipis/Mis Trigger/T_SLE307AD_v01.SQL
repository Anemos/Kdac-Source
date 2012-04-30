CREATE TRIGGER PBIPIS.T_SLE307AD
   AFTER DELETE ON PBSLE.SLE307
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  INSERT INTO PBIPIS.PDSLE307 (CHGDATE, CHGCD, COGUBUN, COCODE,
                               DESC1,      DESC2,    DESC3,    DESC4,
                               EXTD,     STSCD,    DOWNDATE,   DESC5)
    VALUES (CHAR(CURRENT TIMESTAMP), 'D',
                               OR.COGUBUN, OR.COCODE,
                               OR.DESC1,OR.DESC2, OR.DESC3, OR.DESC4,
                               OR.EXTD, 'N', ' ',  OR.DESC5) ;
END

