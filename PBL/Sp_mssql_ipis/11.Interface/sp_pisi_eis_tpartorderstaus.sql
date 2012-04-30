/*
	File Name	: sp_pisi_eis_tpartorderstaus.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartorderstaus
	Description	: EIS Upload tpartorderstaus
			  tpartorderstaus
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
		Where	id = object_id(N'[dbo].[sp_pisi_eis_tpartorderstaus]')
		And	OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartorderstaus]
GO

/*
Execute sp_pisi_eis_tpartorderstaus
*/

Create Procedure sp_pisi_eis_tpartorderstaus

As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@li_id			int,
	@ls_ApplyDate		char(10),
	@ls_AreaCode		char(1),
	@ls_DivisionCode		char(1),
	@ls_SupplierCode	char(5),
	@ls_ItemCode		varchar(12),
	@li_PartOrderQty		int,
	@li_PartForecastQty	int,
	@li_PartReceiptQty	int,
	@li_PartIncomeQty	int,
	@ls_LastEmp		varchar(6),
	@ldt_LastDate		datetime,
	@ls_today		char(10)

create table #tmp_tpartorderstaus
(	checkId			int IDENTITY(1,1),
	ApplyDate		char(10),
	AreaCode		char(1),
	DivisionCode		char(1),
	SupplierCode		char(5),
	ItemCode		varchar(12),
	PartOrderQty		int,
	PartForecastQty		int,
	PartReceiptQty		int,
	PartIncomeQty		int,
	LastEmp			varchar(6),
	LastDate			datetime	)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tpartorderstaus
select	*
from	[ipisele_svr\ipis].ipis.dbo.tpartorderstaus
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_ApplyDate		= ApplyDate,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ItemCode		= ItemCode,
		@li_PartOrderQty		= PartOrderQty,
		@li_PartForecastQty	= PartForecastQty,
		@li_PartReceiptQty	= PartReceiptQty,
		@li_PartIncomeQty	= PartIncomeQty,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tpartorderstaus
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tpartorderstaus
			where	ApplyDate	= @ls_ApplyDate
			and	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ItemCode	= @ls_ItemCode)

		insert into	tpartorderstaus
			(ApplyDate,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		PartOrderQty,		PartForecastQty,		PartReceiptQty,
			PartIncomeQty,		LastEmp)
		values	(@ls_ApplyDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,
			@ls_ItemCode,		@li_PartOrderQty,		@li_PartForecastQty,	@li_PartReceiptQty,
			@li_PartIncomeQty,	@ls_LastEmp)
	Else
		update	tpartorderstaus
		set	PartOrderQty		= @li_PartOrderQty,
			PartForecastQty		= @li_PartForecastQty,
			PartReceiptQty		= @li_PartReceiptQty,
			PartIncomeQty		= @li_PartIncomeQty
		where	ApplyDate		= @ls_ApplyDate
		and	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ItemCode		= @ls_ItemCode

	update	[ipisele_svr\ipis].ipis.dbo.tpartorderstaus
	set	lastemp 	= 'N'
	where	ApplyDate	= @ls_ApplyDate
	and	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ItemCode	= @ls_ItemCode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartorderstaus


-- 대구기계

Insert	into	#tmp_tpartorderstaus
select	*
from	[ipismac_svr\ipis].ipis.dbo.tpartorderstaus
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_ApplyDate		= ApplyDate,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ItemCode		= ItemCode,
		@li_PartOrderQty		= PartOrderQty,
		@li_PartForecastQty	= PartForecastQty,
		@li_PartReceiptQty	= PartReceiptQty,
		@li_PartIncomeQty	= PartIncomeQty,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tpartorderstaus
	Where	checkid > @li_id

	-- key chk
	If not exists (	select	*
			from	tpartorderstaus
			where	ApplyDate	= @ls_ApplyDate
			and	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ItemCode	= @ls_ItemCode)

		insert into tpartorderstaus
			(ApplyDate,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		PartOrderQty,		PartForecastQty,		PartReceiptQty,
			PartIncomeQty,		LastEmp)
		values	(@ls_ApplyDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,
			@ls_ItemCode,		@li_PartOrderQty,		@li_PartForecastQty,	@li_PartReceiptQty,
			@li_PartIncomeQty,	@ls_LastEmp)
	Else
		update	tpartorderstaus
		set	PartOrderQty		= @li_PartOrderQty,
			PartForecastQty		= @li_PartForecastQty,
			PartReceiptQty		= @li_PartReceiptQty,
			PartIncomeQty		= @li_PartIncomeQty
		where	ApplyDate		= @ls_ApplyDate
		and	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ItemCode		= @ls_ItemCode
		
	update	[ipismac_svr\ipis].ipis.dbo.tpartorderstaus
	set	lastemp 	= 'N'
	where	ApplyDate	= @ls_ApplyDate
	and	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ItemCode	= @ls_ItemCode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartorderstaus


