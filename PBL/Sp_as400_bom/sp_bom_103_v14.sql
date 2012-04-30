-- file name : pbpdm.sp_bom_103
-- procedure name : pbpdm.sp_bom_103
-- desc : Creation BOM113, BOM113D, BOM 전개내역 테이블

drop procedure pbpdm.sp_bom_103;
create procedure pbpdm.sp_bom_103 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_pdcd varchar(4),
in a_applydate char(8),
in a_createdate char(8))
language sql
begin
declare sqlcode integer default 0;
declare p_yyyymm char(6);
declare p_tserl varchar(600);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_tmodl varchar(12);
declare p_tlevel decimal(2,0);
declare p_tpitn varchar(12);
declare p_tcitn varchar(12);
declare p_srce char(2);
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
declare p_ygchk char(1);
declare p_explant char(1);
declare p_exdiv char(1);
declare p_ygcst decimal(15,6);
declare p_serial decimal(4,0);
declare p_inputcost numeric(15,6);
declare at_end integer default 0;
declare not_found condition for '02000';

declare continue handler for not_found
  set at_end = 1;

set at_end = 0;
set p_serial = 0;
set p_yyyymm = substring(a_applydate,1,6);
set p_tserl = '';

inc_loop:
loop
 select a.tplnt,a.tdvsn,a.tcitn,a.tserl,b.srce,a.tinputcost,
  a.tsubpaycd,a.texplant,a.texdv
 into p_plant,p_dvsn,p_tcitn,p_tserl,p_srce,p_inputcost,
  p_ygchk,p_explant,p_exdiv
 from qtemp.tmp_bom a inner join pbinv.inv402 b
  on a.tcmcd = b.comltd and a.tplnt = b.xplant and
    a.tdvsn = b.div and a.tcitn = b.itno and b.xyear = p_yyyymm
 where a.topchk <> '2' and a.tserl > p_tserl
 order by a.tserl
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- First Step
  set p_serial = p_serial + 1;
  set p_damdang = '';
  set p_prunt = '';
  set p_ptod = '';
  set p_pcurr = '';
  set p_ptotdan = 0;
  set p_prutc = 0;
  set p_pvsrno = '';
  set p_pvend = '';
  set p_purno = '';
  
if p_yyyymm <> substring(a_createdate,1,6) then
  if p_srce = '01' then
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
  end if;

  if p_srce = '02' or p_srce = '04' then
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
  end if;
end if;

  if p_ygchk = 'Y' then
    select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = p_tcitn
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = p_tcitn
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = p_tcitn
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    into p_ygcst
    from pbcommon.comm000;
  else
    set p_ygcst = 0;
  end if;

  if p_exdiv = '' then
    set p_explant = p_plant;
    set p_exdiv = p_dvsn;
  end if;
  
if p_yyyymm = substring(a_createdate,1,6) then
  insert into pbpdm.bom113d
  ( zcmcd,zdate,zplant,zdiv,zmdcd,zmdno,
    zserial,zlevel,
    zpitno,zitno,zrev,zdesc,zspec,zunit1,zunitqty,zcvtfact,
    zunit2,zsrce,zabccode,zisscode,zwhlcode,zlotsize,zleadtime,
    zmovcost,zrcpcost,zoutcost,zscmovcost,zscrcpcost,zscoutcost,
    zwkct,zgrad,zaltno,zfmdt,
    ztodt,zcalc,zexplant,zexdiv,zcomcd,zygchk,zygcst,
    zdamdang,zprunt,zptod,
    zpcurr,zptotdan,zprutc,zpvsrno,zpvend,zcalc2,ztaxrate )
  select a.tcmcd,a_createdate,a_plant,a_dvsn,a_pdcd,a.tmodl,
    p_serial,
    ( case  when tlevel = 0 then concat('.',cast(tlevel as varchar(3)))
  when tlevel = 1 then concat('.',cast(tlevel as varchar(3)))
  when tlevel = 2 then concat('..',cast(tlevel as varchar(3)))
  when tlevel = 3 then concat('...',cast(tlevel as varchar(3)))
  when tlevel = 4 then concat('....',cast(tlevel as varchar(3)))
  when tlevel = 5 then concat('.....',cast(tlevel as varchar(3)))
  when tlevel = 6 then concat('......',cast(tlevel as varchar(3)))
  when tlevel = 7 then concat('.......',cast(tlevel as varchar(3)))
  else concat('........',cast(tlevel as varchar(3))) end ),
    a.tpitn,a.tcitn,b.rvno,b.itnm,b.spec,b.xunit,a.tqty1,c.convqty,
    c.xunit,c.srce,c.abccd,c.iscd,c.wloc,c.puls,c.pult,
    a.tmovecost,a.tinputcost,a.toutcost,
    case when a.tsubpaycd = 'Y' then a.tscmovecost
      else a.tmovecost end,
    case when a.tsubpaycd = 'Y' then a.tscinputcost
      else a.tinputcost end,
    case when a.tsubpaycd = 'Y' then a.tscoutcost
      else a.toutcost end,
    a.twkct,a.topcd,a.toption,a.tedtm,
    a.tedte,tcalculate,p_explant,p_exdiv,tcomcd,tsubpaycd,ifnull(p_ygcst,0),
    p_damdang,p_prunt,p_ptod,
    p_pcurr,p_ptotdan,p_prutc,p_pvsrno,p_pvend,tcalculate2,
    pbpdm.sf_bom_105(a.tcitn)
  from qtemp.tmp_bom a inner join pbinv.inv002 b
    on a.tcmcd = b.comltd and a.tcitn = b.itno
    inner join pbinv.inv101 c
    on a.tcmcd = c.comltd and a.tplnt = c.xplant and
      a.tdvsn = c.div and a.tcitn = c.itno
  where a.tserl = p_tserl;
