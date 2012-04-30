/*
	File Name	: sp_pisi_eis_tpartkbhis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartkbhis
	Description	: EIS Upload tpartkbhis
			  tpartkbhis
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 12. 23
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartkbhis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartkbhis]
GO

/*
Execute sp_pisi_eis_tpartkbhis
*/

Create Procedure sp_pisi_eis_tpartkbhis

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_partkbno			char(11),
	@ls_applydate			char(10),
	@li_partorderseq			int,
	@ls_areacode			char(1),
	@ls_divisioncode			char(1),
	@ls_suppliercode		char(5),
	@ls_itemcode			varchar(12),
	@ls_applyfrom			char(10),
	@ls_parttype			char(1),
	@ls_reprintflag			char(1),
	@li_reprintcount			int,
	@ls_partkbgubun			char(1),
	@ls_kbactivegubun		char(1),
	@ls_partkbstatus			char(1),
	@ls_kborderpossible		char(1),
	@li_rackqty			int,
	@ls_orderchangeflag		char(1),
	@ls_partordercancel		char(1),
	@ls_partreceiptcancel		char(1),
	@ls_usecentergubun		char(1),
	@ls_usecenter			varchar(5),
	@lbt_partobeydateflag		int,
	@lbt_partobeytimeflag		int,
	@ls_partorderdate		char(10),
	@ldt_partordertime		datetime,
	@ls_partforecastdate		char(10),
	@li_partforecasteditno		int,
	@ldt_partforecasttime		datetime,
	@ls_partreceiptdate		char(10),
	@li_parteditno			int,
	@ldt_partreceipttime		datetime,
	@ls_partincomedate		char(10),
	@ldt_partincometime		datetime,
	@ls_partorderno			char(12),
	@ls_deliveryno			char(12),
	@ls_buybackno			char(11),
	@ldt_partkbcreatedate		datetime,
	@ldt_partkbprintdate		datetime,
	@ldt_orderchangetime		datetime,
	@ls_orderchangecode		varchar(4),
	@ls_changeforecastdate		char(10),
	@li_changeforecasteditno		int,
	@ldt_changeforecasttime		datetime,
	@ls_orderseq			varchar(10),
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_today			char(10)

create table #tmp_tpartkbhis
(	checkId				int IDENTITY(1,1),
	PartKBNo			char(11),
	ApplyDate			char(10),
	PartOrderSeq			int,
	AreaCode			char(1),
	DivisionCode			char(1),
	SupplierCode			char(5),
	ItemCode			varchar(12),
	ApplyFrom			char(10),
	PartType			char(1),
	RePrintFlag			char(1),
	RePrintCount			int,
	PartKBGubun			char(1),
	KBActiveGubun			char(1),
	PartKBStatus			char(1),
	KBOrderPossible			char(1),
	RackQty				int,
	OrderChangeFlag			char(1),
	PartOrderCancel			char(1),
	PartReceiptCancel		char(1),
	UseCenterGubun			char(1),
	UseCenter			varchar(5),
	PartObeyDateFlag		int,
	PartObeyTimeFlag		int,
	PartOrderDate			char(10),
	PartOrderTime			datetime,
	PartForecastDate			char(10),
	PartForecastEditNo		int,
	PartForecastTime			datetime,
	PartReceiptDate			char(10),
	PartEditNo			int,
	PartReceiptTime			datetime,
	PartIncomeDate			char(10),
	PartIncomeTime			datetime,
	PartOrderNo			char(12),
	DeliveryNo			char(12),
	BuyBackNo			char(11),
	PartKBCreateDate			datetime,
	PartKBPrintDate			datetime,
	OrderChangeTime		datetime,
	OrderChangeCode		varchar(4),
	ChangeForecastDate		char(10),
	ChangeForecastEditNo		int,
	ChangeForecastTime		datetime,
	OrderSeq			varchar(10),
	LastEmp				varchar(6),
	LastDate				datetime	)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tpartkbhis
