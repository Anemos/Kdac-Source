CREATE TRIGGER PBIPIS.T_SLE301AU
   AFTER UPDATE OF PRTCD ON PBSLE.SLE301
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  IF (NR.PRTCD > '1' AND OR.PRTCD < '2') THEN
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
       VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.SRNO,    NR.XPLAN,
                      NR.SRDT,    NR.SRTM,    NR.CUSTCD, NR.SCUSTCD,
                      NR.INVOICE, NR.INDT,    NR.MLC,    NR.MLCDT,
                      NR.LLC,     NR.LLCDT,   NR.ELNO1,  NR.ELNO1DT,
                      NR.ELNO2,   NR.ELNO2DT, NR.DPDT,   NR.DPTM,
                      NR.SELLER,  NR.CONSIG,  NR.BUYER,  NR.NOTIFY,
                      NR.REF1,    NR.REF2,    NR.TRANS,  NR.FROM,
                      NR.DSTN,    NR.TRPY,    NR.TRDL,   NR.RMRK,
                      NR.CMNT,    NR.NWEGT,   NR.GWEGT,  NR.CBM,
                      NR.DKTM,    NR.RDEPT,   NR.RDCHG,  NR.PAYCD,
                      NR.CSNGB,   NR.IVGB,    NR.ASCSN,  NR.DBSRNO,
                      NR.EXTD,    NR.INPTID,  NR.INPTDT, NR.UPDTID,
                      NR.UPDTDT,
                            'N', ' ') ;
  END IF ;
  IF (NR.PRTCD < '2' AND OR.PRTCD > '1') THEN
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
       VALUES (CHAR(CURRENT TIMESTAMP), 'D', NR.SRNO,    NR.XPLAN,
                      NR.SRDT,    NR.SRTM,    NR.CUSTCD, NR.SCUSTCD,
                      NR.INVOICE, NR.INDT,    NR.MLC,    NR.MLCDT,
                      NR.LLC,     NR.LLCDT,   NR.ELNO1,  NR.ELNO1DT,
                      NR.ELNO2,   NR.ELNO2DT, NR.DPDT,   NR.DPTM,
                      NR.SELLER,  NR.CONSIG,  NR.BUYER,  NR.NOTIFY,
                      NR.REF1,    NR.REF2,    NR.TRANS,  NR.FROM,
                      NR.DSTN,    NR.TRPY,    NR.TRDL,   NR.RMRK,
                      NR.CMNT,    NR.NWEGT,   NR.GWEGT,  NR.CBM,
                      NR.DKTM,    NR.RDEPT,   NR.RDCHG,  NR.PAYCD,
                      NR.CSNGB,   NR.IVGB,    NR.ASCSN,  NR.DBSRNO,
                      NR.EXTD,    NR.INPTID,  NR.INPTDT, NR.UPDTID,
                      NR.UPDTDT,
                            'N', ' ') ;
  END IF ;
END


