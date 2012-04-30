DROP   FUNCTION  PBPDM.F_BOM_02 ;
CREATE FUNCTION  PBPDM.F_BOM_02(
   A_COMLTD            VARCHAR(2),
   A_PLANT             VARCHAR(1),
   A_DIV               VARCHAR(1),
   A_ITNO              VARCHAR(12),
   A_DATE              VARCHAR(8))
   RETURNS             VARCHAR(12)
   LANGUAGE SQL
   MODIFIES SQL DATA
   BEGIN
      DECLARE L_S_ITNO   CHAR(12) ;
      DECLARE L_S_CNT    INTEGER DEFAULT 0 ;
      DECLARE SQLCODE    INTEGER DEFAULT 0 ;
      SET L_S_ITNO = '' ;
      select count(*) into l_s_cnt from pbpdm.bom003
       where oplant = a_plant and odvsn = a_div and opitn = a_itno
        and (( oedte = ' ' and  oedtm <= a_date ) or
          ( oedte <> ' ' and oedte >= a_date and oedtm <= a_date )) ;
      if l_s_cnt > 0 then
         return '*';
      end if ;
      select opitn into l_s_itno from pbpdm.bom003
       where oplant = a_plant and odvsn = a_div and ofitn = a_itno
        and (( oedte = ' ' and  oedtm <= a_date ) or
         ( oedte <> ' ' and oedte >= a_date and oedtm <= a_date )) ;
      return l_s_itno ;
   END

