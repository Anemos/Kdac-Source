CREATE TRIGGER PBIPIS.T_SLE501AU
   AFTER UPDATE OF CSRNO, CSRNO1, CSRNO2, DTYPE, CITNO, ITNO,
                   CUSTCD, SRNO, XPLANT, DIV, STYPE, CNLCD,
                   INVOICE, DCQTY, SCQTY, RCQTY, DKDT
                   ON PBSLE.SLE501
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   (NR.CSRNO   <> OR.CSRNO   OR NR.CSRNO1  <> OR.CSRNO1 OR
    NR.CSRNO2  <> OR.CSRNO2  OR NR.DTYPE   <> OR.DTYPE  OR
    NR.CITNO   <> OR.CITNO   OR NR.ITNO    <> OR.ITNO   OR
    NR.CUSTCD <> OR.CUSTCD OR NR.SRNO    <> OR.SRNO   OR
    NR.XPLANT  <> OR.XPLANT  OR NR.DIV     <> OR.DIV    OR
    NR.STYPE   <> OR.STYPE   OR NR.CNLCD   <> OR.CNLCD  OR
    NR.INVOICE <> OR.INVOICE OR NR.DCQTY   <> OR.DCQTY  OR
    NR.SCQTY   <> OR.SCQTY   OR NR.RCQTY   <> OR.RCQTY  OR
    NR.DKDT    <> OR.DKDT)
BEGIN
  if nr.dtype = 'C' then
      INSERT INTO PBIPIS.PDSLE501 (CHGDATE, CHGCD,   CSRNO,  CSRNO1,
                                  CSRNO2,  DTYPE,   CITNO,  ITNO,
                                  SCUSTCD, SRNO,    XPLANT, DIV,
                                  STYPE,   CNLCD,   INVOICE, DCQTY,
                                  SCQTY,   RCQTY,   SLNO,
                                  STSCD,   DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'R', NR.CSRNO,   NR.CSRNO1,
                                  NR.CSRNO2, NR.DTYPE,   NR.CITNO,
                                  NR.ITNO,   NR.CUSTCD, NR.SRNO,
                                  NR.XPLANT, NR.DIV,     NR.STYPE,
                                  NR.CNLCD,  NR.INVOICE, NR.DCQTY,
                                  NR.SCQTY,  NR.RCQTY,   NR.DKDT,
                                  'N', ' ') ;
  end if ;
END


