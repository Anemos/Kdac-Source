/*
	File Name	: sp_pisi_d_tplanddrs.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tplanddrs
	Description	: Download DDRS Plan
			  tmstplanddrs
			  여주전자 서버추가 : 2004.04.19
			  부평물류 서버추가 : 2005.10
			  군산물류 서버추가 : 2005.10
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tplanddrs]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tplanddrs]
GO

/*
Execute sp_pisi_d_tplanddrs '2003.01.06'
*/

Create Procedure sp_pisi_d_tplanddrs
	@ps_date		char(10)		-- 일자	
	
As
Begin

set xact_abort off
If Exists (select * from sle904 
		where bbsydt = substring(@ps_date,1,4)+substring(@ps_date,6,2)+substring(@ps_date,9,2))

Begin

Declare	@ls_date1		char(10),
	@ls_date2		char(10),
	@ls_date3		char(10),
	@ls_date4		char(10),
	@ls_date5		char(10),
	@ls_date6		char(10),
	@ls_date7		char(10),
	@ls_date8		char(10)

select	@ls_date1	= convert(char(10), dateadd(day, 1, @ps_date), 102)
select	@ls_date2	= convert(char(10), dateadd(day, 2, @ps_date), 102)
select	@ls_date3	= convert(char(10), dateadd(day, 3, @ps_date), 102)
select	@ls_date4	= convert(char(10), dateadd(day, 4, @ps_date), 102)
select	@ls_date5	= convert(char(10), dateadd(day, 5, @ps_date), 102)
select	@ls_date6	= convert(char(10), dateadd(day, 6, @ps_date), 102)
select	@ls_date7	= convert(char(10), dateadd(day, 7, @ps_date), 102)
select	@ls_date8	= convert(char(10), dateadd(day, 8, @ps_date), 102)
	
-- temp table
select	substring(bbsydt, 1, 4)+'.'+substring(bbsydt, 5, 2)+'.'+substring(bbsydt, 7,2) bbsydt,
	bbxplant,	bbdvsn,		bbitno1,
	sum(bbdqtd+bbdqtn) bbdqt,	sum(bbdqt1d+bbdqt1n) bbdqt1,	
	sum(bbdqt2) bbdqt2,		sum(bbdqt3) bbdqt3,
	sum(bbdqt4) bbdqt4,		sum(bbdqt5) bbdqt5,
	sum(bbdqt6) bbdqt6,		sum(bbdqt7) bbdqt7,
	sum(bbdqt8) bbdqt8
into	#tmp_sle904	
from	sle904
where	bbxplant <>''
and	bbdvsn <> ''
and	bbitno1 <> ''
group by substring(bbsydt, 1, 4)+'.'+substring(bbsydt, 5, 2)+'.'+substring(bbsydt, 7,2),
	bbxplant, bbdvsn,	bbitno1


-- 대구전장 
-- 당일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	Begin
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')
	
	if @@error <> 0
		Begin
		Return
		End
		
	End
