/*
  file name : sp_part_master_down.sql
  system    : cmms system
  procedure name  : sp_part_master_down
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_part_master_down]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_part_master_down]
go

/*
execute sp_part_master_down
*/

create procedure [dbo].[sp_part_master_down]
AS
BEGIN

declare @li_count int

Truncate Table invmaster

insert into [ipis_daegu].cmms.dbo.invmaster
select *
from [ipis_daegu].interface.dbo.invmaster
where stscd = 'N'

select *
into #master_gen
from [ipis_daegu].cmms.dbo.invmaster
where xplant + div + itno + chgdate in
  ( select xplant + div + itno + max(chgdate)
    from [ipis_daegu].cmms.dbo.invmaster
    group by xplant, div, itno )

update #master_gen
set mcno = null
where rtrim(ltrim(mcno)) = ''

-- 대구 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and chgcd in ('A','R','D')

if @li_count > 0
  Begin
    -- Chgcd in ('A','D')
    delete [ipis_daegu].cmms.dbo.part_master
    from #master_gen aa inner join [ipis_daegu].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.chgcd in ('A','D')

    insert into [ipis_daegu].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc
    from #master_gen
    where xplant = 'D' and chgcd = 'A'

--2006.11.07 'R'추가
    delete [ipis_daegu].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipis_daegu].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'D' ) and (aa.chgcd in ('A','R','D'))

    insert into [ipis_daegu].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipis_daegu].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'D' and aa.chgcd IN ( 'A','R') and aa.mcno is not null

    -- Chgcd = 'R'
    insert into [ipis_daegu].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location )
    select aa.xplant, aa.div, aa.itno, ' ', ' ', aa.xunit, aa.saud, aa.srce, aa.wloc
    from #master_gen aa
    where aa.xplant = 'D' and aa.chgcd = 'R' and
      not exists ( select bb.part_code from [ipis_daegu].cmms.dbo.part_master bb
        where bb.area_code = aa.xplant and bb.factory_code = aa.div and bb.part_code = aa.itno )

    update [ipis_daegu].cmms.dbo.part_master
    set part_name = ' ', part_spec = ' ', part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc
    from #master_gen aa inner join [ipis_daegu].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.chgcd = 'R'

/*    update [ipis_daegu].cmms.dbo.equip_spare
    set equip_code = aa.mcno, part_flag = 'D'
    from #master_gen aa inner join [ipis_daegu].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where aa.xplant = 'D' and aa.chgcd = 'R' and aa.mcno is not null
*/
  End

-- 진천 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'J'  and chgcd in ('A','R','D')

if @li_count > 0
  Begin
    -- Chgcd in ('A','D')
    delete [ipisjin_svr].cmms.dbo.part_master
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'J' and aa.chgcd in ('A','D')

    insert into [ipisjin_svr].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc
    from #master_gen
    where xplant = 'J' and chgcd = 'A'

    delete [ipisjin_svr].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'J' ) and (aa.chgcd in ('A','R','D'))

    insert into [ipisjin_svr].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'J' and aa.chgcd IN ( 'A','R') and aa.mcno is not null

    -- Chgcd = 'R'
    insert into [ipisjin_svr].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location )
    select aa.xplant, aa.div, aa.itno, ' ', ' ', aa.xunit, aa.saud, aa.srce, aa.wloc
    from #master_gen aa
    where aa.xplant = 'J' and aa.chgcd = 'R' and
      not exists ( select bb.part_code from [ipisjin_svr].cmms.dbo.part_master bb
        where bb.area_code = aa.xplant and bb.factory_code = aa.div and bb.part_code = aa.itno )

    update [ipisjin_svr].cmms.dbo.part_master
    set part_name = ' ', part_spec = ' ', part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'J' and aa.chgcd = 'R'

/*    update [ipisjin_svr].cmms.dbo.equip_spare
    set equip_code = aa.mcno, part_flag = 'D'
    from #master_gen aa inner join [ipisjin_svr].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where aa.xplant = 'J' and aa.chgcd = 'R' and aa.mcno is not null
*/
  End
