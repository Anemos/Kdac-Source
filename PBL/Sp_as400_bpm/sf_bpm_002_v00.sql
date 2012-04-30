drop   function  pbbpm.sf_bpm_002 ;
create function  pbbpm.sf_bpm_002(
   a_comltd            varchar(2),
   a_xyear             varchar(4),
   a_rev               varchar(2),
   a_gubun             varchar(1),
   a_plant             varchar(1),
   a_div               varchar(1),
   a_itno              varchar(12),
   a_seqgb             varchar(1),
   a_musge             varchar(1))
   returns             numeric(13,6)
   language sql
   modifies sql data
   begin
      declare ls_slecym  char(6) ;
      declare ln_fxcost  numeric(13,6);
      declare li_cnt     integer default 0 ;
      declare sqlcode    integer default 0 ;

      if a_gubun = 'A' then
        set ls_slecym = concat(a_xyear,'0W');
      else
        set ls_slecym = concat(a_xyear,'0R');
      end if;

      select count(*), sum(fxcost) into li_cnt,ln_fxcost
      from pbsle.sle226
      where comltd = a_comltd and gubun = a_gubun and
        cym = ls_slecym and xplant = a_plant and
        div = a_div and itno = a_itno
      fetch first 1 row only;
      if li_cnt > 0 then
         return ln_fxcost;
      end if ;

      select mcmcd into ln_fxcost from pbbpm.bpm515
      where comltd = a_comltd and myear = a_xyear and
        mbrev = a_rev and mgubun = a_gubun and
        mplant = a_plant and mdiv = a_div and
        mmdno = a_itno and mseqgb = a_seqgb and
        musge = a_musge
      fetch first 1 row only;

      return ln_fxcost ;
   end
