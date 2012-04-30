/*
	File Name	: sp_pisi_move_ipis_history.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_move_ipis_history
	Description	: Upload Interface용 테이블의 데이타를 History 테이블로 이동함.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: [ipisele_svr\ipis].ipis
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.07.02
	            2007. 04. 24 : 납품표번호 추가
	Author		: Kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_move_ipis_history]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_move_ipis_history]
GO

/*
Execute sp_pisi_move_ipis_history
*/

Create Procedure sp_pisi_move_ipis_history

	
As
Begin

declare @ls_curdate char(10)
select @ls_curdate = Convert(char(10), DateAdd(DD, -1, DateAdd(MM, -1, Convert(DateTime, Left(convert(char(10),getdate(),102), 7) + '.01'))), 102)

-- 자재 입고 현황
insert into tpartkbincome_interfacehis
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, LastDate, DeliveryNo)
select	OrderSeq,	SeqNo,		MISFlag,	InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartIncomeDate,		PartReceiptDate,
	CostGubun,	UseCenter,	LastEmp, LastDate, DeliveryNo
from tpartkbincome_interface
where PartIncomeDate <= @ls_curdate and interfaceflag = 'N'
		
Delete tpartkbincome_interface
From tpartkbincome_interface aa inner join tpartkbincome_interfacehis bb
  on aa.OrderSeq = bb.OrderSeq and aa.SeqNo = bb.SeqNo and aa.MisFlag = bb.MisFlag

-- 자재 발주 현황
insert into tpartkborder_interfacehis
	(OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartForecastDate,	LastEmp, LastDate)
select	OrderSeq,	SeqNo,		MISFlag,		InterfaceFlag,		AreaCode,		
	DivisionCode,	SupplierCode,	ItemCode,		PartKBNo,
	PartOrderDate,	RackQty,	PartForecastDate,	LastEmp, LastDate
from	tpartkborder_interface
where PartOrderDate <= @ls_curdate and interfaceflag = 'N'

Delete tpartkborder_interface
From tpartkborder_interface aa inner join tpartkborder_interfacehis bb
  on aa.OrderSeq = bb.OrderSeq and aa.SeqNo = bb.SeqNo and aa.MisFlag = bb.MisFlag

-- 제품입고정보
insert into tstock_interfacehis
	(KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp, LastDate)
select	KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp, LastDate 
from	tstock_interface
where	interfaceflag = 'N'	and KBReleaseDate <= @ls_curdate

Delete tstock_interface
From tstock_interface aa inner join tstock_interfacehis bb
  on aa.kbno = bb.kbno and aa.kbreleasedate = bb.kbreleasedate and
    aa.kbreleaseseq = bb.kbreleaseseq and aa.seqno = bb.seqno and
    aa.misflag = bb.misflag

-- 출하정보
insert into tshipsheet_interfacehis
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp, LastDate)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp, LastDate
from	tshipsheet_interface
where	interfaceflag = 'N'	and shipdate <= @ls_curdate

delete	tshipsheet_interface
from tshipsheet_interface aa inner join tshipsheet_interfacehis bb
  on aa.shipdate = bb.shipdate and aa.areacode = bb.areacode and
    aa.divisioncode = bb.divisioncode and aa.srno = bb.srno and
    aa.shipsheetno = bb.shipsheetno and aa.seqno = bb.seqno and
    aa.misflag = bb.misflag

End		-- Procedure End
Go
