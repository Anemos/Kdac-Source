-- file name : pbbpm.sf_bpm_006
-- function name : pbbpm.sf_bpm_006
-- desc : 이체품 누적호환율 가져오기

drop   function  pbbpm.sf_bpm_006 ;
create function  pbbpm.sf_bpm_006(
   a_comltd            varchar(2),
   a_xyear             varchar(4),
   a_rev               varchar(2),
   a_gubun             varchar(1),
   a_plant             varchar(1),
   a_div               varchar(1),
   a_mdno              varchar(12),
   a_mdnopre           varchar(12))
   returns             numeric(7,4)
   language sql
   modifies sql data
   begin
   declare p_cumorate  numeric(7,4);
   declare sqlcode    integer default 0 ;

   if a_gubun = 'B' then
    return 1.0000;
   else
    select sum(a.bcumorate) into p_cumorate
    from pbbpm.bpm508 a inner join pbbpm.bpm503 b
      on a.xyear = b.xyear and a.brev = b.revno and
        a.balcd = b.xplant and a.baldiv = b.div and
        a.bchno = b.itno and a.bgubun = 'B'
    where a.comltd = a_comltd and a.xyear = a_xyear and
      a.brev = a_rev and a.balcd = a_plant and
      a.baldiv = a_div and a.bmdno = a_mdnopre and
      a.bchno = a_mdno and a.bplant <> a.balcd and
      b.srce = '03' and
      a.bchno in ( select itno from pbbpm.bpm503
            where xyear = a_xyear and revno = a_rev and srce = '05' );

    return ifnull(p_cumorate,1);
   end if;

   end
