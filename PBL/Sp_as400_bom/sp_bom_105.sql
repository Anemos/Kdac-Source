-- file name : pbpdm.sp_bom_105
-- procedure name : pbpdm.sp_bom_105
-- desc : 월별BOM 전개내역 테이블에 구매정보 일괄 업데이트

drop procedure pbpdm.sp_bom_105;
create procedure pbpdm.sp_bom_105 (
in a_comltd char(2),
in a_applydate char(8),
in a_createdate char(8))
language sql
begin
declare sqlcode integer default 0;
declare p_yyyymm char(6);
declare p_tcitn varchar(12);
declare p_damdang char(2);
declare p_prunt char(2);
declare p_ptod char(2);
declare p_pcurr char(3);
declare p_ptotdan decimal(15,4);
declare p_prutc decimal(15,4);
declare p_pvsrno varchar(8);
declare p_pvend varchar(50);
declare p_dsheet varchar(20);
declare p_purno char(10);
declare at_end integer default 0;
declare not_found condition for '02000';

declare continue handler for not_found
  set at_end = 1;

set at_end = 0;
set p_yyyymm = substring(a_applydate,1,6);
set p_tcitn = '';

if p_yyyymm = substring(a_createdate,1,6) then
  return;
end if;

inc_loop:
loop
 select a.zitno
 into p_tcitn
 from pbpdm.bom113 a
 where a.zcmcd = a_comltd and zdate = p_yyyymm and
  zsrce = '01' and zitno > p_tcitn
 order by a.zitno
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- First Step
  set p_damdang = '';
  set p_prunt = '';
  set p_ptod = '';
  set p_pcurr = '';
  set p_ptotdan = 0;
  set p_prutc = 0;
  set p_pvsrno = '';
  set p_pvend = '';
  set p_purno = '';
  
    select truncate(xcost,4), xunit1, rtrim(purno)
      into p_prutc, p_prunt, p_purno
    from pbpur.opm102
    where comltd = a_comltd and itno = p_tcitn
    order by inptdt desc
    fetch first 1 row only;

    if at_end = 1 then
      set p_prutc = 0;
      set p_prunt = '';
      set p_purno = '';
      set at_end = 0;
    else
      set p_ptotdan = p_prutc;
      select a.curr, ifnull(rtrim(b.coextend),'F'),
        a.vsrno1,ifnull(c.vndnm,'')
        into p_pcurr,p_ptod,p_pvsrno,p_pvend
      from pbpur.opm101 a left outer join pbcommon.dac002 b
        on a.tod = b.cocode and b.cogubun = 'INV161'
        left outer join pbpur.pur101 c
        on a.comltd = c.comltd and a.vsrno1 = c.vsrno
      where a.comltd = a_comltd and a.purno = p_purno;
      if at_end = 1 then
        set p_pcurr = '';
        set p_ptod = '';
        set p_pvsrno = '';
        set p_pvend = '';
        set at_end = 0;
      end if;
    end if;
  
  update pbpdm.bom113
  set zdamdang = p_damdang,
    zprunt = p_prunt,
    zptod = p_ptod,
    zpcurr = p_pcurr,
    zptotdan = p_ptotdan,
    zprutc = p_prutc,
    zpvsrno = p_pvsrno,
    zpvend = p_pvend
  where a.zcmcd = a_comltd and zdate = p_yyyymm and
    zsrce = '01' and zitno = p_tcitn;
  
  set at_end = 0;
end loop;

