SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*
Execute sp_pisi_u_tpartkbdayorder_interface
*/

ALTER    Procedure sp_pisi_u_tpartkbdayorder_interface


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


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

