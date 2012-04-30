/*
	File Name	: SP_PART_MASTER_DOWN.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: SP_PART_MASTER_DOWN
	Description	: DOWN INVMASTER
	Supply		: 
	Use DataBase	: CMMS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
	Modify    : 2004.11.25
	Modifier  : Kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[SP_PART_MASTER_DOWN]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[SP_PART_MASTER_DOWN]
GO

/*
Execute SP_PART_MASTER_DOWN
*/

Create  Procedure SP_PART_MASTER_DOWN
AS
BEGIN

declare @li_count int

Truncate Table invmaster

insert into [ipisele_svr\ipis].cmms.dbo.invmaster
select *
from [ipisele_svr\ipis].interface.dbo.invmaster
where stscd = 'N'

select *
into #master_gen
from [ipisele_svr\ipis].cmms.dbo.invmaster
where xplant + div + itno + chgdate in 
  ( select xplant + div + itno + max(chgdate)
    from [ipisele_svr\ipis].cmms.dbo.invmaster
    group by xplant, div, itno )

-- 전장 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and div = 'A' and chgcd in ('A','R','D')

if @li_count > 0
  Begin
		-- Chgcd in ('A','D')
		delete [ipisele_svr\ipis].cmms.dbo.part_master
		from #master_gen aa inner join [ipisele_svr\ipis].cmms.dbo.part_master bb
		  on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
		where aa.xplant = 'D' and aa.div = 'A' and aa.chgcd in ('A','D')
		
		insert into [ipisele_svr\ipis].cmms.dbo.part_master
		( area_code, factory_code, part_code, part_name, part_spec, part_unit,
		  part_cost, comp_code, part_location )
		select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc
		from #master_gen
		where xplant = 'D' and div = 'A' and chgcd = 'A'
		
		-- Chgcd = 'R'
		insert into [ipisele_svr\ipis].cmms.dbo.part_master
		( area_code, factory_code, part_code, part_name, part_spec, part_unit,
		  part_cost, comp_code, part_location )
		select aa.xplant, aa.div, aa.itno, ' ', ' ', aa.xunit, aa.saud, aa.srce, aa.wloc
		from #master_gen aa
		where aa.xplant = 'D' and aa.div = 'A' and aa.chgcd = 'R' and
		  not exists ( select bb.part_code from [ipisele_svr\ipis].cmms.dbo.part_master bb
		    where bb.area_code = aa.xplant and bb.factory_code = aa.div and bb.part_code = aa.itno )
		
		update [ipisele_svr\ipis].cmms.dbo.part_master
		set part_name = ' ', part_spec = ' ', part_unit = aa.xunit,
		  part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc
		from #master_gen aa inner join [ipisele_svr\ipis].cmms.dbo.part_master bb
		  on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
		where aa.xplant = 'D' and aa.div = 'A' and aa.chgcd = 'R'

	End
		
-- 기계 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and div in ('M','S') and chgcd in ('A','R','D')

if @li_count > 0
  Begin
		-- Chgcd in ('A','D')
		delete [ipismac_svr\ipis].cmms.dbo.part_master
		from #master_gen aa inner join [ipismac_svr\ipis].cmms.dbo.part_master bb
		  on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
		where aa.xplant = 'D' and aa.div in ('M','S') and aa.chgcd in ('A','D')
		
		insert into [ipismac_svr\ipis].cmms.dbo.part_master
		( area_code, factory_code, part_code, part_name, part_spec, part_unit,
		  part_cost, comp_code, part_location )
		select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc
		from #master_gen
		where xplant = 'D' and div in ('M','S') and chgcd = 'A'
		
		-- Chgcd = 'R'
		insert into [ipismac_svr\ipis].cmms.dbo.part_master
		( area_code, factory_code, part_code, part_name, part_spec, part_unit,
		  part_cost, comp_code, part_location )
		select aa.xplant, aa.div, aa.itno, ' ', ' ', aa.xunit, aa.saud, aa.srce, aa.wloc
		from #master_gen aa
		where aa.xplant = 'D' and aa.div in ('M','S') and aa.chgcd = 'R' and
		  not exists ( select bb.part_code from [ipismac_svr\ipis].cmms.dbo.part_master bb
		    where bb.area_code = aa.xplant and bb.factory_code = aa.div and bb.part_code = aa.itno )
		
		update [ipismac_svr\ipis].cmms.dbo.part_master
		set part_name = ' ', part_spec = ' ', part_unit = aa.xunit,
		  part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc
		from #master_gen aa inner join [ipismac_svr\ipis].cmms.dbo.part_master bb
		  on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
		where aa.xplant = 'D' and aa.div in ('M','S') and aa.chgcd = 'R'
		
	End
