/*
	File Name	: sp_pisi_u_tpartkbdayorder_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tpartkbdayorder_interface
	Description	: Upload tpartkbdayorder(발주현황) 
			  tpartkbdayorder_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tpartkbdayorder_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tpartkbdayorder_interface]
GO


/*
Execute sp_pisi_u_tpartkbdayorder_interface
*/

Create Procedure sp_pisi_u_tpartkbdayorder_interface
	
As
Begin


truncate table tpartkbdayorder_interface

-- 대구전장

insert into tpartkbdayorder_interface
	(SupplierCode,	PartKBNo,	OrderSeq,	AreaCode,		DivisionCode,
	ItemCode,	RackCode,	SupplyTerm,	SupplyEditNo,		SupplyCycle,
	UseCenter,	RackQty,	PartOrderDate,	PartForecastDate,	PartForecastTime, PartReceiptDate)
select	a.suppliercode,	a.partkbno,	a.orderseq,	a.areacode,		a.divisioncode,
	a.itemcode,	b.rackcode,	c.supplyterm,	c.supplyeditno,		c.supplycycle,
	a.usecenter,	a.rackqty,	a.partorderdate,a.partforecastdate,	a.partforecasttime, a.partreceiptdate
from	[ipisele_svr\ipis].ipis.dbo.tpartkbstatus a,
	[ipisele_svr\ipis].ipis.dbo.tmstpartkb b,
	[ipisele_svr\ipis].ipis.dbo.tmstpartcycle c
where	a.partkbstatus in ( 'A', 'B' )
and	a.areacode = b.areacode
and	a.divisioncode = b.divisioncode
and	a.suppliercode = b.suppliercode
and	a.itemcode = b.itemcode
and	a.areacode = c.areacode
and	a.divisioncode = c.divisioncode
and	a.suppliercode = c.suppliercode
and	a.partorderdate >= c.applyfrom
and	a.partorderdate <= c.applyto

-- 대구기계

insert into tpartkbdayorder_interface
	(SupplierCode,	PartKBNo,	OrderSeq,	AreaCode,		DivisionCode,
	ItemCode,	RackCode,	SupplyTerm,	SupplyEditNo,		SupplyCycle,
	UseCenter,	RackQty,	PartOrderDate,	PartForecastDate,	PartForecastTime, PartReceiptDate)
select	a.suppliercode,	a.partkbno,	a.orderseq,	a.areacode,		a.divisioncode,
	a.itemcode,	b.rackcode,	c.supplyterm,	c.supplyeditno,		c.supplycycle,
	a.usecenter,	a.rackqty,	a.partorderdate,a.partforecastdate,	a.partforecasttime, a.partreceiptdate
from	[ipismac_svr\ipis].ipis.dbo.tpartkbstatus a,
	[ipismac_svr\ipis].ipis.dbo.tmstpartkb b,
	[ipismac_svr\ipis].ipis.dbo.tmstpartcycle c
where	a.partkbstatus in ( 'A', 'B' )
and	a.areacode = b.areacode
and	a.divisioncode = b.divisioncode
and	a.suppliercode = b.suppliercode
and	a.itemcode = b.itemcode
and	a.areacode = c.areacode
and	a.divisioncode = c.divisioncode
and	a.suppliercode = c.suppliercode
and	a.partorderdate >= c.applyfrom
and	a.partorderdate <= c.applyto

-- 대구공조

insert into tpartkbdayorder_interface
	(SupplierCode,	PartKBNo,	OrderSeq,	AreaCode,		DivisionCode,
	ItemCode,	RackCode,	SupplyTerm,	SupplyEditNo,		SupplyCycle,
	UseCenter,	RackQty,	PartOrderDate,	PartForecastDate,	PartForecastTime, PartReceiptDate)
select	a.suppliercode,	a.partkbno,	a.orderseq,	a.areacode,		a.divisioncode,
	a.itemcode,	b.rackcode,	c.supplyterm,	c.supplyeditno,		c.supplycycle,
	a.usecenter,	a.rackqty,	a.partorderdate,a.partforecastdate,	a.partforecasttime, a.partreceiptdate
from	[ipishvac_svr\ipis].ipis.dbo.tpartkbstatus a,
	[ipishvac_svr\ipis].ipis.dbo.tmstpartkb b,
	[ipishvac_svr\ipis].ipis.dbo.tmstpartcycle c
where	a.partkbstatus in ( 'A', 'B' )
and	a.areacode = b.areacode
and	a.divisioncode = b.divisioncode
and	a.suppliercode = b.suppliercode
and	a.itemcode = b.itemcode
and	a.areacode = c.areacode
and	a.divisioncode = c.divisioncode
and	a.suppliercode = c.suppliercode
and	a.partorderdate >= c.applyfrom
and	a.partorderdate <= c.applyto

-- 진천

insert into tpartkbdayorder_interface
	(SupplierCode,	PartKBNo,	OrderSeq,	AreaCode,		DivisionCode,
	ItemCode,	RackCode,	SupplyTerm,	SupplyEditNo,		SupplyCycle,
	UseCenter,	RackQty,	PartOrderDate,	PartForecastDate,	PartForecastTime, PartReceiptDate)
select	a.suppliercode,	a.partkbno,	a.orderseq,	a.areacode,		a.divisioncode,
	a.itemcode,	b.rackcode,	c.supplyterm,	c.supplyeditno,		c.supplycycle,
	a.usecenter,	a.rackqty,	a.partorderdate,a.partforecastdate,	a.partforecasttime, a.partreceiptdate
from	[ipisjin_svr].ipis.dbo.tpartkbstatus a,
	[ipisjin_svr].ipis.dbo.tmstpartkb b,
	[ipisjin_svr].ipis.dbo.tmstpartcycle c
where	a.partkbstatus in ( 'A', 'B' )
and	a.areacode = b.areacode
and	a.divisioncode = b.divisioncode
and	a.suppliercode = b.suppliercode
and	a.itemcode = b.itemcode
and	a.areacode = c.areacode
and	a.divisioncode = c.divisioncode
and	a.suppliercode = c.suppliercode
and	a.partorderdate >= c.applyfrom
and	a.partorderdate <= c.applyto

End		-- Procedure End
Go