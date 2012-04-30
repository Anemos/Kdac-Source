/*
	File Name	: sp_pisi_eis_tmhdaily.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhdaily
	Description	: EIS Upload tmhdaily
			  tmhdaily
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhdaily]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhdaily]
GO

/*
Execute sp_pisi_eis_tmhdaily
*/

Create Procedure sp_pisi_eis_tmhdaily

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
	@li_totMH			numeric,
	@li_jungsiMH			numeric,
	@li_mSuppMH			numeric,
	@li_pSuppMH			numeric,
	@li_etcMH			numeric, 
	@li_etcmSuppMH			numeric,
	@li_etcpSuppMH			numeric,
	@li_excunpaidMH			numeric,
	@li_excpaidMH			numeric,
	@li_totInMH			numeric,
	@li_gunteMH			numeric,
	@li_ilboMH			numeric,
	@li_bugaMH			numeric,
	@li_ActInMH			numeric,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhdaily
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),   
	DivisionCode            		char(1),   
	WorkCenter	        		varchar(5),   
	WorkDay	                		char(10),  
	EmpGubun	        		char(1),   
	totMH	                		numeric,   
	jungsiMH			numeric,   
	mSuppMH	                	numeric,   
	pSuppMH	        		numeric,   
	etcMH	                		numeric,   
	etcmSuppMH			numeric,   
	etcpSuppMH			numeric,   
	excunpaidMH			numeric,   
	excpaidMH			numeric,   
	totInMH	              		numeric,   
	gunteMH	              		numeric,   
	ilboMH	                        		numeric,   
	bugaMH	                        		numeric,   
	ActInMH	                        		numeric,   
	LastEmp				varchar(6), 
	LastDate				datetime,   )

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)
                                                        
-- 대구전장	

Insert	into	#tmp_tmhdaily
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhdaily
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
		@li_totMH			= totMH,
		@li_jungsiMH			= jungsiMH,
		@li_mSuppMH			= mSuppMH,
		@li_pSuppMH			= pSuppMH,
		@li_etcMH			= etcMH,
		@li_etcmSuppMH			= etcmSuppMH,
		@li_etcpSuppMH			= etcpSuppMH,
		@li_excunpaidMH			= excunpaidMH,
		@li_excpaidMH			= excpaidMH,
		@li_totInMH	        		= totInMH,
		@li_gunteMH	        		= gunteMH,
		@li_ilboMH	        		= ilboMH,
		@li_bugaMH	        		= bugaMH,
		@li_ActInMH	        		= ActInMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdaily
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdaily
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	)

		insert into tmhdaily
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,	EmpGubun,
			totMH,			jungsiMH,		mSuppMH,		pSuppMH,	etcMH,
			etcmSuppMH,		etcpSuppMH,		excunpaidMH,		excpaidMH,	totInMH,
			gunteMH,		ilboMH,			bugaMH,		ActInMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,	@ls_EmpGubun,
			@li_totMH,		@li_jungsiMH,		@li_mSuppMH,		@li_pSuppMH,	@li_etcMH,
			@li_etcmSuppMH,		@li_etcpSuppMH,		@li_excunpaidMH,	@li_excpaidMH,	@li_totInMH,
			@li_gunteMH,		@li_ilboMH,		@li_bugaMH,		@li_ActInMH,	@ls_lastemp)
	Else
		update	tmhdaily
		set	totMH			= @li_totMH,
			jungsiMH		= @li_jungsiMH,
			mSuppMH		= @li_mSuppMH,
			pSuppMH		= @li_pSuppMH,
			etcMH			= @li_etcMH,
			etcmSuppMH		= @li_etcmSuppMH,
			etcpSuppMH		= @li_etcpSuppMH,
			excunpaidMH		= @li_excunpaidMH,
			excpaidMH		= @li_excpaidMH,
			totInMH			= @li_totInMH,
			gunteMH			= @li_gunteMH,
			ilboMH			= @li_ilboMH,
			bugaMH			= @li_bugaMH,
			ActInMH			= @li_ActInMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter
		and	WorkDay			= @ls_WorkDay
		and	EmpGubun		= @ls_EmpGubun

	update	[ipisele_svr\ipis].ipis.dbo.tmhdaily
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun		
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdaily


-- 대구기계

Insert	into	#tmp_tmhdaily
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhdaily
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
		@li_totMH			= totMH,
		@li_jungsiMH			= jungsiMH,
		@li_mSuppMH			= mSuppMH,
		@li_pSuppMH			= pSuppMH,
		@li_etcMH			= etcMH,
		@li_etcmSuppMH			= etcmSuppMH,
		@li_etcpSuppMH			= etcpSuppMH,
		@li_excunpaidMH			= excunpaidMH,
		@li_excpaidMH			= excpaidMH,
		@li_totInMH	        		= totInMH,
		@li_gunteMH	        		= gunteMH,
		@li_ilboMH	        		= ilboMH,
		@li_bugaMH	        		= bugaMH,
		@li_ActInMH	        		= ActInMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdaily
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdaily
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	)

		insert into tmhdaily
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,	EmpGubun,
			totMH,			jungsiMH,		mSuppMH,		pSuppMH,	etcMH,
			etcmSuppMH,		etcpSuppMH,		excunpaidMH,		excpaidMH,	totInMH,
			gunteMH,		ilboMH,			bugaMH,		ActInMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,	@ls_EmpGubun,
			@li_totMH,		@li_jungsiMH,		@li_mSuppMH,		@li_pSuppMH,	@li_etcMH,
			@li_etcmSuppMH,		@li_etcpSuppMH,		@li_excunpaidMH,	@li_excpaidMH,	@li_totInMH,
			@li_gunteMH,		@li_ilboMH,		@li_bugaMH,		@li_ActInMH,	@ls_lastemp)
	Else
		update	tmhdaily
		set	totMH			= @li_totMH,
			jungsiMH		= @li_jungsiMH,
			mSuppMH		= @li_mSuppMH,
			pSuppMH		= @li_pSuppMH,
			etcMH			= @li_etcMH,
			etcmSuppMH		= @li_etcmSuppMH,
			etcpSuppMH		= @li_etcpSuppMH,
			excunpaidMH		= @li_excunpaidMH,
			excpaidMH		= @li_excpaidMH,
			totInMH			= @li_totInMH,
			gunteMH			= @li_gunteMH,
			ilboMH			= @li_ilboMH,
			bugaMH			= @li_bugaMH,
			ActInMH			= @li_ActInMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter
		and	WorkDay			= @ls_WorkDay
		and	EmpGubun		= @ls_EmpGubun

	update	[ipismac_svr\ipis].ipis.dbo.tmhdaily
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun		
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdaily


-- 대구압축

Insert	into	#tmp_tmhdaily
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhdaily
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
		@li_totMH			= totMH,
		@li_jungsiMH			= jungsiMH,
		@li_mSuppMH			= mSuppMH,
		@li_pSuppMH			= pSuppMH,
		@li_etcMH			= etcMH,
		@li_etcmSuppMH			= etcmSuppMH,
		@li_etcpSuppMH			= etcpSuppMH,
		@li_excunpaidMH			= excunpaidMH,
		@li_excpaidMH			= excpaidMH,
		@li_totInMH	        		= totInMH,
		@li_gunteMH	        		= gunteMH,
		@li_ilboMH	        		= ilboMH,
		@li_bugaMH	        		= bugaMH,
		@li_ActInMH	        		= ActInMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdaily
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdaily
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	)

		insert into tmhdaily
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,	EmpGubun,
			totMH,			jungsiMH,		mSuppMH,		pSuppMH,	etcMH,
			etcmSuppMH,		etcpSuppMH,		excunpaidMH,		excpaidMH,	totInMH,
			gunteMH,		ilboMH,			bugaMH,		ActInMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,	@ls_EmpGubun,
			@li_totMH,		@li_jungsiMH,		@li_mSuppMH,		@li_pSuppMH,	@li_etcMH,
			@li_etcmSuppMH,		@li_etcpSuppMH,		@li_excunpaidMH,	@li_excpaidMH,	@li_totInMH,
			@li_gunteMH,		@li_ilboMH,		@li_bugaMH,		@li_ActInMH,	@ls_lastemp)
	Else
		update	tmhdaily
		set	totMH			= @li_totMH,
			jungsiMH		= @li_jungsiMH,
			mSuppMH		= @li_mSuppMH,
			pSuppMH		= @li_pSuppMH,
			etcMH			= @li_etcMH,
			etcmSuppMH		= @li_etcmSuppMH,
			etcpSuppMH		= @li_etcpSuppMH,
			excunpaidMH		= @li_excunpaidMH,
			excpaidMH		= @li_excpaidMH,
			totInMH			= @li_totInMH,
			gunteMH			= @li_gunteMH,
			ilboMH			= @li_ilboMH,
			bugaMH			= @li_bugaMH,
			ActInMH			= @li_ActInMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter
		and	WorkDay			= @ls_WorkDay
		and	EmpGubun		= @ls_EmpGubun

	update	[ipishvac_svr\ipis].ipis.dbo.tmhdaily
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun		
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhdaily


-- 진천

Insert	into	#tmp_tmhdaily
select	*
from	[ipisjin_svr].ipis.dbo.tmhdaily
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
		@li_totMH			= totMH,
		@li_jungsiMH			= jungsiMH,
		@li_mSuppMH			= mSuppMH,
		@li_pSuppMH			= pSuppMH,
		@li_etcMH			= etcMH,
		@li_etcmSuppMH			= etcmSuppMH,
		@li_etcpSuppMH			= etcpSuppMH,
		@li_excunpaidMH			= excunpaidMH,
		@li_excpaidMH			= excpaidMH,
		@li_totInMH	        		= totInMH,
		@li_gunteMH	        		= gunteMH,
		@li_ilboMH	        		= ilboMH,
		@li_bugaMH	        		= bugaMH,
		@li_ActInMH	        		= ActInMH,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tmhdaily
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmhdaily
			where	AreaCode		= @ls_AreaCode	
			and	DivisionCode		= @ls_DivisionCode
			and	WorkCenter		= @ls_WorkCenter		
			and	WorkDay			= @ls_WorkDay	
			and	EmpGubun		= @ls_EmpGubun	)

		insert into tmhdaily
			(AreaCode,		DivisionCode,		WorkCenter,		WorkDay,	EmpGubun,
			totMH,			jungsiMH,		mSuppMH,		pSuppMH,	etcMH,
			etcmSuppMH,		etcpSuppMH,		excunpaidMH,		excpaidMH,	totInMH,
			gunteMH,		ilboMH,			bugaMH,		ActInMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_WorkDay,	@ls_EmpGubun,
			@li_totMH,		@li_jungsiMH,		@li_mSuppMH,		@li_pSuppMH,	@li_etcMH,
			@li_etcmSuppMH,		@li_etcpSuppMH,		@li_excunpaidMH,	@li_excpaidMH,	@li_totInMH,
			@li_gunteMH,		@li_ilboMH,		@li_bugaMH,		@li_ActInMH,	@ls_lastemp)
	Else
		update	tmhdaily
		set	totMH			= @li_totMH,
			jungsiMH		= @li_jungsiMH,
			mSuppMH		= @li_mSuppMH,
			pSuppMH		= @li_pSuppMH,
			etcMH			= @li_etcMH,
			etcmSuppMH		= @li_etcmSuppMH,
			etcpSuppMH		= @li_etcpSuppMH,
			excunpaidMH		= @li_excunpaidMH,
			excpaidMH		= @li_excpaidMH,
			totInMH			= @li_totInMH,
			gunteMH			= @li_gunteMH,
			ilboMH			= @li_ilboMH,
			bugaMH			= @li_bugaMH,
			ActInMH			= @li_ActInMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter
		and	WorkDay			= @ls_WorkDay
		and	EmpGubun		= @ls_EmpGubun
		
	update	[ipisjin_svr].ipis.dbo.tmhdaily
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter		
	and	WorkDay				= @ls_WorkDay	
	and	EmpGubun			= @ls_EmpGubun		
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhdaily
 
End		-- Procedure End
Go
