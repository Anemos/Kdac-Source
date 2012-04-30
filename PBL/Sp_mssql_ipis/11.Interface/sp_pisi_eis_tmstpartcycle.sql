/*
	File Name	: sp_pisi_eis_tmstpartcycle.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstpartcycle
	Description	: EIS Upload tmstpartcycle
			  tmstpartcycle
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstpartcycle]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstpartcycle]
GO

/*
Execute sp_pisi_eis_tmstpartcycle
*/

Create Procedure sp_pisi_eis_tmstpartcycle

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_suppliercode	varchar(5),
	@ls_applyfrom		char(10),
	@ls_applyto		char(10),
	@ls_SupplyTerm		int,
	@ls_SupplyEditNo	int,
	@ls_SupplyCycle		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmstpartcycle
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	SupplierCode		char (5),
	ApplyFrom		char (10),
	ApplyTo			char (10),
	SupplyTerm		int,
	SupplyEditNo		int,
	SupplyCycle		int,
	LastEmp			varchar(6),
	LastDate		datetime	)

-- 각 서버 tdelete에서 tablename이 tmstpartcycle인 놈 정리하고...

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstpartcycle
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstpartcycle
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_SupplyTerm		= supplyterm,
		@ls_SupplyEditNo	= supplyeditno,
		@ls_SupplyCycle		= supplycycle,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartcycle
	Where	checkid > @ls_id

	If not exists (select * from tmstpartcycle 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartcycle
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			ApplyTo,		supplyterm,		supplyeditno,		supplycycle,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,	@ls_applyfrom,
			@ls_applyto,		@ls_supplyterm,		@ls_supplyeditno,	@ls_supplycycle,
			@ls_LastEmp)

	Else
		update	tmstpartcycle
		set	ApplyTo			= @ls_applyto,
		        supplyterm		= @ls_supplyterm,
		        supplyeditno		= @ls_supplyeditno,
		        supplycycle		= @ls_supplycycle
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipisele_svr\ipis].ipis.dbo.tmstpartcycle
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartcycle


-- 대구기계

Insert	into	#tmp_tmstpartcycle
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstpartcycle
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_SupplyTerm		= supplyterm,
		@ls_SupplyEditNo	= supplyeditno,
		@ls_SupplyCycle		= supplycycle,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartcycle
	Where	checkid > @ls_id

	If not exists (select * from tmstpartcycle 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartcycle
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			ApplyTo,		supplyterm,		supplyeditno,		supplycycle,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,	@ls_applyfrom,
			@ls_applyto,		@ls_supplyterm,		@ls_supplyeditno,	@ls_supplycycle,
			@ls_LastEmp)

	Else
		update	tmstpartcycle
		set	ApplyTo			= @ls_applyto,
		        supplyterm		= @ls_supplyterm,
		        supplyeditno		= @ls_supplyeditno,
		        supplycycle		= @ls_supplycycle
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipismac_svr\ipis].ipis.dbo.tmstpartcycle
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartcycle


-- 대구압축

Insert	into	#tmp_tmstpartcycle
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstpartcycle
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_SupplyTerm		= supplyterm,
		@ls_SupplyEditNo	= supplyeditno,
		@ls_SupplyCycle		= supplycycle,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartcycle
	Where	checkid > @ls_id

	If not exists (select * from tmstpartcycle 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartcycle
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			ApplyTo,		supplyterm,		supplyeditno,		supplycycle,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,	@ls_applyfrom,
			@ls_applyto,		@ls_supplyterm,		@ls_supplyeditno,	@ls_supplycycle,
			@ls_LastEmp)

	Else
		update	tmstpartcycle
		set	ApplyTo			= @ls_applyto,
		        supplyterm		= @ls_supplyterm,
		        supplyeditno		= @ls_supplyeditno,
		        supplycycle		= @ls_supplycycle
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipishvac_svr\ipis].ipis.dbo.tmstpartcycle
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartcycle


-- 진천

Insert	into	#tmp_tmstpartcycle
select	*
from	[ipisjin_svr].ipis.dbo.tmstpartcycle
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_SupplyTerm		= supplyterm,
		@ls_SupplyEditNo	= supplyeditno,
		@ls_SupplyCycle		= supplycycle,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartcycle
	Where	checkid > @ls_id

	If not exists (select * from tmstpartcycle 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartcycle
			(AreaCode,		DivisionCode,		SupplierCode,		ApplyFrom,
			ApplyTo,		supplyterm,		supplyeditno,		supplycycle,
			LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,	@ls_applyfrom,
			@ls_applyto,		@ls_supplyterm,		@ls_supplyeditno,	@ls_supplycycle,
			@ls_LastEmp)

	Else
		update	tmstpartcycle
		set	ApplyTo			= @ls_applyto,
		        supplyterm		= @ls_supplyterm,
		        supplyeditno		= @ls_supplyeditno,
		        supplycycle		= @ls_supplycycle
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipisjin_svr].ipis.dbo.tmstpartcycle
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmstpartcycle
 
End		-- Procedure End
Go