-- 대구압축

Insert	into	#tmp_tpartorderstaus
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tpartorderstaus
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_ApplyDate		= ApplyDate,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ItemCode		= ItemCode,
		@li_PartOrderQty		= PartOrderQty,
		@li_PartForecastQty	= PartForecastQty,
		@li_PartReceiptQty	= PartReceiptQty,
		@li_PartIncomeQty	= PartIncomeQty,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tpartorderstaus
	Where	checkid > @li_id

	-- key chk
	If not exists (select * from tpartorderstaus
			where	ApplyDate	= @ls_ApplyDate
			and	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ItemCode	= @ls_ItemCode)

		insert into tpartorderstaus
			(ApplyDate,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		PartOrderQty,		PartForecastQty,		PartReceiptQty,
			PartIncomeQty,		LastEmp)
		values	(@ls_ApplyDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,
			@ls_ItemCode,		@li_PartOrderQty,		@li_PartForecastQty,	@li_PartReceiptQty,
			@li_PartIncomeQty,	@ls_LastEmp)
	Else
		update	tpartorderstaus
		set	PartOrderQty		= @li_PartOrderQty,
			PartForecastQty		= @li_PartForecastQty,
			PartReceiptQty		= @li_PartReceiptQty,
			PartIncomeQty		= @li_PartIncomeQty
		where	ApplyDate		= @ls_ApplyDate
		and	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ItemCode		= @ls_ItemCode

	update	[ipishvac_svr\ipis].ipis.dbo.tpartorderstaus
	set	lastemp 		= 'N'
	where	ApplyDate	= @ls_ApplyDate
	and	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ItemCode	= @ls_ItemCode
	and	lastemp 		= 'Y'

End	-- while loop end

truncate table #tmp_tpartorderstaus


-- 진천

Insert	into	#tmp_tpartorderstaus
select	*
from	[ipisjin_svr].ipis.dbo.tpartorderstaus
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_ApplyDate		= ApplyDate,
		@ls_AreaCode		= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode	= SupplierCode,
		@ls_ItemCode		= ItemCode,
		@li_PartOrderQty		= PartOrderQty,
		@li_PartForecastQty	= PartForecastQty,
		@li_PartReceiptQty	= PartReceiptQty,
		@li_PartIncomeQty	= PartIncomeQty,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tpartorderstaus
	Where	checkid > @li_id

	-- key chk
	If not exists (select * from tpartorderstaus
			where	ApplyDate	= @ls_ApplyDate
			and	AreaCode	= @ls_AreaCode
			and	DivisionCode	= @ls_DivisionCode
			and	SupplierCode	= @ls_SupplierCode
			and	ItemCode	= @ls_ItemCode)

		insert into tpartorderstaus
			(ApplyDate,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		PartOrderQty,		PartForecastQty,		PartReceiptQty,
			PartIncomeQty,		LastEmp)
		values	(@ls_ApplyDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_SupplierCode,
			@ls_ItemCode,		@li_PartOrderQty,		@li_PartForecastQty,	@li_PartReceiptQty,
			@li_PartIncomeQty,	@ls_LastEmp)
	Else
		update	tpartorderstaus
		set	PartOrderQty		= @li_PartOrderQty,
			PartForecastQty		= @li_PartForecastQty,
			PartReceiptQty		= @li_PartReceiptQty,
			PartIncomeQty		= @li_PartIncomeQty
		where	ApplyDate		= @ls_ApplyDate
		and	AreaCode		= @ls_AreaCode
		and	DivisionCode		= @ls_DivisionCode
		and	SupplierCode		= @ls_SupplierCode
		and	ItemCode		= @ls_ItemCode

	update	[ipisjin_svr].ipis.dbo.tpartorderstaus
	set	lastemp 	= 'N'
	where	ApplyDate	= @ls_ApplyDate
	and	AreaCode	= @ls_AreaCode
	and	DivisionCode	= @ls_DivisionCode
	and	SupplierCode	= @ls_SupplierCode
	and	ItemCode	= @ls_ItemCode
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tpartorderstaus
 
End		-- Procedure End
Go
