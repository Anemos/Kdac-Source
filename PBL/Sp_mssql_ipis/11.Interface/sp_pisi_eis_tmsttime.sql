/*
	File Name	: sp_pisi_eis_tmsttime.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmsttime
	Description	: EIS Upload tmsttime
			  tmsttime
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmsttime]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmsttime]
GO

/*
Execute sp_pisi_eis_tmsttime
*/

Create Procedure sp_pisi_eis_tmsttime

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_applyfrom		char(10),
	@ls_timecode		char(5),
	@ls_applyto		char(10),
	@ls_timeorder		int,
	@ls_timestart		datetime,
	@ls_timeend		datetime,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmsttime
(	checkId		int IDENTITY(1,1),
	AreaCode	char (1),
	DivisionCode	char (1),
	applyfrom	char (10),
	timecode	char (5),
	applyto		char (10),
	timeorder	int,
	timestart	datetime,
	timeend		datetime,
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmsttime
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmsttime
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_applyto		= applyto,
		@ls_timeorder		= timeorder,
		@ls_timestart		= timestart,
		@ls_timeend		= timeend,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmsttime
	Where	checkid > @ls_id

	If not exists (select * from tmsttime 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tmsttime
			(AreaCode,	DivisionCode,		ApplyFrom,	TimeCode,	ApplyTo,
			TimeOrder,	TimeStart,		TimeEnd,	LastEmp)
		values	(@ls_AreaCode,	@ls_DivisionCode,	@ls_applyfrom,	@ls_timecode,	@ls_applyto,
			@ls_timeorder,	@ls_timestart,		@ls_timeend,	@ls_LastEmp)

	Else
		update	tmsttime
		set	timeorder	= @ls_timeorder,
			timestart	= @ls_timestart,
			timeend		= @ls_timeend
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipisele_svr\ipis].ipis.dbo.tmsttime
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmsttime


-- 대구기계

Insert	into	#tmp_tmsttime
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmsttime
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_applyto		= applyto,
		@ls_timeorder		= timeorder,
		@ls_timestart		= timestart,
		@ls_timeend		= timeend,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmsttime
	Where	checkid > @ls_id

	If not exists (select * from tmsttime 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tmsttime
			(AreaCode,	DivisionCode,		ApplyFrom,	TimeCode,	ApplyTo,
			TimeOrder,	TimeStart,		TimeEnd,	LastEmp)
		values	(@ls_AreaCode,	@ls_DivisionCode,	@ls_applyfrom,	@ls_timecode,	@ls_applyto,
			@ls_timeorder,	@ls_timestart,		@ls_timeend,	@ls_LastEmp)

	Else
		update	tmsttime
		set	timeorder	= @ls_timeorder,
			timestart	= @ls_timestart,
			timeend		= @ls_timeend
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipismac_svr\ipis].ipis.dbo.tmsttime
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmsttime


-- 대구압축

Insert	into	#tmp_tmsttime
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmsttime
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_applyto		= applyto,
		@ls_timeorder		= timeorder,
		@ls_timestart		= timestart,
		@ls_timeend		= timeend,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmsttime
	Where	checkid > @ls_id

	If not exists (select * from tmsttime 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tmsttime
			(AreaCode,	DivisionCode,		ApplyFrom,	TimeCode,	ApplyTo,
			TimeOrder,	TimeStart,		TimeEnd,	LastEmp)
		values	(@ls_AreaCode,	@ls_DivisionCode,	@ls_applyfrom,	@ls_timecode,	@ls_applyto,
			@ls_timeorder,	@ls_timestart,		@ls_timeend,	@ls_LastEmp)

	Else
		update	tmsttime
		set	timeorder	= @ls_timeorder,
			timestart	= @ls_timestart,
			timeend		= @ls_timeend
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipishvac_svr\ipis].ipis.dbo.tmsttime
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmsttime


-- 진천

Insert	into	#tmp_tmsttime
select	*
from	[ipisjin_svr].ipis.dbo.tmsttime
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_applyfrom		= applyfrom,
		@ls_timecode		= timecode,
		@ls_applyto		= applyto,
		@ls_timeorder		= timeorder,
		@ls_timestart		= timestart,
		@ls_timeend		= timeend,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmsttime
	Where	checkid > @ls_id

	If not exists (select * from tmsttime 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	applyfrom	= @ls_applyfrom
			and	timecode	= @ls_timecode)

		insert into tmsttime
			(AreaCode,	DivisionCode,		ApplyFrom,	TimeCode,	ApplyTo,
			TimeOrder,	TimeStart,		TimeEnd,	LastEmp)
		values	(@ls_AreaCode,	@ls_DivisionCode,	@ls_applyfrom,	@ls_timecode,	@ls_applyto,
			@ls_timeorder,	@ls_timestart,		@ls_timeend,	@ls_LastEmp)

	Else
		update	tmsttime
		set	timeorder	= @ls_timeorder,
			timestart	= @ls_timestart,
			timeend		= @ls_timeend
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	applyfrom	= @ls_applyfrom
		and	timecode	= @ls_timecode

	update	[ipisjin_svr].ipis.dbo.tmsttime
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	applyfrom	= @ls_applyfrom
	and	timecode	= @ls_timecode
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmsttime
 
End		-- Procedure End
Go
