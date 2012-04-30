/*
	File Name	: sp_pisi_eis_tprdratekb.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tprdratekb
	Description	: EIS Upload tprdratekb
			  tprdratekb
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tprdratekb]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tprdratekb]
GO

/*
Execute sp_pisi_eis_tprdratekb
*/

Create Procedure sp_pisi_eis_tprdratekb

	
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
	@ls_releasecount	int,
	@ls_prdcount		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tprdratekb
(	checkId		int IDENTITY(1,1),
	PrdDate		char (10),
	AreaCode	char (1),
	DivisionCode	char (1),
	WorkCenter	varchar (5),
	LineCode	char (1),
	ItemCode	varchar (12),
	releasecount	int,
	prdcount	int,
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tprdratekb
select	*
from	[ipisele_svr\ipis].ipis.dbo.tprdratekb
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
		@ls_releasecount	= releasecount,
		@ls_prdcount		= prdcount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdratekb
	Where	checkid > @ls_id

	If not exists (select * from tprdratekb 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprdratekb
			(prddate,	AreaCode,		DivisionCode,		WorkCenter,	LineCode,
			ItemCode,	releasecount,		prdcount,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,
			@ls_ItemCode,	@ls_releasecount,	@ls_prdcount,		@ls_LastEmp)

	Else
		update	tprdratekb
		set	releasecount	= @ls_releasecount,
			prdcount	= @ls_prdcount
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisele_svr\ipis].ipis.dbo.tprdratekb
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprdratekb


-- 대구기계

Insert	into	#tmp_tprdratekb
select	*
from	[ipismac_svr\ipis].ipis.dbo.tprdratekb
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
		@ls_releasecount	= releasecount,
		@ls_prdcount		= prdcount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdratekb
	Where	checkid > @ls_id

	If not exists (select * from tprdratekb 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprdratekb
			(prddate,	AreaCode,		DivisionCode,		WorkCenter,	LineCode,
			ItemCode,	releasecount,		prdcount,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,
			@ls_ItemCode,	@ls_releasecount,	@ls_prdcount,		@ls_LastEmp)

	Else
		update	tprdratekb
		set	releasecount	= @ls_releasecount,
			prdcount	= @ls_prdcount
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipismac_svr\ipis].ipis.dbo.tprdratekb
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprdratekb


-- 대구압축

Insert	into	#tmp_tprdratekb
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tprdratekb
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
		@ls_releasecount	= releasecount,
		@ls_prdcount		= prdcount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdratekb
	Where	checkid > @ls_id

	If not exists (select * from tprdratekb 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprdratekb
			(prddate,	AreaCode,		DivisionCode,		WorkCenter,	LineCode,
			ItemCode,	releasecount,		prdcount,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,
			@ls_ItemCode,	@ls_releasecount,	@ls_prdcount,		@ls_LastEmp)

	Else
		update	tprdratekb
		set	releasecount	= @ls_releasecount,
			prdcount	= @ls_prdcount
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipishvac_svr\ipis].ipis.dbo.tprdratekb
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprdratekb


-- 진천

Insert	into	#tmp_tprdratekb
select	*
from	[ipisjin_svr].ipis.dbo.tprdratekb
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
		@ls_releasecount	= releasecount,
		@ls_prdcount		= prdcount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprdratekb
	Where	checkid > @ls_id

	If not exists (select * from tprdratekb 
			where	prddate		= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprdratekb
			(prddate,	AreaCode,		DivisionCode,		WorkCenter,	LineCode,
			ItemCode,	releasecount,		prdcount,		LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,
			@ls_ItemCode,	@ls_releasecount,	@ls_prdcount,		@ls_LastEmp)

	Else
		update	tprdratekb
		set	releasecount	= @ls_releasecount,
			prdcount	= @ls_prdcount
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisjin_svr].ipis.dbo.tprdratekb
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tprdratekb
 
End		-- Procedure End
Go
