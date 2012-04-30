-- file name : pbpdm.sp_bom_001
-- procedure name : pbpdm.sp_bom_001
-- desc : Creation BOM009, 고객사유상사급제외 재료비
-- a_chk : 전사 ('A') to 'D', 공장별('C') to 'E'

drop procedure pbpdm.sp_bom_001;
create procedure pbpdm.sp_bom_001 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_applydate char(8),
in a_chk char(1))
language sql
begin
declare sqlcode integer default 0;
declare p_rtn char(1);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_itno varchar(15);
declare p_gubun char(1);
declare p_yyyymm char(6);
declare p_pdcd char(2);
declare p_cls char(2);
declare p_srce char(2);
declare p_fromdate char(8);
declare p_fdmcst numeric(7,0);
declare p_fdrcst numeric(7,0);
declare p_fdacst numeric(7,0);
declare p_fimcst numeric(7,0);
declare p_fircst numeric(7,0);
declare p_fiacst numeric(7,0);
declare p_foscst numeric(7,0);
declare p_ftmcst numeric(7,0);
declare p_ftrcst numeric(7,0);
declare p_ftacst numeric(7,0);
declare p_fdtcnt integer;
declare p_fitcnt integer;
declare p_fttcnt integer;
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Product item
declare bom_001 Cursor for
 select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
   b.cls,b.srce
 from pbpdm.bom001 a inner join pbinv.inv101 b
  on a.pcmcd = b.comltd and a.plant = b.xplant and
    a.pdvsn = b.div and a.ppitn = b.itno
 where a.pcmcd = a_comltd and a.plant = a_plant and
 a.pdvsn = a_dvsn and b.cls = '30' and
  (( a.pedte = ' '  and a.pedtm <= a_applydate ) or
  ( a.pedte <> ' ' and a.pedtm <= a_applydate
                and a.pedte >= a_applydate ))
 union all
 select distinct b.xplant,b.div,b.itno,substring(b.pdcd,1,2),
    b.cls,b.srce
  from pbinv.inv401 a inner join pbinv.inv101 b
  on a.comltd = b.comltd and a.xplant = b.xplant and
    a.div = b.div and a.itno = b.itno
  where b.comltd = a_comltd and b.xplant = a_plant and
    b.div = a_dvsn and
    ( (b.cls = '10' and b.srce = '03' and
    (a.sliptype = 'RM' or a.sliptype = 'SA' or
     a.sliptype = 'SR' or a.sliptype = 'IW'))
    or (( b.cls = '10' or b.cls = '35' or
      b.cls = '40' or b.cls = '50' ) and
    ( b.srce = '01' or b.srce = '02' or b.srce = '04' ) and
    (a.sliptype = 'SA' or a.sliptype = 'SR'))) and
  a.tdte4 >= p_fromdate and a.tdte4 <= a_applydate;

declare continue handler for not_found
  set at_end = 1;

if a_chk = 'A' then
  set p_gubun = 'D';
end if;
if a_chk = 'C' then
  set p_gubun = 'E';
end if;
if a_chk <> 'A' and a_chk <> 'C' then
  return;
end if;

set p_yyyymm = substring(a_applydate,1,6);
set p_fromdate = concat(p_yyyymm,'01');

select count(*) into p_fttcnt
from pbpdm.bom009
where fcmcd = a_comltd AND fgubun = p_gubun and
 fdate = p_yyyymm and fplant = a_plant and
 fdvsn = a_dvsn;
if p_fttcnt > 0 then
  delete from pbpdm.bom009
  where fcmcd = a_comltd AND fgubun = p_gubun and
   fdate = p_yyyymm and fplant = a_plant and
   fdvsn = a_dvsn;
end if;

