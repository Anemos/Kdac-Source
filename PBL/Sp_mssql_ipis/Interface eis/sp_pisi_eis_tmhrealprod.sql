/*
	File Name	: sp_pisi_eis_tmhrealprod.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhrealprod
	Description	: EIS Upload tmhrealprod
			  tmhrealprod
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhrealprod]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhrealprod]
GO

/*
Execute sp_pisi_eis_tmhrealprod
*/

Create Procedure sp_pisi_eis_tmhrealprod
	
As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@ls_id				int,
	@ls_AreaCode			char (1),
	@ls_DivisionCode		char (1),
	@ls_WorkCenter			varchar (5),
	@ls_WorkDay			char (10),
	@ls_ItemCode			varchar (12),
	@ls_sublinecode			varchar(7),
	@ls_sublineno			char(1),
	@ls_seq				numeric(3,0),
	@ls_wcitemgroup			varchar(30),
	@ls_daypqty			int,
	@ls_nightpqty			int,
	@ls_unusemh			numeric(4,1),
	@ls_actmh			numeric(4,1),
	@ls_actinmh			numeric(4,1),
	@ls_basictime			numeric(9,4),
	@ls_basicmh			numeric(4,1),
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tmhrealprod
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	WorkCenter		varchar (5),
	WorkDay			char (10),
	ItemCode		varchar (12),
	sublinecode		varchar(7),
	sublineno		char(1),
	seq			numeric(3,0),
	wcitemgroup		varchar(30),
	daypqty			int,
	nightpqty		int,
	unusemh			numeric(4,1),
	actmh			numeric(4,1),
	actinmh			numeric(4,1),
	basictime		numeric(9,4),
	basicmh			numeric(4,1),
	LastEmp			varchar(6),
	LastDate		datetime	)

-- 각 서버 tdelete에서 tablename이 tmhrealprod인 놈 정리하고...

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tmhrealprod
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhrealprod
where	workday <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode	= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_WorkDay		= workday,
		@ls_ItemCode		= itemcode,
		@ls_sublinecode		= sublinecode,
		@ls_sublineno		= sublineno,
		@ls_seq			= seq,
		@ls_wcitemgroup		= wcitemgroup,
		@ls_daypqty		= daypqty,
		@ls_nightpqty		= nightpqty,
		@ls_unusemh		= unusemh,
		@ls_actmh		= actmh,
		@ls_actinmh		= actinmh,
		@ls_basictime		= basictime,
		@ls_basicmh		= basicmh,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhrealprod
	Where	checkid > @ls_id

	If not exists (select * from tmhrealprod 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday
			and	ItemCode	= @ls_itemcode
			and	sublinecode	= @ls_sublinecode
			and	sublineno	= @ls_sublineno)

		insert into tmhrealprod
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			ItemCode,		sublinecode,		sublineno,		seq,
			wcitemgroup,		daypqty,		nightpqty,		unusemh,
			actmh,			actinmh,		basictime,
			basicmh,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_ItemCode,		@ls_sublinecode,	@ls_sublineno,		@ls_seq,
			@ls_wcitemgroup,	@ls_daypqty,		@ls_nightpqty,		@ls_unusemh,
			@ls_actmh,		@ls_actinmh,		@ls_basictime,
			@ls_basicmh,		@ls_LastEmp)

	Else
		update	tmhrealprod
		set	seq		= @ls_seq,
			wcitemgroup	= @ls_wcitemgroup,
			daypqty		= @ls_daypqty,
			nightpqty	= @ls_nightpqty,
			unusemh		= @ls_unusemh,
			actmh		= @ls_actmh,
			actinmh		= @ls_actinmh,
			basictime	= @ls_basictime,
			basicmh		= @ls_basicmh
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday
		and	ItemCode	= @ls_itemcode
		and	sublinecode	= @ls_sublinecode
		and	sublineno	= @ls_sublineno

		                        
	update	[ipisele_svr\ipis].ipis.dbo.tmhrealprod
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	ItemCode	= @ls_itemcode
	and	sublinecode	= @ls_sublinecode
	and	sublineno	= @ls_sublineno
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmhrealprod


-- 대구기계

Insert	into	#tmp_tmhrealprod
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhrealprod
where	workday <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode	= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_WorkDay		= workday,
		@ls_ItemCode		= itemcode,
		@ls_sublinecode		= sublinecode,
		@ls_sublineno		= sublineno,
		@ls_seq			= seq,
		@ls_wcitemgroup		= wcitemgroup,
		@ls_daypqty		= daypqty,
		@ls_nightpqty		= nightpqty,
		@ls_unusemh		= unusemh,
		@ls_actmh		= actmh,
		@ls_actinmh		= actinmh,
		@ls_basictime		= basictime,
		@ls_basicmh		= basicmh,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhrealprod
	Where	checkid > @ls_id

	If not exists (select * from tmhrealprod 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday
			and	ItemCode	= @ls_itemcode
			and	sublinecode	= @ls_sublinecode
			and	sublineno	= @ls_sublineno)

		insert into tmhrealprod
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			ItemCode,		sublinecode,		sublineno,		seq,
			wcitemgroup,		daypqty,		nightpqty,		unusemh,
			actmh,			actinmh,		basictime,
			basicmh,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_ItemCode,		@ls_sublinecode,	@ls_sublineno,		@ls_seq,
			@ls_wcitemgroup,	@ls_daypqty,		@ls_nightpqty,		@ls_unusemh,
			@ls_actmh,		@ls_actinmh,		@ls_basictime,
			@ls_basicmh,		@ls_LastEmp)

	Else
		update	tmhrealprod
		set	seq		= @ls_seq,
			wcitemgroup	= @ls_wcitemgroup,
			daypqty		= @ls_daypqty,
			nightpqty	= @ls_nightpqty,
			unusemh		= @ls_unusemh,
			actmh		= @ls_actmh,
			actinmh		= @ls_actinmh,
			basictime	= @ls_basictime,
			basicmh		= @ls_basicmh
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday
		and	ItemCode	= @ls_itemcode
		and	sublinecode	= @ls_sublinecode
		and	sublineno	= @ls_sublineno

		                        
	update	[ipismac_svr\ipis].ipis.dbo.tmhrealprod
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	ItemCode	= @ls_itemcode
	and	sublinecode	= @ls_sublinecode
	and	sublineno	= @ls_sublineno
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmhrealprod


