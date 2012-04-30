DROP TRIGGER PBIPIS.T_INV101AI;

CREATE TRIGGER PBIPIS.T_INV101AI
   AFTER INSERT ON PBINV.INV101
   REFERENCING NEW ROW AS NR
   FOR EACH ROW
   MODE DB2SQL
BEGIN
   DECLARE l_n_cost INTEGER DEFAULT 0 ;
   IF nr.SAUD = 0 THEN
      IF INTEGER(nr.COSTAV) = 0 then
         IF INTEGER(NR.COSTLS) = 0 then
            set l_n_cost = 0 ;
         ELSE
            set l_n_cost = INTEGER(nr.COSTLS) ;
         end if;
      ELSE
         set l_n_cost = INTEGER(nr.COSTAV) ;
      end if;
   ELSE
      set l_n_cost = nr.SAUD ;
   end if;
  INSERT INTO PBIPIS.PDINV101 (CHGDATE, CHGCD, XPLANT, DIV,
                               PDCD, ITNO, CLS, SRCE,
                               XUNIT, CONVQTY,  SAUD,
                               ABCCD, WLOC,     XPLAN, MCNO,
                               STSCD, DOWNDATE)
    VALUES (CHAR(CURRENT TIMESTAMP), 'A', NR.XPLANT, NR.DIV,
                               NR.PDCD, NR.ITNO, NR.CLS, NR.SRCE,
                               NR.XUNIT, NR.CONVQTY, l_n_cost,
                               NR.ABCCD, NR.WLOC, NR.XPLAN, NR.MCNO,
                               'N', ' ');
END
