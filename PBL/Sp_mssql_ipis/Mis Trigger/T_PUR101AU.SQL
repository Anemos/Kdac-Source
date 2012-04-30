CREATE TRIGGER PBIPIS.T_PUR101AU
   AFTER UPDATE OF SCGUBUN, VSRNO, VNDR, VNDNM, VNDNM1, ADDR, PRNM,
                   NATN, TELN, FAXN, TLXN, VPOST,DIGUBUN
                   ON PBPUR.PUR101
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
    (NR.SCGUBUN IN ('S', 'C'))
BEGIN
  INSERT INTO PBIPIS.PDPUR101 (CHGDATE, CHGCD, SCGUBUN, VSRNO,
                               VNDR,    VNDNM, VNDNM1,  ADDR,
                               PRNM,    NATN,  TELN,    FAXN,
                               TLXN,    VPOST, DIGUBUN,
                               STSCD,   DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'R', NR.SCGUBUN, NR.VSRNO,
                               NR.VNDR, NR.VNDNM, NR.VNDNM1, NR.ADDR,
                               NR.PRNM, NR.NATN, NR.TELN, NR.FAXN,
                               NR.TLXN, NR.VPOST, NR.DIGUBUN,
                               'N', ' ') ;
END


