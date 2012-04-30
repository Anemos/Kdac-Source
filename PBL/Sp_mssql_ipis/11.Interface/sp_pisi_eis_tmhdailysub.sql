/*
	File Name	: sp_pisi_eis_tmhdailysub.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhdailysub
	Description	: EIS Upload tmhdailysub
			  tmhdailysub
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 12. 25
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhdailysub]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhdailysub]
GO

/*
Execute sp_pisi_eis_tmhdailysub
*/

Create Procedure sp_pisi_eis_tmhdailysub

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_WorkCenter			varchar(5),
	@ls_WorkDay			char(10),
	@ls_mhGubun			char(1),
	@ls_mhCode			varchar(2),
	@li_seqNo			decimal,
	@ls_detailWork			varchar(100),
	@ldt_FromTime			smalldatetime,
	@ldt_ToTime			smalldatetime,
	@li_subMH			decimal,
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhdailysub
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),
	DivisionCode			char(1),
	WorkCenter			varchar(5),
	WorkDay				char(10),
	mhGubun			char(1),
	mhCode				varchar(2),
	seqNo				decimal,
	detailWork			varchar(100),
	FromTime			smalldatetime,
	ToTime				smalldatetime,
	subMH				decimal,
	LastEmp				varchar(6),
	LastDate				datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhdailysub
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhdailysub
where	WorkDay		<= @ls_yesterday
and	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_mhGubun			= mhGubun,
		@ls_mhCode			= mhCode,
		@li_seqNo			= seqNo,
		@ls_detailWork			= detailWork,
		@ldt_FromTime			= FromTime,
		@ldt_ToTime			= ToTime,
		@li_subMH			= subMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdailysub
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhdailysub
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	WorkDay		= @ls_WorkDay	
			and	mhGubun	= @ls_mhGubun	
			and	mhCode		= @ls_mhCode	
			and	seqNo		= @li_seqNo	)

		insert into tmhdailysub
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		mhGubun,
			mhCode,		seqNo,			detailWork,		FromTime,		ToTime,
			subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_mhGubun,
			@ls_mhCode,		@li_seqNo,		@ls_detailWork,		@ldt_FromTime,		@ldt_ToTime,
			@li_subMH,		@ls_lastemp)
	Else
		update	tmhdailysub
		set	detailWork		= @ls_detailWork,
			FromTime		= @ldt_FromTime,
			ToTime			= @ldt_ToTime,
			subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	WorkDay			= @ls_WorkDay	
		and	mhGubun		= @ls_mhGubun	
		and	mhCode			= @ls_mhCode	
		and	seqNo			= @li_seqNo	

	update	[ipisele_svr\ipis].ipis.dbo.tmhdailysub
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	WorkDay				= @ls_WorkDay	
	and	mhGubun			= @ls_mhGubun	
	and	mhCode				= @ls_mhCode	
	and	seqNo				= @li_seqNo	
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailysub


-- 대구기계

Insert	into	#tmp_tmhdailysub
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhdailysub
where	WorkDay		<= @ls_yesterday
and	lastemp 		= 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_mhGubun			= mhGubun,
		@ls_mhCode			= mhCode,
		@li_seqNo			= seqNo,
		@ls_detailWork			= detailWork,
		@ldt_FromTime			= FromTime,
		@ldt_ToTime			= ToTime,
		@li_subMH			= subMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdailysub
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhdailysub
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	WorkDay		= @ls_WorkDay	
			and	mhGubun	= @ls_mhGubun	
			and	mhCode		= @ls_mhCode	
			and	seqNo		= @li_seqNo	)

		insert into tmhdailysub
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		mhGubun,
			mhCode,		seqNo,			detailWork,		FromTime,		ToTime,
			subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_mhGubun,
			@ls_mhCode,		@li_seqNo,		@ls_detailWork,		@ldt_FromTime,		@ldt_ToTime,
			@li_subMH,		@ls_lastemp)
	Else
		update	tmhdailysub
		set	detailWork		= @ls_detailWork,
			FromTime		= @ldt_FromTime,
			ToTime			= @ldt_ToTime,
			subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	WorkDay			= @ls_WorkDay	
		and	mhGubun		= @ls_mhGubun	
		and	mhCode			= @ls_mhCode	
		and	seqNo			= @li_seqNo	
		
	update	[ipismac_svr\ipis].ipis.dbo.tmhdailysub
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	WorkDay				= @ls_WorkDay	
	and	mhGubun			= @ls_mhGubun	
	and	mhCode				= @ls_mhCode	
	and	seqNo				= @li_seqNo	
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailysub


-- 대구압축

Insert	into	#tmp_tmhdailysub
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhdailysub
where	WorkDay		<= @ls_yesterday
and	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_mhGubun			= mhGubun,
		@ls_mhCode			= mhCode,
		@li_seqNo			= seqNo,
		@ls_detailWork			= detailWork,
		@ldt_FromTime			= FromTime,
		@ldt_ToTime			= ToTime,
		@li_subMH			= subMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdailysub
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhdailysub
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	WorkDay		= @ls_WorkDay	
			and	mhGubun	= @ls_mhGubun	
			and	mhCode		= @ls_mhCode	
			and	seqNo		= @li_seqNo	)

		insert into tmhdailysub
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		mhGubun,
			mhCode,		seqNo,			detailWork,		FromTime,		ToTime,
			subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_mhGubun,
			@ls_mhCode,		@li_seqNo,		@ls_detailWork,		@ldt_FromTime,		@ldt_ToTime,
			@li_subMH,		@ls_lastemp)
	Else
		update	tmhdailysub
		set	detailWork	= @ls_detailWork,
			FromTime		= @ldt_FromTime,
			ToTime			= @ldt_ToTime,
			subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	WorkDay			= @ls_WorkDay	
		and	mhGubun		= @ls_mhGubun	
		and	mhCode			= @ls_mhCode	
		and	seqNo			= @li_seqNo	

	update	[ipishvac_svr\ipis].ipis.dbo.tmhdailysub
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	WorkDay				= @ls_WorkDay	
	and	mhGubun			= @ls_mhGubun	
	and	mhCode				= @ls_mhCode	
	and	seqNo				= @li_seqNo	
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailysub


-- 진천

Insert	into	#tmp_tmhdailysub
select	*
from	[ipisjin_svr].ipis.dbo.tmhdailysub
where	WorkDay		<= @ls_yesterday
and	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_mhGubun			= mhGubun,
		@ls_mhCode			= mhCode,
		@li_seqNo			= seqNo,
		@ls_detailWork			= detailWork,
		@ldt_FromTime			= FromTime,
		@ldt_ToTime			= ToTime,
		@li_subMH			= subMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdailysub
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhdailysub
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	WorkDay		= @ls_WorkDay	
			and	mhGubun	= @ls_mhGubun	
			and	mhCode		= @ls_mhCode	
			and	seqNo		= @li_seqNo	)

		insert into tmhdailysub
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		mhGubun,
			mhCode,		seqNo,			detailWork,		FromTime,		ToTime,
			subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_mhGubun,
			@ls_mhCode,		@li_seqNo,		@ls_detailWork,		@ldt_FromTime,		@ldt_ToTime,
			@li_subMH,		@ls_lastemp)
	Else
		update	tmhdailysub
		set	detailWork		= @ls_detailWork,
			FromTime		= @ldt_FromTime,
			ToTime			= @ldt_ToTime,
			subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	WorkDay			= @ls_WorkDay	
		and	mhGubun		= @ls_mhGubun	
		and	mhCode			= @ls_mhCode	
		and	seqNo			= @li_seqNo	
		
	update	[ipisjin_svr].ipis.dbo.tmhdailysub
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	WorkDay				= @ls_WorkDay	
	and	mhGubun			= @ls_mhGubun	
	and	mhCode				= @ls_mhCode	
	and	seqNo				= @li_seqNo	
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhdailysub
 
End		-- Procedure End
Go
