DROP TRIGGER PBIPIS.T_INV201AI;

CREATE TRIGGER PBIPIS.T_INV201AI
   AFTER INSERT ON PBINV.INV201
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
  DECLARE SQLCODE  INTEGER default 0 ;
  DECLARE SQLSTATE CHAR(5) default '00000' ;
  DECLARE L_N_DCKQT NUMERIC(11,1) DEFAULT 0 ;
  DECLARE l_s_cls  CHAR(2) ;
  if substr(nr.slno,3,1) = 'D' then
     set l_n_dckqt = nr.xcost ;
  else
     set l_n_dckqt = nr.dckqt;
  end if;
  SELECT CLS INTO L_S_CLS FROM PBINV.INV101
  WHERE COMLTD = '01' AND XPLANT = NR.XPLANT AND DIV = NR.DIV
        and ITNO = NR.ITNO ;
  IF SQLCODE <> 0 THEN
     SET l_s_cls = ' ' ;
  END IF;
  if (L_S_CLS = '10') OR (L_S_CLS = '20') OR (L_S_CLS = '35') OR
     (L_S_CLS = '40') OR (L_S_CLS = '50') then
     INSERT INTO PBIPIS.PDINV201 (CHGDATE, CHGCD, XPLANT, DIV,
                                  SLNO,    DCKDT, VNDR,  ITNO,
                                  QCCD,    DCKQT,
                                  DCAMT,   BLNO,  FOBAMT,
                                  STSCD, DOWNDATE)
       VALUES (CHAR(CURRENT TIMESTAMP), 'A', nr.XPLANT, nr.DIV,
                                  nr.SLNO,  nr.DCKDT, nr.VNDR, nr.ITNO,
                                  SUBSTR(NR.EXTD,1,1), l_n_dckqt,
                                  nr.DCAMT, nr.BLNO, nr.FOBAMT,
                                  'N', ' ')  ;
  end if ;
END


