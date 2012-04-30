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
	            2007. 04. 24 : 납품표번호 추가
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
	CostGubun,	UseCenter,	LastEmp, DeliveryNo)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo
from	[ipisele_svr\ipis].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'	and
	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface)
order by lastdate asc
		
update	[ipisele_svr\ipis].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface
		where	interfaceflag = 'Y')

-- 대구기계

insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo
from	[ipismac_svr\ipis].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'	and
	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface)
order by lastdate asc

update	[ipismac_svr\ipis].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface
		where	interfaceflag = 'Y')

-- 대구공조

insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo
from	[ipishvac_svr\ipis].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'	and
	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface)
order by lastdate asc

update	[ipishvac_svr\ipis].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface
		where	interfaceflag = 'Y')

-- 진천

insert into tpartkbincome_interface
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, DeliveryNo
from	[ipisjin_svr].ipis.dbo.tpartkbincome_interface
where	interfaceflag = 'Y'	and
	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface)
order by lastdate asc

update	[ipisjin_svr].ipis.dbo.tpartkbincome_interface
set	interfaceflag = 'N'
where	OrderSeq + cast(SeqNo as char(1)) + MISFlag
	in 	(select	OrderSeq + cast(SeqNo as char(1)) + MISFlag
		from	tpartkbincome_interface
		where	interfaceflag = 'Y')

End		-- Procedure End
Go
