CREATE TRIGGER PBIPIS.T_INV101AU
   AFTER UPDATE OF XPLANT, DIV, PDCD, ITNO, CLS, SRCE, XUNIT, CONVQTY,
                   SAUD, COSTAV, ABCCD, WLOC, XPLAN ON PBINV.INV101
   REFERENCING NEW ROW AS NR
               OLD ROW AS OR
   FOR EACH ROW
   MODE DB2SQL
WHEN
   (NR.PDCD  <> OR.PDCD  OR NR.CLS   <> OR.CLS OR
    NR.SRCE  <> OR.SRCE  OR NR.XUNIT <> OR.XUNIT or
    NR.CONVQTY <> OR.CONVQTY OR NR.SAUD <> OR.SAUD or
    NR.ABCCD <> OR.ABCCD OR NR.WLOC <> OR.WLOC or
    NR.XPLAN <> OR.XPLAN OR NR.COSTAV <> OR.COSTAV)
BEGIN
   DECLARE l_n_cost  INTEGER DEFAULT 0 ;
   DECLARE l_s_stscd char ;
   set l_s_stscd = ' ' ;
   IF (NR.CLS = '23' OR NR.CLS = '43') THEN
      SET L_S_STSCD = ' ' ;
   ELSE
      IF (NR.PDCD    = OR.PDCD    AND NR.CLS   = OR.CLS   AND
          NR.SRCE    = OR.SRCE    AND NR.XUNIT = OR.XUNIT AND
          NR.CONVQTY = OR.CONVQTY AND NR.SAUD  = OR.SAUD  AND
          NR.ABCCD   = OR.ABCCD   AND NR.WLOC  = OR.WLOC  AND
          NR.XPLAN   = OR.XPLAN) THEN
          set l_s_stscd = '1' ;
      END IF;
   END IF ;
   IF (NR.CLS = '23' OR NR.CLS = '43') THEN
      set l_n_cost = INTEGER(nr.COSTAV) ;
   ELSE
      IF NR.SAUD = 0 THEN
         IF INTEGER(nr.COSTAV) = 0 then
            IF INTEGER(nr.COSTLS) = 0 then
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
   END IF;
   IF NR.XPLANT = 'Y' THEN
     IF NR.SAUD = OR.SAUD THEN
       set l_s_stscd = '1' ;
     END IF;
   END IF;
   IF L_S_STSCD = ' ' THEN
      INSERT INTO PBIPIS.PDINV101 (CHGDATE, CHGCD, XPLANT, DIV,
                                   PDCD, ITNO, CLS, SRCE,
                                   XUNIT, CONVQTY, SAUD,
                                   ABCCD, WLOC, XPLAN,
                                   STSCD, DOWNDATE)
        VALUES (CHAR(CURRENT TIMESTAMP), 'R', NR.XPLANT, NR.DIV,
                                   NR.PDCD, NR.ITNO, NR.CLS, NR.SRCE,
                                   NR.XUNIT, NR.CONVQTY, l_n_cost,
                                   NR.ABCCD, NR.WLOC, NR.XPLAN,
                                   'N', ' ');
   END IF;
END


