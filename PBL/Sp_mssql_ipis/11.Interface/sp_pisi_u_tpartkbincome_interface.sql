/*
	File Name	: sp_pisi_u_tpartkbincome_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tpartkbincome_interface
	Description	: Upload tpartkbincome_interface(자재 발주정보)) 
			  tpartkbincome_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tpartkbincome_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tpartkbincome_interface]
GO

/*
Execute sp_pisi_u_tpartkbincome_interface
*/

Create Procedure sp_pisi_u_tpartkbincome_interface

	
As
Begin


-- 대구전장
insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp 
from	[ipisele_svr\ipis].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 대구기계
insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 대구공조
insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 진천
insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp 
from	[ipisjin_svr].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'
 
End		-- Procedure End
Go
