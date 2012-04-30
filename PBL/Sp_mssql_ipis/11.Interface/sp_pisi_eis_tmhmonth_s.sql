/*
	File Name	: sp_pisi_eis_tmhmonth_s.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhmonth_s
	Description	: EIS Upload tmhmonth_s
			  tmhmonth_s
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhmonth_s]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhmonth_s]
GO

/*
Execute sp_pisi_eis_tmhmonth_s
*/

Create Procedure sp_pisi_eis_tmhmonth_s

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_WorkCenter			varchar(5),
	@ls_sMonth			char(7),
	@ld_totMH			decimal,
	@ld_jungsiMH			decimal,
	@ld_mSuppMH			decimal,
	@ld_pSuppMH			decimal,
	@ld_etcMH			decimal,
	@ld_etcmSuppMH		decimal,
	@ld_etcpSuppMH			decimal,
	@ld_excunpaidMH		decimal,
	@ld_excpaidMH			decimal,
	@ld_totInMH			decimal,
	@ld_gunteMH			decimal,
	@ld_ilboMH			decimal,
	@ld_bugaMH			decimal,
	@ld_UnuseMH			decimal,
	@ld_ActMH			decimal,
	@ld_ActInMH			decimal,
	@ld_effDownMH			decimal,
	@ld_BasicMH			decimal,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhmonth_s
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),   
	DivisionCode			char(1),   
	WorkCenter			varchar(5),
	sMonth				char(7),   
	totMH				decimal,   
	jungsiMH			decimal,   
	mSuppMH			decimal,   
	pSuppMH			decimal,   
	etcMH				decimal,   
	etcmSuppMH			decimal,   
	etcpSuppMH			decimal,   
	excunpaidMH			decimal,   
	excpaidMH			decimal,   
	totInMH				decimal,   
	gunteMH				decimal,   
	ilboMH				decimal,   
	bugaMH				decimal,   
	UnuseMH			decimal,   
	ActMH				decimal,   
	ActInMH				decimal,   
	effDownMH			decimal,   
	BasicMH			decimal,   
	LastEmp				varchar(6),
	LastDate				datetime,  )

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhmonth_s
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhmonth_s
where	lastemp		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_sMonth			= sMonth,
		@ld_totMH			= totMH,
		@ld_jungsiMH			= jungsiMH,
		@ld_mSuppMH			= mSuppMH,
		@ld_pSuppMH			= pSuppMH,
		@ld_etcMH			= etcMH,
		@ld_etcmSuppMH		= etcmSuppMH,
		@ld_etcpSuppMH			= etcpSuppMH,
		@ld_excunpaidMH		= excunpaidMH,
		@ld_excpaidMH			= excpaidMH,
		@ld_totInMH			= totInMH,
		@ld_gunteMH			= gunteMH,
		@ld_ilboMH			= ilboMH,
		@ld_bugaMH			= bugaMH,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_effDownMH			= effDownMH,
		@ld_BasicMH			= BasicMH,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonth_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonth_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonth_s
			(AreaCode,		DivisionCode,		WorkCenter,		sMonth,		totMH,
			jungsiMH,		mSuppMH,		pSuppMH,		etcMH,		etcmSuppMH,
			etcpSuppMH,		excunpaidMH,		excpaidMH,		totInMH,		gunteMH,
			ilboMH,			bugaMH,		UnuseMH,		ActMH,		ActInMH,
			effDownMH,		BasicMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_sMonth,	@ld_totMH,
			@ld_jungsiMH,		@ld_mSuppMH,		@ld_pSuppMH,		@ld_etcMH,	@ld_etcmSuppMH,
			@ld_etcpSuppMH,	@ld_excunpaidMH,	@ld_excpaidMH,		@ld_totInMH,	@ld_gunteMH,
			@ld_ilboMH,		@ld_bugaMH,		@ld_UnuseMH,		@ld_ActMH,	@ld_ActInMH,
			@ld_effDownMH,		@ld_BasicMH,		@ls_LastEmp)
	Else
		update	tmhmonth_s
		set	totMH			= @ld_totMH,
			jungsiMH		= @ld_jungsiMH,
			mSuppMH		= @ld_mSuppMH,
			pSuppMH		= @ld_pSuppMH,
			etcMH			= @ld_etcMH,
			etcmSuppMH		= @ld_etcmSuppMH,
			etcpSuppMH		= @ld_etcpSuppMH,
			excunpaidMH		= @ld_excunpaidMH,
			excpaidMH		= @ld_excpaidMH,
			totInMH			= @ld_totInMH,
			gunteMH			= @ld_gunteMH,
			ilboMH			= @ld_ilboMH,
			bugaMH			= @ld_bugaMH,
			UnuseMH		= @ld_UnuseMH,
			ActMH			= @ld_ActMH,
			ActInMH			= @ld_ActInMH,
			effDownMH		= @ld_effDownMH,
                        		BasicMH		= @ld_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	sMonth			= @ls_sMonth	

	update	[ipisele_svr\ipis].ipis.dbo.tmhmonth_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	sMonth				= @ls_sMonth	
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonth_s


