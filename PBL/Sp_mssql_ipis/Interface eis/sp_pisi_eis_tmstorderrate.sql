/*
	File Name	: sp_pisi_eis_tmstorderrate.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstorderrate
	Description	: EIS Upload tmstorderrate
			  tmstorderrate
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstorderrate]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstorderrate]
GO

/*
Execute sp_pisi_eis_tmstorderrate
*/

Create Procedure sp_pisi_eis_tmstorderrate
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_itemcode		varchar(12),
	@ls_suppliercode	varchar(5),
	@ls_orderrate		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmstorderrate
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	ItemCode		varchar (12),
	SupplierCode		char (5),
	OrderRate		int,
	LastEmp			varchar(6),
	LastDate		datetime	)

-- 각 서버 tdelete에서 tablename이 tmstorderrate인 놈 정리하고...

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstorderrate
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstorderrate
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_suppliercode	= suppliercode,
		@ls_orderrate		= orderrate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstorderrate
	Where	checkid > @ls_id

	If not exists (select * from tmstorderrate 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode
			and	SupplierCode	= @ls_suppliercode)

		insert into tmstorderrate
			(AreaCode,		DivisionCode,		ItemCode,	SupplierCode,
			OrderRate,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_itemcode,	@ls_suppliercode,
			@ls_orderrate,		@ls_LastEmp)

	Else
		update	tmstorderrate
		set	orderrate	= @ls_orderrate
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		and	SupplierCode	= @ls_suppliercode
		                        
	update	[ipisele_svr\ipis].ipis.dbo.tmstorderrate
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	SupplierCode	= @ls_suppliercode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstorderrate


-- 대구기계

Insert	into	#tmp_tmstorderrate
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstorderrate
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_suppliercode	= suppliercode,
		@ls_orderrate		= orderrate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstorderrate
	Where	checkid > @ls_id

	If not exists (select * from tmstorderrate 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode
			and	SupplierCode	= @ls_suppliercode)

		insert into tmstorderrate
			(AreaCode,		DivisionCode,		ItemCode,	SupplierCode,
			OrderRate,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_itemcode,	@ls_suppliercode,
			@ls_orderrate,		@ls_LastEmp)

	Else
		update	tmstorderrate
		set	orderrate	= @ls_orderrate
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		and	SupplierCode	= @ls_suppliercode
		                        
	update	[ipismac_svr\ipis].ipis.dbo.tmstorderrate
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	SupplierCode	= @ls_suppliercode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstorderrate


-- 대구압축

Insert	into	#tmp_tmstorderrate
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstorderrate
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_suppliercode	= suppliercode,
		@ls_orderrate		= orderrate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstorderrate
	Where	checkid > @ls_id

	If not exists (select * from tmstorderrate 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode
			and	SupplierCode	= @ls_suppliercode)

		insert into tmstorderrate
			(AreaCode,		DivisionCode,		ItemCode,	SupplierCode,
			OrderRate,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_itemcode,	@ls_suppliercode,
			@ls_orderrate,		@ls_LastEmp)

	Else
		update	tmstorderrate
		set	orderrate	= @ls_orderrate
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		and	SupplierCode	= @ls_suppliercode
		                        
	update	[ipishvac_svr\ipis].ipis.dbo.tmstorderrate
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	SupplierCode	= @ls_suppliercode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstorderrate


-- 진천

Insert	into	#tmp_tmstorderrate
select	*
from	[ipisjin_svr].ipis.dbo.tmstorderrate
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_suppliercode	= suppliercode,
		@ls_orderrate		= orderrate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstorderrate
	Where	checkid > @ls_id

	If not exists (select * from tmstorderrate 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode
			and	SupplierCode	= @ls_suppliercode)

		insert into tmstorderrate
			(AreaCode,		DivisionCode,		ItemCode,	SupplierCode,
			OrderRate,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_itemcode,	@ls_suppliercode,
			@ls_orderrate,		@ls_LastEmp)

	Else
		update	tmstorderrate
		set	orderrate	= @ls_orderrate
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		and	SupplierCode	= @ls_suppliercode
		                        
	update	[ipisjin_svr].ipis.dbo.tmstorderrate
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	SupplierCode	= @ls_suppliercode
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmstorderrate
 
End		-- Procedure End
Go