select	*
from	[ipisele_svr\ipis].ipis.dbo.tpartkbhis
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_partkbno			= PartKBNo,
		@ls_applydate			= ApplyDate,
		@li_partorderseq			= PartOrderSeq,
		@ls_areacode			= AreaCode,
		@ls_divisioncode			= DivisionCode,
		@ls_suppliercode		= SupplierCode,
		@ls_itemcode			= ItemCode,
		@ls_applyfrom			= ApplyFrom,
		@ls_parttype			= PartType,
		@ls_reprintflag			= RePrintFlag,
		@li_reprintcount			= RePrintCount,
		@ls_partkbgubun			= PartKBGubun,
		@ls_kbactivegubun		= KBActiveGubun,
		@ls_partkbstatus			= PartKBStatus,
		@ls_kborderpossible		= KBOrderPossible,
		@li_rackqty			= RackQty,
		@ls_orderchangeflag		= OrderChangeFlag,
		@ls_partordercancel		= PartOrderCancel,
		@ls_partreceiptcancel		= PartReceiptCancel,
		@ls_usecentergubun		= UseCenterGubun,
		@ls_usecenter			= UseCenter,
		@lbt_partobeydateflag		= PartObeyDateFlag,
		@lbt_partobeytimeflag		= PartObeyTimeFlag,
		@ls_partorderdate		= PartOrderDate,
		@ldt_partordertime		= PartOrderTime,
		@ls_partforecastdate		= PartForecastDate,
		@li_partforecasteditno		= PartForecastEditNo,
		@ldt_partforecasttime		= PartForecastTime,
		@ls_partreceiptdate		= PartReceiptDate,
		@li_parteditno			= PartEditNo,
		@ldt_partreceipttime		= PartReceiptTime,
		@ls_partincomedate		= PartIncomeDate,
		@ldt_partincometime		= PartIncomeTime,
		@ls_partorderno			= PartOrderNo,
		@ls_deliveryno			= DeliveryNo,
		@ls_buybackno			= BuyBackNo,
		@ldt_partkbcreatedate		= PartKBCreateDate,
		@ldt_partkbprintdate		= PartKBPrintDate,
		@ldt_orderchangetime		= OrderChangeTime,
		@ls_orderchangecode		= OrderChangeCode,
		@ls_changeforecastdate		= ChangeForecastDate,
		@li_changeforecasteditno		= ChangeForecastEditNo,
		@ldt_changeforecasttime		= ChangeForecastTime,
		@ls_orderseq			= OrderSeq,
		@ls_lastemp			= lastemp,
		@li_id				= checkid
	From	#tmp_tpartkbhis
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tpartkbhis
			where	PartKBNo	= @ls_partkbno
			and	ApplyDate	= @ls_applydate
			and	PartOrderSeq	= @li_partorderseq)

		insert into tpartkbhis
			(PartKBNo,		ApplyDate,		PartOrderSeq,		AreaCode,		DivisionCode,
			SupplierCode,		ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,		KBOrderPossible,
			RackQty,			OrderChangeFlag,	PartOrderCancel,		PartReceiptCancel,	UseCenterGubun,
			UseCenter,		PartObeyDateFlag,	PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,
			PartForecastDate,	PartForecastEditNo,	PartForecastTime,	PartReceiptDate,		PartEditNo,
			PartReceiptTime,		PartIncomeDate,		PartIncomeTime,		PartOrderNo,		DeliveryNo,
			BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,		OrderChangeTime,	OrderChangeCode,
			ChangeForecastDate,	ChangeForecastEditNo,	ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_applydate,		@li_partorderseq,		@ls_areacode,		@ls_divisioncode,
			@ls_suppliercode,	@ls_itemcode,		@ls_applyfrom,		@ls_parttype,		@ls_reprintflag,
			@li_reprintcount,		@ls_partkbgubun,		@ls_kbactivegubun,	@ls_partkbstatus,		@ls_kborderpossible,
			@li_rackqty,		@ls_orderchangeflag,	@ls_partordercancel,	@ls_partreceiptcancel,	@ls_usecentergubun,
			@ls_usecenter,		@lbt_partobeydateflag,	@lbt_partobeytimeflag,	@ls_partorderdate,	@ldt_partordertime,
			@ls_partforecastdate,	@li_partforecasteditno,	@ldt_partforecasttime,	@ls_partreceiptdate,	@li_parteditno,
			@ldt_partreceipttime,	@ls_partincomedate,	@ldt_partincometime,	@ls_partorderno,		@ls_deliveryno,
			@ls_buybackno,		@ldt_partkbcreatedate,	@ldt_partkbprintdate,	@ldt_orderchangetime,	@ls_orderchangecode,
			@ls_changeforecastdate,	@li_changeforecasteditno,	@ldt_changeforecasttime,	@ls_orderseq,		@ls_lastemp)
	Else
		update	tpartkbhis
		set	AreaCode		= @ls_areacode,            
			DivisionCode		= @ls_divisioncode,        
			SupplierCode		= @ls_suppliercode,        
			ItemCode		= @ls_itemcode,            
			ApplyFrom		= @ls_applyfrom,           
			PartType		= @ls_parttype,            
			RePrintFlag		= @ls_reprintflag,         
			RePrintCount		= @li_reprintcount,        
			PartKBGubun		= @ls_partkbgubun,         
			KBActiveGubun		= @ls_kbactivegubun,       
			PartKBStatus		= @ls_partkbstatus,        
			KBOrderPossible		= @ls_kborderpossible,     
			RackQty			= @li_rackqty,             
			OrderChangeFlag		= @ls_orderchangeflag,     
			PartOrderCancel		= @ls_partordercancel,     
			PartReceiptCancel	= @ls_partreceiptcancel,   
			UseCenterGubun		= @ls_usecentergubun,      
			UseCenter		= @ls_usecenter,           
			PartObeyDateFlag	= @lbt_partobeydateflag,    
			PartObeyTimeFlag	= @lbt_partobeytimeflag,    
			PartOrderDate		= @ls_partorderdate,       
			PartOrderTime		= @ldt_partordertime,       
			PartForecastDate		= @ls_partforecastdate,    
			PartForecastEditNo	= @li_partforecasteditno,  
			PartForecastTime		= @ldt_partforecasttime,    
			PartReceiptDate		= @ls_partreceiptdate,
			PartEditNo		= @li_parteditno,
			PartReceiptTime		= @ldt_partreceipttime,
			PartIncomeDate		= @ls_partincomedate,
			PartIncomeTime		= @ldt_partincometime,
			PartOrderNo		= @ls_partorderno,
			DeliveryNo		= @ls_deliveryno,
			BuyBackNo		= @ls_buybackno,
			PartKBCreateDate		= @ldt_partkbcreatedate,
			PartKBPrintDate		= @ldt_partkbprintdate,
			OrderChangeTime	= @ldt_orderchangetime,
			OrderChangeCode	= @ls_orderchangecode,
			ChangeForecastDate	= @ls_changeforecastdate,
			ChangeForecastEditNo	= @li_changeforecasteditno,
			ChangeForecastTime	= @ldt_changeforecasttime,
			OrderSeq		= @ls_orderseq
		where	PartKBNo		= @ls_partkbno
		and	ApplyDate		= @ls_applydate
		and	PartOrderSeq		= @li_partorderseq

	update	[ipisele_svr\ipis].ipis.dbo.tpartkbhis
	set	lastemp 	= 'N'
	where	PartKBNo	= @ls_partkbno
	and	ApplyDate	= @ls_applydate
	and	PartOrderSeq	= @li_partorderseq
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartkbhis


