/*
	File Name	: sp_pisi_eis_tmhstandard.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhstandard
	Description	: EIS Upload tmhstandard
			  tmhstandard
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhstandard]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhstandard]
GO

/*
Execute sp_pisi_eis_tmhstandard
*/

Create Procedure sp_pisi_eis_tmhstandard

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_stYear			char(4),
	@ls_WorkCenter			varchar(5),
	@ls_ItemCode			varchar(12),
	@ls_subLineCode		varchar(7),
	@ls_subLineNo			char(1),
	@ld_stMH			decimal,
	@ls_modifyFlag			char(1),
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhstandard
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),    
	DivisionCode			char(1),    
	stYear				char(4),    
	WorkCenter			varchar(5), 
	ItemCode			varchar(12),
	subLineCode			varchar(7),
	subLineNo			char(1),
	stMH				decimal,    
	modifyFlag			char(1),    
	LastEmp				varchar(6),
	LastDate				datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhstandard
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhstandard
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_stYear			= stYear,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ld_stMH			= stMH,
		@ls_modifyFlag			= modifyFlag,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhstandard
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhstandard
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	stYear	        	= @ls_stYear	
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo		)

		insert into tmhstandard
			(AreaCode,		DivisionCode,		stYear,			WorkCenter,
			ItemCode,		subLineCode,		subLineNo,		stMH,
			modifyFlag,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_stYear,		@ls_WorkCenter,
			@ls_ItemCode,		@ls_subLineCode,	@ls_subLineNo,		@ld_stMH,
			@ls_modifyFlag,		@ls_lastemp)
	Else
		update	tmhstandard
		set	stMH			= @ld_stMH,
			modifyFlag		= @ls_modifyFlag
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	stYear	      		= @ls_stYear	
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo

	update	[ipisele_svr\ipis].ipis.dbo.tmhstandard
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	stYear	        			= @ls_stYear	
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode
	and	subLineCode			= @ls_subLineCode
	and	subLineNo			= @ls_subLineNo
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhstandard


-- 대구기계

Insert	into	#tmp_tmhstandard
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhstandard
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_stYear			= stYear,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ld_stMH			= stMH,
		@ls_modifyFlag			= modifyFlag,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhstandard
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhstandard
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	stYear	        	= @ls_stYear	
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo		)

		insert into tmhstandard
			(AreaCode,		DivisionCode,		stYear,			WorkCenter,
			ItemCode,		subLineCode,		subLineNo,		stMH,
			modifyFlag,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_stYear,		@ls_WorkCenter,
			@ls_ItemCode,		@ls_subLineCode,	@ls_subLineNo,		@ld_stMH,
			@ls_modifyFlag,		@ls_lastemp)
	Else
		update	tmhstandard
		set	stMH			= @ld_stMH,
			modifyFlag		= @ls_modifyFlag
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	stYear	      		= @ls_stYear	
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo

	update	[ipismac_svr\ipis].ipis.dbo.tmhstandard
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	stYear	        			= @ls_stYear	
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode
	and	subLineCode			= @ls_subLineCode
	and	subLineNo			= @ls_subLineNo
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhstandard


-- 대구압축

Insert	into	#tmp_tmhstandard
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhstandard
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_stYear			= stYear,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ld_stMH			= stMH,
		@ls_modifyFlag			= modifyFlag,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhstandard
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhstandard
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	stYear	        	= @ls_stYear	
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo		)

		insert into tmhstandard
			(AreaCode,		DivisionCode,		stYear,			WorkCenter,
			ItemCode,		subLineCode,		subLineNo,		stMH,
			modifyFlag,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_stYear,		@ls_WorkCenter,
			@ls_ItemCode,		@ls_subLineCode,	@ls_subLineNo,		@ld_stMH,
			@ls_modifyFlag,		@ls_lastemp)
	Else
		update	tmhstandard
		set	stMH			= @ld_stMH,
			modifyFlag		= @ls_modifyFlag
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	stYear	      		= @ls_stYear	
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo

	update	[ipishvac_svr\ipis].ipis.dbo.tmhstandard
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	stYear	        			= @ls_stYear	
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode
	and	subLineCode			= @ls_subLineCode
	and	subLineNo			= @ls_subLineNo
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhstandard


-- 진천

Insert	into	#tmp_tmhstandard
select	*
from	[ipisjin_svr].ipis.dbo.tmhstandard
where	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_stYear			= stYear,
		@ls_WorkCenter			= WorkCenter,
		@ls_ItemCode			= ItemCode,
		@ls_subLineCode		= subLineCode,
		@ls_subLineNo			= subLineNo,
		@ld_stMH			= stMH,
		@ls_modifyFlag			= modifyFlag,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhstandard
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhstandard
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	stYear	        	= @ls_stYear	
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo		)

		insert into tmhstandard
			(AreaCode,		DivisionCode,		stYear,			WorkCenter,
			ItemCode,		subLineCode,		subLineNo,		stMH,
			modifyFlag,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_stYear,		@ls_WorkCenter,
			@ls_ItemCode,		@ls_subLineCode,	@ls_subLineNo,		@ld_stMH,
			@ls_modifyFlag,		@ls_lastemp)
	Else
		update	tmhstandard
		set	stMH			= @ld_stMH,
			modifyFlag		= @ls_modifyFlag
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	stYear	      		= @ls_stYear	
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode
		and	subLineCode		= @ls_subLineCode
		and	subLineNo		= @ls_subLineNo

	update	[ipisjin_svr].ipis.dbo.tmhstandard
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	stYear	        			= @ls_stYear	
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode
	and	subLineCode			= @ls_subLineCode
	and	subLineNo			= @ls_subLineNo
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhstandard
 
End		-- Procedure End
Go
