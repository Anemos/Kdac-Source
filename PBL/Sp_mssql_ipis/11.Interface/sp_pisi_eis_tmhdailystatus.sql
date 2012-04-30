/*
	File Name	: sp_pisi_eis_tmhdailystatus.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhdailystatus
	Description	: EIS Upload tmhdailystatus
			  tmhdailystatus
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhdailystatus]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhdailystatus]
GO

/*
Execute sp_pisi_eis_tmhdailystatus
*/

Create Procedure sp_pisi_eis_tmhdailystatus
	
As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@ls_id				int,
	@ls_AreaCode			char (1),
	@ls_DivisionCode		char (1),
	@ls_WorkCenter			varchar (5),
	@ls_WorkDay			char (10),
	@ls_DailyStatus			char(1),
	@ls_InputTime			datetime,
	@ls_InputEmp			varchar(6),
	@ls_Remark			varchar(100),
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tmhdailystatus
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	WorkCenter		varchar (5),
	WorkDay			char (10),
	DailyStatus		char (1),
	InputTime		datetime,
	InputEmp		varchar(6),
	Remark			varchar(100),
	LastEmp			varchar(6),
	LastDate		datetime	)

-- 각 서버 tdelete에서 tablename이 tmhdailystatus인 놈 정리하고...

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tmhdailystatus
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhdailystatus
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
		@ls_DailyStatus		= DailyStatus,
		@ls_InputTime		= InputTime,
		@ls_InputEmp		= InputEmp,
		@ls_Remark		= Remark,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhdailystatus
	Where	checkid > @ls_id

	If not exists (select * from tmhdailystatus 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday)

		insert into tmhdailystatus
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			DailyStatus,		InputTime,		InputEmp,		Remark,
			lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_DailyStatus,	@ls_InputTime,		@ls_InputEmp,		@ls_Remark,
			@ls_LastEmp)

	Else
		update	tmhdailystatus
		set	DailyStatus	= @ls_DailyStatus,
			InputTime	= @ls_InputTime,
			InputEmp	= @ls_InputEmp,
			Remark		= @ls_Remark
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday

		                        
	update	[ipisele_svr\ipis].ipis.dbo.tmhdailystatus
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailystatus


-- 대구기계

Insert	into	#tmp_tmhdailystatus
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhdailystatus
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
		@ls_DailyStatus		= DailyStatus,
		@ls_InputTime		= InputTime,
		@ls_InputEmp		= InputEmp,
		@ls_Remark		= Remark,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhdailystatus
	Where	checkid > @ls_id

	If not exists (select * from tmhdailystatus 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday)

		insert into tmhdailystatus
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			DailyStatus,		InputTime,		InputEmp,		Remark,
			lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_DailyStatus,	@ls_InputTime,		@ls_InputEmp,		@ls_Remark,
			@ls_LastEmp)

	Else
		update	tmhdailystatus
		set	DailyStatus	= @ls_DailyStatus,
			InputTime	= @ls_InputTime,
			InputEmp	= @ls_InputEmp,
			Remark		= @ls_Remark
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday

		                        
	update	[ipismac_svr\ipis].ipis.dbo.tmhdailystatus
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailystatus


-- 대구압축

Insert	into	#tmp_tmhdailystatus
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhdailystatus
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
		@ls_DailyStatus		= DailyStatus,
		@ls_InputTime		= InputTime,
		@ls_InputEmp		= InputEmp,
		@ls_Remark		= Remark,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhdailystatus
	Where	checkid > @ls_id

	If not exists (select * from tmhdailystatus 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday)

		insert into tmhdailystatus
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			DailyStatus,		InputTime,		InputEmp,		Remark,
			lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_DailyStatus,	@ls_InputTime,		@ls_InputEmp,		@ls_Remark,
			@ls_LastEmp)

	Else
		update	tmhdailystatus
		set	DailyStatus	= @ls_DailyStatus,
			InputTime	= @ls_InputTime,
			InputEmp	= @ls_InputEmp,
			Remark		= @ls_Remark
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday

		                        
	update	[ipishvac_svr\ipis].ipis.dbo.tmhdailystatus
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailystatus


-- 진천

Insert	into	#tmp_tmhdailystatus
select	*
from	[ipisjin_svr].ipis.dbo.tmhdailystatus
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
		@ls_DailyStatus		= DailyStatus,
		@ls_InputTime		= InputTime,
		@ls_InputEmp		= InputEmp,
		@ls_Remark		= Remark,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhdailystatus
	Where	checkid > @ls_id

	If not exists (select * from tmhdailystatus 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	WorkDay		= @ls_workday)

		insert into tmhdailystatus
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,
			DailyStatus,		InputTime,		InputEmp,		Remark,
			lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,
			@ls_DailyStatus,	@ls_InputTime,		@ls_InputEmp,		@ls_Remark,
			@ls_LastEmp)

	Else
		update	tmhdailystatus
		set	DailyStatus	= @ls_DailyStatus,
			InputTime	= @ls_InputTime,
			InputEmp	= @ls_InputEmp,
			Remark		= @ls_Remark
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	WorkDay		= @ls_workday

		                        
	update	[ipisjin_svr].ipis.dbo.tmhdailystatus
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	WorkDay		= @ls_workday
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmhdailystatus
 
End		-- Procedure End
Go
