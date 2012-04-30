/*
	File Name	: sp_pisi_d_tmstpartcost.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tmstpartcost
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

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_vsrno		varchar(8),
	@ls_itno		varchar(12),
	@ls_dadjdt		char(8),	-- �����ܰ�������
	@ld_dcost		decimal(13,2),	-- �����ܰ�
	@ls_xstop		char(1),	-- �ŷ��ߴܿ���
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdpur103
from	pdpur103
where	len(vsrno) = 5
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_vsrno	= rtrim(vsrno),
		@ls_itno	= rtrim(itno),
		@ls_date	= chgdate
	From	#tmp_pdpur103
	Where	chgdate > @ls_date

	If @ls_chgcd = 'A' 	-- �߰�
	Begin
		If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tmstpartcost
			Where	suppliercode = @ls_vsrno
			and	itemcode = @ls_itno)

			-- �뱸����
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
			select 	top 1 @ls_vsrno,	@ls_itno,
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
			from 	pur103_temp
			where	vsrno	= @ls_vsrno
			and	itno	= @ls_itno	

		If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tmstpartcost
			Where	suppliercode = @ls_vsrno
			and	itemcode = @ls_itno)
			
			-- �뱸���
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
			select 	top 1 @ls_vsrno,	@ls_itno,
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
			from 	pur103_temp
			where	vsrno	= @ls_vsrno
			and	itno	= @ls_itno	

		If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
			Where	suppliercode = @ls_vsrno
			and	itemcode = @ls_itno)

			-- �뱸����
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
			select 	top 1 @ls_vsrno,	@ls_itno,
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
			from 	pur103_temp
			where	vsrno	= @ls_vsrno
			and	itno	= @ls_itno	

		If not exists (select * from [ipisjin_svr].ipis.dbo.tmstpartcost
			Where	suppliercode = @ls_vsrno
			and	itemcode = @ls_itno)

			-- ��õ
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
			select 	top 1 @ls_vsrno,	@ls_itno,
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
			from 	pur103_temp
			where	vsrno	= @ls_vsrno
			and	itno	= @ls_itno	
			
	End	-- �߰� end
			
	
	If @ls_chgcd = 'R' 	-- ����
	Begin
	
		-- �뱸����	
		Delete	from [ipisele_svr\ipis].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno

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
		select 	top 1 @ls_vsrno,	@ls_itno,
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
		from 	pur103_temp
		where	vsrno	= @ls_vsrno
		and	itno	= @ls_itno	
		
		-- �뱸���	
		Delete	from [ipismac_svr\ipis].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno

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
		select 	top 1 @ls_vsrno,	@ls_itno,
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
		from 	pur103_temp
		where	vsrno	= @ls_vsrno
		and	itno	= @ls_itno	
		
		-- �뱸����	
		Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno

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
		select 	top 1 @ls_vsrno,	@ls_itno,
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
		from 	pur103_temp
		where	vsrno	= @ls_vsrno
		and	itno	= @ls_itno	
		
		-- ��õ	
		Delete	from [ipisjin_svr].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno

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
		select 	top 1 @ls_vsrno,	@ls_itno,
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
		from 	pur103_temp
		where	vsrno	= @ls_vsrno
		and	itno	= @ls_itno	
		
	End	-- ���� end	
			
	If @ls_chgcd = 'D' 	-- ����
	Begin
		
		-- �뱸����	
		Delete	from [ipisele_svr\ipis].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno
		
		-- �뱸���	
		Delete	from [ipismac_svr\ipis].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno
		
		-- �뱸����	
		Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno
		
		-- ��õ	
		Delete	from [ipisjin_svr].ipis.dbo.tmstpartcost
		Where	suppliercode = @ls_vsrno
		and	itemcode = @ls_itno
	
	End	-- ���� end	

End			-- While Loop End

--truncate table pur103_temp
Drop table #tmp_pdpur103

End		-- Procedure End
Go
