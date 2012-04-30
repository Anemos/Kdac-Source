/*
	File Name	: sp_pisi_eis_tmstpartkbhis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstpartkbhis
	Description	: EIS Upload tmstpartkbhis
			  tmstpartkbhis
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstpartkbhis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstpartkbhis]
GO

/*
Execute sp_pisi_eis_tmstpartkbhis
*/

Create Procedure sp_pisi_eis_tmstpartkbhis

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_suppliercode	varchar(5),
	@ls_itemcode		varchar(12),
	@ls_applyfrom		char(10),
	@ls_applyto		char(10),
	@ls_parttype		char(1),
	@ls_changeflag		char(1),
	@ls_PartModelID		varchar(4),
	@ls_PartID		char(2),
	@ls_UseCenterGubun	char(1),
	@ls_UseCenter		varchar(5),
	@ls_CostGubun		char(1),
	@ls_RackQty		int,
	@ls_RackCode		char(5),
	@ls_StockGubun		char(1),
	@ls_ReceiptLocation	varchar(4),
	@ls_MailBoxNo		int,
	@ls_SafetyStock		numeric(3,1),
	@ls_UseFlag		char(1),
	@ls_AutoReorderFlag	char(1),
	@ls_KBUseFlag		char(1),
	@ls_ChangeDate		char(10),
	@ls_NormalKBSN		char(11),
	@ls_TempKBSN		char(11),
	@ls_PartKBPrintCount	int,
	@ls_PartKBActiveCount	int,
	@ls_PartKBPlanCount	int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmstpartkbhis
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	SupplierCode		char (5),
	ItemCode		varchar (12),
	ApplyFrom		char (10),
	ApplyTo			char (10),
	PartType		char (1),
	ChangeFlag		char (1),
	PartModelID		varchar (4),
	PartID			char (2),
	UseCenterGubun		char (1),
	UseCenter		varchar (5),
	CostGubun		char (1),
	RackQty			int,
	RackCode		char (5),
	StockGubun		char (1),
	ReceiptLocation		varchar (4),
	MailBoxNo		int,
	SafetyStock		numeric(3, 1),
	UseFlag			char(1),
	AutoReorderFlag		char(1),
	KBUseFlag		char(1),
	ChangeDate		char (10),
	NormalKBSN		char (11),
	TempKBSN		char (11),
	PartKBPrintCount	int,
	PartKBActiveCount	int,
	PartKBPlanCount		int,
	LastEmp		varchar(6),
	LastDate	datetime	)