-- 대구기계

Insert	into	#tmp_tpartkbhis
select	*
from	[ipismac_svr\ipis].ipis.dbo.tpartkbhis
where	ApplyDate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_partkbno			= PartKBNo,
		@ls_applydate			= ApplyDate,
		@li_partorderseq			= PartOrderSeq,
		@ls_areacode			= AreaCode,
		@ls_divisioncode			= DivisionCode,
		@ls_suppliercode		= SupplierCode,
		@ls_itemcode			= ItemCode,
		@ls_applyfrom			= ApplyFrom,
		@ls_parttype			= PartType,
		@ls_reprintflag			= RePrintFlag,
		@li_reprintcount			= RePrintCount,
		@ls_partkbgubun			= PartKBGubun,
		@ls_kbactivegubun		= KBActiveGubun,
		@ls_partkbstatus			= PartKBStatus,
		@ls_kborderpossible		= KBOrderPossible,
		@li_rackqty			= RackQty,
		@ls_orderchangeflag		= OrderChangeFlag,
		@ls_partordercancel		= PartOrderCancel,
		@ls_partreceiptcancel		= PartReceiptCancel,
		@ls_usecentergubun		= UseCenterGubun,
		@ls_usecenter			= UseCenter,
		@lbt_partobeydateflag		= PartObeyDateFlag,
		@lbt_partobeytimeflag		= PartObeyTimeFlag,
		@ls_partorderdate		= PartOrderDate,
		@ldt_partordertime		= PartOrderTime,
		@ls_partforecastdate		= PartForecastDate,
		@li_partforecasteditno		= PartForecastEditNo,
		@ldt_partforecasttime		= PartForecastTime,
		@ls_partreceiptdate		= PartReceiptDate,
		@li_parteditno			= PartEditNo,
		@ldt_partreceipttime		= PartReceiptTime,
		@ls_partincomedate		= PartIncomeDate,
		@ldt_partincometime		= PartIncomeTime,
		@ls_partorderno			= PartOrderNo,
		@ls_deliveryno			= DeliveryNo,
		@ls_buybackno			= BuyBackNo,
		@ldt_partkbcreatedate		= PartKBCreateDate,
		@ldt_partkbprintdate		= PartKBPrintDate,
		@ldt_orderchangetime		= OrderChangeTime,
		@ls_orderchangecode		= OrderChangeCode,
		@ls_changeforecastdate		= ChangeForecastDate,
		@li_changeforecasteditno		= ChangeForecastEditNo,
		@ldt_changeforecasttime		= ChangeForecastTime,
		@ls_orderseq			= OrderSeq,
		@ls_lastemp			= lastemp,
		@li_id				= checkid
	From	#tmp_tpartkbhis
	Where	checkid > @li_id

	If not exists (	select * from tpartkbhis
			where	PartKBNo	= @ls_partkbno
			and	ApplyDate	= @ls_applydate
			and	PartOrderSeq	= @li_partorderseq)

		insert into tpartkbhis
			(PartKBNo,		ApplyDate,		PartOrderSeq,		AreaCode,		DivisionCode,
			SupplierCode,		ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,		KBOrderPossible,
			RackQty,			OrderChangeFlag,	PartOrderCancel,		PartReceiptCancel,	UseCenterGubun,
			UseCenter,		PartObeyDateFlag,	PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,
			PartForecastDate,	PartForecastEditNo,	PartForecastTime,	PartReceiptDate,		PartEditNo,
			PartReceiptTime,		PartIncomeDate,		PartIncomeTime,		PartOrderNo,		DeliveryNo,
			BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,		OrderChangeTime,	OrderChangeCode,
			ChangeForecastDate,	ChangeForecastEditNo,	ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_applydate,		@li_partorderseq,		@ls_areacode,		@ls_divisioncode,
			@ls_suppliercode,	@ls_itemcode,		@ls_applyfrom,		@ls_parttype,		@ls_reprintflag,
			@li_reprintcount,		@ls_partkbgubun,		@ls_kbactivegubun,	@ls_partkbstatus,		@ls_kborderpossible,
			@li_rackqty,		@ls_orderchangeflag,	@ls_partordercancel,	@ls_partreceiptcancel,	@ls_usecentergubun,
			@ls_usecenter,		@lbt_partobeydateflag,	@lbt_partobeytimeflag,	@ls_partorderdate,	@ldt_partordertime,
			@ls_partforecastdate,	@li_partforecasteditno,	@ldt_partforecasttime,	@ls_partreceiptdate,	@li_parteditno,
			@ldt_partreceipttime,	@ls_partincomedate,	@ldt_partincometime,	@ls_partorderno,		@ls_deliveryno,
			@ls_buybackno,		@ldt_partkbcreatedate,	@ldt_partkbprintdate,	@ldt_orderchangetime,	@ls_orderchangecode,
			@ls_changeforecastdate,	@li_changeforecasteditno,	@ldt_changeforecasttime,	@ls_orderseq,		@ls_lastemp)
	Else
		update	tpartkbhis
		set	AreaCode		= @ls_areacode,            
			DivisionCode		= @ls_divisioncode,        
			SupplierCode		= @ls_suppliercode,        
			ItemCode		= @ls_itemcode,            
			ApplyFrom		= @ls_applyfrom,           
			PartType		= @ls_parttype,            
			RePrintFlag		= @ls_reprintflag,         
			RePrintCount		= @li_reprintcount,        
			PartKBGubun		= @ls_partkbgubun,         
			KBActiveGubun		= @ls_kbactivegubun,       
			PartKBStatus		= @ls_partkbstatus,        
			KBOrderPossible		= @ls_kborderpossible,     
			RackQty			= @li_rackqty,             
			OrderChangeFlag		= @ls_orderchangeflag,     
			PartOrderCancel		= @ls_partordercancel,     
			PartReceiptCancel	= @ls_partreceiptcancel,   
			UseCenterGubun		= @ls_usecentergubun,      
			UseCenter		= @ls_usecenter,           
			PartObeyDateFlag	= @lbt_partobeydateflag,    
			PartObeyTimeFlag	= @lbt_partobeytimeflag,    
			PartOrderDate		= @ls_partorderdate,       
			PartOrderTime		= @ldt_partordertime,       
			PartForecastDate		= @ls_partforecastdate,    
			PartForecastEditNo	= @li_partforecasteditno,  
			PartForecastTime		= @ldt_partforecasttime,    
			PartReceiptDate		= @ls_partreceiptdate,
			PartEditNo		= @li_parteditno,
			PartReceiptTime		= @ldt_partreceipttime,
			PartIncomeDate		= @ls_partincomedate,
			PartIncomeTime		= @ldt_partincometime,
			PartOrderNo		= @ls_partorderno,
			DeliveryNo		= @ls_deliveryno,
			BuyBackNo		= @ls_buybackno,
			PartKBCreateDate		= @ldt_partkbcreatedate,
			PartKBPrintDate		= @ldt_partkbprintdate,
			OrderChangeTime	= @ldt_orderchangetime,
			OrderChangeCode	= @ls_orderchangecode,
			ChangeForecastDate	= @ls_changeforecastdate,
			ChangeForecastEditNo	= @li_changeforecasteditno,
			ChangeForecastTime	= @ldt_changeforecasttime,
			OrderSeq		= @ls_orderseq
		where	PartKBNo		= @ls_partkbno
		and	ApplyDate		= @ls_applydate
		and	PartOrderSeq		= @li_partorderseq
		
	update	[ipismac_svr\ipis].ipis.dbo.tpartkbhis
	set	lastemp 	= 'N'
	where	PartKBNo	= @ls_partkbno
	and	ApplyDate	= @ls_applydate
	and	PartOrderSeq	= @li_partorderseq
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartkbhis


