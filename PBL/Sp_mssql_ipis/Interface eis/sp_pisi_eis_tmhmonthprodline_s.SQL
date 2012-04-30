/*
	File Name	: sp_pisi_eis_tmhmonthprodline_s.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhmonthprodline_s
	Description	: EIS Upload tmhmonthprodline_s
			  tmhmonthprodline_s
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2003. 01. 16
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhmonthprodline_s]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhmonthprodline_s]
GO

/*
Execute sp_pisi_eis_tmhmonthprodline_s
*/

Create Procedure sp_pisi_eis_tmhmonthprodline_s

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_WorkCenter			varchar(5),
	@ls_ItemCode			varchar(12),
	@ls_subLineCode		varchar(7),
	@ls_subLineNo			char(1),
	@ls_sMonth			char(7),
	@li_pQty				int,
	@li_UnuseMH			numeric,
	@li_ActMH			numeric,
	@li_ActInMH			numeric,
	@li_BasicMH			numeric,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhmonthprodline_s
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),
	DivisionCode			char(1),
	WorkCenter			varchar(5),
	ItemCode			varchar(12),
	subLineCode			varchar(7),
	subLineNo			char(1),
	sMonth				char(7),
	pQty				int,
	UnuseMH			numeric,
	ActMH				numeric,
	ActInMH				numeric,
	BasicMH			numeric,
	LastEmp				varchar(6),
	LastDate				datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhmonthprodline_s
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhmonthprodline_s
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@li_UnuseMH			= UnuseMH,
		@li_ActMH			= ActMH,
		@li_ActInMH			= ActInMH,
		@li_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprodline_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprodline_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode	
			and	WorkCenter	= @ls_WorkCenter
			and	ItemCode	= @ls_ItemCode	
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonthprodline_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		sMonth,			pQty,
			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_sMonth,		@li_pQty,
			@li_UnuseMH,		@li_ActMH,		@li_ActInMH,		@li_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprodline_s
		set	pQty			= @li_pQty,
			UnuseMH		= @li_UnuseMH,
			ActMH			= @li_ActMH,
			ActInMH			= @li_ActInMH,
			BasicMH		= @li_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode	
		and	WorkCenter		= @ls_WorkCenter
		and	ItemCode		= @ls_ItemCode	
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo
		and	sMonth			= @ls_sMonth

	update	[ipisele_svr\ipis].ipis.dbo.tmhmonthprodline_s
	set	lastemp 			= 'N'
	where	AreaCode		= @ls_AreaCode
	and	DivisionCode		= @ls_DivisionCode	
	and	WorkCenter		= @ls_WorkCenter
	and	ItemCode		= @ls_ItemCode	
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	sMonth			= @ls_sMonth
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthprodline_s


-- 대구기계

Insert	into	#tmp_tmhmonthprodline_s
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhmonthprodline_s
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@li_UnuseMH			= UnuseMH,
		@li_ActMH			= ActMH,
		@li_ActInMH			= ActInMH,
		@li_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprodline_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprodline_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode	
			and	WorkCenter	= @ls_WorkCenter
			and	ItemCode	= @ls_ItemCode	
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonthprodline_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		sMonth,			pQty,
			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_sMonth,		@li_pQty,
			@li_UnuseMH,		@li_ActMH,		@li_ActInMH,		@li_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprodline_s
		set	pQty			= @li_pQty,
			UnuseMH		= @li_UnuseMH,
			ActMH			= @li_ActMH,
			ActInMH			= @li_ActInMH,
			BasicMH		= @li_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode	
		and	WorkCenter		= @ls_WorkCenter
		and	ItemCode		= @ls_ItemCode	
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo
		and	sMonth			= @ls_sMonth

	update	[ipismac_svr\ipis].ipis.dbo.tmhmonthprodline_s
	set	lastemp 			= 'N'
	where	AreaCode		= @ls_AreaCode
	and	DivisionCode		= @ls_DivisionCode	
	and	WorkCenter		= @ls_WorkCenter
	and	ItemCode		= @ls_ItemCode	
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	sMonth			= @ls_sMonth
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthprodline_s


-- 대구압축

Insert	into	#tmp_tmhmonthprodline_s
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhmonthprodline_s
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@li_UnuseMH			= UnuseMH,
		@li_ActMH			= ActMH,
		@li_ActInMH			= ActInMH,
		@li_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprodline_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprodline_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode	
			and	WorkCenter	= @ls_WorkCenter
			and	ItemCode	= @ls_ItemCode	
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonthprodline_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		sMonth,			pQty,
			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_sMonth,		@li_pQty,
			@li_UnuseMH,		@li_ActMH,		@li_ActInMH,		@li_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprodline_s
		set	pQty			= @li_pQty,
			UnuseMH		= @li_UnuseMH,
			ActMH			= @li_ActMH,
			ActInMH			= @li_ActInMH,
			BasicMH		= @li_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode	
		and	WorkCenter		= @ls_WorkCenter
		and	ItemCode		= @ls_ItemCode	
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo
		and	sMonth			= @ls_sMonth

	update	[ipishvac_svr\ipis].ipis.dbo.tmhmonthprodline_s
	set	lastemp 			= 'N'
	where	AreaCode		= @ls_AreaCode
	and	DivisionCode		= @ls_DivisionCode	
	and	WorkCenter		= @ls_WorkCenter
	and	ItemCode		= @ls_ItemCode	
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	sMonth			= @ls_sMonth
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthprodline_s


-- 진천

Insert	into	#tmp_tmhmonthprodline_s
select	*
from	[ipisjin_svr].ipis.dbo.tmhmonthprodline_s
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@li_UnuseMH			= UnuseMH,
		@li_ActMH			= ActMH,
		@li_ActInMH			= ActInMH,
		@li_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprodline_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprodline_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode	
			and	WorkCenter	= @ls_WorkCenter
			and	ItemCode	= @ls_ItemCode	
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonthprodline_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		sMonth,			pQty,
			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_sMonth,		@li_pQty,
			@li_UnuseMH,		@li_ActMH,		@li_ActInMH,		@li_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprodline_s
		set	pQty			= @li_pQty,
			UnuseMH		= @li_UnuseMH,
			ActMH			= @li_ActMH,
			ActInMH			= @li_ActInMH,
			BasicMH		= @li_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode	
		and	WorkCenter		= @ls_WorkCenter
		and	ItemCode		= @ls_ItemCode	
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo
		and	sMonth			= @ls_sMonth

	update	[ipisjin_svr].ipis.dbo.tmhmonthprodline_s
	set	lastemp 			= 'N'
	where	AreaCode		= @ls_AreaCode
	and	DivisionCode		= @ls_DivisionCode	
	and	WorkCenter		= @ls_WorkCenter
	and	ItemCode		= @ls_ItemCode	
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	sMonth			= @ls_sMonth
	and	LastEmp 		= 'Y'

End	-- while loop end

drop table #tmp_tmhmonthprodline_s
 
End		-- Procedure End
Go
