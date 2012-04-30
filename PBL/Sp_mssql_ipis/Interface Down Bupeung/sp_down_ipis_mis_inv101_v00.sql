/*
  File Name : sp_down_ipis_mis_inv101.SQL
  SYSTEM    : Interface System
  Procedure Name  : sp_down_ipis_mis_inv101
  Description : 공무자재 정보 다운로드, 대구전장인터페이스 JOB Schedule
  Use DataBase  : CMMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_down_ipis_mis_inv101]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_down_ipis_mis_inv101]
GO

/*
Execute sp_down_ipis_mis_inv101
*/

Create Procedure sp_down_ipis_mis_inv101

As
Begin

declare @li_count int
declare @max_chgdate varchar(30)

SELECT chgdate = aa.chgdate,
  chgcd = aa.chgcd,
  xplant = aa.xplant,
  div = aa.div,
  pdcd = aa.pdcd,
  itno = aa.itno,
  cls = aa.cls,
  srce = aa.srce,
  xunit = aa.xunit,
  convqty = aa.convqty,
  saud = aa.saud,
  abccd = aa.abccd,
  wloc = aa.wloc,
  xplan = aa.xplan,
  mcno = aa.mcno,
  minq = aa.minq,
  maxq = aa.maxq,
  stscd = aa.stscd,
  downdate = aa.downdate,
  itnm = bb.itnm,
  spec = bb.spec
INTO #master_gen
FROM tmisinv101 aa INNER JOIN (
  SELECT ITNO = TMP_AA.ITNO,
    ITNM = TMP_AA.ITNM,
    SPEC = TMP_AA.SPEC FROM TMISINV002 TMP_AA INNER JOIN
      ( SELECT ITNO,MAX(CHGDATE) AS MAX_CHGDATE FROM TMISINV002
          WHERE ITNO IN ( SELECT ITNO FROM TMISINV101 WHERE stscd = 'N' )
        GROUP BY ITNO ) TMP_BB
    ON TMP_AA.ITNO = TMP_BB.ITNO AND TMP_AA.CHGDATE = TMP_BB.MAX_CHGDATE) bb
    ON aa.itno = bb.itno
WHERE aa.stscd = 'N' and
  ( aa.xplant + aa.div + aa.itno + aa.chgdate in ( select xplant + div + itno + max(chgdate)
            from tmisinv101 where stscd = 'N' group by xplant, div, itno ) )
ORDER BY aa.chgdate

if @@error <> 0 or @@rowcount = 0
  Begin
  Return
  End

Select @max_chgdate = max(chgdate)
from #master_gen

-- 전장 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and div = 'A' and chgcd in ('C','U','D')

if @li_count > 0
  Begin
    -- Chgcd in ('C','D')
    delete [ipisele_svr\ipis].cmms.dbo.part_master
    from #master_gen aa inner join [ipisele_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.div = 'A' and aa.chgcd in ('C','D')

    insert into [ipisele_svr\ipis].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location, minq, maxq )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc, minq, maxq
    from #master_gen
    where xplant = 'D' and div = 'A' and chgcd = 'C'

    delete [ipisele_svr\ipis].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipisele_svr\ipis].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'D' and aa.div = 'A' ) and (aa.chgcd in ('C','U','D'))

    insert into [ipisele_svr\ipis].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipisele_svr\ipis].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'D' and aa.div = 'A' and aa.chgcd IN ( 'C','U') and aa.mcno is not null

    -- Chgcd = 'U'
    update [ipisele_svr\ipis].cmms.dbo.part_master
    set part_name = aa.itnm, part_spec = aa.spec, part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc,
      minq = aa.minq, maxq = aa.maxq
    from #master_gen aa inner join [ipisele_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.div = 'A' and aa.chgcd = 'U'

  End

-- 기계 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and div in ('M','S') and chgcd in ('C','U','D')