-- 대구압축

Insert	into	#tmp_tpartkbhis
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tpartkbhis
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_partkbno			= PartKBNo,
		@ls_applydate			= ApplyDate,
		@li_partorderseq			= PartOrderSeq,
		@ls_areacode			= AreaCode,
		@ls_divisioncode			= DivisionCode,
		@ls_suppliercode		= SupplierCode,
		@ls_itemcode			= ItemCode,
		@ls_applyfrom			= ApplyFrom,
		@ls_parttype			= PartType,
		@ls_reprintflag			= RePrintFlag,
		@li_reprintcount			= RePrintCount,
		@ls_partkbgubun			= PartKBGubun,
		@ls_kbactivegubun		= KBActiveGubun,
		@ls_partkbstatus			= PartKBStatus,
		@ls_kborderpossible		= KBOrderPossible,
		@li_rackqty			= RackQty,
		@ls_orderchangeflag		= OrderChangeFlag,
		@ls_partordercancel		= PartOrderCancel,
		@ls_partreceiptcancel		= PartReceiptCancel,
		@ls_usecentergubun		= UseCenterGubun,
		@ls_usecenter			= UseCenter,
		@lbt_partobeydateflag		= PartObeyDateFlag,
		@lbt_partobeytimeflag		= PartObeyTimeFlag,
		@ls_partorderdate		= PartOrderDate,
		@ldt_partordertime		= PartOrderTime,
		@ls_partforecastdate		= PartForecastDate,
		@li_partforecasteditno		= PartForecastEditNo,
		@ldt_partforecasttime		= PartForecastTime,
		@ls_partreceiptdate		= PartReceiptDate,
		@li_parteditno			= PartEditNo,
		@ldt_partreceipttime		= PartReceiptTime,
		@ls_partincomedate		= PartIncomeDate,
		@ldt_partincometime		= PartIncomeTime,
		@ls_partorderno			= PartOrderNo,
		@ls_deliveryno			= DeliveryNo,
		@ls_buybackno			= BuyBackNo,
		@ldt_partkbcreatedate		= PartKBCreateDate,
		@ldt_partkbprintdate		= PartKBPrintDate,
		@ldt_orderchangetime		= OrderChangeTime,
		@ls_orderchangecode		= OrderChangeCode,
		@ls_changeforecastdate		= ChangeForecastDate,
		@li_changeforecasteditno		= ChangeForecastEditNo,
		@ldt_changeforecasttime		= ChangeForecastTime,
		@ls_orderseq			= OrderSeq,
		@ls_lastemp			= lastemp,
		@li_id				= checkid
	From	#tmp_tpartkbhis
	Where	checkid > @li_id

	If not exists (	select * from tpartkbhis
			where	PartKBNo	= @ls_partkbno
			and	ApplyDate	= @ls_applydate
			and	PartOrderSeq	= @li_partorderseq)

		insert into tpartkbhis
			(PartKBNo,		ApplyDate,		PartOrderSeq,		AreaCode,		DivisionCode,
			SupplierCode,		ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,		KBOrderPossible,
			RackQty,			OrderChangeFlag,	PartOrderCancel,		PartReceiptCancel,	UseCenterGubun,
			UseCenter,		PartObeyDateFlag,	PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,
			PartForecastDate,	PartForecastEditNo,	PartForecastTime,	PartReceiptDate,		PartEditNo,
			PartReceiptTime,		PartIncomeDate,		PartIncomeTime,		PartOrderNo,		DeliveryNo,
			BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,		OrderChangeTime,	OrderChangeCode,
			ChangeForecastDate,	ChangeForecastEditNo,	ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_applydate,		@li_partorderseq,		@ls_areacode,		@ls_divisioncode,
			@ls_suppliercode,	@ls_itemcode,		@ls_applyfrom,		@ls_parttype,		@ls_reprintflag,
			@li_reprintcount,		@ls_partkbgubun,		@ls_kbactivegubun,	@ls_partkbstatus,		@ls_kborderpossible,
			@li_rackqty,		@ls_orderchangeflag,	@ls_partordercancel,	@ls_partreceiptcancel,	@ls_usecentergubun,
			@ls_usecenter,		@lbt_partobeydateflag,	@lbt_partobeytimeflag,	@ls_partorderdate,	@ldt_partordertime,
			@ls_partforecastdate,	@li_partforecasteditno,	@ldt_partforecasttime,	@ls_partreceiptdate,	@li_parteditno,
			@ldt_partreceipttime,	@ls_partincomedate,	@ldt_partincometime,	@ls_partorderno,		@ls_deliveryno,
			@ls_buybackno,		@ldt_partkbcreatedate,	@ldt_partkbprintdate,	@ldt_orderchangetime,	@ls_orderchangecode,
			@ls_changeforecastdate,	@li_changeforecasteditno,	@ldt_changeforecasttime,	@ls_orderseq,		@ls_lastemp)
	Else
		update	tpartkbhis
		set	AreaCode		= @ls_areacode,            
			DivisionCode		= @ls_divisioncode,        
			SupplierCode		= @ls_suppliercode,        
			ItemCode		= @ls_itemcode,            
			ApplyFrom		= @ls_applyfrom,           
			PartType		= @ls_parttype,            
			RePrintFlag		= @ls_reprintflag,         
			RePrintCount		= @li_reprintcount,        
			PartKBGubun		= @ls_partkbgubun,         
			KBActiveGubun		= @ls_kbactivegubun,       
			PartKBStatus		= @ls_partkbstatus,        
			KBOrderPossible		= @ls_kborderpossible,     
			RackQty			= @li_rackqty,             
			OrderChangeFlag		= @ls_orderchangeflag,     
			PartOrderCancel		= @ls_partordercancel,     
			PartReceiptCancel	= @ls_partreceiptcancel,   
			UseCenterGubun		= @ls_usecentergubun,      
			UseCenter		= @ls_usecenter,           
			PartObeyDateFlag	= @lbt_partobeydateflag,    
			PartObeyTimeFlag	= @lbt_partobeytimeflag,    
			PartOrderDate		= @ls_partorderdate,       
			PartOrderTime		= @ldt_partordertime,       
			PartForecastDate		= @ls_partforecastdate,    
			PartForecastEditNo	= @li_partforecasteditno,  
			PartForecastTime		= @ldt_partforecasttime,    
			PartReceiptDate		= @ls_partreceiptdate,
			PartEditNo		= @li_parteditno,
			PartReceiptTime		= @ldt_partreceipttime,
			PartIncomeDate		= @ls_partincomedate,
			PartIncomeTime		= @ldt_partincometime,
			PartOrderNo		= @ls_partorderno,
			DeliveryNo		= @ls_deliveryno,
			BuyBackNo		= @ls_buybackno,
			PartKBCreateDate		= @ldt_partkbcreatedate,
			PartKBPrintDate		= @ldt_partkbprintdate,
			OrderChangeTime	= @ldt_orderchangetime,
			OrderChangeCode	= @ls_orderchangecode,
			ChangeForecastDate	= @ls_changeforecastdate,
			ChangeForecastEditNo	= @li_changeforecasteditno,
			ChangeForecastTime	= @ldt_changeforecasttime,
			OrderSeq		= @ls_orderseq
		where	PartKBNo		= @ls_partkbno
		and	ApplyDate		= @ls_applydate
		and	PartOrderSeq		= @li_partorderseq

	update	[ipishvac_svr\ipis].ipis.dbo.tpartkbhis
	set	lastemp 	= 'N'
	where	PartKBNo	= @ls_partkbno
	and	ApplyDate	= @ls_applydate
	and	PartOrderSeq	= @li_partorderseq
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tpartkbhis


