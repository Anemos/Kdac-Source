/*
	File Name	: sp_pisi_d_tmstpartcost.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstcustitem
	Description	: Download Part Cost
			  tmstpartcost
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstpartcost]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstpartcost]
GO

/*
Execute sp_pisi_d_tmstpartcost
*/

Create Procedure sp_pisi_d_tmstpartcost
	
As
Begin

set xact_abort off

Select	*
into	#tmp_pdpur103
from	pdpur103_log
where vsrno+itno+chgdate	in
	(select	vsrno+itno+max(chgdate)	from	pdpur103_log
		group by vsrno,itno)

if @@error <> 0
	Begin
	Return
	End

-- 대구전장
delete from [ipisele_svr\ipis].ipis.dbo.tmstpartcost
where SupplierCode+ItemCode in (select rtrim(vsrno)+rtrim(itno) from #tmp_pdpur103
			where	len(vsrno)	<=	5)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisele_svr\ipis].ipis.dbo.tmstpartcost
	(SupplierCode,	ItemCode,	
	ApplyDate,	
	CurrentUnit,	UnitCost,	SheetNo,	ARR,		XPAY,
	VZERO,		QCGubun,	
	QCApplyDate,	
	QCInDate,		
	PQTY,		XRATE,		ShareRate,	StartGubun,	ChangeCost,
	FPURNO,		
	FPINDT,
	FCOST,		PURNO,		
	PINDT,
	RQNO,		SRNO,		SRNO1,		
	DKDT,
	LCOST,		XSTOP,		LastEmp)	
select 	vsrno,	itno,
	substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
	dcurr,		dcost,		dsheet,		arr,		xpay,
	vzero,		qccd,
	substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
	substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
	pqty,		xrate,		shrt,		strt,		chcs,
	fpurno,		
	substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
	fcost,		purno,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	rqno,		srno,		srno1,
	substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
	lcost,		xstop,		'SYSTEM'
from 	#tmp_pdpur103
where	len(vsrno)	<= 	5  and chgcd in ('A','R')
	
if @@error <> 0
	Begin
	Return
	End

-- 대구기계
delete from [ipismac_svr\ipis].ipis.dbo.tmstpartcost
where SupplierCode+ItemCode in (select rtrim(vsrno)+rtrim(itno) from #tmp_pdpur103
			where	len(vsrno)	<=	5)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipismac_svr\ipis].ipis.dbo.tmstpartcost
	(SupplierCode,	ItemCode,	
	ApplyDate,	
	CurrentUnit,	UnitCost,	SheetNo,	ARR,		XPAY,
	VZERO,		QCGubun,	
	QCApplyDate,	
	QCInDate,		
	PQTY,		XRATE,		ShareRate,	StartGubun,	ChangeCost,
	FPURNO,		
	FPINDT,
	FCOST,		PURNO,		
	PINDT,
	RQNO,		SRNO,		SRNO1,		
	DKDT,
	LCOST,		XSTOP,		LastEmp)	
select 	vsrno,	itno,
	substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
	dcurr,		dcost,		dsheet,		arr,		xpay,
	vzero,		qccd,
	substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
	substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
	pqty,		xrate,		shrt,		strt,		chcs,
	fpurno,		
	substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
	fcost,		purno,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	rqno,		srno,		srno1,
	substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
	lcost,		xstop,		'SYSTEM'
from 	#tmp_pdpur103
where	len(vsrno)	<= 	5 and chgcd in ('A','R')

if @@error <> 0
	Begin
	Return
	End

-- 대구공조
delete from [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
where SupplierCode+ItemCode in (select rtrim(vsrno)+rtrim(itno) from #tmp_pdpur103
			where	len(vsrno)	<=	5)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
	(SupplierCode,	ItemCode,	
	ApplyDate,	
	CurrentUnit,	UnitCost,	SheetNo,	ARR,		XPAY,
	VZERO,		QCGubun,	
	QCApplyDate,	
	QCInDate,		
	PQTY,		XRATE,		ShareRate,	StartGubun,	ChangeCost,
	FPURNO,		
	FPINDT,
	FCOST,		PURNO,		
	PINDT,
	RQNO,		SRNO,		SRNO1,		
	DKDT,
	LCOST,		XSTOP,		LastEmp)	
select 	vsrno,	itno,
	substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
	dcurr,		dcost,		dsheet,		arr,		xpay,
	vzero,		qccd,
	substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
	substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
	pqty,		xrate,		shrt,		strt,		chcs,
	fpurno,		
	substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
	fcost,		purno,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	rqno,		srno,		srno1,
	substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
	lcost,		xstop,		'SYSTEM'
from 	#tmp_pdpur103
where	len(vsrno)	<= 	5  and chgcd in ('A','R')

if @@error <> 0
	Begin
	Return
	End

-- 여주전자
delete from [ipisyeo_svr\ipis].ipis.dbo.tmstpartcost
where SupplierCode+ItemCode in (select rtrim(vsrno)+rtrim(itno) from #tmp_pdpur103
			where	len(vsrno)	<=	5)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisyeo_svr\ipis].ipis.dbo.tmstpartcost
	(SupplierCode,	ItemCode,	
	ApplyDate,	
	CurrentUnit,	UnitCost,	SheetNo,	ARR,		XPAY,
	VZERO,		QCGubun,	
	QCApplyDate,	
	QCInDate,		
	PQTY,		XRATE,		ShareRate,	StartGubun,	ChangeCost,
	FPURNO,		
	FPINDT,
	FCOST,		PURNO,		
	PINDT,
	RQNO,		SRNO,		SRNO1,		
	DKDT,
	LCOST,		XSTOP,		LastEmp)	
select 	vsrno,	itno,
	substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
	dcurr,		dcost,		dsheet,		arr,		xpay,
	vzero,		qccd,
	substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
	substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
	pqty,		xrate,		shrt,		strt,		chcs,
	fpurno,		
	substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
	fcost,		purno,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	rqno,		srno,		srno1,
	substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
	lcost,		xstop,		'SYSTEM'
from 	#tmp_pdpur103
where	len(vsrno)	<= 	5  and chgcd in ('A','R')

if @@error <> 0
	Begin
	Return
	End

-- 진천
delete from [ipisjin_svr].ipis.dbo.tmstpartcost
where SupplierCode+ItemCode in (select rtrim(vsrno)+rtrim(itno) from #tmp_pdpur103
			where	len(vsrno)	<=	5)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisjin_svr].ipis.dbo.tmstpartcost
	(SupplierCode,	ItemCode,	
	ApplyDate,	
	CurrentUnit,	UnitCost,	SheetNo,	ARR,		XPAY,
	VZERO,		QCGubun,	
	QCApplyDate,	
	QCInDate,		
	PQTY,		XRATE,		ShareRate,	StartGubun,	ChangeCost,
	FPURNO,		
	FPINDT,
	FCOST,		PURNO,		
	PINDT,
	RQNO,		SRNO,		SRNO1,		
	DKDT,
	LCOST,		XSTOP,		LastEmp)	
select 	vsrno,	itno,
	substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
	dcurr,		dcost,		dsheet,		arr,		xpay,
	vzero,		qccd,
	substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
	substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
	pqty,		xrate,		shrt,		strt,		chcs,
	fpurno,		
	substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
	fcost,		purno,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	rqno,		srno,		srno1,
	substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
	lcost,		xstop,		'SYSTEM'
from 	#tmp_pdpur103
where	len(vsrno)	<= 	5  and chgcd in ('A','R')

if @@error <> 0
	Begin
	Return
	End

delete	From	pdpur103_log

Drop table #tmp_pdpur103


End		-- Procedure End

GO
