CREATE TRIGGER PBIPIS.T_SLE501AD
   AFTER DELETE ON PBSLE.SLE501
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  if or.dtype = 'C' then
     INSERT INTO PBIPIS.PDSLE501 (CHGDATE, CHGCD,   CSRNO,  CSRNO1,
                                  CSRNO2,  DTYPE,   CITNO,  ITNO,
                                  SCUSTCD, SRNO,    XPLANT, DIV,
                                  STYPE,   CNLCD,   INVOICE, DCQTY,
                                  SCQTY,   RCQTY,   SLNO,
                                  STSCD,   DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.CSRNO, OR.CSRNO1,
                                  OR.CSRNO2, OR.DTYPE, OR.CITNO,
                                  OR.ITNO,   OR.CUSTCD, OR.SRNO,
                                  OR.XPLANT, OR.DIV,     OR.STYPE,
                                  OR.CNLCD, OR.INVOICE, OR.DCQTY,
                                  OR.SCQTY, OR.RCQTY, OR.DKDT,
                                  'N', ' ') ;
  end if ;
END