if @li_count > 0
  Begin
    -- Chgcd in ('C','D')
    delete [ipismac_svr\ipis].cmms.dbo.part_master
    from #master_gen aa inner join [ipismac_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.div in ('M','S') and aa.chgcd in ('C','D')

    insert into [ipismac_svr\ipis].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location, minq, maxq )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc, minq, maxq
    from #master_gen
    where xplant = 'D' and div in ('M','S') and chgcd = 'C'

    delete [ipismac_svr\ipis].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipismac_svr\ipis].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'D' and aa.div in ('M','S') ) and (aa.chgcd in ('C','U','D'))

    insert into [ipismac_svr\ipis].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipismac_svr\ipis].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'D' and aa.div in ('M','S') and aa.chgcd IN ( 'C','U') and aa.mcno is not null

    -- Chgcd = 'U'
    update [ipismac_svr\ipis].cmms.dbo.part_master
    set part_name = aa.itnm, part_spec = aa.spec, part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc,
      minq = aa.minq, maxq = aa.maxq
    from #master_gen aa inner join [ipismac_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.div in ('M','S') and aa.chgcd = 'U'

  End
-- 공조 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and div in ('H','V') and chgcd in ('C','U','D')

if @li_count > 0
  Begin
    -- Chgcd in ('C','D')
    delete [ipishvac_svr\ipis].cmms.dbo.part_master
    from #master_gen aa inner join [ipishvac_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.div in ('H','V') and aa.chgcd in ('C','D')

    insert into [ipishvac_svr\ipis].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location, minq, maxq )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc, minq, maxq
    from #master_gen
    where xplant = 'D' and div in ('H','V') and chgcd = 'C'

    delete [ipishvac_svr\ipis].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipishvac_svr\ipis].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'D' and aa.div in ('H','V') ) and (aa.chgcd in ('C','U','D'))

    insert into [ipishvac_svr\ipis].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipishvac_svr\ipis].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'D' and aa.div in ('H','V') and aa.chgcd IN ( 'C','U') and aa.mcno is not null

    -- Chgcd = 'U'

    update [ipishvac_svr\ipis].cmms.dbo.part_master
    set part_name = aa.itnm, part_spec = aa.spec, part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc,
      minq = aa.minq, maxq = aa.maxq
    from #master_gen aa inner join [ipishvac_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.div in ('H','V') and aa.chgcd = 'U'

  End
-- 진천 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'J'  and chgcd in ('C','U','D')

if @li_count > 0
  Begin
    -- Chgcd in ('C','D')
    delete [ipisjin_svr].cmms.dbo.part_master
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'J' and aa.chgcd in ('C','D')

    insert into [ipisjin_svr].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location, minq, maxq )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc, minq, maxq
    from #master_gen
    where xplant = 'J' and chgcd = 'C'

    delete [ipisjin_svr].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'J' ) and (aa.chgcd in ('C','U','D'))

    insert into [ipisjin_svr].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'J' and aa.chgcd IN ( 'C','U') and aa.mcno is not null

    -- Chgcd = 'U'

    update [ipisjin_svr].cmms.dbo.part_master
    set part_name = aa.itnm, part_spec = aa.spec, part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc,
      minq = aa.minq, maxq = aa.maxq
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'J' and aa.chgcd = 'U'

  End
-- 여주 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'Y'  and chgcd in ('C','U','D')

if @li_count > 0
  Begin
    -- Chgcd in ('C','D')
    delete [ipisyeo_svr\ipis].cmms.dbo.part_master
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'Y' and aa.chgcd in ('C','D')

    insert into [ipisyeo_svr\ipis].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location, minq, maxq )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc, minq, maxq
    from #master_gen
    where xplant = 'Y' and chgcd = 'C'

    delete [ipisyeo_svr\ipis].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'Y' ) and (aa.chgcd in ('C','U','D'))

    insert into [ipisyeo_svr\ipis].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'Y' and aa.chgcd IN ( 'C','U') and aa.mcno is not null

    -- Chgcd = 'U'

    update [ipisyeo_svr\ipis].cmms.dbo.part_master
    set part_name = aa.itnm, part_spec = aa.spec, part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc,
      minq = aa.minq, maxq = aa.maxq
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'Y' and aa.chgcd = 'U'


  End
-- 마무리작업
update tmisinv101
set stscd = 'Y'
from tmisinv101 aa inner join #master_gen bb
  on aa.xplant = bb.xplant and aa.div = bb.div and
    aa.itno = bb.itno
where aa.chgdate <= @max_chgdate

Drop Table #master_gen

End   -- Procedure End
Go
