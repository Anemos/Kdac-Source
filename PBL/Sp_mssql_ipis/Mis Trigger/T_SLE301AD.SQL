CREATE TRIGGER PBIPIS.T_SLE301AD
   AFTER DELETE  ON PBSLE.SLE301
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  IF (OR.PRTCD > '1') THEN
     INSERT INTO PBIPIS.PDSLE301 (CHGDATE, CHGCD,   SRNO,    XPLAN,
                                  SRDT,    SRTM,    CUSTCD,  SCUSTCD,
                                  INVOICE, INDT,    MLC,     MLCDT,
                                  LLC,     LLCDT,   ELNO1,   ELNO1DT,
                                  ELNO2,   ELNO2DT, DPDT,    DPTM,
                                  SELLER,  CONSIG,  BUYER,   NOTIFY,
                                  REF1,    REF2,    TRANS,   FROM,
                                  DSTN,    TRPY,    TRDL,    RMRK,
                                  CMNT,    NWEGT,   GWEGT,   CBM,
                                  DKTM,    RDEPT,   RDCHG,   PAYCD,
                                  CSNGB,   IVGB,    ASCSN,   DBSRNO,
                                  EXTD,    INPTID,  INPTDT,  UPDTID,
                                  UPDTDT,
                                  STSCD,   DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.SRNO,    OR.XPLAN,
                      OR.SRDT,    OR.SRTM,    OR.CUSTCD, OR.SCUSTCD,
                      OR.INVOICE, OR.INDT,    OR.MLC,    OR.MLCDT,
                      OR.LLC,     OR.LLCDT,   OR.ELNO1,  OR.ELNO1DT,
                      OR.ELNO2,   OR.ELNO2DT, OR.DPDT,   OR.DPTM,
                      OR.SELLER,  OR.CONSIG,  OR.BUYER,  OR.NOTIFY,
                      OR.REF1,    OR.REF2,    OR.TRANS,  OR.FROM,
                      OR.DSTN,    OR.TRPY,    OR.TRDL,   OR.RMRK,
                      OR.CMNT,    OR.NWEGT,   OR.GWEGT,  OR.CBM,
                      OR.DKTM,    OR.RDEPT,   OR.RDCHG,  OR.PAYCD,
                      OR.CSNGB,   OR.IVGB,    OR.ASCSN,  OR.DBSRNO,
                      OR.EXTD,    OR.INPTID,  OR.INPTDT, OR.UPDTID,
                      OR.UPDTDT,
                            'N', ' ') ;
  END IF ;
END


