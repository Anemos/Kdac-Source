CREATE TRIGGER PBIPIS.T_PUR101AI
   AFTER INSERT ON PBPUR.PUR101
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   (NR.SCGUBUN IN ('C' , 'S'))
BEGIN
  INSERT INTO PBIPIS.PDPUR101 (CHGDATE, CHGCD, SCGUBUN, VSRNO,
                               VNDR,    VNDNM, VNDNM1,  ADDR,
                               PRNM,    NATN,  TELN,    FAXN,
                               TLXN,    VPOST, DIGUBUN,
                               STSCD,   DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.SCGUBUN, NR.VSRNO,
                               NR.VNDR, NR.VNDNM, NR.VNDNM1, NR.ADDR,
                               NR.PRNM, NR.NATN, NR.TELN, NR.FAXN,
                               NR.TLXN, NR.VPOST, NR.DIGUBUN,
                               'N', ' ') ;
END

