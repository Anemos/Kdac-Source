/*
	File Name	: sp_pisi_eis_tprdtime.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tprdtime
	Description	: EIS Upload tprdtime
			  tprdtime
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tprdtime]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tprdtime]
GO

/*
Execute sp_pisi_eis_tprdtime
*/

Create Procedure sp_pisi_eis_tprdtime

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_prddate		char(10),
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(13),
	@ls_applyfrom		char(10),
	@ls_timecode		char(5),
	@ls_planqty		int,
	@ls_prdqty		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tprdtime
(	checkId		int IDENTITY(1,1),
	PrdDate		char (10),
	AreaCode	char (1),
	DivisionCode	char (1),
	WorkCenter	varchar (5),
	LineCode	char (1),
	ItemCode	varchar (12),
	ApplyFrom	char(10),
	TimeCode	char(5),
	PlanQty		int,
	PrdQty		int,
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tprdtime
select	*
from	[ipisele_svr\ipis].ipis.dbo.tprdtime
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdtime
	Where	checkid > @ls_id

	If not exists (select * from tprdtime 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tprdtime
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	applyfrom,	timecode,		PlanQty,	
			prdqty,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_applyfrom,	@ls_timecode,		@ls_PlanQty,	
			@ls_prdqty,	@ls_LastEmp)

	Else
		update	tprdtime
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipisele_svr\ipis].ipis.dbo.tprdtime
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprdtime


-- 대구기계

Insert	into	#tmp_tprdtime
select	*
from	[ipismac_svr\ipis].ipis.dbo.tprdtime
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdtime
	Where	checkid > @ls_id

	If not exists (select * from tprdtime 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tprdtime
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	applyfrom,	timecode,		PlanQty,	
			prdqty,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_applyfrom,	@ls_timecode,		@ls_PlanQty,	
			@ls_prdqty,	@ls_LastEmp)

	Else
		update	tprdtime
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipismac_svr\ipis].ipis.dbo.tprdtime
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprdtime


-- 대구압축

Insert	into	#tmp_tprdtime
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tprdtime
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdtime
	Where	checkid > @ls_id

	If not exists (select * from tprdtime 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tprdtime
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	applyfrom,	timecode,		PlanQty,	
			prdqty,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_applyfrom,	@ls_timecode,		@ls_PlanQty,	
			@ls_prdqty,	@ls_LastEmp)

	Else
		update	tprdtime
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipishvac_svr\ipis].ipis.dbo.tprdtime
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprdtime


-- 진천

Insert	into	#tmp_tprdtime
select	*
from	[ipisjin_svr].ipis.dbo.tprdtime
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdtime
	Where	checkid > @ls_id

	If not exists (select * from tprdtime 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tprdtime
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	applyfrom,	timecode,		PlanQty,	
			prdqty,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_applyfrom,	@ls_timecode,		@ls_PlanQty,	
			@ls_prdqty,	@ls_LastEmp)

	Else
		update	tprdtime
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipisjin_svr].ipis.dbo.tprdtime
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tprdtime
 
End		-- Procedure End
Go
