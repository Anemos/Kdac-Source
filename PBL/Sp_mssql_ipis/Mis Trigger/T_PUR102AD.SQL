CREATE TRIGGER PBIPIS.T_PUR102AD
   AFTER DELETE ON PBPUR.PUR102
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   (OR.DEPT = 'D')
BEGIN
  INSERT INTO PBIPIS.PDPUR102 (CHGDATE, CHGCD, VSRNO, INSIDE,
                               KBCD,    VANCD, JSCD, XSTOP,
                               STSCD,   DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'R', OR.VSRNO, ' ',
                               ' ', ' ', ' ', ' ',
                               'N', ' ') ;
END

