-- file name : pbpdm.sp_bom_004
-- procedure name : pbpdm.sp_bom_004
-- desc : Creation BOMT15, BOM 전체전개내역 테이블

drop procedure pbpdm.sp_bom_004;
create procedure pbpdm.sp_bom_004 (
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
declare p_dsheet varchar(20);
declare p_purno char(10);
declare p_ygchk char(1);
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

  select a.tcitn,a.tserl,
  ( select case when count(*) > 0 then 'Y' else 'N' end
    from pbpdm.bom001 c
    where c.pcmcd = a.tcmcd and c.plant = a.tplnt and
      c.pdvsn = a.tdvsn and c.ppitn = a.tcitn and
      c.pwkct = '8888' and
      (( c.pedte = ' '  and c.pedtm <= a_applydate ) or
      ( c.pedte <> ' ' and c.pedtm <= a_applydate
                and c.pedte >= a_applydate )))
 into p_tcitn,p_tserl,p_ygchk
 from qtemp.tmp_bom a
 where a.topchk <> '2' and a.tserl > p_tserl
 order by a.tserl
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- First Step
  set p_serial = p_serial + 1;

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

  insert into pbpdm.bomt15
  ( zcmcd,zdate,zplant,zdiv,zmdcd,zmdno,
    zserial,zlevel,
    zpitno,zitno,zrev,zdesc,zspec,zunit1,zunitqty,zcvtfact,
    zunit2,zsrce,zabccode,zisscode,zwhlcode,zlotsize,zleadtime,
    zmovcost,zrcpcost,zoutcost,zwkct,zgrad,zaltno,zfmdt,
    ztodt,zcalc,zcomcd,zexplant,zexdiv,zygchk,zygcst )
  select a.tcmcd,p_yyyymm,a_plant,a_dvsn,a_pdcd,a.tmodl,
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
    a.tmovecost,a.tinputcost,a.toutcost,a.twkct,a.topcd,a.toption,a.tedtm,
    a.tedte,a.tcalculate,a.tcomcd,a.tplnt,a.tdvsn,
    p_ygchk,ifnull(p_ygcst,0)
  from qtemp.tmp_bom a inner join pbinv.inv002 b
    on a.tcmcd = b.comltd and a.tcitn = b.itno
    inner join pbinv.inv101 c
    on a.tcmcd = c.comltd and a.tplnt = c.xplant and
      a.tdvsn = c.div and a.tcitn = c.itno
  where a.tserl = p_tserl;

  set at_end = 0;

end loop;

end
