
/*
	File Name	: sp_pisi_eis_tmstpartedit.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstpartedit
	Description	: EIS Upload tmstpartedit
			  tmstpartedit
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 12. 23
	Author		: Gary Kim
*/

use EIS

If Exists (	Select	*
		From	sysobjects
		Where	id = object_id(N'[dbo].[sp_pisi_eis_tmstpartedit]')
		And	OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstpartedit]
GO

/*
Execute sp_pisi_eis_tmstpartedit
*/

Create Procedure sp_pisi_eis_tmstpartedit

As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@li_id			int,
	@ls_AreaCode		char(1),
	@ls_DivisionCode		char(1),
	@ls_SupplierCode	char(5),
	@ls_ApplyFrom		char(10),
	@li_PartEditNo		int,
	@ls_PartEditTime		char(5),
	@ls_ApplyTo		char(10),
	@ls_lastemp		varchar(6),
	@ldt_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmstpartedit
(	checkId			int IDENTITY(1,1),
	AreaCode		char(1),
	DivisionCode		char(1),
	SupplierCode		char(5),
	ApplyFrom		char(10),
	PartEditNo		int,
	PartEditTime		char(5),
	ApplyTo			char (10),
	LastEmp			varchar(6),
	LastDate			datetime	)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstpartedit
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstpartedit
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ApplyFrom		= ApplyFrom,
		@li_PartEditNo		= PartEditNo,
		@ls_PartEditTime		= PartEditTime,
		@ls_ApplyTo		= ApplyTo,
		@ls_lastemp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmstpartedit
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmstpartedit
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ApplyFrom	= @ls_ApplyFrom
			and	PartEditNo	= @li_PartEditNo)

		insert into	tmstpartedit
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			PartEditNo,		PartEditTime,		ApplyTo,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,	@ls_ApplyFrom,
			@li_PartEditNo,		@ls_PartEditTime,		@ls_ApplyTo,		@ls_LastEmp)
	Else
		update	tmstpartedit
		set	PartEditTime		= @ls_PartEditTime,
			ApplyTo			= @ls_ApplyTo
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ApplyFrom		= @ls_ApplyFrom
		and	PartEditNo		= @li_PartEditNo

	update	[ipisele_svr\ipis].ipis.dbo.tmstpartedit
	set	lastemp 		= 'N'
	where	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ApplyFrom	= @ls_ApplyFrom
	and	PartEditNo	= @li_PartEditNo
	and	lastemp 		= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartedit


-- 대구기계

Insert	into	#tmp_tmstpartedit
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstpartedit
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ApplyFrom		= ApplyFrom,
		@li_PartEditNo		= PartEditNo,
		@ls_PartEditTime		= PartEditTime,
		@ls_ApplyTo		= ApplyTo,
		@ls_lastemp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmstpartedit
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmstpartedit
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ApplyFrom	= @ls_ApplyFrom
			and	PartEditNo	= @li_PartEditNo)

		insert into	tmstpartedit
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			PartEditNo,		PartEditTime,		ApplyTo,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,	@ls_ApplyFrom,
			@li_PartEditNo,		@ls_PartEditTime,		@ls_ApplyTo,		@ls_LastEmp)
	Else
		update	tmstpartedit
		set	PartEditTime		= @ls_PartEditTime,
			ApplyTo			= @ls_ApplyTo
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ApplyFrom		= @ls_ApplyFrom
		and	PartEditNo		= @li_PartEditNo
		
	update	[ipismac_svr\ipis].ipis.dbo.tmstpartedit
	set	lastemp 		= 'N'
	where	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ApplyFrom	= @ls_ApplyFrom
	and	PartEditNo	= @li_PartEditNo
	and	lastemp 		= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartedit


-- 대구압축

Insert	into	#tmp_tmstpartedit
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstpartedit
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ApplyFrom		= ApplyFrom,
		@li_PartEditNo		= PartEditNo,
		@ls_PartEditTime		= PartEditTime,
		@ls_ApplyTo		= ApplyTo,
		@ls_lastemp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmstpartedit
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmstpartedit
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ApplyFrom	= @ls_ApplyFrom
			and	PartEditNo	= @li_PartEditNo)

		insert into	tmstpartedit
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			PartEditNo,		PartEditTime,		ApplyTo,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,	@ls_ApplyFrom,
			@li_PartEditNo,		@ls_PartEditTime,		@ls_ApplyTo,		@ls_LastEmp)
	Else
		update	tmstpartedit
		set	PartEditTime		= @ls_PartEditTime,
			ApplyTo			= @ls_ApplyTo
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ApplyFrom		= @ls_ApplyFrom
		and	PartEditNo		= @li_PartEditNo

	update	[ipishvac_svr\ipis].ipis.dbo.tmstpartedit
	set	lastemp 		= 'N'
	where	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ApplyFrom	= @ls_ApplyFrom
	and	PartEditNo	= @li_PartEditNo
	and	lastemp 		= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartedit


-- 진천

Insert	into	#tmp_tmstpartedit
select	*
from	[ipisjin_svr].ipis.dbo.tmstpartedit
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ApplyFrom		= ApplyFrom,
		@li_PartEditNo		= PartEditNo,
		@ls_PartEditTime		= PartEditTime,
		@ls_ApplyTo		= ApplyTo,
		@ls_lastemp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmstpartedit
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tmstpartedit
			where	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ApplyFrom	= @ls_ApplyFrom
			and	PartEditNo	= @li_PartEditNo)

		insert into	tmstpartedit
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			PartEditNo,		PartEditTime,		ApplyTo,			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,	@ls_ApplyFrom,
			@li_PartEditNo,		@ls_PartEditTime,		@ls_ApplyTo,		@ls_LastEmp)
	Else
		update	tmstpartedit
		set	PartEditTime		= @ls_PartEditTime,
			ApplyTo			= @ls_ApplyTo
		where	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ApplyFrom		= @ls_ApplyFrom
		and	PartEditNo		= @li_PartEditNo
		
	update	[ipisjin_svr].ipis.dbo.tmstpartedit
	set	lastemp 		= 'N'
	where	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ApplyFrom	= @ls_ApplyFrom
	and	PartEditNo	= @li_PartEditNo
	and	lastemp 		= 'Y'

End	-- while loop end

drop table #tmp_tmstpartedit
 
End		-- Procedure End
Go