else  
  insert into pbpdm.bom113
  ( zcmcd,zdate,zplant,zdiv,zmdcd,zmdno,
    zserial,zlevel,
    zpitno,zitno,zrev,zdesc,zspec,zunit1,zunitqty,zcvtfact,
    zunit2,zsrce,zabccode,zisscode,zwhlcode,zlotsize,zleadtime,
    zmovcost,zrcpcost,zoutcost,zscmovcost,zscrcpcost,zscoutcost,
    zwkct,zgrad,zaltno,zfmdt,
    ztodt,zcalc,zexplant,zexdiv,zcomcd,zygchk,zygcst,
    zdamdang,zprunt,zptod,
    zpcurr,zptotdan,zprutc,zpvsrno,zpvend,zcalc2,ztaxrate )
  select a.tcmcd,p_yyyymm,a_plant,a_dvsn,a_pdcd,a.tmodl,
    p_serial,
    ( case  when tlevel = 0 then concat('.',cast(tlevel as varchar(3)))
  when tlevel = 1 then concat('.',cast(tlevel as varchar(3)))
  when tlevel = 2 then concat('..',cast(tlevel as varchar(3)))
  when tlevel = 3 then concat('...',cast(tlevel as varchar(3)))
  when tlevel = 4 then concat('....',cast(tlevel as varchar(3)))
  when tlevel = 5 then concat('.....',cast(tlevel as varchar(3)))
  when tlevel = 6 then concat('......',cast(tlevel as varchar(3)))
  when tlevel = 7 then concat('.......',cast(tlevel as varchar(3)))
  else concat('........',cast(tlevel as varchar(3))) end ),
    a.tpitn,a.tcitn,b.rvno,b.itnm,b.spec,b.xunit,a.tqty1,c.convqty,
    d.xunit,d.srce,c.abccd,c.iscd,c.wloc,c.puls,c.pult,
    a.tmovecost,a.tinputcost,a.toutcost,
    case when a.tsubpaycd = 'Y' then a.tscmovecost
      else a.tmovecost end,
    case when a.tsubpaycd = 'Y' then a.tscinputcost
      else a.tinputcost end,
    case when a.tsubpaycd = 'Y' then a.tscoutcost
      else a.toutcost end,
    a.twkct,a.topcd,a.toption,a.tedtm,
    a.tedte,tcalculate,p_explant,p_exdiv,tcomcd,tsubpaycd,ifnull(p_ygcst,0),
    p_damdang,p_prunt,p_ptod,
    p_pcurr,p_ptotdan,p_prutc,p_pvsrno,p_pvend,tcalculate2,
    pbpdm.sf_bom_105(a.tcitn)
  from qtemp.tmp_bom a inner join pbinv.inv002 b
    on a.tcmcd = b.comltd and a.tcitn = b.itno
    inner join pbinv.inv101 c
    on a.tcmcd = c.comltd and a.tplnt = c.xplant and
      a.tdvsn = c.div and a.tcitn = c.itno
    inner join pbinv.inv402 d
    on a.tcmcd = d.comltd and a.tplnt = d.xplant and
      a.tdvsn = d.div and a.tcitn = d.itno and
      d.xyear = p_yyyymm
  where a.tserl = p_tserl;
end if;

  set at_end = 0;
end loop;

end
