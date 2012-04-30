-- file name : pbpdm.sp_bom_003
-- procedure name : pbpdm.sp_bom_003
-- desc : Creation BOM013, BOM 전개내역 테이블

drop procedure pbpdm.sp_bom_003;
create procedure pbpdm.sp_bom_003 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_pdcd varchar(4),
in a_applydate char(8))
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
declare p_purno char(10);
declare p_serial decimal(4,0);
declare p_inputcost numeric(15,6);
declare at_end integer default 0;
declare not_found condition for '02000';

--Get BOM History Itemno
declare bom_003 Cursor for
 select a.tplnt,a.tdvsn,a.tcitn,a.tserl,b.srce,a.tinputcost
 from qtemp.tmp_bom a inner join pbinv.inv101 b
  on a.tcmcd = b.comltd and a.tplnt = b.xplant and
    a.tdvsn = b.div and a.tcitn = b.itno
 where a.tcmcd = a_comltd and a.tplnt = a_plant and
   a.tdvsn = a_dvsn and a.topchk <> '2'
 order by a.tserl;

declare continue handler for not_found
  set at_end = 1;

set at_end = 0;
set p_serial = 0;
set p_yyyymm = substring(a_applydate,1,6);
open bom_003;
inc_loop:
loop
  fetch bom_003 into p_plant,p_dvsn,p_tcitn,p_tserl,p_srce,p_inputcost;
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
  if p_srce = '01' then
    select truncate(xcost,4), xunit1, rtrim(purno)
      into p_prutc, p_prunt, p_purno
    from pbpur.opm102
    where comltd = a_comltd and xplant = p_plant and
      div = p_dvsn and itno = p_tcitn and
      inptdt <= a_applydate
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
    select a.vsrno, case when substring(ifnull(b.dsheet,''),1,4) = 'EXPT'
        then ( select xplan from pbinv.inv101 
         where comltd = a_comltd and xplant = p_plant and
            div = p_dvsn and itno = p_tcitn )
        else '' end,
      ifnull(c.vndnm,'')
    into p_pvsrno,p_damdang,p_pvend
    from pbpur.pur402 a left outer join pbpur.pur103 b
      on a.comltd = b.comltd and a.vsrno = b.vsrno and
        a.itno = b.itno
      left outer join pbpur.pur101 c
      on a.comltd = c.comltd and a.vsrno = c.vsrno
    where a.comltd = a_comltd and a.xplant = p_plant and
      a.div = p_dvsn and a.itno = p_tcitn and
      a.inptdt <= a_applydate
    order by a.inptdt desc
    fetch first 1 row only;
    if at_end = 1 then
      set p_pvsrno = '';
      set p_damdang = '';
      set p_pvend = '';
      set at_end = 0;
    end if;
    set p_ptotdan = p_inputcost;
  end if;

  insert into pbpdm.bomt13
  ( zcmcd,zdate,zplant,zdiv,zmdcd,zmdno,
    zserial,zlevel,
    zpitno,zitno,zrev,zdesc,zspec,zunit1,zunitqty,zcvtfact,
    zunit2,zsrce,zabccode,zisscode,zwhlcode,zlotsize,zleadtime,
    zmovcost,zrcpcost,zwkct,zgrad,zaltno,zfmdt,
    ztodt,zcalc,zcomcd,zsubpaycd,
    zdamdang,zprunt,zptod,
    zpcurr,zptotdan,zprutc,zpvsrno,zpvend )
  select a.tcmcd,p_yyyymm,a.tplnt,a.tdvsn,a_pdcd,a.tmodl,
    p_serial,
    ( case  when tlevel = 1 then concat('.',cast(tlevel as varchar(3)))
  when tlevel = 2 then concat('..',cast(tlevel as varchar(3)))
  when tlevel = 3 then concat('...',cast(tlevel as varchar(3)))
  when tlevel = 4 then concat('....',cast(tlevel as varchar(3)))
  when tlevel = 5 then concat('.....',cast(tlevel as varchar(3)))
  when tlevel = 6 then concat('......',cast(tlevel as varchar(3)))
  when tlevel = 7 then concat('.......',cast(tlevel as varchar(3)))
  else concat('........',cast(tlevel as varchar(3))) end ),
    a.tpitn,a.tcitn,b.rvno,b.itnm,b.spec,b.xunit,a.tqty1,c.convqty,
    c.xunit,c.srce,c.abccd,c.iscd,c.wloc,c.puls,c.pult,
    a.tmovecost,a.tinputcost,a.twkct,a.topcd,a.toption,a.tedtm,
    a.tedte,tcalculate,tcomcd,tsubpaycd,
    p_damdang,p_prunt,p_ptod,
    p_pcurr,p_ptotdan,p_prutc,p_pvsrno,p_pvend
  from qtemp.tmp_bom a inner join pbinv.inv002 b
    on a.tcmcd = b.comltd and a.tcitn = b.itno
    inner join pbinv.inv101 c
    on a.tcmcd = c.comltd and a.tplnt = c.xplant and
      a.tdvsn = c.div and a.tcitn = c.itno
  where a.tserl = p_tserl;
  
end loop;
close bom_003;

end