set at_end = 0;
set p_tcitn = '';
inc_loop2:
loop
 select a.zitno
 into p_tcitn
 from pbpdm.bom113 a
 where a.zcmcd = a_comltd and zdate = p_yyyymm and
  zsrce = '02' and zitno > p_tcitn
 order by a.zitno
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop2;
  end if;
  
  -- First Step
  set p_damdang = '';
  set p_prunt = '';
  set p_ptod = '';
  set p_pcurr = '';
  set p_ptotdan = 0;
  set p_prutc = 0;
  set p_pvsrno = '';
  set p_pvend = '';
  set p_purno = '';
  
    set p_pcurr = 'WON';
    select a.vsrno, substring(ifnull(b.dsheet,''),1,4),
      ifnull(c.vndnm,'')
    into p_pvsrno,p_dsheet,p_pvend
    from pbpur.pur402 a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.vsrno = b.vsrno and
        a.itno = b.itno
      left outer join pbpur.pur101 c
      on a.comltd = c.comltd and a.vsrno = c.vsrno
    where a.comltd = a_comltd and a.itno = p_tcitn
    order by b.xstop, a.pdudt desc
    fetch first 1 row only;

    if at_end = 1 then
      set p_pvsrno = '';
      set p_damdang = '';
      set p_pvend = '';
      set at_end = 0;
    else
      if p_dsheet = 'EXPT' then
        select xplan into p_damdang from pbinv.inv101
        where comltd = a_comltd and xplant = p_plant and
              div = p_dvsn and itno = p_tcitn;
        if at_end = 1 then
          set p_damdang = '';
          set at_end = 0;
        end if;
      end if;
    end if;
    set p_ptotdan = p_inputcost;
  
  update pbpdm.bom113
  set zdamdang = p_damdang,
    zprunt = p_prunt,
    zptod = p_ptod,
    zpcurr = p_pcurr,
    zptotdan = p_ptotdan,
    zprutc = p_prutc,
    zpvsrno = p_pvsrno,
    zpvend = p_pvend
  where a.zcmcd = a_comltd and zdate = p_yyyymm and
    zsrce = '01' and zitno = p_tcitn;
  
  set at_end = 0;
end loop;

set at_end = 0;
set p_tcitn = '';
inc_loop3:
loop
 select a.zitno
 into p_tcitn
 from pbpdm.bom113 a
 where a.zcmcd = a_comltd and zdate = p_yyyymm and
  zsrce = '04' and zitno > p_tcitn
 order by a.zitno
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop3;
  end if;
  
  -- First Step
  set p_damdang = '';
  set p_prunt = '';
  set p_ptod = '';
  set p_pcurr = '';
  set p_ptotdan = 0;
  set p_prutc = 0;
  set p_pvsrno = '';
  set p_pvend = '';
  set p_purno = '';
  
    set p_pcurr = 'WON';
    select a.vsrno, substring(ifnull(b.dsheet,''),1,4),
      ifnull(c.vndnm,'')
    into p_pvsrno,p_dsheet,p_pvend
    from pbpur.pur402 a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.vsrno = b.vsrno and
        a.itno = b.itno
      left outer join pbpur.pur101 c
      on a.comltd = c.comltd and a.vsrno = c.vsrno
    where a.comltd = a_comltd and a.itno = p_tcitn
    order by b.xstop, a.pdudt desc
    fetch first 1 row only;

    if at_end = 1 then
      set p_pvsrno = '';
      set p_damdang = '';
      set p_pvend = '';
      set at_end = 0;
    else
      if p_dsheet = 'EXPT' then
        select xplan into p_damdang from pbinv.inv101
        where comltd = a_comltd and xplant = p_plant and
              div = p_dvsn and itno = p_tcitn;
        if at_end = 1 then
          set p_damdang = '';
          set at_end = 0;
        end if;
      end if;
    end if;
    set p_ptotdan = p_inputcost;
  
  update pbpdm.bom113
  set zdamdang = p_damdang,
    zprunt = p_prunt,
    zptod = p_ptod,
    zpcurr = p_pcurr,
    zptotdan = p_ptotdan,
    zprutc = p_prutc,
    zpvsrno = p_pvsrno,
    zpvend = p_pvend
  where a.zcmcd = a_comltd and zdate = p_yyyymm and
    zsrce = '01' and zitno = p_tcitn;
  
  set at_end = 0;
end loop;

end