-- 공조 CMMS
select @li_count = count(*)
from #master_gen
where xplant = 'D' and div in ('H','V') and chgcd in ('A','R','D')

if @li_count > 0
  Begin
		-- Chgcd in ('A','D')
		delete [ipishvac_svr\ipis].cmms.dbo.part_master
		from #master_gen aa inner join [ipishvac_svr\ipis].cmms.dbo.part_master bb
		  on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
		where aa.xplant = 'D' and aa.div in ('H','V') and aa.chgcd in ('A','D')
		
		insert into [ipishvac_svr\ipis].cmms.dbo.part_master
		( area_code, factory_code, part_code, part_name, part_spec, part_unit,
		  part_cost, comp_code, part_location )
		select xplant, div, itno, ' ', ' ', xunit, saud, srce, wloc
		from #master_gen
		where xplant = 'D' and div in ('H','V') and chgcd = 'A'
		-- Chgcd = 'R'
		insert into [ipishvac_svr\ipis].cmms.dbo.part_master
		( area_code, factory_code, part_code, part_name, part_spec, part_unit,
		  part_cost, comp_code, part_location )
		select aa.xplant, aa.div, aa.itno, ' ', ' ', aa.xunit, aa.saud, aa.srce, aa.wloc
		from #master_gen aa
		where aa.xplant = 'D' and aa.div in ('H','V') and aa.chgcd = 'R' and
		  not exists ( select bb.part_code from [ipishvac_svr\ipis].cmms.dbo.part_master bb
		    where bb.area_code = aa.xplant and bb.factory_code = aa.div and bb.part_code = aa.itno )
		
		update [ipishvac_svr\ipis].cmms.dbo.part_master
		set part_name = ' ', part_spec = ' ', part_unit = aa.xunit,
		  part_cost = aa.saud, comp_code = aa.srce, part_location = aa.wloc
		from #master_gen aa inner join [ipishvac_svr\ipis].cmms.dbo.part_master bb
		  on aa.xplant = bb.area_code and aa.div = bb.factory_code and aa.itno = bb.part_code
		where aa.xplant = 'D' and aa.div in ('H','V') and aa.chgcd = 'R'
		
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

	End
-- 마무리작업
update [ipisele_svr\ipis].interface.dbo.invmaster
set stscd = 'Y'
from [ipisele_svr\ipis].interface.dbo.invmaster aa inner join [ipisele_svr\ipis].cmms.dbo.invmaster bb
on aa.logid = bb.logid
 
Drop Table #master_gen

--tmstitem 과 part_master 에서 품명과 규격이 다른 품번을 update (추가일 : 2003.07.10)
--전장서버
UPDATE [ipisele_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipisele_svr\ipis].cmms.dbo.part_master a, [ipisele_svr\ipis].ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--공조서버
UPDATE [ipishvac_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipishvac_svr\ipis].cmms.dbo.part_master a, [ipishvac_svr\ipis].ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--제동서버
UPDATE [ipismac_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipismac_svr\ipis].cmms.dbo.part_master a, [ipismac_svr\ipis].ipis.dbo.tmstitem b
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

GO
