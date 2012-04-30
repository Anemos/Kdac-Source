-- file name : pbbpm.sf_bpm_004
-- function name : pbbpm.sf_bpm_004 수출가 적용
-- desc : 하위레벨의 유상단가 차이의 누계금액 계산
-- woct '9999' : 하위전체 8888인 품목의 차이금액 합계 계산
-- woct '8888' : 1레벨 하위 8888 품목의 차이 합계 계산

drop   function  pbbpm.sf_bpm_004 ;
create function  pbbpm.sf_bpm_004(
   a_comltd            varchar(2),
   a_xyear             varchar(4),
   a_rev               varchar(2),
   a_gubun             varchar(1),
   a_plant             varchar(1),
   a_div               varchar(1),
   a_mdno              varchar(12),
   a_pitno             varchar(12),
   a_level             numeric(2,0),
   a_serial            numeric(4,0))
   returns             numeric(14,6)
   language sql
   modifies sql data
   begin
      declare ld_amtsum  numeric(13,6);
      declare p_serl varchar(600);
      declare li_nextlev numeric(2,0) default 0 ;
      declare sqlcode    integer default 0 ;

      select extd into p_serl
      from pbbpm.bpm508
      where comltd = a_comltd and xyear = a_xyear and
            brev = a_rev and bgubun = a_gubun and
            bplant = a_plant and bdiv = a_div and
            bmdno = a_mdno and bserno = a_serial;

      set li_nextlev = a_level + 1;
      set p_serl = concat(trim(p_serl),'%');
      select sum(a.zwoneamt - a.zwonsamt) into ld_amtsum
      from pbbpm.bpm514a a inner join pbbpm.bpm508 b
        on a.zcmcd = b.comltd and a.zdate = b.xyear and
          a.zbrev = b.brev and a.zgubun = b.bgubun and
          a.zplant = b.bplant and a.zdiv = b.bdiv and
          a.zmdno = b.bmdno and a.zserial = b.bserno
      where a.zcmcd = a_comltd and a.zdate = a_xyear and
            a.zbrev = a_rev and a.zgubun = a_gubun and
            a.zplant = a_plant and a.zdiv = a_div and
            a.zmdno = a_mdno and a.zpitno = a_pitno and
            a.zwkct = '8888' and a.zlevel = li_nextlev and
            b.extd like p_serl;

      return ifnull(ld_amtsum,0);
   end
