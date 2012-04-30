CREATE TRIGGER PBIPIS.T_INV201AD
   AFTER DELETE ON PBINV.INV201
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
 WHEN
   (OR.EXTD <> 'Q' and or.DEXQT = 0 and or.NDEXQT = 0)
BEGIN
  DECLARE SQLCODE  INTEGER default 0 ;
  DECLARE SQLSTATE CHAR(5) default '00000' ;
  DECLARE l_s_cls  char(2) ;
  DECLARE L_N_DCKQT NUMERIC(11,1) DEFAULT 0 ;
  SELECT VALUE(SUM(DCKQT),0) INTO L_N_DCKQT FROM PBINV.INV201
            WHERE COMLTD = '01' AND SLNO = OR.SLNO AND
                  ITNO   = OR.ITNO ;
  IF SQLCODE <> 0 THEN
     SET L_N_DCKQT = 0 ;
  END IF;
  SELECT CLS INTO L_S_CLS FROM PBINV.INV101
  WHERE COMLTD = '01' AND XPLANT = OR.XPLANT AND DIV = OR.DIV
        and ITNO = OR.ITNO ;
  IF SQLCODE <> 0 THEN
     SET l_s_cls = ' ' ;
  END IF;
  if l_s_cls = '10' or L_S_CLS = '20' or l_s_cls = '35' or
     l_s_cls = '40' or L_S_CLS = '50' then
     IF L_N_DCKQT = 0 THEN
        INSERT INTO PBIPIS.PDINV201 (CHGDATE, CHGCD, XPLANT, DIV,
                                     SLNO,    DCKDT, VNDR,  ITNO,
                                     QCCD, DCKQT,
                                     STSCD, DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.XPLANT, OR.DIV,
                                     OR.SLNO,   OR.DCKDT,  OR.VNDR,
                                 or.itno,   SUBSTR(OR.EXTD,1,1), OR.DCKQT,
                                     'N', ' ')  ;
     ELSE
        INSERT INTO PBIPIS.PDINV201 (CHGDATE, CHGCD, XPLANT, DIV,
                                     SLNO,    DCKDT, VNDR,  ITNO,
                                     QCCD, DCKQT,
                                     STSCD, DOWNDATE)
          VALUES (CHAR(CURRENT TIMESTAMP), 'R', OR.XPLANT, OR.DIV,
                                     OR.SLNO,   OR.DCKDT,  OR.VNDR,
                                 or.itno, SUBSTR(OR.EXTD,1,1), L_N_DCKQT,
                                     'N', ' ')  ;
     END IF;
  end if ;
END


