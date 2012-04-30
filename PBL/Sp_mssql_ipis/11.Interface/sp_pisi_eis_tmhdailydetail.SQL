/*
	File Name	: sp_pisi_eis_tmhdailydetail.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhdailydetail
	Description	: EIS Upload tmhdailydetail
			  tmhdailydetail
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 12. 24
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhdailydetail]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhdailydetail]
GO

/*
Execute sp_pisi_eis_tmhdailydetail
*/

Create Procedure sp_pisi_eis_tmhdailydetail

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_WorkCenter			varchar(5),
	@ls_WorkDay			char(10),
	@ls_EmpGubun			char(1),
	@li_mhGubun			char(1),
	@li_mhCode			varchar(2),
	@li_subMH			numeric,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhdailydetail
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),       
	DivisionCode            		char(1),       
	WorkCenter	        		varchar(5),    
	WorkDay	                		char(10),      
	EmpGubun	        		char(1),       
	mhGubun	                	char(1),       
	mhCode	        			varchar(2),    
	subMH	                		numeric,       
	LastEmp				varchar(6), 
	LastDate				datetime   )

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)
                                                        
-- 대구전장	

Insert	into	#tmp_tmhdailydetail
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhdailydetail
where	WorkDay 	<= @ls_yesterday
and	lastemp		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_EmpGubun			= EmpGubun,
		@li_mhGubun			= mhGubun,
		@li_mhCode			= mhCode,
		@li_subMH			= subMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdailydetail
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdailydetail
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	
			and	mhGubun		= @li_mhGubun	
			and	mhCode			= @li_mhCode	)

		insert into tmhdailydetail
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		EmpGubun,
			mhGubun,		mhCode,		subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_EmpGubun,
			@li_mhGubun,		@li_mhCode,		@li_subMH,		@ls_LastEmp)
	Else
		update	tmhdailydetail
		set	subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter		
		and	WorkDay			= @ls_WorkDay	
		and	EmpGubun		= @ls_EmpGubun	
		and	mhGubun		= @li_mhGubun	
		and	mhCode			= @li_mhCode

	update	[ipisele_svr\ipis].ipis.dbo.tmhdailydetail
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun	
	and	mhGubun			= @li_mhGubun	
	and	mhCode				= @li_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailydetail


-- 대구기계

Insert	into	#tmp_tmhdailydetail
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhdailydetail
where	WorkDay 		<= @ls_yesterday
and	lastemp 			= 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_EmpGubun			= EmpGubun,
		@li_mhGubun			= mhGubun,
		@li_mhCode			= mhCode,
		@li_subMH			= subMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdailydetail
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdailydetail
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	
			and	mhGubun		= @li_mhGubun	
			and	mhCode			= @li_mhCode	)

		insert into tmhdailydetail
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		EmpGubun,
			mhGubun,		mhCode,		subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_EmpGubun,
			@li_mhGubun,		@li_mhCode,		@li_subMH,		@ls_LastEmp)
	Else
		update	tmhdailydetail
		set	subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter		
		and	WorkDay			= @ls_WorkDay	
		and	EmpGubun		= @ls_EmpGubun	
		and	mhGubun		= @li_mhGubun	
		and	mhCode			= @li_mhCode

	update	[ipismac_svr\ipis].ipis.dbo.tmhdailydetail
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun	
	and	mhGubun			= @li_mhGubun	
	and	mhCode				= @li_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailydetail


-- 대구압축

Insert	into	#tmp_tmhdailydetail
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhdailydetail
where	WorkDay 	<= @ls_yesterday
and	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_EmpGubun			= EmpGubun,
		@li_mhGubun			= mhGubun,
		@li_mhCode			= mhCode,
		@li_subMH			= subMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdailydetail
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdailydetail
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	
			and	mhGubun		= @li_mhGubun	
			and	mhCode			= @li_mhCode	)

		insert into tmhdailydetail
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		EmpGubun,
			mhGubun,		mhCode,		subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_EmpGubun,
			@li_mhGubun,		@li_mhCode,		@li_subMH,		@ls_LastEmp)
	Else
		update	tmhdailydetail
		set	subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter		
		and	WorkDay			= @ls_WorkDay	
		and	EmpGubun		= @ls_EmpGubun	
		and	mhGubun		= @li_mhGubun	
		and	mhCode			= @li_mhCode

	update	[ipishvac_svr\ipis].ipis.dbo.tmhdailydetail
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun	
	and	mhGubun			= @li_mhGubun	
	and	mhCode				= @li_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdailydetail


-- 진천

Insert	into	#tmp_tmhdailydetail
select	*
from	[ipisjin_svr].ipis.dbo.tmhdailydetail
where	WorkDay 	<= @ls_yesterday
and	lastemp 		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_WorkDay			= WorkDay,
		@ls_EmpGubun			= EmpGubun,
		@li_mhGubun			= mhGubun,
		@li_mhCode			= mhCode,
		@li_subMH			= subMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdailydetail
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdailydetail
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	
			and	mhGubun		= @li_mhGubun	
			and	mhCode			= @li_mhCode	)

		insert into tmhdailydetail
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,		EmpGubun,
			mhGubun,		mhCode,		subMH,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,		@ls_EmpGubun,
			@li_mhGubun,		@li_mhCode,		@li_subMH,		@ls_LastEmp)
	Else
		update	tmhdailydetail
		set	subMH			= @li_subMH
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter		
		and	WorkDay			= @ls_WorkDay	
		and	EmpGubun		= @ls_EmpGubun	
		and	mhGubun		= @li_mhGubun	
		and	mhCode			= @li_mhCode
		
	update	[ipisjin_svr].ipis.dbo.tmhdailydetail
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun	
	and	mhGubun			= @li_mhGubun	
	and	mhCode				= @li_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhdailydetail
 
End		-- Procedure End
Go
