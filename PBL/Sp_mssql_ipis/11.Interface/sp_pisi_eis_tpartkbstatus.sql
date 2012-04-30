/*
	File Name	: sp_pisi_eis_tpartkbstatus.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartkbstatus
	Description	: EIS Upload tpartkbstatus
			  tpartkbstatus
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartkbstatus]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartkbstatus]
GO

/*
Execute sp_pisi_eis_tpartkbstatus
*/

Create Procedure sp_pisi_eis_tpartkbstatus
	
As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@ls_id				int,
	@ls_PartKBNo			char (11),
	@ls_AreaCode			char (1),
	@ls_DivisionCode		char (1),
	@ls_SupplierCode		char (5),
	@ls_ItemCode			varchar (12),
	@ls_ApplyFrom			char (10),
	@ls_PartType			char (1),
	@ls_RePrintFlag			char(1),
	@ls_RePrintCount		int,
	@ls_PartKBGubun			char (1),
	@ls_KBActiveGubun		char (1),
	@ls_PartKBStatus		char (1),
	@ls_KBOrderPossible		char(1),
	@ls_RackQty			int,
	@ls_OrderChangeFlag		char(1),
	@ls_PartOrderCancel		char(1),
	@ls_PartReceiptCancel		char(1),
	@ls_UseCenterGubun		char (1),
	@ls_UseCenter			varchar (5),
	@ls_PartObeyDateFlag		int,
	@ls_PartObeyTimeFlag		int,
	@ls_PartOrderDate		char (10),
	@ls_PartOrderTime		datetime,
	@ls_PartForecastDate		char (10),
	@ls_PartForecastEditNo		int,
	@ls_PartForecastTime		datetime,
	@ls_PartReceiptDate		char (10),
	@ls_PartEditNo			int,
	@ls_PartReceiptTime		datetime,
	@ls_PartIncomeDate		char (10),
	@ls_PartIncomeTime		datetime,
	@ls_PartOrderNo			char (12),
	@ls_DeliveryNo			char (12),
	@ls_BuyBackNo			char (11),
	@ls_PartKBCreateDate		datetime,	
	@ls_PartKBPrintDate		datetime,
	@ls_OrderChangeTime		datetime,
	@ls_OrderChangeCode		varchar (4),
	@ls_ChangeForecastDate		char (10),
	@ls_ChangeForecastEditNo	int,
	@ls_ChangeForecastTime		datetime,
	@ls_OrderSeq			varchar (10),
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tpartkbstatus
(	checkId			int IDENTITY(1,1),
	PartKBNo		char (11),
	AreaCode		char (1),
	DivisionCode		char (1),
	SupplierCode		char (5),
	ItemCode		varchar (12),
	ApplyFrom		char (10),
	PartType		char (1),
	RePrintFlag		char(1),
	RePrintCount		int,
	PartKBGubun		char (1),
	KBActiveGubun		char (1),
	PartKBStatus		char (1),
	KBOrderPossible		char(1),
	RackQty			int,
	OrderChangeFlag		char(1),
	PartOrderCancel		char(1),
	PartReceiptCancel	char(1),
	UseCenterGubun		char (1),
	UseCenter		varchar (5),
	PartObeyDateFlag	int,
	PartObeyTimeFlag	int,
	PartOrderDate		char (10),
	PartOrderTime		datetime,
	PartForecastDate	char (10),
	PartForecastEditNo	int,
	PartForecastTime	datetime,
	PartReceiptDate		char (10),
	PartEditNo		int,
	PartReceiptTime		datetime,
	PartIncomeDate		char(10),
	PartIncomeTime		datetime,
	PartOrderNo		char (12),
	DeliveryNo		char (12),
	BuyBackNo		char (11),
	PartKBCreateDate	datetime,
	PartKBPrintDate		datetime,
	OrderChangeTime		datetime,
	OrderChangeCode		varchar (4),
	ChangeForecastDate	char (10),
	ChangeForecastEditNo	int,
	ChangeForecastTime	datetime,
	OrderSeq		varchar (10),
	LastEmp			varchar(6),
	LastDate		datetime	)

