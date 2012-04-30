CREATE TRIGGER PBIPIS.T_INV401AD
   AFTER DELETE ON PBINV.INV401
   REFERENCING OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   ((OR.CLS = '23' OR OR.CLS = '43') AND
    (OR.SLIPTYPE = 'RP' OR OR.SLIPTYPE = 'RF' OR
     OR.SLIPTYPE = 'RM' OR OR.SLIPTYPE = 'SS' OR
     OR.SLIPTYPE = 'SM' OR OR.SLIPTYPE = 'RW' OR
     OR.SLIPTYPE = 'IW' OR OR.SLIPTYPE = 'EX'))
BEGIN
  DECLARE L_S_SLIP CHAR ;
  DECLARE L_S_INVSTCD CHAR ;
  DECLARE L_S_INVSTCD1 CHAR ;
  SET L_S_SLIP = ' ' ;
  IF (OR.SLIPTYPE = 'RP' OR OR.SLIPTYPE = 'RF' OR
      OR.SLIPTYPE = 'RM') THEN
     SET L_S_SLIP = '1' ;
     SET L_S_INVSTCD = 'U' ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (OR.SLIPTYPE = 'SS' OR OR.SLIPTYPE = 'SM')THEN
     SET L_S_SLIP = '2' ;
     SET L_S_INVSTCD = OR.INVSTCD ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (OR.SLIPTYPE = 'RW')THEN
     SET L_S_SLIP = '1' ;
     SET L_S_INVSTCD = OR.INVSTCD ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (OR.SLIPTYPE = 'IW')THEN
     SET L_S_SLIP = '2' ;
     SET L_S_INVSTCD = OR.INVSTCD ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (OR.SLIPTYPE = 'EX')THEN
     SET L_S_SLIP = '3' ;
     SET L_S_INVSTCD = OR.EXFR ;
     SET L_S_INVSTCD1 = OR.EXTO ;
  END IF;
  INSERT INTO PBIPIS.PDINV401 (CHGDATE,   CHGCD, SLIPTYPE,
                               SRNO,      SRNO1, SRNO2,
                               XPLANT,    DIV,   ITNO,
                               INVSTCD,   TQTY4, INVSTCD1,
                               SLIPGUBUN, STSCD, DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.SLIPTYPE,
                               OR.SRNO,   OR.SRNO1, OR.SRNO2,
                               OR.XPLANT, OR.DIV,   OR.ITNO,
                               L_S_INVSTCD, OR.TQTY4, L_S_INVSTCD1,
                               L_S_SLIP, 'N', ' ') ;
END


