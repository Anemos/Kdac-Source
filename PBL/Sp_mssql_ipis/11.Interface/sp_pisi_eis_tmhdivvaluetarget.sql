/*
	File Name	: sp_pisi_eis_tmhdivvaluetarget.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhdivvaluetarget
	Description	: EIS Upload tmhdivvaluetarget
			  tmhdivvaluetarget
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhdivvaluetarget]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhdivvaluetarget]
GO

/*
Execute sp_pisi_eis_tmhdivvaluetarget
*/

Create Procedure sp_pisi_eis_tmhdivvaluetarget

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_tarMonth			char(7),
	@li_tarLPI_bunmo			numeric,
	@li_tarLPI_bunja			numeric,
	@li_tarLPI			numeric,
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhdivvaluetarget
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),
	DivisionCode    			char(1),
	tarMonth				char(7),
	tarLPI_bunmo    			numeric,
	tarLPI_bunja    			numeric,
	tarLPI	        			numeric,
	LastEmp				varchar(6),
	LastDate				datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhdivvaluetarget
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhdivvaluetarget
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_tarMonth			= tarMonth,
		@li_tarLPI_bunmo			= tarLPI_bunmo,
		@li_tarLPI_bunja			= tarLPI_bunja,
		@li_tarLPI			= tarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdivvaluetarget
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhdivvaluetarget
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	tarMonth		= @ls_tarMonth	)

		insert into tmhdivvaluetarget
			(AreaCode,		DivisionCode,		tarMonth,		tarLPI_bunmo,
			tarLPI_bunja,		tarLPI,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_tarMonth,		@li_tarLPI_bunmo,
			@li_tarLPI_bunja,		@li_tarLPI,		@ls_lastemp)
	Else
		update	tmhdivvaluetarget
		set	tarLPI_bunmo		= @li_tarLPI_bunmo,
			tarLPI_bunja		= @li_tarLPI_bunja,
			tarLPI			= @li_tarLPI
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	tarMonth			= @ls_tarMonth

	update	[ipisele_svr\ipis].ipis.dbo.tmhdivvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode
	and	DivisionCode			= @ls_DivisionCode
	and	tarMonth				= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdivvaluetarget


-- 대구기계

Insert	into	#tmp_tmhdivvaluetarget
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhdivvaluetarget
where	lastemp 		= 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_tarMonth			= tarMonth,
		@li_tarLPI_bunmo			= tarLPI_bunmo,
		@li_tarLPI_bunja			= tarLPI_bunja,
		@li_tarLPI			= tarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdivvaluetarget
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhdivvaluetarget
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	tarMonth		= @ls_tarMonth	)

		insert into tmhdivvaluetarget
			(AreaCode,		DivisionCode,		tarMonth,		tarLPI_bunmo,
			tarLPI_bunja,		tarLPI,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_tarMonth,		@li_tarLPI_bunmo,
			@li_tarLPI_bunja,		@li_tarLPI,		@ls_lastemp)
	Else
		update	tmhdivvaluetarget
		set	tarLPI_bunmo		= @li_tarLPI_bunmo,
			tarLPI_bunja		= @li_tarLPI_bunja,
			tarLPI			= @li_tarLPI
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	tarMonth			= @ls_tarMonth
		
	update	[ipismac_svr\ipis].ipis.dbo.tmhdivvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode
	and	DivisionCode			= @ls_DivisionCode
	and	tarMonth				= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdivvaluetarget


-- 대구압축

Insert	into	#tmp_tmhdivvaluetarget
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhdivvaluetarget
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_tarMonth			= tarMonth,
		@li_tarLPI_bunmo			= tarLPI_bunmo,
		@li_tarLPI_bunja			= tarLPI_bunja,
		@li_tarLPI			= tarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdivvaluetarget
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhdivvaluetarget
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	tarMonth		= @ls_tarMonth	)

		insert into tmhdivvaluetarget
			(AreaCode,		DivisionCode,		tarMonth,		tarLPI_bunmo,
			tarLPI_bunja,		tarLPI,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_tarMonth,		@li_tarLPI_bunmo,
			@li_tarLPI_bunja,		@li_tarLPI,		@ls_lastemp)
	Else
		update	tmhdivvaluetarget
		set	tarLPI_bunmo		= @li_tarLPI_bunmo,
			tarLPI_bunja		= @li_tarLPI_bunja,
			tarLPI			= @li_tarLPI
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	tarMonth			= @ls_tarMonth

	update	[ipishvac_svr\ipis].ipis.dbo.tmhdivvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode
	and	DivisionCode			= @ls_DivisionCode
	and	tarMonth				= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdivvaluetarget


-- 진천

Insert	into	#tmp_tmhdivvaluetarget
select	*
from	[ipisjin_svr].ipis.dbo.tmhdivvaluetarget
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_tarMonth			= tarMonth,
		@li_tarLPI_bunmo			= tarLPI_bunmo,
		@li_tarLPI_bunja			= tarLPI_bunja,
		@li_tarLPI			= tarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhdivvaluetarget
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhdivvaluetarget
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	tarMonth		= @ls_tarMonth	)

		insert into tmhdivvaluetarget
			(AreaCode,		DivisionCode,		tarMonth,		tarLPI_bunmo,
			tarLPI_bunja,		tarLPI,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_tarMonth,		@li_tarLPI_bunmo,
			@li_tarLPI_bunja,		@li_tarLPI,		@ls_lastemp)
	Else
		update	tmhdivvaluetarget
		set	tarLPI_bunmo		= @li_tarLPI_bunmo,
			tarLPI_bunja		= @li_tarLPI_bunja,
			tarLPI			= @li_tarLPI
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	tarMonth			= @ls_tarMonth

		
	update	[ipisjin_svr].ipis.dbo.tmhdivvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode
	and	DivisionCode			= @ls_DivisionCode
	and	tarMonth				= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhdivvaluetarget
 
End		-- Procedure End
Go
