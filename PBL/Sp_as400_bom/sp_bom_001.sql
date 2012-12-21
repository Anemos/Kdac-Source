-- file name : pbpdm.sp_bom_001
-- procedure name : pbpdm.sp_bom_001
-- desc : Creation BOM109, 고객사유상사급제외 재료비
-- a_chk : FULL ('A'), 전체 ('B'), 공장별('C') to 'E'
--         ONLY 재료비산출('N')
--         Create BOM113 'K'
--         Create BOM115 'M'
--         Create BOM113D 'P'

drop procedure pbpdm.sp_bom_001;
create procedure pbpdm.sp_bom_001 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_applydate char(8),
in a_createdate char(8),
in a_chk char(1))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
declare p_exprtn char(1);
declare p_expchk char(1);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_itno varchar(15);
declare p_yyyymm char(6);
declare p_nextmm char(6);
declare p_pdcd char(2);
declare p_cls char(2);
declare p_srce char(2);
declare p_costdiv char(1);
declare p_fromdate char(8);
declare p_fttcnt integer;
declare p_tlogid integer;
declare at_end integer default 0;
declare not_found condition for '02000';

declare continue handler for not_found
  set at_end = 1;

declare continue handler for sqlstate '42704'
-- create qtemp.tmp_bomitem
 create table qtemp.tmp_bomitem (
 tlogid integer generated always
  as identity(start with 1, increment by 1, no cache),
 txplant char(1) not null,
 tdiv char(1) not null,titno varchar(15) not null,
 tpdcd char(2) not null,tcls char(2) not null,
 tsrce char(2) not null,tcostdiv char(1) not null);

delete from qtemp.tmp_bomitem;

if a_chk <> 'A' and a_chk <> 'B' and a_chk <> 'C' and
  a_chk <> 'K' and a_chk <> 'M' and a_chk <> 'N' and a_chk <> 'P' then
  return;
end if;

set p_yyyymm = substring(a_applydate,1,6);
set p_nextmm = substring(a_createdate,1,6);
set p_fromdate = concat(p_yyyymm,'01');

insert into qtemp.tmp_bomitem(txplant,tdiv,titno,
 tpdcd,tcls,tsrce,tcostdiv)
select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
   b.cls,b.srce,b.costdiv
 from pbpdm.bom001 a inner join pbinv.inv101 b
  on a.pcmcd = b.comltd and a.plant = b.xplant and
    a.pdvsn = b.div and a.ppitn = b.itno
 where a.pcmcd = a_comltd and a.plant = a_plant and
 a.pdvsn = a_dvsn and b.cls = '30' and
  (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
  ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ))
  union
  select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
   b.cls,b.srce,b.costdiv
  from pbpdm.bom001 a inner join pbinv.inv101 b
    on a.pcmcd = b.comltd and a.pexplant = b.xplant and
      a.pexdv = b.div and a.pcitn = b.itno
  where a.pcmcd = a_comltd and a.pexplant = a_plant and
  a.pexdv = a_dvsn and
    (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
    ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ))
  union
  select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
    b.cls,b.srce,b.costdiv
  from pbinv.inv401 a inner join pbinv.inv101 b
  on a.comltd = b.comltd and a.xplant = b.xplant and
    a.div = b.div and a.itno = b.itno
  where a.comltd = a_comltd and a.xplant = a_plant and
    a.div = a_dvsn and
    ( b.cls = '10' or b.cls = '35' or b.cls = '50' ) and
    (a.sliptype = 'RM' or a.sliptype = 'SA' or
     a.sliptype = 'SR' or a.sliptype = 'IW') and
    a.tdte4 >= p_fromdate and a.tdte4 <= a_applydate
  union
  select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
    b.cls,b.srce,b.costdiv
  from pbinv.inv401 a inner join pbinv.inv101 b
  on a.comltd = b.comltd and a.xplant = b.xplant and
    a.div = b.div and a.itno = b.itno
  where a.comltd = a_comltd and a.xplant = a_plant and
    a.div = a_dvsn and
    ( b.srce = '03' or b.cls = '50' ) and
    (a.sliptype = 'RP' or a.sliptype = 'IS') and
    a.tdte4 >= p_fromdate and a.tdte4 <= a_applydate
  union
  select distinct c.xplant,c.div,c.itno,substring(d.pdcd,1,2),
    d.cls,d.srce,d.costdiv
  from pbsle.sle212 c inner join pbinv.inv101 d
  on c.comltd = d.comltd and c.xplant = d.xplant and
    c.div = d.div and c.itno = d.itno
  where c.COMLTD = a_comltd AND c.GUBUN  = 'B' AND
    c.CYM  = p_nextmm AND c.XPLANT = a_plant AND
  c.DIV  = a_dvsn and ( d.cls = '10' or d.cls = '35' or
      d.cls = '40' or d.cls = '50' ) ;

