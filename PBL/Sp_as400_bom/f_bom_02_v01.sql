drop   function  pbpdm.f_bom_02 ;
create function  pbpdm.f_bom_02(
   a_comltd            varchar(2),
   a_plant             varchar(1),
   a_div               varchar(1),
   a_itno              varchar(12),
   a_date              varchar(8))
   returns             varchar(12)
   language sql
   modifies sql data
   begin
      declare l_s_itno   char(12) ;
      declare l_s_cnt    integer default 0 ;
      declare sqlcode    integer default 0 ;
      set l_s_itno = '' ;

      select opitn into l_s_itno from pbpdm.bom003
       where oplant = a_plant and odvsn = a_div and ofitn = a_itno
        and (( oedte = ' ' and  oedtm <= a_date ) or
          ( oedte <> ' ' and oedte >= a_date and oedtm <= a_date ))
      fetch first 1 row only;
      if ifnull(l_s_itno,'') <> '' then
         return l_s_itno ;
      end if ;

      select count(*) into l_s_cnt from pbpdm.bom003
       where oplant = a_plant and odvsn = a_div and opitn = a_itno
        and (( oedte = ' ' and  oedtm <= a_date ) or
         ( oedte <> ' ' and oedte >= a_date and oedtm <= a_date )) ;
      if l_s_cnt > 0 then
         return '*';
      else
         return '';
      end if ;
   end