-- 여주 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'Y'  and chgcd in ('A','R','D')

if @li_count > 0
  Begin
    -- Chgcd in ('A','D')
    delete [ipisyeo_svr\ipis].cmms.dbo.part_master
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'Y' and aa.chgcd in ('A','D')

    insert into [ipisyeo_svr\ipis].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location )
    select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc
    from #master_gen
    where xplant = 'Y' and chgcd = 'A'

    delete [ipisyeo_svr\ipis].cmms.dbo.equip_spare
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where ( aa.xplant = 'Y' ) and (aa.chgcd in ('A','R','D'))

    insert into [ipisyeo_svr\ipis].cmms.dbo.equip_spare
    (area_code, factory_code, equip_code, part_code, part_qty, part_flag)
    select aa.xplant, aa.div, aa.mcno, aa.itno, 0, 'D'
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.equip_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.mcno = bb.equip_code
    where aa.xplant = 'Y' and aa.chgcd IN ( 'A','R') and aa.mcno is not null

    -- Chgcd = 'R'
    insert into [ipisyeo_svr\ipis].cmms.dbo.part_master
    ( area_code, factory_code, part_code, part_name, part_spec, part_unit,
      part_cost, comp_code, part_location )
    select aa.xplant, aa.div, aa.itno, ' ', ' ', aa.xunit, aa.saud, aa.srce, aa.wloc
    from #master_gen aa
    where aa.xplant = 'Y' and aa.chgcd = 'R' and
      not exists ( select bb.part_code from [ipisyeo_svr\ipis].cmms.dbo.part_master bb
        where bb.area_code = aa.xplant and bb.factory_code = aa.div and bb.part_code = aa.itno )

    update [ipisyeo_svr\ipis].cmms.dbo.part_master
    set part_name = ' ', part_spec = ' ', part_unit = aa.xunit,
      part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.part_master bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
    where aa.xplant = 'Y' and aa.chgcd = 'R'

/*    update [ipisyeo_svr\ipis].cmms.dbo.equip_spare
    set equip_code = aa.mcno, part_flag = 'D'
    from #master_gen aa inner join [ipisyeo_svr\ipis].cmms.dbo.equip_spare bb
      on aa.xplant = bb.area_code and aa.div = bb.factory_code and
        aa.itno = bb.part_code
    where aa.xplant = 'Y' and aa.chgcd = 'R' and aa.mcno is not null
*/

  End
-- 마무리작업
update [ipis_daegu].interface.dbo.invmaster
set stscd = 'Y'
from [ipis_daegu].interface.dbo.invmaster aa inner join [ipis_daegu].cmms.dbo.invmaster bb
on aa.logid = bb.logid

Drop Table #master_gen

--tmstitem 과 part_master 에서 품명과 규격이 다른 품번을 update (추가일 : 2003.07.10)
--대구서버
UPDATE [ipis_daegu].cmms.dbo.part_master
  SET part_name = b.itemname, part_spec = b.itemspec
  FROM [ipis_daegu].cmms.dbo.part_master a, [ipis_daegu].ipis.dbo.tmstitem b
  WHERE a.part_code = b.itemcode
    and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--진천서버
UPDATE [ipisjin_svr].cmms.dbo.part_master
  SET part_name = b.itemname, part_spec = b.itemspec
  FROM [ipisjin_svr].cmms.dbo.part_master a, [ipisjin_svr].ipis.dbo.tmstitem b
  WHERE a.part_code = b.itemcode
    and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--여주서버
UPDATE [ipisyeo_svr\ipis].cmms.dbo.part_master
  SET part_name = b.itemname, part_spec = b.itemspec
  FROM [ipisyeo_svr\ipis].cmms.dbo.part_master a, [ipisyeo_svr\ipis].ipis.dbo.tmstitem b
  WHERE a.part_code = b.itemcode
    and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )

END