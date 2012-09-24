DROP FUNCTION pbwip.f_wip_qty;
CREATE FUNCTION  pbwip.f_wip_qty(
   a_year varchar(4),a_mont varchar(2),a_cmcd  varchar(2),
   a_plant varchar(1), a_dvsn varchar(1), a_dept varchar(5),
   a_itno varchar(15), a_gubun varchar(1) )
   RETURNS   numeric(11,2)
   LANGUAGE SQL
   BEGIN
      declare a_qty   numeric(11,2);
      declare a_scrp  numeric(11,2);
      declare a_retn  numeric(11,2);
      DECLARE SQLCODE INTEGER DEFAULT 0;

      SELECT WFPHQT,WFSCRP,WFRETN INTO a_qTY,a_scrp,a_retn
             FROM PBWIP.WIP006
             WHERE WFYEAR = a_year AND WFMONTH = a_mont AND
                   WFCMCD = a_cmcd AND WFPLANT = a_plant AND
                   WFDVSN = a_dvsn AND WFDEPT  = a_dept  AND
                   WFITNO = a_itno;
      IF SQLCODE <> 0 THEN
         RETURN 0;
      END IF;
      CASE a_gubun
         WHEN '2' THEN
            RETURN a_scrp;
         WHEN '3' THEN
            RETURN a_retn;
         ELSE
            RETURN a_qty;
      END CASE;
   END
