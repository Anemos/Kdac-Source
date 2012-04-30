CREATE TRIGGER PBIPIS.T_SLE501AI
   AFTER INSERT ON PBSLE.SLE501
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  if nr.dtype = 'C' then
     INSERT INTO PBIPIS.PDSLE501 (CHGDATE, CHGCD,   CSRNO,  CSRNO1,
                                  CSRNO2,  DTYPE,   CITNO,  ITNO,
                                  SCUSTCD, SRNO,    XPLANT, DIV,
                                  STYPE,   CNLCD,   INVOICE, DCQTY,
                                  SCQTY,   RCQTY,   SLNO,
                                  STSCD,   DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.CSRNO,   NR.CSRNO1,
                                  NR.CSRNO2, NR.DTYPE,   NR.CITNO,
                                  NR.ITNO,   NR.CUSTCD,  NR.SRNO,
                                  NR.XPLANT, NR.DIV,     NR.STYPE,
                                  NR.CNLCD,  NR.INVOICE, NR.DCQTY,
                                  NR.SCQTY,  NR.RCQTY,   NR.DKDT,
                                  'N', ' ') ;
  end if ;
END


