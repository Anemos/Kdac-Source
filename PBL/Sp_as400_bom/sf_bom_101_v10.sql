-- file name : sf_bom_101
-- procedure name : pbpdm.sf_bom_101
-- desc : BOM 전체 재료비 데이타생성함수 : 고객사유상제외 'D'
-- a_comltd, a_plant, a_dvsn, a_itno, a_pdcd, a_costdiv,
-- a_yyyymm, a_createdate, a_rtn
drop function pbpdm.sf_bom_101;
create function pbpdm.sf_bom_101 (
a_comltd char(2),
a_plant char(1),
a_dvsn char(1),
a_itno varchar(15),
a_pdcd char(2),
a_costdiv char(1),
a_yyyymm char(6),
a_createdate char(8),
a_rtn   char(1))
returns char(1)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_gubun char(1);
declare p_costdiv char(2);
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

declare continue handler for not_found
        set at_end = 1;

set p_gubun = 'D';
set p_costdiv = concat(a_plant,a_costdiv);

-- Calculate Cost
select sum(case when b.srce = '02' or b.srce = '04'
  then 1 else 0 end) as fdtcnt,
sum(case when b.srce = '01'
  then 1 else 0 end) as fitcnt,
count(*) as fttcnt,
decimal(sum(case when b.cls = '10' then
  case when b.srce = '02' or b.srce = '04' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscmoveamt end
    else a.tscmoveamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tmoveamt end
    else a.tmoveamt end
  end
  else  0 end
else 0 end),7,0) as fdmcst,
decimal(sum(case when b.cls = '10' then
  case when b.srce = '02' or b.srce = '04' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscinputamt end
    else a.tscinputamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tinputamt end
    else a.tinputamt end
  end
  else  0 end
else 0 end),7,0) as fdrcst,
decimal(sum(case when b.cls = '10' then
  case when b.srce = '02' or b.srce = '04' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscoutamt end
    else a.tscoutamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.toutamt end
    else a.toutamt end
  end
  else  0 end
else 0 end),7,0) as fdacst,
decimal(sum(case when b.cls = '10' then
  case when b.srce = '01' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscmoveamt end
    else a.tscmoveamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tmoveamt end
    else a.tmoveamt end
  end
  else  0 end
else 0 end),7,0) as fimcst,
decimal(sum(case when b.cls = '10' then
  case when b.srce = '01' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscinputamt end
    else a.tscinputamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tinputamt end
    else a.tinputamt end
  end
  else  0 end
else 0 end),7,0) as fircst,
decimal(sum(case when b.cls = '10' then
  case when b.srce = '01' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscoutamt end
    else a.tscoutamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.toutamt end
    else a.toutamt end
  end
  else  0 end
else 0 end),7,0) as fiacst,
decimal(sum(case when b.cls = '40' or b.cls = '50' then
  case when b.srce = '04' then
  case when a.tsubpaycd = 'Y' then
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tscmoveamt end
    else a.tscmoveamt end
  else
    case when a.tcomcd = 'Y' then
      case when a.tcalculate = 'Y' then 0
      else (-1) * a.tmoveamt end
    else a.tmoveamt end
  end
  else  0 end
else 0 end),7,0) as foscst
into p_fdtcnt,p_fitcnt,p_fttcnt,p_fdmcst,p_fdrcst,p_fdacst,
p_fimcst,p_fircst, p_fiacst, p_foscst
from qtemp.tmp_bom a inner join pbinv.inv101 b
on a.tcmcd = b.comltd and a.tplnt = b.xplant and
a.tdvsn = b.div and a.tcitn = b.itno
where a.tcalculate = 'Y' or a.tcomcd = 'Y' or
  (a.twkct = '8888' and a.topchk <> '2') or
  (a.tcalculate2 = 'Y' and a.topchk <> '2');

if at_end = 1 then
  set p_fdmcst = 0;
  set p_fdrcst = 0;
  set p_fdacst = 0;
  set p_fimcst = 0;
  set p_fircst = 0;
  set p_fiacst = 0;
  set p_foscst = 0;
  set p_fdtcnt = 0;
  set p_fitcnt = 0;
  set p_fttcnt = 0;
  set at_end = 0;
end if;

set p_ftmcst = p_fdmcst + p_fimcst;
set p_ftrcst = p_fdrcst + p_fircst;
set p_ftacst = p_fdacst + p_fiacst;

insert into pbpdm.bom109
  ( fcmcd,fgubun,fdate,fplant,fdvsn,fpdcd,fmdno,
  fdmcst,fdrcst,fdacst,fimcst,fircst,fiacst,
  fdvomt,fdvort,fdvoat,ftmcst,ftrcst,ftacst,foscst,
  fdtcnt,fitcnt,fttcnt,fisrce,fshipp,fcrdt,
  fcostdiv,fcmcst )
values(a_comltd,p_gubun,a_yyyymm,a_plant,a_dvsn,a_pdcd,a_itno,
  p_fdmcst,p_fdrcst,p_fdacst,p_fimcst,p_fircst,p_fiacst,
  0, 0, 0,p_ftmcst,p_ftrcst,p_ftacst,p_foscst,
  p_fdtcnt,p_fitcnt,p_fttcnt,'',a_rtn,a_createdate,
  p_costdiv,0);

return 'Y';
end