-- 진천

Insert	into	#tmp_tpartkbhis
select	*
from	[ipisjin_svr].ipis.dbo.tpartkbhis
where	ApplyDate <= @ls_today
and	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i				= @i + 1,
		@ls_partkbno			= PartKBNo,
		@ls_applydate			= ApplyDate,
		@li_partorderseq			= PartOrderSeq,
		@ls_areacode			= AreaCode,
		@ls_divisioncode			= DivisionCode,
		@ls_suppliercode		= SupplierCode,
		@ls_itemcode			= ItemCode,
		@ls_applyfrom			= ApplyFrom,
		@ls_parttype			= PartType,
		@ls_reprintflag			= RePrintFlag,
		@li_reprintcount			= RePrintCount,
		@ls_partkbgubun			= PartKBGubun,
		@ls_kbactivegubun		= KBActiveGubun,
		@ls_partkbstatus			= PartKBStatus,
		@ls_kborderpossible		= KBOrderPossible,
		@li_rackqty			= RackQty,
		@ls_orderchangeflag		= OrderChangeFlag,
		@ls_partordercancel		= PartOrderCancel,
		@ls_partreceiptcancel		= PartReceiptCancel,
		@ls_usecentergubun		= UseCenterGubun,
		@ls_usecenter			= UseCenter,
		@lbt_partobeydateflag		= PartObeyDateFlag,
		@lbt_partobeytimeflag		= PartObeyTimeFlag,
		@ls_partorderdate		= PartOrderDate,
		@ldt_partordertime		= PartOrderTime,
		@ls_partforecastdate		= PartForecastDate,
		@li_partforecasteditno		= PartForecastEditNo,
		@ldt_partforecasttime		= PartForecastTime,
		@ls_partreceiptdate		= PartReceiptDate,
		@li_parteditno			= PartEditNo,
		@ldt_partreceipttime		= PartReceiptTime,
		@ls_partincomedate		= PartIncomeDate,
		@ldt_partincometime		= PartIncomeTime,
		@ls_partorderno			= PartOrderNo,
		@ls_deliveryno			= DeliveryNo,
		@ls_buybackno			= BuyBackNo,
		@ldt_partkbcreatedate		= PartKBCreateDate,
		@ldt_partkbprintdate		= PartKBPrintDate,
		@ldt_orderchangetime		= OrderChangeTime,
		@ls_orderchangecode		= OrderChangeCode,
		@ls_changeforecastdate		= ChangeForecastDate,
		@li_changeforecasteditno		= ChangeForecastEditNo,
		@ldt_changeforecasttime		= ChangeForecastTime,
		@ls_orderseq			= OrderSeq,
		@ls_lastemp			= lastemp,
		@li_id				= checkid
	From	#tmp_tpartkbhis
	Where	checkid > @li_id

	If not exists (	select * from tpartkbhis
			where	PartKBNo	= @ls_partkbno
			and	ApplyDate	= @ls_applydate
			and	PartOrderSeq	= @li_partorderseq)

		insert into tpartkbhis
			(PartKBNo,		ApplyDate,		PartOrderSeq,		AreaCode,		DivisionCode,
			SupplierCode,		ItemCode,		ApplyFrom,		PartType,		RePrintFlag,
			RePrintCount,		PartKBGubun,		KBActiveGubun,		PartKBStatus,		KBOrderPossible,
			RackQty,			OrderChangeFlag,	PartOrderCancel,		PartReceiptCancel,	UseCenterGubun,
			UseCenter,		PartObeyDateFlag,	PartObeyTimeFlag,	PartOrderDate,		PartOrderTime,
			PartForecastDate,	PartForecastEditNo,	PartForecastTime,	PartReceiptDate,		PartEditNo,
			PartReceiptTime,		PartIncomeDate,		PartIncomeTime,		PartOrderNo,		DeliveryNo,
			BuyBackNo,		PartKBCreateDate,	PartKBPrintDate,		OrderChangeTime,	OrderChangeCode,
			ChangeForecastDate,	ChangeForecastEditNo,	ChangeForecastTime,	OrderSeq,		LastEmp)
		values	(@ls_partkbno,		@ls_applydate,		@li_partorderseq,		@ls_areacode,		@ls_divisioncode,
			@ls_suppliercode,	@ls_itemcode,		@ls_applyfrom,		@ls_parttype,		@ls_reprintflag,
			@li_reprintcount,		@ls_partkbgubun,		@ls_kbactivegubun,	@ls_partkbstatus,		@ls_kborderpossible,
			@li_rackqty,		@ls_orderchangeflag,	@ls_partordercancel,	@ls_partreceiptcancel,	@ls_usecentergubun,
			@ls_usecenter,		@lbt_partobeydateflag,	@lbt_partobeytimeflag,	@ls_partorderdate,	@ldt_partordertime,
			@ls_partforecastdate,	@li_partforecasteditno,	@ldt_partforecasttime,	@ls_partreceiptdate,	@li_parteditno,
			@ldt_partreceipttime,	@ls_partincomedate,	@ldt_partincometime,	@ls_partorderno,		@ls_deliveryno,
			@ls_buybackno,		@ldt_partkbcreatedate,	@ldt_partkbprintdate,	@ldt_orderchangetime,	@ls_orderchangecode,
			@ls_changeforecastdate,	@li_changeforecasteditno,	@ldt_changeforecasttime,	@ls_orderseq,		@ls_lastemp)
	Else
		update	tpartkbhis
		set	AreaCode		= @ls_areacode,            
			DivisionCode		= @ls_divisioncode,        
			SupplierCode		= @ls_suppliercode,        
			ItemCode		= @ls_itemcode,            
			ApplyFrom		= @ls_applyfrom,           
			PartType		= @ls_parttype,            
			RePrintFlag		= @ls_reprintflag,         
			RePrintCount		= @li_reprintcount,        
			PartKBGubun		= @ls_partkbgubun,         
			KBActiveGubun		= @ls_kbactivegubun,       
			PartKBStatus		= @ls_partkbstatus,        
			KBOrderPossible		= @ls_kborderpossible,     
			RackQty			= @li_rackqty,             
			OrderChangeFlag		= @ls_orderchangeflag,     
			PartOrderCancel		= @ls_partordercancel,     
			PartReceiptCancel	= @ls_partreceiptcancel,   
			UseCenterGubun		= @ls_usecentergubun,      
			UseCenter		= @ls_usecenter,           
			PartObeyDateFlag	= @lbt_partobeydateflag,    
			PartObeyTimeFlag	= @lbt_partobeytimeflag,    
			PartOrderDate		= @ls_partorderdate,       
			PartOrderTime		= @ldt_partordertime,       
			PartForecastDate		= @ls_partforecastdate,    
			PartForecastEditNo	= @li_partforecasteditno,  
			PartForecastTime		= @ldt_partforecasttime,    
			PartReceiptDate		= @ls_partreceiptdate,
			PartEditNo		= @li_parteditno,
			PartReceiptTime		= @ldt_partreceipttime,
			PartIncomeDate		= @ls_partincomedate,
			PartIncomeTime		= @ldt_partincometime,
			PartOrderNo		= @ls_partorderno,
			DeliveryNo		= @ls_deliveryno,
			BuyBackNo		= @ls_buybackno,
			PartKBCreateDate		= @ldt_partkbcreatedate,
			PartKBPrintDate		= @ldt_partkbprintdate,
			OrderChangeTime	= @ldt_orderchangetime,
			OrderChangeCode	= @ls_orderchangecode,
			ChangeForecastDate	= @ls_changeforecastdate,
			ChangeForecastEditNo	= @li_changeforecasteditno,
			ChangeForecastTime	= @ldt_changeforecasttime,
			OrderSeq		= @ls_orderseq
		where	PartKBNo		= @ls_partkbno
		and	ApplyDate		= @ls_applydate
		and	PartOrderSeq		= @li_partorderseq
		
	update	[ipisjin_svr].ipis.dbo.tpartkbhis
	set	lastemp 	= 'N'
	where	PartKBNo	= @ls_partkbno
	and	ApplyDate	= @ls_applydate
	and	PartOrderSeq	= @li_partorderseq
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tpartkbhis
 
End		-- Procedure End
Go
