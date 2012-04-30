CREATE TRIGGER PBIPIS.T_PUR101AD
   AFTER DELETE ON PBPUR.PUR101
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   (OR.SCGUBUN IN ('C' , 'S'))
BEGIN
  INSERT INTO PBIPIS.PDPUR101 (CHGDATE, CHGCD, SCGUBUN, VSRNO,
                               VNDR,    VNDNM, VNDNM1,  ADDR,
                               PRNM,    NATN,  TELN,    FAXN,
                               TLXN,    VPOST, DIGUBUN,
                               STSCD,   DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.SCGUBUN, OR.VSRNO,
                               OR.VNDR, OR.VNDNM, OR.VNDNM1, OR.ADDR,
                               OR.PRNM, OR.NATN, OR.TELN, OR.FAXN,
                               OR.TLXN, OR.VPOST, OR.DIGUBUN,
                               'N', ' ') ;
END