if a_chk = 'A' then
  set p_expchk = 'A';
  if p_yyyymm = p_nextmm then
    delete from pbpdm.bom109d
    where fcmcd = a_comltd AND fdate = a_createdate and
    fplant = a_plant and fdvsn = a_dvsn;

    delete from pbpdm.bom113d
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;

    delete from pbpdm.bom115d
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;
  else
    delete from pbpdm.bom009
    where fcmcd = a_comltd AND fdate = p_yyyymm and
    fplant = a_plant and fdvsn = a_dvsn and
      (fgubun = 'D' or fgubun = 'E');

    delete from pbpdm.bom109
    where fcmcd = a_comltd AND fdate = p_yyyymm and
    fplant = a_plant and fdvsn = a_dvsn;

    delete from pbpdm.bom113
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdiv = a_dvsn;

    delete from pbpdm.bom115
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdiv = a_dvsn;
  end if;
end if;
if a_chk = 'B' then
  set p_expchk = 'A';
  if p_yyyymm = p_nextmm then
    delete from pbpdm.bom109d
    where fcmcd = a_comltd AND fdate = a_createdate and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun in ('A','D');
      
    delete from pbpdm.bom115d
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;
  else
    delete from pbpdm.bom009
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun = 'D';

    delete from pbpdm.bom109
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun in ('A','D');
      
    delete from pbpdm.bom115
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdiv = a_dvsn;
  end if;
end if;
if a_chk = 'C' then
  set p_expchk = 'C';
  if p_yyyymm = p_nextmm then
    delete from pbpdm.bom109d
    where fcmcd = a_comltd AND fdate = a_createdate and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun in ('B','E');
      
    delete from pbpdm.bom113d
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;
  else
    delete from pbpdm.bom009
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun = 'E';

    delete from pbpdm.bom109
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun in ('B','E');
      
    delete from pbpdm.bom113
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdiv = a_dvsn;
  end if;
end if;
if a_chk = 'K' then
  set p_expchk = 'C';
  if p_yyyymm = p_nextmm then
    delete from pbpdm.bom113d
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;
  else
    delete from pbpdm.bom113
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdiv = a_dvsn;
  end if;
end if;
if a_chk = 'M' then
  set p_expchk = 'A';
  if p_yyyymm = p_nextmm then
    delete from pbpdm.bom115
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;
  else
    delete from pbpdm.bom115
    where zcmcd = a_comltd and zdate = p_yyyymm and
      zplant = a_plant and zdiv = a_dvsn;
  end if;
end if;
if a_chk = 'N' then
  set p_expchk = 'C';
  
  delete from pbpdm.bom109
    where fcmcd = a_comltd AND fdate = p_yyyymm and
      fplant = a_plant and fdvsn = a_dvsn and
      fgubun in ('B','E');
end if;
if a_chk = 'P' then
  set p_expchk = 'C';
  delete from pbpdm.bom113d
    where zcmcd = a_comltd and zdate = a_createdate and
      zplant = a_plant and zdiv = a_dvsn;