open bom_001;
inc_loop:
loop
  fetch bom_001 into p_plant,p_dvsn,p_itno,p_pdcd,p_cls,p_srce;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- First Step
  if p_srce = '01' or p_srce = '02' then
    set p_rtn = 'N';
  else
    set p_rtn = pbpdm.sf_bom_exp(a_comltd,p_plant,p_dvsn,
            p_itno,a_applydate,a_chk);
  end if;

  -- Calculate Cost
  if p_rtn = 'Y' then
    -- domestic item
    select count(*) into p_fdtcnt
    from qtemp.bomtemp a inner join pbinv.inv101 b
      on a.tcmcd = b.comltd and a.tplnt = b.xplant and
      a.tdvsn = b.div and a.tcitn = b.itno
    where a.tcalculate = 'Y' and b.cls = '10' and
      (b.srce = '02' or b.srce = '04');
    -- oversea item
    select count(*) into p_fitcnt
    from qtemp.bomtemp a inner join pbinv.inv101 b
      on a.tcmcd = b.comltd and a.tplnt = b.xplant and
      a.tdvsn = b.div and a.tcitn = b.itno
    where a.tcalculate = 'Y' and b.cls = '10' and
      b.srce = '01';
    -- total count
    select count(*) into p_fttcnt
    from qtemp.bomtemp a inner join pbinv.inv101 b
      on a.tcmcd = b.comltd and a.tplnt = b.xplant and
      a.tdvsn = b.div and a.tcitn = b.itno
    where a.tcalculate = 'Y' or a.tcomcd = 'Y';
    if p_fttcnt > 0 then
      select decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            case when a.tcomcd = 'Y' then 0
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as fdmcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            case when a.tcomcd = 'Y' then 0
            else a.tinputamt end
          else  0 end
          else 0 end),7,0) as fdrcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            case when a.tcomcd = 'Y' then 0
            else a.toutamt end
          else  0 end
          else 0 end),7,0) as fdacst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            case when a.tcomcd = 'Y' then 0
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as fimcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            case when a.tcomcd = 'Y' then 0
            else a.tinputamt end
          else  0 end
          else 0 end),7,0) as fircst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            case when a.tcomcd = 'Y' then 0
            else a.toutamt end
          else  0 end
          else 0 end),7,0) as fiacst,
       decimal(sum(case when b.cls = '40' or b.cls = '50' then
          case when b.srce = '04' then
            case when a.tcomcd = 'Y' then 0
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as foscst
      into p_fdmcst, p_fdrcst, p_fdacst, p_fimcst,
        p_fircst, p_fiacst, p_foscst
      from qtemp.bomtemp a inner join pbinv.inv101 b
        on a.tcmcd = b.comltd and a.tplnt = b.xplant and
        a.tdvsn = b.div and a.tcitn = b.itno
      where a.tcalculate = 'Y' or a.tcomcd = 'Y';
    else
      set p_fdmcst = 0;
      set p_fdrcst = 0;
      set p_fdacst = 0;
      set p_fimcst = 0;
      set p_fircst = 0;
      set p_fiacst = 0;
      set p_foscst = 0;
    end if;
  else
    select decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
          else  0 end
          else 0 end),7,0) as fdmcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            b.costls
          else  0 end
          else 0 end),7,0) as fdrcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            truncate(CASE WHEN b.outqty <> 0
            THEN abs(B.OUTAMT / B.OUTQTY)
            ELSE B.COSTLS END,6)
          else  0 end
          else 0 end),7,0) as fdacst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
          else  0 end
          else 0 end),7,0) as fimcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            b.costls
          else  0 end
          else 0 end),7,0) as fircst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            truncate(CASE WHEN b.outqty <> 0
            THEN abs(B.OUTAMT / B.OUTQTY)
            ELSE B.COSTLS END,6)
          else  0 end
          else 0 end),7,0) as fiacst,
       decimal(sum(case when b.cls = '40' or b.cls = '50' then
          case when b.srce = '04' then
            CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
          else  0 end
          else 0 end),7,0) as foscst
    into p_fdmcst, p_fdrcst, p_fdacst, p_fimcst,
      p_fircst, p_fiacst, p_foscst
    from pbinv.inv402 b
    where b.comltd = a_comltd and b.xplant = p_plant and
      b.div = p_dvsn and b.itno = p_itno and
      b.xyear = p_yyyymm;
    if at_end = 1 then
      set p_fdmcst = 0;
      set p_fdrcst = 0;
      set p_fdacst = 0;
      set p_fimcst = 0;
      set p_fircst = 0;
      set p_fiacst = 0;
      set p_foscst = 0;
      set at_end = 0;
    end if;
    set p_fdtcnt = 0;
    set p_fitcnt = 0;
    set p_fttcnt = 0;
  end if;
  set p_ftmcst = p_fdmcst + p_fimcst;
  set p_ftrcst = p_fdrcst + p_fircst;
  set p_ftacst = p_fdacst + p_fiacst;

  insert into pbpdm.bom009
  ( fcmcd,fgubun,fdate,fplant,fdvsn,fpdcd,fmdno,
  fdmcst,fdrcst,fdacst,fimcst,fircst,fiacst,
  fdvomt,fdvort,fdvoat,ftmcst,ftrcst,ftacst,foscst,
  fdtcnt,fitcnt,fttcnt,fisrce,fshipp,fcrdt,
  fcostdiv,fcmcst )
  values(a_comltd,p_gubun,p_yyyymm,p_plant,p_dvsn,p_pdcd,p_itno,
  p_fdmcst,p_fdrcst,p_fdacst,p_fimcst,p_fircst,p_fiacst,
  0, 0, 0,p_ftmcst,p_ftrcst,p_ftacst,p_foscst,
  p_fdtcnt,p_fitcnt,p_fttcnt,'',p_rtn,'20090316',
  '',0);
end loop;
close bom_001;
end