Else	
	begin
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구전장 당일 + 1일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구전장 당일 + 2일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구전장 당일 + 3일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	begin	
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구전장 당일 + 4일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	BEGIN
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구전장 당일 + 5일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	BEGIN	
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구전장 당일 + 6일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	BEGIN	
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구전장 당일 + 7일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	BEGIN
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구전장 당일 + 8일
If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	begin
	insert into [ipisele_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('A')

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	Begin 
	update	[ipisele_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisele_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	End
	
Delete From sle904
where	bbxplant = 'D' 
and	bbdvsn in ('A')
	
if @@error <> 0
	Begin
	Return
	End

-- 대구기계 
-- 당일

If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	begin
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	end
	
Else	
	begin
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구기계 당일 + 1일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구기계 당일 + 2일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	BEGIN
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구기계 당일 + 3일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	BEGIN	
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구기계 당일 + 4일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	BEGIN
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
-- 대구기계 당일 + 5일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	BEGIN	
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구기계 당일 + 6일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	BEGIN	
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구기계 당일 + 7일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	BEGIN
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	BEGIN
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	END
	
-- 대구기계 당일 + 8일
If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	BEGIN
	insert into [ipismac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'D' 
	and	bbdvsn in ('M','S')

	if @@error <> 0
		Begin
		Return
		End

	END
Else	
	begin
	update	[ipismac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipismac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

Delete From sle904
where	bbxplant = 'D' 
and	bbdvsn in ('M','S')

if @@error <> 0
	Begin
	Return
	End
	
-- 대구공조 
-- 당일

If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	begin
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구공조 당일 + 1일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
	
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 대구공조 당일 + 2일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구공조 당일 + 3일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	begin	
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 대구공조 당일 + 4일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	begin
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,	
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구공조 당일 + 5일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	begin	
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,	
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구공조 당일 + 6일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	begin	
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구공조 당일 + 7일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	begin
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 대구공조 당일 + 8일
If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	begin
	insert into [ipishvac_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipishvac_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipishvac_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

Delete From sle904
where	(bbxplant = 'D' and	bbdvsn in ('H','V'))

if @@error <> 0
	Begin
	Return
	End

-- 부평물류
-- 당일

If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	begin
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 부평물류 당일 + 1일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
	
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 부평물류 당일 + 2일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 부평물류 당일 + 3일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	begin	
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 부평물류 당일 + 4일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	begin
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,	
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 부평물류 당일 + 5일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	begin	
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,	
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 부평물류 당일 + 6일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	begin	
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 부평물류 당일 + 7일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	begin
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 부평물류 당일 + 8일
If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	begin
	insert into [ipisbup_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'B'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisbup_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisbup_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

Delete From sle904
where	bbxplant = 'B'

if @@error <> 0
	Begin
	Return
	End

-- 군산물류
-- 당일

If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	begin
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 군산물류 당일 + 1일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
	
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 군산물류 당일 + 2일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 군산물류 당일 + 3일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	begin	
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 군산물류 당일 + 4일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	begin
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,	
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 군산물류 당일 + 5일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	begin	
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,	
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 군산물류 당일 + 6일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	begin	
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 군산물류 당일 + 7일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	begin
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 군산물류 당일 + 8일
If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	begin
	insert into [ipiskun_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'K'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipiskun_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipiskun_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

Delete From sle904
where	bbxplant = 'K'

if @@error <> 0
	Begin
	Return
	End

-- 여주전자 
-- 당일

If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	begin
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 여주전자 당일 + 1일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
	
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 여주전자 당일 + 2일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 여주전자 당일 + 3일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	begin	
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
-- 여주전자 당일 + 4일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	begin
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,	
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 여주전자 당일 + 5일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	begin	
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,	
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 여주전자 당일 + 6일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	begin	
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 여주전자 당일 + 7일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	begin
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 여주전자 당일 + 8일
If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	begin
	insert into [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'Y'

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisyeo_svr\ipis].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

Delete From sle904
where	bbxplant = 'Y'

if @@error <> 0
	Begin
	Return
	End

-- 진천
-- 당일

If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ps_date)
	begin
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	bbsydt,			bbxplant,		bbdvsn,			bbitno1,
		bbdqt,			bbdqt1,			bbdqt2,			bbdqt3,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt,	PlanQty01	= bbdqt1,
		PlanQty02	= bbdqt2,	PlanQty03	= bbdqt3,
		PlanQty04	= bbdqt4,	PlanQty05	= bbdqt5,
		PlanQty06	= bbdqt6,	PlanQty07	= bbdqt7,
		PlanQty08	= bbdqt8,	PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= bbsydt
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

-- 진천 당일 + 1일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date1)
	begin
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date1,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt1,			bbdqt2,			bbdqt3,			bbdqt4,	
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,	
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt1,	PlanQty01	= bbdqt2,
		PlanQty02	= bbdqt3,	PlanQty03	= bbdqt4,
		PlanQty04	= bbdqt5,	PlanQty05	= bbdqt6,
		PlanQty06	= bbdqt7,	PlanQty07	= bbdqt8,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date1
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 진천 당일 + 2일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date2)
	begin
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date2,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt2,			bbdqt3,			bbdqt4,			bbdqt5,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt2,	PlanQty01	= bbdqt3,
		PlanQty02	= bbdqt4,	PlanQty03	= bbdqt5,
		PlanQty04	= bbdqt6,	PlanQty05	= bbdqt7,
		PlanQty06	= bbdqt8,	PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date2
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 진천 당일 + 3일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date3)
	begin	
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date3,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt3,			bbdqt4,			bbdqt5,			bbdqt6,	
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt3,	PlanQty01	= bbdqt4,
		PlanQty02	= bbdqt5,	PlanQty03	= bbdqt6,
		PlanQty04	= bbdqt7,	PlanQty05	= bbdqt8,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date3
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 진천 당일 + 4일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date4)
	begin
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date4,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt4,			bbdqt5,			bbdqt6,			bbdqt7,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt4,	PlanQty01	= bbdqt5,
		PlanQty02	= bbdqt6,	PlanQty03	= bbdqt7,
		PlanQty04	= bbdqt8,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date4
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 진천 당일 + 5일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date5)
	begin	
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date5,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt5,			bbdqt6,			bbdqt7,			bbdqt8,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt5,	PlanQty01	= bbdqt6,
		PlanQty02	= bbdqt7,	PlanQty03	= bbdqt8,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date5
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 진천 당일 + 6일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date6)
	begin	
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date6,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt6,			bbdqt7,			bbdqt8,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt6,	PlanQty01	= bbdqt7,
		PlanQty02	= bbdqt8,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date6
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
	
-- 진천 당일 + 7일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date7)
	begin
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date7,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt7,			bbdqt8,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt7,	PlanQty01	= bbdqt8,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date7
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end

-- 진천 당일 + 8일
If not exists (select * from [ipisjin_svr].ipis.dbo.tplanddrs
		where	plandate = @ls_date8)
	begin
	insert into [ipisjin_svr].ipis.dbo.tplanddrs
		(PlanDate,		AreaCode,		DivisionCode,		ItemCode,
		PlanQty,			PlanQty01,		PlanQty02,		PlanQty03,
		PlanQty04,		PlanQty05,		PlanQty06,		PlanQty07,
		PlanQty08,		PlanQty09,		KDQty,			ASQty,
		EtcQty01,		EtcQty02,		EtcQty03,		LastEmp)
	select	@ls_date8,		bbxplant,		bbdvsn,			bbitno1,
		bbdqt8,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			0,
		0,			0,			0,			'SYSTEM'
	from	#tmp_sle904
	where	bbxplant = 'J' 

	if @@error <> 0
		Begin
		Return
		End

	end
Else	
	begin
	update	[ipisjin_svr].ipis.dbo.tplanddrs
	set	PlanQty		= bbdqt8,	PlanQty01	= 0,
		PlanQty02	= 0,	PlanQty03	= 0,
		PlanQty04	= 0,	PlanQty05	= 0,
		PlanQty06	= 0,		PlanQty07	= 0,
		PlanQty08	= 0,		PlanQty09	= 0		
	from	#tmp_sle904, [ipisjin_svr].ipis.dbo.tplanddrs
	where	plandate	= @ls_date8
	and	areacode	= bbxplant
	and	divisioncode	= bbdvsn
	and	itemcode	= bbitno1

	if @@error <> 0
		Begin
		Return
		End

	end
Delete From sle904
Where	bbxplant = 'J'

End

End		-- Procedure End
Go