-- 각 서버 tdelete에서 tablename이 tpartkbstatus인 놈 정리하고...

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tpartkbstatus
select	*
from	[ipisele_svr\ipis].ipis.dbo.tpartkbstatus
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_PartKBNo			= PartKBNo,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode		= SupplierCode,
		@ls_ItemCode			= ItemCode,
		@ls_ApplyFrom			= ApplyFrom,			 
		@ls_PartType			= PartType,			 
		@ls_RePrintFlag			= RePrintFlag,			 
		@ls_RePrintCount		= RePrintCount,		 
		@ls_PartKBGubun			= PartKBGubun,
		@ls_KBActiveGubun		= KBActiveGubun,		 
		@ls_PartKBStatus		= PartKBStatus,		 
		@ls_KBOrderPossible		= KBOrderPossible,		 
		@ls_RackQty			= RackQty,			 
		@ls_OrderChangeFlag		= OrderChangeFlag,		 
		@ls_PartOrderCancel		= PartOrderCancel,		 
		@ls_PartReceiptCancel		= PartReceiptCancel,		 
		@ls_UseCenterGubun		= UseCenterGubun,		 
		@ls_UseCenter			= UseCenter,			 
		@ls_PartObeyDateFlag		= PartObeyDateFlag,		 
		@ls_PartObeyTimeFlag		= PartObeyTimeFlag,		 
		@ls_PartOrderDate		= PartOrderDate,		 
		@ls_PartOrderTime		= PartOrderTime,		 
		@ls_PartForecastDate		= PartForecastDate,		 
		@ls_PartForecastEditNo		= PartForecastEditNo,		 
		@ls_PartForecastTime		= PartForecastTime,		 
		@ls_PartReceiptDate		= PartReceiptDate,		 
		@ls_PartEditNo			= PartEditNo,			 
		@ls_PartReceiptTime		= PartReceiptTime,		 
		@ls_PartIncomeDate		= PartIncomeDate,		 
		@ls_PartIncomeTime		= PartIncomeTime,		 
		@ls_PartOrderNo			= PartOrderNo,			 
		@ls_DeliveryNo			= DeliveryNo,			 
		@ls_BuyBackNo			= BuyBackNo,			 
		@ls_PartKBCreateDate		= PartKBCreateDate,		
		@ls_PartKBPrintDate		= PartKBPrintDate,		 
		@ls_OrderChangeTime		= OrderChangeTime,		 
		@ls_OrderChangeCode		= OrderChangeCode,		 
		@ls_ChangeForecastDate		= ChangeForecastDate,		 
		@ls_ChangeForecastEditNo	= ChangeForecastEditNo,	 
		@ls_ChangeForecastTime		= ChangeForecastTime,		 
		@ls_OrderSeq			= OrderSeq,			 
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tpartkbstatus
	Where	checkid > @ls_id

	If not exists (select * from tpartkbstatus 
			where	PartKBNO	= @ls_partkbno)

		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)

	Else
		begin
		
		delete	from tpartkbstatus 
		where	PartKBNO	= @ls_partkbno
		
		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)
		
		end
		                        
	update	[ipisele_svr\ipis].ipis.dbo.tpartkbstatus
	set	lastemp 	= 'N'
	where	PartKBNO	= @ls_partkbno
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartkbstatus


-- 대구기계

Insert	into	#tmp_tpartkbstatus
select	*
from	[ipismac_svr\ipis].ipis.dbo.tpartkbstatus
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_PartKBNo			= PartKBNo,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode		= SupplierCode,
		@ls_ItemCode			= ItemCode,
		@ls_ApplyFrom			= ApplyFrom,			 
		@ls_PartType			= PartType,			 
		@ls_RePrintFlag			= RePrintFlag,			 
		@ls_RePrintCount		= RePrintCount,		 
		@ls_PartKBGubun			= PartKBGubun,
		@ls_KBActiveGubun		= KBActiveGubun,		 
		@ls_PartKBStatus		= PartKBStatus,		 
		@ls_KBOrderPossible		= KBOrderPossible,		 
		@ls_RackQty			= RackQty,			 
		@ls_OrderChangeFlag		= OrderChangeFlag,		 
		@ls_PartOrderCancel		= PartOrderCancel,		 
		@ls_PartReceiptCancel		= PartReceiptCancel,		 
		@ls_UseCenterGubun		= UseCenterGubun,		 
		@ls_UseCenter			= UseCenter,			 
		@ls_PartObeyDateFlag		= PartObeyDateFlag,		 
		@ls_PartObeyTimeFlag		= PartObeyTimeFlag,		 
		@ls_PartOrderDate		= PartOrderDate,		 
		@ls_PartOrderTime		= PartOrderTime,		 
		@ls_PartForecastDate		= PartForecastDate,		 
		@ls_PartForecastEditNo		= PartForecastEditNo,		 
		@ls_PartForecastTime		= PartForecastTime,		 
		@ls_PartReceiptDate		= PartReceiptDate,		 
		@ls_PartEditNo			= PartEditNo,			 
		@ls_PartReceiptTime		= PartReceiptTime,		 
		@ls_PartIncomeDate		= PartIncomeDate,		 
		@ls_PartIncomeTime		= PartIncomeTime,		 
		@ls_PartOrderNo			= PartOrderNo,			 
		@ls_DeliveryNo			= DeliveryNo,			 
		@ls_BuyBackNo			= BuyBackNo,			 
		@ls_PartKBCreateDate		= PartKBCreateDate,		
		@ls_PartKBPrintDate		= PartKBPrintDate,		 
		@ls_OrderChangeTime		= OrderChangeTime,		 
		@ls_OrderChangeCode		= OrderChangeCode,		 
		@ls_ChangeForecastDate		= ChangeForecastDate,		 
		@ls_ChangeForecastEditNo	= ChangeForecastEditNo,	 
		@ls_ChangeForecastTime		= ChangeForecastTime,		 
		@ls_OrderSeq			= OrderSeq,			 
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tpartkbstatus
	Where	checkid > @ls_id

	If not exists (select * from tpartkbstatus 
			where	PartKBNO	= @ls_partkbno)

		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)

	Else
		begin
		
		delete	from tpartkbstatus 
		where	PartKBNO	= @ls_partkbno
		
		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)
		
		end
		                        
	update	[ipismac_svr\ipis].ipis.dbo.tpartkbstatus
	set	lastemp 	= 'N'
	where	PartKBNO	= @ls_partkbno
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartkbstatus


