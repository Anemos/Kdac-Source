-- file name : pbbpm.sp_bpm_001
-- procedure name : pbbpm.sp_bpm_001
-- desc : Creation bpm508 : 사업계획 bom 원단위정보 생성
-- 배분후('A') - BOM전개('D' : 호환주품번 공장별전개)
-- 배분전('B') - BOM전개('B' : 호환주품번 전공장전개)
-- 사업계획 매출 버전 a_rev ('0A'~ )

drop procedure pbbpm.sp_bpm_001;
create procedure pbbpm.sp_bpm_001 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_xyear char(4),
in a_applydate char(10),
in a_divcode char(1),
in a_expcode char(1),
in a_rev char(2),
in a_lastdate char(8),
in a_lastemp char(6))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
declare p_mdno varchar(12);
declare p_mdcd varchar(4);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_serno integer;
declare p_prno varchar(12);
declare p_chno varchar(12);
declare p_lev integer;
declare p_lolev integer;
declare p_xunit char(2);
declare p_wkct char(4);
declare p_prqt numeric(9,3);
declare p_wkprqt numeric(9,3);
declare p_prqt1 numeric(9,3);
declare p_alcd char(1);
declare p_aldiv char(1);
declare p_you char(1);
declare p_convqty  numeric(13,4);
declare p_explant char(1);
declare p_exdv char(1);
declare p_cls char(2);
declare p_srce char(2);
declare p_grad char(1);
declare p_altno varchar(12);
declare p_calc char(1);
declare p_comcd  char(1);
declare p_fmdt varchar(8);
declare p_todt varchar(8);
declare p_serl varchar(600);
declare p_ygchk char(1);
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Product item
declare bpm501a_cursor Cursor for
 select distinct a.amdno,a.apdcd,ifnull(b.xunit,''),
   ifnull(c.cls,''),ifnull(c.srce,''),ifnull(c.convqty,1)
 from pbbpm.bpm501 a left outer join pbbpm.bpm502 b
    on a.ayear = b.xyear and a.arev = b.revno and
       a.amdno = b.itno
   left outer join pbbpm.bpm503 c
    on a.ayear = c.xyear and a.arev = c.revno and
       a.aplant = c.xplant and a.adiv = c.div and
       a.amdno = c.itno
 where a.comltd = a_comltd and a.ayear = a_xyear and
   a.aplant = a_plant and a.adiv = a_dvsn and
   a.acode = a_divcode and a.seqgb <> 'S' and
   a.arev = a_rev;
-- Get bom list
declare bpm501b_cursor cursor for
  select a.tplnt,a.tdvsn,a.tpitn,a.tcitn,a.tlevel,
    a.twkct,a.tqtym,a.tqty1,a.toscd,a.texplant,a.texdv,
    ifnull(b.xunit,''),ifnull(c.cls,''),ifnull(c.srce,''),
    case when a.topcd = '1' then a.toption else '' end,
    a.toption,a.tcalculate,a.tedtm,a.tedte,a.tcomcd,a.tserl,a.tygchk
  from qtemp.tmp_bpm a left outer join pbbpm.bpm502 b
    on b.xyear = a_xyear and b.revno = a_rev and
       b.itno = a.tcitn
    left outer join pbbpm.bpm503 c
    on c.xyear = a_xyear and c.revno = a_rev and
      a.tplnt = c.xplant and
      a.tdvsn = c.div and a.tcitn = c.itno
  order by tserl;

declare continue handler for not_found
  set at_end = 1;

delete from pbbpm.bpm508
where comltd = a_comltd and xyear = a_xyear and
  brev = a_rev and bgubun = a_divcode and
  bplant = a_plant and bdiv = a_dvsn;

