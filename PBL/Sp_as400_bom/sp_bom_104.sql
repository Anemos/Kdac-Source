-- file name : pbpdm.sp_bom_104
-- procedure name : pbpdm.sp_bom_104
-- desc : Creation BOM115, BOM115D, BOM 전체전개내역 테이블

drop procedure pbpdm.sp_bom_104;
create procedure pbpdm.sp_bom_104 (
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
declare p_ygchk char(1);
declare p_ygcst decimal(15,6);
declare p_explant char(1);
declare p_exdiv char(1);
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

  select a.tplnt,a.tdvsn,a.tcitn,a.tserl,a.tsubpaycd,a.texplant,a.texdv
 into p_plant,p_dvsn,p_tcitn,p_tserl,p_ygchk,p_explant,p_exdiv
 from qtemp.tmp_bom a
 where a.topchk <> '2' and a.tserl > p_tserl
 order by a.tserl
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- First Step
  set p_serial = p_serial + 1;
  set p_ygcst = 0;

  if p_exdiv = '' then
    set p_explant = p_plant;
    set p_exdiv = p_dvsn;
  end if;

if p_yyyymm = substring(a_createdate,1,6) then
  insert into pbpdm.bom115d
  ( zcmcd,zdate,zplant,zdiv,zmdcd,zmdno,
    zserial,zlevel,
    zpitno,zitno,zrev,zdesc,zspec,zunit1,zunitqty,zcvtfact,
    zunit2,zsrce,zabccode,zisscode,zwhlcode,zlotsize,zleadtime,
    zmovcost,zrcpcost,zoutcost,zscmovcost,zscrcpcost,zscoutcost,
    zwkct,zgrad,zaltno,zfmdt,
    ztodt,zcalc,zcomcd,zexplant,zexdiv,zygchk,zygcst,zcalc2,zcostchk )
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
    a.tedte,a.tcalculate,a.tcomcd,p_explant,p_exdiv,
    a.tsubpaycd,ifnull(p_ygcst,0),a.tcalculate2,a.tcostchk
  from qtemp.tmp_bom a inner join pbinv.inv002 b
    on a.tcmcd = b.comltd and a.tcitn = b.itno
    inner join pbinv.inv101 c
    on a.tcmcd = c.comltd and a.tplnt = c.xplant and
      a.tdvsn = c.div and a.tcitn = c.itno
  where a.tserl = p_tserl;
else
  insert into pbpdm.bom115
  ( zcmcd,zdate,zplant,zdiv,zmdcd,zmdno,
    zserial,zlevel,
    zpitno,zitno,zrev,zdesc,zspec,zunit1,zunitqty,zcvtfact,
    zunit2,zsrce,zabccode,zisscode,zwhlcode,zlotsize,zleadtime,
    zmovcost,zrcpcost,zoutcost,zscmovcost,zscrcpcost,zscoutcost,
    zwkct,zgrad,zaltno,zfmdt,
    ztodt,zcalc,zcomcd,zexplant,zexdiv,zygchk,zygcst,zcalc2,zcostchk )
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
    a.tedte,a.tcalculate,a.tcomcd,p_explant,p_exdiv,
    a.tsubpaycd,ifnull(p_ygcst,0),a.tcalculate2,a.tcostchk
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