-- 각 서버 tdelete에서 tablename이 tmstpartkbhis인 놈 정리하고...

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstpartkbhis
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstpartkbhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_parttype		= parttype,
		@ls_changeflag		= changeflag,
		@ls_PartModelID		= PartModelID,
		@ls_PartID		= PartID,
		@ls_UseCenterGubun	= UseCenterGubun,
		@ls_UseCenter		= UseCenter,
		@ls_CostGubun		= CostGubun,
		@ls_RackQty		= RackQty,
		@ls_RackCode		= RackCode,
		@ls_StockGubun		= StockGubun,
		@ls_ReceiptLocation	= ReceiptLocation,
		@ls_MailBoxNo		= MailBoxNo,
		@ls_SafetyStock		= SafetyStock,
		@ls_UseFlag		= UseFlag,
		@ls_AutoReorderFlag	= AutoReorderFlag,
		@ls_KBUseFlag		= KBUseFlag,
		@ls_ChangeDate		= ChangeDate,
		@ls_NormalKBSN		= NormalKBSN,
		@ls_TempKBSN		= TempKBSN,
		@ls_PartKBPrintCount	= PartKBPrintCount,
		@ls_PartKBActiveCount	= PartKBActiveCount,
		@ls_PartKBPlanCount	= PartKBPlanCount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartkbhis
	Where	checkid > @ls_id

	If not exists (select * from tmstpartkbhis 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ItemCode	= @ls_itemcode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartkbhis
			(AreaCode,		DivisionCode,		SupplierCode,	ItemCode,	ApplyFrom,
			ApplyTo,		PartType,		ChangeFlag,	PartModelID,	PartID,
			UseCenterGubun,		UseCenter,		CostGubun,	RackQty,	RackCode,
			StockGubun,		ReceiptLocation,	MailBoxNo,	SafetyStock,	UseFlag,
			AutoReorderFlag,	KBUseFlag,		ChangeDate,	NormalKBSN,	TempKBSN,
			PartKBPrintCount,	PartKBActiveCount,	PartKBPlanCount,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,@ls_ItemCode,	@ls_applyfrom,
			@ls_applyto,		@ls_PartType,		@ls_ChangeFlag,	@ls_PartModelID,@ls_PartID,
			@ls_UseCenterGubun,	@ls_UseCenter,		@ls_CostGubun,	@ls_RackQty,	@ls_RackCode,
			@ls_StockGubun,		@ls_ReceiptLocation,	@ls_MailBoxNo,	@ls_SafetyStock,@ls_UseFlag,
			@ls_AutoReorderFlag,	@ls_KBUseFlag,		@ls_ChangeDate,	@ls_NormalKBSN,	@ls_TempKBSN,
			@ls_PartKBPrintCount,	@ls_PartKBActiveCount,	@ls_PartKBPlanCount,	@ls_LastEmp)

	Else
		update	tmstpartkbhis
		set	ApplyTo			= @ls_applyto,
		        PartType		= @ls_parttype,		
		        ChangeFlag		= @ls_changeflag,		
		        PartModelID		= @ls_PartModelID,		
		        PartID			= @ls_PartID,		
		        UseCenterGubun		= @ls_UseCenterGubun,	
		        UseCenter		= @ls_UseCenter,		
		        CostGubun		= @ls_CostGubun,		
		        RackQty			= @ls_RackQty,		
		        RackCode		= @ls_RackCode,		
		        StockGubun		= @ls_StockGubun,		
		        ReceiptLocation		= @ls_ReceiptLocation,	
		        MailBoxNo		= @ls_MailBoxNo,		
		        SafetyStock		= @ls_SafetyStock,		
		        UseFlag			= @ls_UseFlag,		
		        AutoReorderFlag		= @ls_AutoReorderFlag,	
		        KBUseFlag		= @ls_KBUseFlag,		
		        ChangeDate		= @ls_ChangeDate,		
		        NormalKBSN		= @ls_NormalKBSN,		
		        TempKBSN		= @ls_TempKBSN,		
		        PartKBPrintCount	= @ls_PartKBPrintCount,	
		        PartKBActiveCount	= @ls_PartKBActiveCount,	
		        PartKBPlanCount		= @ls_PartKBPlanCount	
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ItemCode	= @ls_itemcode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipisele_svr\ipis].ipis.dbo.tmstpartkbhis
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ItemCode	= @ls_itemcode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartkbhis


-- 대구기계

