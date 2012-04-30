CREATE TRIGGER PBIPIS.T_INV401AI
   AFTER INSERT ON PBINV.INV401
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   ((NR.CLS = '23' OR NR.CLS = '43') AND
    (NR.SLIPTYPE = 'RP' OR NR.SLIPTYPE = 'RF' OR
     NR.SLIPTYPE = 'RM' OR NR.SLIPTYPE = 'SS' OR
     NR.SLIPTYPE = 'SM' OR NR.SLIPTYPE = 'RW' OR
     NR.SLIPTYPE = 'IW' OR NR.SLIPTYPE = 'EX'))
BEGIN
  DECLARE L_S_SLIP CHAR ;
  DECLARE L_S_INVSTCD CHAR ;
  DECLARE L_S_INVSTCD1 CHAR ;
  SET L_S_SLIP = ' ' ;
  IF (NR.SLIPTYPE = 'RP' OR NR.SLIPTYPE = 'RF' OR
      NR.SLIPTYPE = 'RM') THEN
     SET L_S_SLIP = '1' ;
     SET L_S_INVSTCD = 'U' ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'SS' OR NR.SLIPTYPE = 'SM')THEN
     SET L_S_SLIP = '2' ;
     SET L_S_INVSTCD = NR.INVSTCD ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'RW')THEN
     SET L_S_SLIP = '1' ;
     SET L_S_INVSTCD = NR.INVSTCD ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'IW')THEN
     SET L_S_SLIP = '2' ;
     SET L_S_INVSTCD = NR.INVSTCD ;
     SET L_S_INVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'EX')THEN
     SET L_S_SLIP = '3' ;
     SET L_S_INVSTCD = NR.EXFR ;
     SET L_S_INVSTCD1 = NR.EXTO ;
  END IF;
  INSERT INTO PBIPIS.PDINV401 (CHGDATE,   CHGCD, SLIPTYPE,
                               SRNO,      SRNO1, SRNO2,
                               XPLANT,    DIV,   ITNO,
                               INVSTCD,   TQTY4, INVSTCD1,
                               SLIPGUBUN, STSCD, DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.SLIPTYPE,
                               NR.SRNO,   NR.SRNO1, NR.SRNO2,
                               NR.XPLANT, NR.DIV,   NR.ITNO,
                               L_S_INVSTCD, NR.TQTY4, L_S_INVSTCD1,
                               L_S_SLIP, 'N', ' ') ;
END