-- 대구압축

Insert	into	#tmp_tpartkbstatus
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tpartkbstatus
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_PartKBNo			= PartKBNo,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode		= SupplierCode,
		@ls_ItemCode			= ItemCode,
		@ls_ApplyFrom			= ApplyFrom,			 
		@ls_PartType			= PartType,			 
		@ls_RePrintFlag			= RePrintFlag,			 
		@ls_RePrintCount		= RePrintCount,		 
		@ls_PartKBGubun			= PartKBGubun,
		@ls_KBActiveGubun		= KBActiveGubun,		 
		@ls_PartKBStatus		= PartKBStatus,		 
		@ls_KBOrderPossible		= KBOrderPossible,		 
		@ls_RackQty			= RackQty,			 
		@ls_OrderChangeFlag		= OrderChangeFlag,		 
		@ls_PartOrderCancel		= PartOrderCancel,		 
		@ls_PartReceiptCancel		= PartReceiptCancel,		 
		@ls_UseCenterGubun		= UseCenterGubun,		 
		@ls_UseCenter			= UseCenter,			 
		@ls_PartObeyDateFlag		= PartObeyDateFlag,		 
		@ls_PartObeyTimeFlag		= PartObeyTimeFlag,		 
		@ls_PartOrderDate		= PartOrderDate,		 
		@ls_PartOrderTime		= PartOrderTime,		 
		@ls_PartForecastDate		= PartForecastDate,		 
		@ls_PartForecastEditNo		= PartForecastEditNo,		 
		@ls_PartForecastTime		= PartForecastTime,		 
		@ls_PartReceiptDate		= PartReceiptDate,		 
		@ls_PartEditNo			= PartEditNo,			 
		@ls_PartReceiptTime		= PartReceiptTime,		 
		@ls_PartIncomeDate		= PartIncomeDate,		 
		@ls_PartIncomeTime		= PartIncomeTime,		 
		@ls_PartOrderNo			= PartOrderNo,			 
		@ls_DeliveryNo			= DeliveryNo,			 
		@ls_BuyBackNo			= BuyBackNo,			 
		@ls_PartKBCreateDate		= PartKBCreateDate,		
		@ls_PartKBPrintDate		= PartKBPrintDate,		 
		@ls_OrderChangeTime		= OrderChangeTime,		 
		@ls_OrderChangeCode		= OrderChangeCode,		 
		@ls_ChangeForecastDate		= ChangeForecastDate,		 
		@ls_ChangeForecastEditNo	= ChangeForecastEditNo,	 
		@ls_ChangeForecastTime		= ChangeForecastTime,		 
		@ls_OrderSeq			= OrderSeq,			 
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tpartkbstatus
	Where	checkid > @ls_id

	If not exists (select * from tpartkbstatus 
			where	PartKBNO	= @ls_partkbno)

		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)

	Else
		begin
		
		delete	from tpartkbstatus 
		where	PartKBNO	= @ls_partkbno
		
		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)
		
		end
		                        
	update	[ipishvac_svr\ipis].ipis.dbo.tpartkbstatus
	set	lastemp 	= 'N'
	where	PartKBNO	= @ls_partkbno
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartkbstatus


-- 진천