end if;

set at_end = 0;
set p_tlogid = 0;

inc_loop:
loop
  select tlogid,txplant,tdiv,titno,tpdcd,tcls,tsrce,tcostdiv
  into p_tlogid,p_plant,p_dvsn,p_itno,p_pdcd,p_cls,p_srce,p_costdiv
  from qtemp.tmp_bomitem
  where tlogid > p_tlogid
  order by tlogid asc
  fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  if a_chk = 'A' then
    -- Full Explode
    if p_yyyymm <> p_nextmm then
      set p_exprtn = pbpdm.sf_bom_exm(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,'A');
      set p_rtn = pbpdm.sf_bom_001(a_comltd,p_plant,p_dvsn,
        p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    else
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,'A');
    end if;
    set p_rtn = pbpdm.sf_bom_101(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    set p_rtn = pbpdm.sf_bom_103(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    call pbpdm.sp_bom_104(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);

    -- Division Explode
    if p_yyyymm <> p_nextmm then
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,'C');
      set p_rtn = pbpdm.sf_bom_002(a_comltd,p_plant,p_dvsn,
        p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    else
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,'C');
    end if;
    set p_rtn = pbpdm.sf_bom_102(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    set p_rtn = pbpdm.sf_bom_104(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    call pbpdm.sp_bom_103(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);
  end if;
  if a_chk = 'B' then
    -- First Step
    if p_yyyymm <> p_nextmm then
      set p_exprtn = pbpdm.sf_bom_exm(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,'A');
      set p_rtn = pbpdm.sf_bom_001(a_comltd,p_plant,p_dvsn,
        p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    else
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,'A');
    end if;
    set p_rtn = pbpdm.sf_bom_101(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    set p_rtn = pbpdm.sf_bom_103(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    call pbpdm.sp_bom_104(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);
  end if;
  if a_chk = 'C' then
    -- First Step
    if p_yyyymm <> p_nextmm then
      set p_exprtn = pbpdm.sf_bom_exm(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
      set p_rtn = pbpdm.sf_bom_002(a_comltd,p_plant,p_dvsn,
        p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    else
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
    end if;
    set p_rtn = pbpdm.sf_bom_102(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    set p_rtn = pbpdm.sf_bom_104(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    call pbpdm.sp_bom_103(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);
  end if;
  if a_chk = 'K' then
    -- First Step
    if p_yyyymm <> p_nextmm then
      set p_exprtn = pbpdm.sf_bom_exm(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
    else
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
    end if;
    call pbpdm.sp_bom_103(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);
  end if;
  if a_chk = 'M' then
    -- First Step
    if p_yyyymm <> p_nextmm then
      set p_exprtn = pbpdm.sf_bom_exm(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
    else
      set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
    end if;
    call pbpdm.sp_bom_104(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);
  end if;
  if a_chk = 'N' then
    set p_exprtn = pbpdm.sf_bom_exm(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,p_expchk);
    set p_rtn = pbpdm.sf_bom_102(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
    set p_rtn = pbpdm.sf_bom_104(a_comltd,p_plant,p_dvsn,
      p_itno,p_pdcd,p_costdiv,p_yyyymm,a_createdate,p_exprtn);
  end if;
  if a_chk = 'P' then
    set p_exprtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
      p_itno,a_applydate,p_expchk);
    call pbpdm.sp_bom_106(a_comltd,p_plant,p_dvsn,p_pdcd,
      a_applydate,a_createdate);
  end if;
  set at_end = 0;
end loop;

insert into pbpdm.bom020(zdate,
  zworkdate,zplant,zdiv,zjobname,zjobcnt)
values(p_yyyymm,
  concat(concat(char(CURRENT DATE,ISO),' '),char(CURRENT TIME,ISO)),
  a_plant,a_dvsn,
  concat('check gubun : ',a_chk),
  (select count(*) from qtemp.tmp_bomitem));

end