Insert	into	#tmp_tmstpartkbhis
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstpartkbhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_parttype		= parttype,
		@ls_changeflag		= changeflag,
		@ls_PartModelID		= PartModelID,
		@ls_PartID		= PartID,
		@ls_UseCenterGubun	= UseCenterGubun,
		@ls_UseCenter		= UseCenter,
		@ls_CostGubun		= CostGubun,
		@ls_RackQty		= RackQty,
		@ls_RackCode		= RackCode,
		@ls_StockGubun		= StockGubun,
		@ls_ReceiptLocation	= ReceiptLocation,
		@ls_MailBoxNo		= MailBoxNo,
		@ls_SafetyStock		= SafetyStock,
		@ls_UseFlag		= UseFlag,
		@ls_AutoReorderFlag	= AutoReorderFlag,
		@ls_KBUseFlag		= KBUseFlag,
		@ls_ChangeDate		= ChangeDate,
		@ls_NormalKBSN		= NormalKBSN,
		@ls_TempKBSN		= TempKBSN,
		@ls_PartKBPrintCount	= PartKBPrintCount,
		@ls_PartKBActiveCount	= PartKBActiveCount,
		@ls_PartKBPlanCount	= PartKBPlanCount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartkbhis
	Where	checkid > @ls_id

	If not exists (select * from tmstpartkbhis 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ItemCode	= @ls_itemcode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartkbhis
			(AreaCode,		DivisionCode,		SupplierCode,	ItemCode,	ApplyFrom,
			ApplyTo,		PartType,		ChangeFlag,	PartModelID,	PartID,
			UseCenterGubun,		UseCenter,		CostGubun,	RackQty,	RackCode,
			StockGubun,		ReceiptLocation,	MailBoxNo,	SafetyStock,	UseFlag,
			AutoReorderFlag,	KBUseFlag,		ChangeDate,	NormalKBSN,	TempKBSN,
			PartKBPrintCount,	PartKBActiveCount,	PartKBPlanCount,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,@ls_ItemCode,	@ls_applyfrom,
			@ls_applyto,		@ls_PartType,		@ls_ChangeFlag,	@ls_PartModelID,@ls_PartID,
			@ls_UseCenterGubun,	@ls_UseCenter,		@ls_CostGubun,	@ls_RackQty,	@ls_RackCode,
			@ls_StockGubun,		@ls_ReceiptLocation,	@ls_MailBoxNo,	@ls_SafetyStock,@ls_UseFlag,
			@ls_AutoReorderFlag,	@ls_KBUseFlag,		@ls_ChangeDate,	@ls_NormalKBSN,	@ls_TempKBSN,
			@ls_PartKBPrintCount,	@ls_PartKBActiveCount,	@ls_PartKBPlanCount,	@ls_LastEmp)

	Else
		update	tmstpartkbhis
		set	ApplyTo			= @ls_applyto,
		        PartType		= @ls_parttype,		
		        ChangeFlag		= @ls_changeflag,		
		        PartModelID		= @ls_PartModelID,		
		        PartID			= @ls_PartID,		
		        UseCenterGubun		= @ls_UseCenterGubun,	
		        UseCenter		= @ls_UseCenter,		
		        CostGubun		= @ls_CostGubun,		
		        RackQty			= @ls_RackQty,		
		        RackCode		= @ls_RackCode,		
		        StockGubun		= @ls_StockGubun,		
		        ReceiptLocation		= @ls_ReceiptLocation,	
		        MailBoxNo		= @ls_MailBoxNo,		
		        SafetyStock		= @ls_SafetyStock,		
		        UseFlag			= @ls_UseFlag,		
		        AutoReorderFlag		= @ls_AutoReorderFlag,	
		        KBUseFlag		= @ls_KBUseFlag,		
		        ChangeDate		= @ls_ChangeDate,		
		        NormalKBSN		= @ls_NormalKBSN,		
		        TempKBSN		= @ls_TempKBSN,		
		        PartKBPrintCount	= @ls_PartKBPrintCount,	
		        PartKBActiveCount	= @ls_PartKBActiveCount,	
		        PartKBPlanCount		= @ls_PartKBPlanCount	
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ItemCode	= @ls_itemcode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipismac_svr\ipis].ipis.dbo.tmstpartkbhis
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ItemCode	= @ls_itemcode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartkbhis


-- 대구압축

