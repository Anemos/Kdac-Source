-- file name : sf_bom_002
-- procedure name : pbpdm.sf_bom_002
-- desc : BOM 공장기준 재료비 데이타생성함수
-- a_comltd, a_plant, a_dvsn, a_itno, a_pdcd, a_costdiv,
-- a_yyyymm, a_createdate, a_rtn
drop function pbpdm.sf_bom_002;
create function pbpdm.sf_bom_002 (
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
declare p_fdvomt numeric(7,0);
declare p_fdvort numeric(7,0);
declare p_fdvoat numeric(7,0);
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

set p_gubun = 'E';
set p_costdiv = concat(a_plant,a_costdiv);
-- Calculate Cost
  if a_rtn = 'Y' then
    -- domestic item
    select count(*) into p_fdtcnt
    from qtemp.tmp_bom a inner join pbinv.inv101 b
      on a.tcmcd = b.comltd and a.tplnt = b.xplant and
      a.tdvsn = b.div and a.tcitn = b.itno
    where a.tcmcd = a_comltd and a.tplnt = a_plant and
      a.tdvsn = a_dvsn and
      ( a.tcalculate = 'Y' or a.tcomcd = 'Y' ) and
      b.cls = '10' and
      (b.srce = '02' or b.srce = '04');
    -- oversea item
    select count(*) into p_fitcnt
    from qtemp.tmp_bom a inner join pbinv.inv101 b
      on a.tcmcd = b.comltd and a.tplnt = b.xplant and
      a.tdvsn = b.div and a.tcitn = b.itno
    where a.tcmcd = a_comltd and a.tplnt = a_plant and
      a.tdvsn = a_dvsn and
      ( a.tcalculate = 'Y' or a.tcomcd = 'Y' ) and
      b.cls = '10' and b.srce = '01';
    -- total count
    select count(*) into p_fttcnt
    from qtemp.tmp_bom a inner join pbinv.inv101 b
      on a.tcmcd = b.comltd and a.tplnt = b.xplant and
      a.tdvsn = b.div and a.tcitn = b.itno
    where a.tcmcd = a_comltd and a.tplnt = a_plant and
      a.tdvsn = a_dvsn and
      ( a.tcalculate = 'Y' or a.tcomcd = 'Y' );
    if p_fttcnt > 0 then
      select decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tmoveamt end
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as fdmcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tinputamt end
            else a.tinputamt end
          else  0 end
          else 0 end),7,0) as fdrcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '02' or b.srce = '04' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.toutamt end
            else a.toutamt end
          else  0 end
          else 0 end),7,0) as fdacst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tmoveamt end
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as fimcst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tinputamt end
            else a.tinputamt end
          else  0 end
          else 0 end),7,0) as fircst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '01' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.toutamt end
            else a.toutamt end
          else  0 end
          else 0 end),7,0) as fiacst,
       decimal(sum(case when b.cls = '40' or b.cls = '50' then
          case when b.srce = '04' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tmoveamt end
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as foscst,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '06' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tmoveamt end
            else a.tmoveamt end
          else  0 end
          else 0 end),7,0) as fdvomt,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '06' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.tinputamt end
            else a.tinputamt end
          else  0 end
          else 0 end),7,0) as fdvort,
       decimal(sum(case when b.cls = '10' then
          case when b.srce = '06' then
            case when a.tcomcd = 'Y' then
              case when a.tcalculate = 'Y' then 0
              else (-1) * a.toutamt end
            else a.toutamt end
          else  0 end
          else 0 end),7,0) as fdvoat
      into p_fdmcst, p_fdrcst, p_fdacst, p_fimcst,
        p_fircst, p_fiacst, p_foscst, p_fdvomt,
        p_fdvort, p_fdvoat
      from qtemp.tmp_bom a inner join pbinv.inv101 b
        on a.tcmcd = b.comltd and a.tplnt = b.xplant and
        a.tdvsn = b.div and a.tcitn = b.itno
      where a.tcmcd = a_comltd and a.tplnt = a_plant and
        a.tdvsn = a_dvsn and
        ( a.tcalculate = 'Y' or a.tcomcd = 'Y' );
    else
      set p_fdmcst = 0;
      set p_fdrcst = 0;
      set p_fdacst = 0;
      set p_fimcst = 0;
      set p_fircst = 0;
      set p_fiacst = 0;
      set p_foscst = 0;
      set p_fdvomt = 0;
      set p_fdvort = 0;
      set p_fdvoat = 0;
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
    where b.comltd = a_comltd and b.xplant = a_plant and
      b.div = a_dvsn and b.itno = a_itno and
      b.xyear = a_yyyymm;
    if at_end = 1 then
      set p_fdmcst = 0;
      set p_fdrcst = 0;
      set p_fdacst = 0;
      set p_fimcst = 0;
      set p_fircst = 0;
      set p_fiacst = 0;
      set p_foscst = 0;
      set p_fdvomt = 0;
      set p_fdvort = 0;
      set p_fdvoat = 0;
      set at_end = 0;
    end if;
    if p_fdrcst = 0 then
      set p_fdrcst = p_fdmcst;
    end if;
    if p_fdacst = 0 then
      set p_fdacst = p_fdmcst;
    end if;
    if p_fircst = 0 then
      set p_fircst = p_fimcst;
    end if;
    if p_fiacst = 0 then
      set p_fiacst = p_fimcst;
    end if;
    set p_fdtcnt = 0;
    set p_fitcnt = 0;
    set p_fttcnt = 0;
    set p_fdvomt = 0;
    set p_fdvort = 0;
    set p_fdvoat = 0;
  end if;
  set p_ftmcst = p_fdmcst + p_fimcst + p_fdvomt;
  set p_ftrcst = p_fdrcst + p_fircst + p_fdvort;
  set p_ftacst = p_fdacst + p_fiacst + p_fdvoat;

  insert into pbpdm.bom009
  ( fcmcd,fgubun,fdate,fplant,fdvsn,fpdcd,fmdno,
  fdmcst,fdrcst,fdacst,fimcst,fircst,fiacst,
  fdvomt,fdvort,fdvoat,ftmcst,ftrcst,ftacst,foscst,
  fdtcnt,fitcnt,fttcnt,fisrce,fshipp,fcrdt,
  fcostdiv,fcmcst )
  values(a_comltd,p_gubun,a_yyyymm,a_plant,a_dvsn,a_pdcd,a_itno,
  p_fdmcst,p_fdrcst,p_fdacst,p_fimcst,p_fircst,p_fiacst,
  p_fdvomt,p_fdvort,p_fdvoat,p_ftmcst,p_ftrcst,p_ftacst,p_foscst,
  p_fdtcnt,p_fitcnt,p_fttcnt,'',a_rtn,a_createdate,
  p_costdiv,0);

return 'Y';
end
