/*
	File Name	: sp_pisi_move_interface_history.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_move_interface_history
	Description	: Upload Interface�� ���̺��� ����Ÿ�� History ���̺�� �̵���.
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

-- ���� �԰� ��Ȳ
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

-- ���� ���� ��Ȳ
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

-- ��ǰ�԰�����
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

-- ��������
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