Insert	into	#tmp_tmstpartkbhis
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstpartkbhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_parttype		= parttype,
		@ls_changeflag		= changeflag,
		@ls_PartModelID		= PartModelID,
		@ls_PartID		= PartID,
		@ls_UseCenterGubun	= UseCenterGubun,
		@ls_UseCenter		= UseCenter,
		@ls_CostGubun		= CostGubun,
		@ls_RackQty		= RackQty,
		@ls_RackCode		= RackCode,
		@ls_StockGubun		= StockGubun,
		@ls_ReceiptLocation	= ReceiptLocation,
		@ls_MailBoxNo		= MailBoxNo,
		@ls_SafetyStock		= SafetyStock,
		@ls_UseFlag		= UseFlag,
		@ls_AutoReorderFlag	= AutoReorderFlag,
		@ls_KBUseFlag		= KBUseFlag,
		@ls_ChangeDate		= ChangeDate,
		@ls_NormalKBSN		= NormalKBSN,
		@ls_TempKBSN		= TempKBSN,
		@ls_PartKBPrintCount	= PartKBPrintCount,
		@ls_PartKBActiveCount	= PartKBActiveCount,
		@ls_PartKBPlanCount	= PartKBPlanCount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartkbhis
	Where	checkid > @ls_id

	If not exists (select * from tmstpartkbhis 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ItemCode	= @ls_itemcode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartkbhis
			(AreaCode,		DivisionCode,		SupplierCode,	ItemCode,	ApplyFrom,
			ApplyTo,		PartType,		ChangeFlag,	PartModelID,	PartID,
			UseCenterGubun,		UseCenter,		CostGubun,	RackQty,	RackCode,
			StockGubun,		ReceiptLocation,	MailBoxNo,	SafetyStock,	UseFlag,
			AutoReorderFlag,	KBUseFlag,		ChangeDate,	NormalKBSN,	TempKBSN,
			PartKBPrintCount,	PartKBActiveCount,	PartKBPlanCount,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,@ls_ItemCode,	@ls_applyfrom,
			@ls_applyto,		@ls_PartType,		@ls_ChangeFlag,	@ls_PartModelID,@ls_PartID,
			@ls_UseCenterGubun,	@ls_UseCenter,		@ls_CostGubun,	@ls_RackQty,	@ls_RackCode,
			@ls_StockGubun,		@ls_ReceiptLocation,	@ls_MailBoxNo,	@ls_SafetyStock,@ls_UseFlag,
			@ls_AutoReorderFlag,	@ls_KBUseFlag,		@ls_ChangeDate,	@ls_NormalKBSN,	@ls_TempKBSN,
			@ls_PartKBPrintCount,	@ls_PartKBActiveCount,	@ls_PartKBPlanCount,	@ls_LastEmp)

	Else
		update	tmstpartkbhis
		set	ApplyTo			= @ls_applyto,
		        PartType		= @ls_parttype,		
		        ChangeFlag		= @ls_changeflag,		
		        PartModelID		= @ls_PartModelID,		
		        PartID			= @ls_PartID,		
		        UseCenterGubun		= @ls_UseCenterGubun,	
		        UseCenter		= @ls_UseCenter,		
		        CostGubun		= @ls_CostGubun,		
		        RackQty			= @ls_RackQty,		
		        RackCode		= @ls_RackCode,		
		        StockGubun		= @ls_StockGubun,		
		        ReceiptLocation		= @ls_ReceiptLocation,	
		        MailBoxNo		= @ls_MailBoxNo,		
		        SafetyStock		= @ls_SafetyStock,		
		        UseFlag			= @ls_UseFlag,		
		        AutoReorderFlag		= @ls_AutoReorderFlag,	
		        KBUseFlag		= @ls_KBUseFlag,		
		        ChangeDate		= @ls_ChangeDate,		
		        NormalKBSN		= @ls_NormalKBSN,		
		        TempKBSN		= @ls_TempKBSN,		
		        PartKBPrintCount	= @ls_PartKBPrintCount,	
		        PartKBActiveCount	= @ls_PartKBActiveCount,	
		        PartKBPlanCount		= @ls_PartKBPlanCount	
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ItemCode	= @ls_itemcode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipishvac_svr\ipis].ipis.dbo.tmstpartkbhis
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ItemCode	= @ls_itemcode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstpartkbhis


-- 진천

