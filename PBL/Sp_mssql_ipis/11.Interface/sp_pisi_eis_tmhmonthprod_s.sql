/*
	File Name	: sp_pisi_eis_tmhmonthprod_s.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhmonthprod_s
	Description	: EIS Upload tmhmonthprod_s
			  tmhmonthprod_s
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhmonthprod_s]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhmonthprod_s]
GO

/*
Execute sp_pisi_eis_tmhmonthprod_s
*/

Create Procedure sp_pisi_eis_tmhmonthprod_s

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AreaCode			char(1),
	@ls_DivisionCode			char(1),
	@ls_WorkCenter			varchar(5),
	@ls_ItemCode			varchar(12),
	@ls_sMonth			char(7),
	@li_pQty				int,
	@ld_UnuseMH			decimal,
	@ld_ActMH			decimal,
	@ld_ActInMH			decimal,
	@ld_BasicMH			decimal,
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tmhmonthprod_s
(	checkId				int IDENTITY(1,1),
	AreaCode			char(1),
	DivisionCode			char(1),
	WorkCenter			varchar(5),
	ItemCode			varchar(12),
	sMonth				char(7),
	pQty				int,
	UnuseMH			decimal,
	ActMH				decimal,
	ActInMH				decimal,
	BasicMH			decimal,
	LastEmp				varchar(6),
	LastDate				datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhmonthprod_s
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhmonthprod_s
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
		@ls_ItemCode			= ItemCode,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprod_s
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprod_s
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode	
			and	sMonth		= @ls_sMonth	)

		insert into tmhmonthprod_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,		sMonth,
			pQty,			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,		@ls_sMonth,
			@li_pQty,		@ld_UnuseMH,		@ld_ActMH,		@ld_ActInMH,		@ld_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprod_s
		set	pQty			= @li_pQty,	
			UnuseMH		= @ld_UnuseMH,	
			ActMH			= @ld_ActMH,	
			ActInMH			= @ld_ActInMH,	
			BasicMH	        	= @ld_BasicMH
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode	
		and	sMonth			= @ls_sMonth

	update	[ipisele_svr\ipis].ipis.dbo.tmhmonthprod_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode	
	and	sMonth				= @ls_sMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthprod_s


-- 대구기계

Insert	into	#tmp_tmhmonthprod_s
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhmonthprod_s
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
		@ls_ItemCode			= ItemCode,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprod_s
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprod_s
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode	
			and	sMonth		= @ls_sMonth	)

		insert into tmhmonthprod_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,		sMonth,
			pQty,			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,		@ls_sMonth,
			@li_pQty,		@ld_UnuseMH,		@ld_ActMH,		@ld_ActInMH,		@ld_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprod_s
		set	pQty			= @li_pQty,	
			UnuseMH		= @ld_UnuseMH,
			ActMH			= @ld_ActMH,	
			ActInMH			= @ld_ActInMH,	
			BasicMH	        	= @ld_BasicMH	
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode	
		and	sMonth			= @ls_sMonth
		
	update	[ipismac_svr\ipis].ipis.dbo.tmhmonthprod_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode	
	and	sMonth				= @ls_sMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthprod_s


-- 대구압축

Insert	into	#tmp_tmhmonthprod_s
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhmonthprod_s
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
		@ls_ItemCode			= ItemCode,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprod_s
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprod_s
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode	
			and	sMonth		= @ls_sMonth	)

		insert into tmhmonthprod_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,		sMonth,
			pQty,			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,		@ls_sMonth,
			@li_pQty,		@ld_UnuseMH,		@ld_ActMH,		@ld_ActInMH,		@ld_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprod_s
		set	pQty			= @li_pQty,	
			UnuseMH		= @ld_UnuseMH,	
			ActMH			= @ld_ActMH,	
			ActInMH			= @ld_ActInMH,	
	                        	BasicMH	        	= @ld_BasicMH	
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode	
		and	sMonth			= @ls_sMonth

	update	[ipishvac_svr\ipis].ipis.dbo.tmhmonthprod_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode	
	and	sMonth				= @ls_sMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthprod_s


-- 진천

Insert	into	#tmp_tmhmonthprod_s
select	*
from	[ipisjin_svr].ipis.dbo.tmhmonthprod_s
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
		@ls_ItemCode			= ItemCode,
		@ls_sMonth			= sMonth,
		@li_pQty				= pQty,
		@ld_UnuseMH			= UnuseMH,
		@ld_ActMH			= ActMH,
		@ld_ActInMH			= ActInMH,
		@ld_BasicMH			= BasicMH,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tmhmonthprod_s
	Where	checkid 				> @lI_id

	-- key chk
	If not exists (	select * from tmhmonthprod_s
			where	AreaCode	= @ls_AreaCode	
			and	DivisionCode	= @ls_DivisionCode
			and	WorkCenter	= @ls_WorkCenter	
			and	ItemCode	= @ls_ItemCode	
			and	sMonth		= @ls_sMonth	)

		insert into tmhmonthprod_s
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,		sMonth,
			pQty,			UnuseMH,		ActMH,			ActInMH,			BasicMH,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,		@ls_sMonth,
			@li_pQty,		@ld_UnuseMH,		@ld_ActMH,		@ld_ActInMH,		@ld_BasicMH,
			@ls_lastemp)
	Else
		update	tmhmonthprod_s
		set	pQty			= @li_pQty,	
			UnuseMH		= @ld_UnuseMH,	
			ActMH			= @ld_ActMH,	
			ActInMH			= @ld_ActInMH,	
                        		BasicMH	        	= @ld_BasicMH	
		where	AreaCode		= @ls_AreaCode	
		and	DivisionCode		= @ls_DivisionCode
		and	WorkCenter		= @ls_WorkCenter	
		and	ItemCode		= @ls_ItemCode	
		and	sMonth			= @ls_sMonth
		
	update	[ipisjin_svr].ipis.dbo.tmhmonthprod_s
	set	lastemp 				= 'N'
	where	AreaCode			= @ls_AreaCode	
	and	DivisionCode			= @ls_DivisionCode
	and	WorkCenter			= @ls_WorkCenter	
	and	ItemCode			= @ls_ItemCode	
	and	sMonth				= @ls_sMonth
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhmonthprod_s
 
End		-- Procedure End
Go