-- 대구압축

Insert	into	#tmp_tmhrealprod
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhrealprod
where	workday <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode	= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_WorkDay		= workday,
		@ls_ItemCode		= itemcode,
		@ls_sublinecode		= sublinecode,
		@ls_sublineno		= sublineno,
		@ls_seq			= seq,
		@ls_wcitemgroup		= wcitemgroup,
		@ls_daypqty		= daypqty,
		@ls_nightpqty		= nightpqty,
		@ls_unusemh		= unusemh,
		@ls_actmh		= actmh,
		@ls_actinmh		= actinmh,
		@ls_basictime		= basictime,
		@ls_basicmh		= basicmh,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhrealprod
	Where	checkid > @ls_id

	If not exists (select * from tmhrealprod 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday
			and	ItemCode	= @ls_itemcode
			and	sublinecode	= @ls_sublinecode
			and	sublineno	= @ls_sublineno)

		insert into tmhrealprod
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			ItemCode,		sublinecode,		sublineno,		seq,
			wcitemgroup,		daypqty,		nightpqty,		unusemh,
			actmh,			actinmh,		basictime,
			basicmh,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_ItemCode,		@ls_sublinecode,	@ls_sublineno,		@ls_seq,
			@ls_wcitemgroup,	@ls_daypqty,		@ls_nightpqty,		@ls_unusemh,
			@ls_actmh,		@ls_actinmh,		@ls_basictime,
			@ls_basicmh,		@ls_LastEmp)

	Else
		update	tmhrealprod
		set	seq		= @ls_seq,
			wcitemgroup	= @ls_wcitemgroup,
			daypqty		= @ls_daypqty,
			nightpqty	= @ls_nightpqty,
			unusemh		= @ls_unusemh,
			actmh		= @ls_actmh,
			actinmh		= @ls_actinmh,
			basictime	= @ls_basictime,
			basicmh		= @ls_basicmh
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday
		and	ItemCode	= @ls_itemcode
		and	sublinecode	= @ls_sublinecode
		and	sublineno	= @ls_sublineno

		                        
	update	[ipishvac_svr\ipis].ipis.dbo.tmhrealprod
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	ItemCode	= @ls_itemcode
	and	sublinecode	= @ls_sublinecode
	and	sublineno	= @ls_sublineno
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmhrealprod


-- 진천

Insert	into	#tmp_tmhrealprod
select	*
from	[ipisjin_svr].ipis.dbo.tmhrealprod
where	workday <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode	= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_WorkDay		= workday,
		@ls_ItemCode		= itemcode,
		@ls_sublinecode		= sublinecode,
		@ls_sublineno		= sublineno,
		@ls_seq			= seq,
		@ls_wcitemgroup		= wcitemgroup,
		@ls_daypqty		= daypqty,
		@ls_nightpqty		= nightpqty,
		@ls_unusemh		= unusemh,
		@ls_actmh		= actmh,
		@ls_actinmh		= actinmh,
		@ls_basictime		= basictime,
		@ls_basicmh		= basicmh,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhrealprod
	Where	checkid > @ls_id

	If not exists (select * from tmhrealprod 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday
			and	ItemCode	= @ls_itemcode
			and	sublinecode	= @ls_sublinecode
			and	sublineno	= @ls_sublineno)

		insert into tmhrealprod
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			ItemCode,		sublinecode,		sublineno,		seq,
			wcitemgroup,		daypqty,		nightpqty,		unusemh,
			actmh,			actinmh,		basictime,
			basicmh,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_ItemCode,		@ls_sublinecode,	@ls_sublineno,		@ls_seq,
			@ls_wcitemgroup,	@ls_daypqty,		@ls_nightpqty,		@ls_unusemh,
			@ls_actmh,		@ls_actinmh,		@ls_basictime,
			@ls_basicmh,		@ls_LastEmp)

	Else
		update	tmhrealprod
		set	seq		= @ls_seq,
			wcitemgroup	= @ls_wcitemgroup,
			daypqty		= @ls_daypqty,
			nightpqty	= @ls_nightpqty,
			unusemh		= @ls_unusemh,
			actmh		= @ls_actmh,
			actinmh		= @ls_actinmh,
			basictime	= @ls_basictime,
			basicmh		= @ls_basicmh
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday
		and	ItemCode	= @ls_itemcode
		and	sublinecode	= @ls_sublinecode
		and	sublineno	= @ls_sublineno

		                        
	update	[ipisjin_svr].ipis.dbo.tmhrealprod
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	ItemCode	= @ls_itemcode
	and	sublinecode	= @ls_sublinecode
	and	sublineno	= @ls_sublineno
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmhrealprod
 
End		-- Procedure End
Go