Insert	into	#tmp_tmstpartkbhis
select	*
from	[ipisjin_svr].ipis.dbo.tmstpartkbhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_suppliercode	= suppliercode,
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_applyto		= applyto,
		@ls_parttype		= parttype,
		@ls_changeflag		= changeflag,
		@ls_PartModelID		= PartModelID,
		@ls_PartID		= PartID,
		@ls_UseCenterGubun	= UseCenterGubun,
		@ls_UseCenter		= UseCenter,
		@ls_CostGubun		= CostGubun,
		@ls_RackQty		= RackQty,
		@ls_RackCode		= RackCode,
		@ls_StockGubun		= StockGubun,
		@ls_ReceiptLocation	= ReceiptLocation,
		@ls_MailBoxNo		= MailBoxNo,
		@ls_SafetyStock		= SafetyStock,
		@ls_UseFlag		= UseFlag,
		@ls_AutoReorderFlag	= AutoReorderFlag,
		@ls_KBUseFlag		= KBUseFlag,
		@ls_ChangeDate		= ChangeDate,
		@ls_NormalKBSN		= NormalKBSN,
		@ls_TempKBSN		= TempKBSN,
		@ls_PartKBPrintCount	= PartKBPrintCount,
		@ls_PartKBActiveCount	= PartKBActiveCount,
		@ls_PartKBPlanCount	= PartKBPlanCount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstpartkbhis
	Where	checkid > @ls_id

	If not exists (select * from tmstpartkbhis 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	SupplierCode	= @ls_suppliercode
			and	ItemCode	= @ls_itemcode
			and	ApplyFrom	= @ls_applyfrom)

		insert into tmstpartkbhis
			(AreaCode,		DivisionCode,		SupplierCode,	ItemCode,	ApplyFrom,
			ApplyTo,		PartType,		ChangeFlag,	PartModelID,	PartID,
			UseCenterGubun,		UseCenter,		CostGubun,	RackQty,	RackCode,
			StockGubun,		ReceiptLocation,	MailBoxNo,	SafetyStock,	UseFlag,
			AutoReorderFlag,	KBUseFlag,		ChangeDate,	NormalKBSN,	TempKBSN,
			PartKBPrintCount,	PartKBActiveCount,	PartKBPlanCount,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,@ls_ItemCode,	@ls_applyfrom,
			@ls_applyto,		@ls_PartType,		@ls_ChangeFlag,	@ls_PartModelID,@ls_PartID,
			@ls_UseCenterGubun,	@ls_UseCenter,		@ls_CostGubun,	@ls_RackQty,	@ls_RackCode,
			@ls_StockGubun,		@ls_ReceiptLocation,	@ls_MailBoxNo,	@ls_SafetyStock,@ls_UseFlag,
			@ls_AutoReorderFlag,	@ls_KBUseFlag,		@ls_ChangeDate,	@ls_NormalKBSN,	@ls_TempKBSN,
			@ls_PartKBPrintCount,	@ls_PartKBActiveCount,	@ls_PartKBPlanCount,	@ls_LastEmp)

	Else
		update	tmstpartkbhis
		set	ApplyTo			= @ls_applyto,
		        PartType		= @ls_parttype,		
		        ChangeFlag		= @ls_changeflag,		
		        PartModelID		= @ls_PartModelID,		
		        PartID			= @ls_PartID,		
		        UseCenterGubun		= @ls_UseCenterGubun,	
		        UseCenter		= @ls_UseCenter,		
		        CostGubun		= @ls_CostGubun,		
		        RackQty			= @ls_RackQty,		
		        RackCode		= @ls_RackCode,		
		        StockGubun		= @ls_StockGubun,		
		        ReceiptLocation		= @ls_ReceiptLocation,	
		        MailBoxNo		= @ls_MailBoxNo,		
		        SafetyStock		= @ls_SafetyStock,		
		        UseFlag			= @ls_UseFlag,		
		        AutoReorderFlag		= @ls_AutoReorderFlag,	
		        KBUseFlag		= @ls_KBUseFlag,		
		        ChangeDate		= @ls_ChangeDate,		
		        NormalKBSN		= @ls_NormalKBSN,		
		        TempKBSN		= @ls_TempKBSN,		
		        PartKBPrintCount	= @ls_PartKBPrintCount,	
		        PartKBActiveCount	= @ls_PartKBActiveCount,	
		        PartKBPlanCount		= @ls_PartKBPlanCount	
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	SupplierCode	= @ls_suppliercode
		and	ItemCode	= @ls_itemcode
		and	ApplyFrom	= @ls_applyfrom
                                        
	update	[ipisjin_svr].ipis.dbo.tmstpartkbhis
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	SupplierCode	= @ls_suppliercode
	and	ItemCode	= @ls_itemcode
	and	ApplyFrom	= @ls_applyfrom
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmstpartkbhis
 
End		-- Procedure End
Go