-- 대구기계

Insert	into	#tmp_tmhmonth_s
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhmonth_s
where	lastemp		= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode			= DivisionCode,
		@ls_WorkCenter			= WorkCenter,
		@ls_sMonth			= sMonth,
		@ld_totMH			= totMH,
		@ld_jungsiMH			= jungsiMH,
		@ld_mSuppMH			= mSuppMH,
		@ld_pSuppMH			= pSuppMH,
		@ld_etcMH			= etcMH,
		@ld_etcmSuppMH		= etcmSuppMH,
		@ld_etcpSuppMH			= etcpSuppMH,
		@ld_excunpaidMH		= excunpaidMH,
		@ld_excpaidMH			= excpaidMH,
		@ld_totInMH			= totInMH,
		@ld_gunteMH			= gunteMH,
		@ld_ilboMH			= ilboMH,
		@ld_bugaMH			= bugaMH,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_effDownMH			= effDownMH,
		@ld_BasicMH			= BasicMH,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonth_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonth_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonth_s
			(AreaCode,		DivisionCode,		WorkCenter,		sMonth,		totMH,
			jungsiMH,		mSuppMH,		pSuppMH,		etcMH,		etcmSuppMH,
			etcpSuppMH,		excunpaidMH,		excpaidMH,		totInMH,		gunteMH,
			ilboMH,			bugaMH,		UnuseMH,		ActMH,		ActInMH,
			effDownMH,		BasicMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_sMonth,	@ld_totMH,
			@ld_jungsiMH,		@ld_mSuppMH,		@ld_pSuppMH,		@ld_etcMH,	@ld_etcmSuppMH,
			@ld_etcpSuppMH,	@ld_excunpaidMH,	@ld_excpaidMH,		@ld_totInMH,	@ld_gunteMH,
			@ld_ilboMH,		@ld_bugaMH,		@ld_UnuseMH,		@ld_ActMH,	@ld_ActInMH,
			@ld_effDownMH,		@ld_BasicMH,		@ls_LastEmp)
	Else
		update	tmhmonth_s
		set	totMH			= @ld_totMH,
			jungsiMH		= @ld_jungsiMH,
			mSuppMH		= @ld_mSuppMH,
			pSuppMH		= @ld_pSuppMH,
			etcMH			= @ld_etcMH,
			etcmSuppMH		= @ld_etcmSuppMH,
			etcpSuppMH		= @ld_etcpSuppMH,
			excunpaidMH		= @ld_excunpaidMH,
			excpaidMH		= @ld_excpaidMH,
			totInMH			= @ld_totInMH,
			gunteMH			= @ld_gunteMH,
			ilboMH			= @ld_ilboMH,
			bugaMH			= @ld_bugaMH,
			UnuseMH		= @ld_UnuseMH,
			ActMH			= @ld_ActMH,
			ActInMH			= @ld_ActInMH,
			effDownMH		= @ld_effDownMH,
                        		BasicMH		= @ld_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	sMonth			= @ls_sMonth	

	update	[ipismac_svr\ipis].ipis.dbo.tmhmonth_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	sMonth				= @ls_sMonth	
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonth_s


-- 대구압축