set at_end = 0;
open bpm501a_cursor;
inc_loop:
loop
  fetch bpm501a_cursor into p_mdno,p_mdcd,p_xunit,
    p_cls,p_srce,p_convqty;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  if p_cls = '35' or p_srce = '01' or
      p_srce = '02' or p_srce = '04' then
    set p_wkprqt = 1 * p_convqty;

    select case when count(*) > 0 then 'Y' else 'N' end
    into p_ygchk
    from pbbpm.bpm504 a
    where a.pcmcd = a_comltd and a.xyear = a_xyear and
      a.revno = a_rev and a.plant = a_plant and
      a.pdvsn = a_dvsn and a.ppitn = p_mdno and
      a.pwkct = '8888' and
      (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
      ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ));
    if sqlcode <> 0 or at_end = 1 then
      select pexplant,pexdv
      into p_explant, p_exdv
      from pbbpm.bpm504 a
      where a.pcmcd = a_comltd and a.xyear = a_xyear and
        a.revno = a_rev and a.plant = a_plant and
        a.pdvsn = a_dvsn and a.pcitn = p_mdno and
        a.pwkct = '8888' and
        (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
        ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ))
      order by a.pexdv desc
      fetch first 1 row only;
      if sqlcode <> 0 or trim(p_exdv) = '' then
        set p_ygchk = 'N';
      else
        select case when count(*) > 0 then 'Y' else 'N' end
        into p_ygchk
        from pbbpm.bpm504 a
        where a.pcmcd = a_comltd and a.xyear = a_xyear and
          a.revno = a_rev and a.plant = p_explant and
          a.pdvsn = p_exdv and a.ppitn = p_mdno and
          a.pwkct = '8888' and
          (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
          ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ));
      end if;
    end if;

    insert into pbbpm.bpm508
    ( comltd,xyear,brev,bgubun,bplant,bdiv,bmdcd,bmdno,
      bserno,bprno,bchno,blev,blole,bum,bwoct,bprqt,bprqt1,
      bfmdt,btodt,balcd,baldiv,byou,bgrad,baltno,bcalc,bcomcd,
      bygchk,extd,updtid,updtdt )
    values(a_comltd,a_xyear,a_rev,a_divcode,a_plant,a_dvsn,p_mdcd,p_mdno,
      5,p_mdno,p_mdno,0,0,p_xunit,'',p_wkprqt,p_wkprqt,
      a_applydate,a_applydate,a_plant,a_dvsn,'','','','Y','',
      p_ygchk,'',a_lastemp,a_lastdate);

    set at_end = 0;
  end if;

  set p_rtn = pbbpm.sf_bpm_exp(a_comltd,a_xyear,a_rev,a_plant,a_dvsn,
            p_mdno,a_applydate,a_expcode);
  if p_rtn <> 'Y' then
    goto inc_loop;
  end if;

  set p_serno = 0;
  open bpm501b_cursor;
  inc_loop01:
  loop
    fetch bpm501b_cursor into p_plant,p_dvsn,p_prno,p_chno,p_lev,
      p_wkct,p_prqt1,p_prqt,p_you,p_explant,p_exdv,
      p_xunit,p_cls,p_srce,p_grad,p_altno,p_calc,
      p_fmdt,p_todt,p_comcd,p_serl,p_ygchk;
    if at_end = 1 or sqlcode <> 0 then
      leave inc_loop01;
    end if;

    if p_cls <> '10' and p_cls <> '30' and p_cls <> '35' and
      p_cls <> '50' then
      goto inc_loop01;
    end if;

    if p_altno = '*' then
      select ofitn into p_altno from pbbpm.bpm505
      where ocmcd = a_comltd and xyear = a_xyear and
        revno = a_rev and oplant = p_plant and
        odvsn = p_dvsn and opitn = p_chno and
        (( oedte = ' ' and  oedtm <= a_applydate ) or
        ( oedte <> ' ' and oedte >= a_applydate and oedtm <= a_applydate ))
     fetch first 1 row only;
    end if;

    if a_divcode = 'B' then
      if p_srce = '05' or p_srce = '06' then
        if p_exdv <> '' then
          set p_alcd = p_explant;
          set p_aldiv = p_exdv;
        else
          set p_alcd = p_plant;
          set p_aldiv = p_dvsn;
        end if;
      else
        set p_alcd = p_plant;
        set p_aldiv = p_dvsn;
      end if;
    else
      if p_srce = '06' and p_exdv <> '' then
        set p_alcd = p_explant;
        set p_aldiv = p_exdv;
      else
        set p_alcd = p_plant;
        set p_aldiv = p_dvsn;
      end if;
    end if;

    set p_lolev = p_lev + 1;
    set p_serno = p_serno + 10;

    insert into pbbpm.bpm508
    ( comltd,xyear,brev,bgubun,bplant,bdiv,bmdcd,bmdno,bserno,
      bprno,bchno,blev,blole,bum,bwoct,bprqt,bprqt1,
      bfmdt,btodt,balcd,baldiv,byou,bgrad,baltno,bcalc,bcomcd,
      bygchk,extd,updtid,updtdt)
    values(a_comltd,a_xyear,a_rev,a_divcode,a_plant,a_dvsn,p_mdcd,p_mdno,
      p_serno,p_prno,p_chno,p_lev,p_lev,p_xunit,p_wkct,p_prqt,p_prqt1,
      p_fmdt,p_todt,p_alcd,p_aldiv,p_you,p_grad,p_altno,p_calc,p_comcd,
      p_ygchk,p_serl,a_lastemp,a_lastdate);

    select max(blole) into p_lolev
    from pbbpm.bpm508
    where comltd = a_comltd and xyear = a_xyear and
      brev = a_rev and bgubun = a_divcode and bchno = p_chno;
    if p_lev > p_lolev then
      update pbbpm.bpm508
      set blole = p_lev
      where comltd = a_comltd and xyear = a_xyear and
        brev = a_rev and bgubun = a_divcode and bchno = p_chno;
    else
      update pbbpm.bpm508
      set blole = p_lolev
      where comltd = a_comltd and xyear = a_xyear and
        brev = a_rev and bgubun = a_divcode and bchno = p_chno;
    end if;
  end loop;
  close bpm501b_cursor;
  set at_end = 0;
end loop;
close bpm501a_cursor;

end
