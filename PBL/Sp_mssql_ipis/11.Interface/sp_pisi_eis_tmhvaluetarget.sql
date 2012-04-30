/*
	File Name	: sp_pisi_eis_tmhvaluetarget.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhvaluetarget
	Description	: EIS Upload tmhvaluetarget
			  tmhvaluetarget
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhvaluetarget]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhvaluetarget]
GO

/*
Execute sp_pisi_eis_tmhvaluetarget
*/

Create Procedure sp_pisi_eis_tmhvaluetarget

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_WorkCenter			varchar(5),
	@ls_tarMonth			char(7),
	@ld_totInMH			decimal,
	@ld_ActMH			decimal,
	@ld_basicMH			decimal,
	@ld_tarLPI			decimal,
	@ld_divtarLPI			decimal,
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhvaluetarget
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),   
	DivisionCode    			char(1),   
	WorkCenter			varchar(5),
	tarMonth				char(7),   
	totInMH	        			decimal,   
	ActMH	        			decimal,   
	basicMH	        			decimal,   
	tarLPI	        			decimal,   
	divtarLPI				decimal,   
	LastEmp				varchar(6),
	LastDate				datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhvaluetarget
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhvaluetarget
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_tarMonth			= tarMonth,
		@ld_totInMH			= totInMH,
		@ld_ActMH			= ActMH,
		@ld_basicMH			= basicMH,
		@ld_tarLPI			= tarLPI,
		@ld_divtarLPI			= divtarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhvaluetarget
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhvaluetarget
			where	AreaCode   	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter 	= @ls_WorkCenter	
			and	tarMonth  	= @ls_tarMonth	)

		insert into tmhvaluetarget
			(AreaCode,		DivisionCode,		WorkCenter,		tarMonth,
			totInMH,			ActMH,			basicMH,		tarLPI,
			divtarLPI,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_tarMonth,
			@ld_totInMH,		@ld_ActMH,		@ld_basicMH,		@ld_tarLPI,
			@ld_divtarLPI,		@ls_lastemp)
	Else
		update	tmhvaluetarget
		set	totInMH	 		= @ld_totInMH,
			ActMH	 		= @ld_ActMH,
			basicMH	 		= @ld_basicMH,
			tarLPI	 		= @ld_tarLPI,
			divtarLPI			= @ld_divtarLPI
		where	AreaCode   		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter 		= @ls_WorkCenter	
		and	tarMonth  		= @ls_tarMonth

	update	[ipisele_svr\ipis].ipis.dbo.tmhvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode   			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter 			= @ls_WorkCenter	
	and	tarMonth  			= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhvaluetarget


-- 대구기계

Insert	into	#tmp_tmhvaluetarget
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhvaluetarget
where	lastemp 		= 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_tarMonth			= tarMonth,
		@ld_totInMH			= totInMH,
		@ld_ActMH			= ActMH,
		@ld_basicMH			= basicMH,
		@ld_tarLPI			= tarLPI,
		@ld_divtarLPI			= divtarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhvaluetarget
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhvaluetarget
			where	AreaCode   	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter 	= @ls_WorkCenter	
			and	tarMonth  	= @ls_tarMonth	)

		insert into tmhvaluetarget
			(AreaCode,		DivisionCode,		WorkCenter,		tarMonth,
			totInMH,			ActMH,			basicMH,		tarLPI,
			divtarLPI,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_tarMonth,
			@ld_totInMH,		@ld_ActMH,		@ld_basicMH,		@ld_tarLPI,
			@ld_divtarLPI,		@ls_lastemp)
	Else
		update	tmhvaluetarget
		set	totInMH	 		= @ld_totInMH,
			ActMH	 		= @ld_ActMH,
			basicMH	 		= @ld_basicMH,
			tarLPI	 		= @ld_tarLPI,
			divtarLPI			= @ld_divtarLPI
		where	AreaCode   		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter 		= @ls_WorkCenter	
		and	tarMonth  		= @ls_tarMonth
		
	update	[ipismac_svr\ipis].ipis.dbo.tmhvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode   			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter 			= @ls_WorkCenter	
	and	tarMonth  			= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhvaluetarget


-- 대구압축

Insert	into	#tmp_tmhvaluetarget
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhvaluetarget
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_tarMonth			= tarMonth,
		@ld_totInMH			= totInMH,
		@ld_ActMH			= ActMH,
		@ld_basicMH			= basicMH,
		@ld_tarLPI			= tarLPI,
		@ld_divtarLPI			= divtarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhvaluetarget
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhvaluetarget
			where	AreaCode   	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter 	= @ls_WorkCenter	
			and	tarMonth  	= @ls_tarMonth	)

		insert into tmhvaluetarget
			(AreaCode,		DivisionCode,		WorkCenter,		tarMonth,
			totInMH,			ActMH,			basicMH,		tarLPI,
			divtarLPI,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_tarMonth,
			@ld_totInMH,		@ld_ActMH,		@ld_basicMH,		@ld_tarLPI,
			@ld_divtarLPI,		@ls_lastemp)
	Else
		update	tmhvaluetarget
		set	totInMH	 		= @ld_totInMH,
			ActMH	 		= @ld_ActMH,
			basicMH	 		= @ld_basicMH,
			tarLPI	 		= @ld_tarLPI,
			divtarLPI			= @ld_divtarLPI
		where	AreaCode   		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter 		= @ls_WorkCenter	
		and	tarMonth  		= @ls_tarMonth

	update	[ipishvac_svr\ipis].ipis.dbo.tmhvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode   			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter 			= @ls_WorkCenter	
	and	tarMonth  			= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhvaluetarget


-- 진천

Insert	into	#tmp_tmhvaluetarget
select	*
from	[ipisjin_svr].ipis.dbo.tmhvaluetarget
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_tarMonth			= tarMonth,
		@ld_totInMH			= totInMH,
		@ld_ActMH			= ActMH,
		@ld_basicMH			= basicMH,
		@ld_tarLPI			= tarLPI,
		@ld_divtarLPI			= divtarLPI,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhvaluetarget
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhvaluetarget
			where	AreaCode   	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter 	= @ls_WorkCenter	
			and	tarMonth  	= @ls_tarMonth	)

		insert into tmhvaluetarget
			(AreaCode,		DivisionCode,		WorkCenter,		tarMonth,
			totInMH,			ActMH,			basicMH,		tarLPI,
			divtarLPI,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_tarMonth,
			@ld_totInMH,		@ld_ActMH,		@ld_basicMH,		@ld_tarLPI,
			@ld_divtarLPI,		@ls_lastemp)
	Else
		update	tmhvaluetarget
		set	totInMH	 		= @ld_totInMH,
			ActMH	 		= @ld_ActMH,
			basicMH	 		= @ld_basicMH,
			tarLPI	 		= @ld_tarLPI,
			divtarLPI			= @ld_divtarLPI
		where	AreaCode   		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter 		= @ls_WorkCenter	
		and	tarMonth  		= @ls_tarMonth
		
	update	[ipisjin_svr].ipis.dbo.tmhvaluetarget
	set	lastemp 				= 'N'
	where	AreaCode   			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter 			= @ls_WorkCenter	
	and	tarMonth  			= @ls_tarMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhvaluetarget
 
End		-- Procedure End
Go
