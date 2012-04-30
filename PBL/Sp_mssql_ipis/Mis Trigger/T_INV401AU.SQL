CREATE TRIGGER PBIPIS.T_INV401AU
   AFTER UPDATE OF XPLANT, DIV, ITNO, INVSTCD, TQTY4, EXFR, EXTO
                   ON PBINV.INV401
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   ((NR.CLS = '23' OR NR.CLS = '43') AND
    (NR.SLIPTYPE = 'RP' OR NR.SLIPTYPE = 'RF' OR
     NR.SLIPTYPE = 'RM' OR NR.SLIPTYPE = 'SS' OR
     NR.SLIPTYPE = 'SM' OR NR.SLIPTYPE = 'RW' OR
     NR.SLIPTYPE = 'IW' OR NR.SLIPTYPE = 'EX') AND
    (NR.XPLANT <> OR.XPLANT OR NR.DIV   <> OR.DIV OR
     NR.ITNO   <> OR.ITNO   OR NR.INVSTCD <> OR.INVSTCD OR
     NR.TQTY4  <> OR.TQTY4  OR NR.EXFR  <> OR.EXFR  or
     NR.EXTO  <> OR.EXTO))
BEGIN
  DECLARE L_S_SLIP CHAR ;
  DECLARE L_S_OLDINVSTCD CHAR ;
  DECLARE L_S_OLDINVSTCD1 CHAR ;
  DECLARE L_S_NEWINVSTCD CHAR ;
  DECLARE L_S_NEWINVSTCD1 CHAR ;
  SET L_S_SLIP = ' ' ;
  IF (NR.SLIPTYPE = 'RP' OR NR.SLIPTYPE = 'RF' OR
      NR.SLIPTYPE = 'RM') THEN
     SET L_S_SLIP = '1' ;
     SET L_S_OLDINVSTCD = 'U' ;
     SET L_S_OLDINVSTCD1 = ' ' ;
     SET L_S_NEWINVSTCD = 'U' ;
     SET L_S_NEWINVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'SS' OR NR.SLIPTYPE = 'SM')THEN
     SET L_S_SLIP = '2' ;
     SET L_S_OLDINVSTCD = OR.INVSTCD ;
     SET L_S_OLDINVSTCD1 = ' ' ;
     SET L_S_NEWINVSTCD = NR.INVSTCD ;
     SET L_S_NEWINVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'RW')THEN
     SET L_S_SLIP = '1' ;
     SET L_S_OLDINVSTCD = OR.INVSTCD ;
     SET L_S_OLDINVSTCD1 = ' ' ;
     SET L_S_NEWINVSTCD = NR.INVSTCD ;
     SET L_S_NEWINVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'IW')THEN
     SET L_S_SLIP = '2' ;
     SET L_S_OLDINVSTCD = OR.INVSTCD ;
     SET L_S_OLDINVSTCD1 = ' ' ;
     SET L_S_NEWINVSTCD = NR.INVSTCD ;
     SET L_S_NEWINVSTCD1 = ' ' ;
  END IF;
  IF (NR.SLIPTYPE = 'EX')THEN
     SET L_S_SLIP = '3' ;
     SET L_S_OLDINVSTCD = OR.EXFR ;
     SET L_S_OLDINVSTCD1 = OR.EXTO ;
     SET L_S_NEWINVSTCD = NR.EXFR ;
     SET L_S_NEWINVSTCD1 = NR.EXTO ;
  END IF;
  INSERT INTO PBIPIS.PDINV401 (CHGDATE,   CHGCD, SLIPTYPE,
                               SRNO,      SRNO1, SRNO2,
                               XPLANT,    DIV,   ITNO,
                               INVSTCD,   TQTY4, INVSTCD1,
                               SLIPGUBUN, STSCD, DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'D', OR.SLIPTYPE,
                               OR.SRNO,   OR.SRNO1, OR.SRNO2,
                               OR.XPLANT, OR.DIV,   OR.ITNO,
                               L_S_OLDINVSTCD, OR.TQTY4,
                               L_S_OLDINVSTCD1,
                               L_S_SLIP, 'N', ' ') ;
  INSERT INTO PBIPIS.PDINV401 (CHGDATE,   CHGCD, SLIPTYPE,
                               SRNO,      SRNO1, SRNO2,
                               XPLANT,    DIV,   ITNO,
                               INVSTCD,   TQTY4, INVSTCD1,
                               SLIPGUBUN, STSCD, DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.SLIPTYPE,
                               NR.SRNO,   NR.SRNO1, NR.SRNO2,
                               NR.XPLANT, NR.DIV,   NR.ITNO,
                               L_S_NEWINVSTCD, NR.TQTY4,
                               L_S_NEWINVSTCD1,
                               L_S_SLIP, 'N', ' ') ;
END


