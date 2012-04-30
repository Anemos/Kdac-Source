/*
	File Name	: sp_pisi_move_interface_history.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_move_interface_history
	Description	: Upload Interface용 테이블의 데이타를 History 테이블로 이동함.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: [ipisele_svr\ipis].interface
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.07.02
	Author		: Kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_move_interface_history]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_move_interface_history]
GO

/*
Execute sp_pisi_move_interface_history
*/

Create Procedure sp_pisi_move_interface_history

	
As
Begin

declare @ls_curdate char(10)
select @ls_curdate = Convert(char(10), DateAdd(DD, -1, DateAdd(MM, -1, Convert(DateTime, Left(convert(char(10),getdate(),102), 7) + '.01'))), 102)

-- 자재 입고 현황
insert into tpartkbincome_interfacehis
	(Logid, OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, LastDate)
select	Logid, OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, LastDate 
from tpartkbincome_interface
where PartIncomeDate <= @ls_curdate and interfaceflag = 'N'
		
Delete tpartkbincome_interface
From tpartkbincome_interface aa inner join tpartkbincome_interfacehis bb
  on aa.logid = bb.logid

-- 자재 발주 현황
insert into tpartkborder_interfacehis
	(Logid, OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartForecastDate,	LastEmp, LastDate)
select	Logid, OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartForecastDate,	LastEmp, LastDate
from	tpartkborder_interface
where PartOrderDate <= @ls_curdate and interfaceflag = 'N'

Delete tpartkborder_interface
From tpartkborder_interface aa inner join tpartkborder_interfacehis bb
  on aa.logid = bb.logid

-- 제품입고정보
insert into tstock_interfacehis
	(Logid, KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp, LastDate)
select	Logid, KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp, LastDate 
from	tstock_interface
where	interfaceflag = 'N'	and KBReleaseDate <= @ls_curdate

Delete tstock_interface
From tstock_interface aa inner join tstock_interfacehis bb
  on aa.logid = bb.logid

-- 출하정보
insert into tshipsheet_interfacehis
	(Logid, ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp, LastDate)	
select	Logid, ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp, LastDate
from	tshipsheet_interface
where	interfaceflag = 'N'	and shipdate <= @ls_curdate

delete	tshipsheet_interface
from tshipsheet_interface aa inner join tshipsheet_interfacehis bb
  on aa.logid = bb.logid

End		-- Procedure End
Go