Insert	into	#tmp_tmhmonth_s
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhmonth_s
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
		@ls_sMonth			= sMonth,
		@ld_totMH			= totMH,
		@ld_jungsiMH			= jungsiMH,
		@ld_mSuppMH			= mSuppMH,
		@ld_pSuppMH			= pSuppMH,
		@ld_etcMH			= etcMH,
		@ld_etcmSuppMH		= etcmSuppMH,
		@ld_etcpSuppMH			= etcpSuppMH,
		@ld_excunpaidMH		= excunpaidMH,
		@ld_excpaidMH			= excpaidMH,
		@ld_totInMH			= totInMH,
		@ld_gunteMH			= gunteMH,
		@ld_ilboMH			= ilboMH,
		@ld_bugaMH			= bugaMH,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_effDownMH			= effDownMH,
		@ld_BasicMH			= BasicMH,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonth_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonth_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonth_s
			(AreaCode,		DivisionCode,		WorkCenter,		sMonth,		totMH,
			jungsiMH,		mSuppMH,		pSuppMH,		etcMH,		etcmSuppMH,
			etcpSuppMH,		excunpaidMH,		excpaidMH,		totInMH,		gunteMH,
			ilboMH,			bugaMH,		UnuseMH,		ActMH,		ActInMH,
			effDownMH,		BasicMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_sMonth,	@ld_totMH,
			@ld_jungsiMH,		@ld_mSuppMH,		@ld_pSuppMH,		@ld_etcMH,	@ld_etcmSuppMH,
			@ld_etcpSuppMH,	@ld_excunpaidMH,	@ld_excpaidMH,		@ld_totInMH,	@ld_gunteMH,
			@ld_ilboMH,		@ld_bugaMH,		@ld_UnuseMH,		@ld_ActMH,	@ld_ActInMH,
			@ld_effDownMH,		@ld_BasicMH,		@ls_LastEmp)
	Else
		update	tmhmonth_s
		set	totMH			= @ld_totMH,
			jungsiMH		= @ld_jungsiMH,
			mSuppMH		= @ld_mSuppMH,
			pSuppMH		= @ld_pSuppMH,
			etcMH			= @ld_etcMH,
			etcmSuppMH		= @ld_etcmSuppMH,
			etcpSuppMH		= @ld_etcpSuppMH,
			excunpaidMH		= @ld_excunpaidMH,
			excpaidMH		= @ld_excpaidMH,
			totInMH			= @ld_totInMH,
			gunteMH			= @ld_gunteMH,
			ilboMH			= @ld_ilboMH,
			bugaMH			= @ld_bugaMH,
			UnuseMH		= @ld_UnuseMH,
			ActMH			= @ld_ActMH,
			ActInMH			= @ld_ActInMH,
			effDownMH		= @ld_effDownMH,
                        		BasicMH		= @ld_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	sMonth			= @ls_sMonth	

	update	[ipishvac_svr\ipis].ipis.dbo.tmhmonth_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	sMonth				= @ls_sMonth	
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonth_s


-- 진천

Insert	into	#tmp_tmhmonth_s
select	*
from	[ipisjin_svr].ipis.dbo.tmhmonth_s
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
		@ls_sMonth			= sMonth,
		@ld_totMH			= totMH,
		@ld_jungsiMH			= jungsiMH,
		@ld_mSuppMH			= mSuppMH,
		@ld_pSuppMH			= pSuppMH,
		@ld_etcMH			= etcMH,
		@ld_etcmSuppMH		= etcmSuppMH,
		@ld_etcpSuppMH			= etcpSuppMH,
		@ld_excunpaidMH		= excunpaidMH,
		@ld_excpaidMH			= excpaidMH,
		@ld_totInMH			= totInMH,
		@ld_gunteMH			= gunteMH,
		@ld_ilboMH			= ilboMH,
		@ld_bugaMH			= bugaMH,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_effDownMH			= effDownMH,
		@ld_BasicMH			= BasicMH,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonth_s
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tmhmonth_s
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter
			and	sMonth		= @ls_sMonth		)

		insert into tmhmonth_s
			(AreaCode,		DivisionCode,		WorkCenter,		sMonth,		totMH,
			jungsiMH,		mSuppMH,		pSuppMH,		etcMH,		etcmSuppMH,
			etcpSuppMH,		excunpaidMH,		excpaidMH,		totInMH,		gunteMH,
			ilboMH,			bugaMH,		UnuseMH,		ActMH,		ActInMH,
			effDownMH,		BasicMH,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_sMonth,	@ld_totMH,
			@ld_jungsiMH,		@ld_mSuppMH,		@ld_pSuppMH,		@ld_etcMH,	@ld_etcmSuppMH,
			@ld_etcpSuppMH,	@ld_excunpaidMH,	@ld_excpaidMH,		@ld_totInMH,	@ld_gunteMH,
			@ld_ilboMH,		@ld_bugaMH,		@ld_UnuseMH,		@ld_ActMH,	@ld_ActInMH,
			@ld_effDownMH,		@ld_BasicMH,		@ls_LastEmp)
	Else
		update	tmhmonth_s
		set	totMH			= @ld_totMH,
			jungsiMH		= @ld_jungsiMH,
			mSuppMH		= @ld_mSuppMH,
			pSuppMH		= @ld_pSuppMH,
			etcMH			= @ld_etcMH,
			etcmSuppMH		= @ld_etcmSuppMH,
			etcpSuppMH		= @ld_etcpSuppMH,
			excunpaidMH		= @ld_excunpaidMH,
			excpaidMH		= @ld_excpaidMH,
			totInMH			= @ld_totInMH,
			gunteMH			= @ld_gunteMH,
			ilboMH			= @ld_ilboMH,
			bugaMH			= @ld_bugaMH,
			UnuseMH		= @ld_UnuseMH,
			ActMH			= @ld_ActMH,
			ActInMH			= @ld_ActInMH,
			effDownMH		= @ld_effDownMH,
                        		BasicMH		= @ld_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	sMonth			= @ls_sMonth	
		
	update	[ipisjin_svr].ipis.dbo.tmhmonth_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	sMonth				= @ls_sMonth	
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhmonth_s
 
End		-- Procedure End
Go