Insert	into	#tmp_tpartkbstatus
select	*
from	[ipisjin_svr].ipis.dbo.tpartkbstatus
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_PartKBNo			= PartKBNo,
		@ls_AreaCode			= AreaCode,
		@ls_DivisionCode		= DivisionCode,
		@ls_SupplierCode		= SupplierCode,
		@ls_ItemCode			= ItemCode,
		@ls_ApplyFrom			= ApplyFrom,			 
		@ls_PartType			= PartType,			 
		@ls_RePrintFlag			= RePrintFlag,			 
		@ls_RePrintCount		= RePrintCount,		 
		@ls_PartKBGubun			= PartKBGubun,
		@ls_KBActiveGubun		= KBActiveGubun,		 
		@ls_PartKBStatus		= PartKBStatus,		 
		@ls_KBOrderPossible		= KBOrderPossible,		 
		@ls_RackQty			= RackQty,			 
		@ls_OrderChangeFlag		= OrderChangeFlag,		 
		@ls_PartOrderCancel		= PartOrderCancel,		 
		@ls_PartReceiptCancel		= PartReceiptCancel,		 
		@ls_UseCenterGubun		= UseCenterGubun,		 
		@ls_UseCenter			= UseCenter,			 
		@ls_PartObeyDateFlag		= PartObeyDateFlag,		 
		@ls_PartObeyTimeFlag		= PartObeyTimeFlag,		 
		@ls_PartOrderDate		= PartOrderDate,		 
		@ls_PartOrderTime		= PartOrderTime,		 
		@ls_PartForecastDate		= PartForecastDate,		 
		@ls_PartForecastEditNo		= PartForecastEditNo,		 
		@ls_PartForecastTime		= PartForecastTime,		 
		@ls_PartReceiptDate		= PartReceiptDate,		 
		@ls_PartEditNo			= PartEditNo,			 
		@ls_PartReceiptTime		= PartReceiptTime,		 
		@ls_PartIncomeDate		= PartIncomeDate,		 
		@ls_PartIncomeTime		= PartIncomeTime,		 
		@ls_PartOrderNo			= PartOrderNo,			 
		@ls_DeliveryNo			= DeliveryNo,			 
		@ls_BuyBackNo			= BuyBackNo,			 
		@ls_PartKBCreateDate		= PartKBCreateDate,		
		@ls_PartKBPrintDate		= PartKBPrintDate,		 
		@ls_OrderChangeTime		= OrderChangeTime,		 
		@ls_OrderChangeCode		= OrderChangeCode,		 
		@ls_ChangeForecastDate		= ChangeForecastDate,		 
		@ls_ChangeForecastEditNo	= ChangeForecastEditNo,	 
		@ls_ChangeForecastTime		= ChangeForecastTime,		 
		@ls_OrderSeq			= OrderSeq,			 
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tpartkbstatus
	Where	checkid > @ls_id

	If not exists (select * from tpartkbstatus 
			where	PartKBNO	= @ls_partkbno)

		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)

	Else
		begin
		
		delete	from tpartkbstatus 
		where	PartKBNO	= @ls_partkbno
		
		insert into tpartkbstatus
			(PartKBNo,		AreaCode,		DivisionCode,		SupplierCode,
			ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,
			KBOrderPossible,	RackQty,		OrderChangeFlag,	PartOrderCancel,
			PartReceiptCancel,	UseCenterGubun,		UseCenter,		PartObeyDateFlag,
			PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,		PartForecastDate,
			PartForecastEditNo,	PartForecastTime,	PartReceiptDate,	PartEditNo,
			PartReceiptTime,	PartIncomeDate,		PartIncomeTime,		PartOrderNo,
			DeliveryNo,		BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,
			OrderChangeTime,	OrderChangeCode,	ChangeForecastDate,	ChangeForecastEditNo,
			ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_AreaCode,		@ls_DivisionCode,	@ls_suppliercode,
			@ls_itemcode,		@ls_applyfrom,		@ls_PartType,		@ls_RePrintFlag,
			@ls_RePrintCount,	@ls_PartKBGubun,	@ls_KBActiveGubun,	@ls_PartKBStatus,
			@ls_KBOrderPossible,	@ls_RackQty,		@ls_OrderChangeFlag,	@ls_PartOrderCancel,
			@ls_PartReceiptCancel,	@ls_UseCenterGubun,	@ls_UseCenter,		@ls_PartObeyDateFlag,
			@ls_PartObeyTimeFlag,	@ls_PartOrderDate,	@ls_PartOrderTime,	@ls_PartForecastDate,
			@ls_PartForecastEditNo,	@ls_PartForecastTime,	@ls_PartReceiptDate,	@ls_PartEditNo,
			@ls_PartReceiptTime,	@ls_PartIncomeDate,	@ls_PartIncomeTime,	@ls_PartOrderNo,
			@ls_DeliveryNo,		@ls_BuyBackNo,		@ls_PartKBCreateDate,	@ls_PartKBPrintDate,
			@ls_OrderChangeTime,	@ls_OrderChangeCode,	@ls_ChangeForecastDate,	@ls_ChangeForecastEditNo,
			@ls_ChangeForecastTime,	@ls_OrderSeq,		@ls_LastEmp)
		
		end
		                        
	update	[ipisjin_svr].ipis.dbo.tpartkbstatus
	set	lastemp 	= 'N'
	where	PartKBNO	= @ls_partkbno
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tpartkbstatus
 
End		-- Procedure End
Go
