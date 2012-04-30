/*
	File Name	: sp_pisi_d_tqbusinesstemp.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tqbusinesstemp
	Description	: Download 납품현황
			  tqbusinesstemp
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tqbusinesstemp]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tqbusinesstemp]
GO

/*
Execute sp_pisi_d_tqbusinesstemp
*/

Create Procedure sp_pisi_d_tqbusinesstemp
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgdate		char(30),
	@ls_chgcd		char(1),
	@ls_xplant		char(1),
	@ls_div			char(1),
	@ls_slno		varchar(12),
	@ls_dckdt		char(10),
	@ls_vndr		varchar(10),
	@ls_itno		varchar(12),
	@ls_dckqt		decimal(11,1),
	@ls_class		varchar(5),
	@ls_qccd		char(1)


Select	*
into	#tmp_pdinv201
from	pdinv201_log
order by chgdate	
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_chgdate = ''

While @i < @li_loop_count
Begin
	
	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_xplant	= xplant,
		@ls_div		= div,
		@ls_slno	= slno,
		@ls_dckdt	= substring(dckdt, 1, 4) + substring(dckdt, 5, 2) + substring(dckdt, 7, 2),
		@ls_vndr	= vndr,
		@ls_itno	= ltrim(rtrim(itno)),
		@ls_dckqt	= dckqt,
		@ls_qccd	= qccd
	From	#tmp_pdinv201
	Where	chgdate > @ls_ChgDate

	if (Select	count(*)
		From	pdinv201_log
		Where	chgdate < @ls_Chgdate	and
			xplant	=	@ls_xplant	and
			div	=	@ls_div		and
			slno	=	@ls_slno	and
			vndr	=	@ls_vndr	and
			Itno	=	@ls_itno)	> 0
	    Begin
	    Continue
	    End	
	
	If @ls_chgcd = 'A' or @ls_chgcd = 'R'	-- 추가 또는 수정건이면 있으면 insert 없으면 update
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'	and -- 대구전장
		   substring(@ls_vndr,1,1) <> 'D'	-- 외자
		begin
			If not exists (select *
						from	[ipisele_svr\ipis].ipis.dbo.TQQCRESULT
						where	areacode = @ls_xplant
						and	divisioncode = @ls_div
						and	DELIVERYNO = @ls_slno)
				INSERT INTO [ipisele_svr\ipis].ipis.dbo.TQQCRESULT  
					( AREACODE,	DIVISIONCODE,	SUPPLIERCODE,		DELIVERYNO,
					ITEMCODE,	MAKEDATE,	
					CHARGENAME,	STANDARDREVNO,
					SUPPLIERLOTQTY,	KBCOUNT,	SUPPLIERDELIVERYQTY,	QCMETHOD,
					REMARK,		KDACREMARK,	
					JUDGEFLAG,	GOODQTY,
					BADQTY,		BADREASON,	BADMEMO,		INSPECTORCODE,
					CONFIRMCODE,	CONFIRMFLAG,	PRINTFLAG,		QCDATE,
					QCTIME,							QCLEADTIME,	
					QCKBFLAG,	SLNO,
					DELIVERYDATE,	
					DELIVERYTIME,	LASTEMP)  
				VALUES	( @ls_xplant,	@ls_div,	'I0000',		@ls_slno,
					@ls_itno,		CONVERT(CHAR(10), getdate(), 102),   
					'델파이',	'00',
					1,		0,		@ls_dckqt,		'1',
					@ls_vndr,	'외자품으로 자동 작성된 검사성적서입니다',
					'1',		@ls_dckqt,
					0,		' ',		' ',			'외자품',
					'외자품',	'Y',		'N',			CONVERT(CHAR(10), getdate(), 102),
					CONVERT(CHAR(8), getdate(), 108),			'0',
					'2',		@ls_slno,
					substring(@ls_dckdt,1,4) + '.' + substring(@ls_dckdt,5,2) + '.' + substring(@ls_dckdt,7,2),
					'00:00:00',	'Y')  
			If exists (select *	from	[ipisele_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	DELIVERYNO = @ls_slno)
					delete	from pdinv201_log
					where chgdate =	@ls_chgdate
		End
		
		If @ls_xplant = 'D' and @ls_div = 'A'	and -- 대구전장
		   substring(@ls_vndr,1,1) = 'D'	-- 내자
		begin
			If not exists (select *
					from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)
				Insert Into [ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
					(AreaCode,	Divisioncode,	SlNo,		
					DeliveryDate,
					SupplierCode,	ItemCode,	SupplierDeliveryQty,	QCGubun,
					JudgeFlag,	GoodQty,	BadQty,			LastEmp)
				Values (@ls_xplant,	@ls_div,	@ls_slno,	
					@ls_dckdt,
					@ls_vndr,	@ls_itno,	@ls_dckqt,		@ls_qccd,
					'9',		0,		0,			'SYSTEM')
			Else
				Update	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
				Set	DeliveryDate		= @ls_dckdt,
					SupplierCode		= @ls_vndr,
					ItemCode		= @ls_itno,
					SupplierDeliveryQty	= @ls_dckqt,
					LastDate = Getdate()
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
			If exists (select *	from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
						where	areacode = @ls_xplant
						and	divisioncode	= @ls_div
						and	slno		= @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End			

		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S') 	-- 대구기계
			and substring(@ls_vndr,1,1) <> 'D'	-- 외자
		begin
			If not exists (select *
					from	[ipismac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	DELIVERYNO = @ls_slno)
				INSERT INTO [ipismac_svr\ipis].ipis.dbo.TQQCRESULT  
					( AREACODE,	DIVISIONCODE,	SUPPLIERCODE,		DELIVERYNO,
					ITEMCODE,	MAKEDATE,	
					CHARGENAME,	STANDARDREVNO,
					SUPPLIERLOTQTY,	KBCOUNT,	SUPPLIERDELIVERYQTY,	QCMETHOD,
					REMARK,		KDACREMARK,	
					JUDGEFLAG,	GOODQTY,
					BADQTY,		BADREASON,	BADMEMO,		INSPECTORCODE,
					CONFIRMCODE,	CONFIRMFLAG,	PRINTFLAG,		QCDATE,
					QCTIME,							QCLEADTIME,	
					QCKBFLAG,	SLNO,
					DELIVERYDATE,	
					DELIVERYTIME,	LASTEMP)  
				VALUES	( @ls_xplant,	@ls_div,	'I0000',		@ls_slno,
					@ls_itno,		CONVERT(CHAR(10), getdate(), 102),   
					'델파이',	'00',
					1,		0,		@ls_dckqt,		'1',
					@ls_vndr,	'외자품으로 자동 작성된 검사성적서입니다',
					'1',		@ls_dckqt,
					0,		' ',		' ',			'외자품',
					'외자품',	'Y',		'N',			CONVERT(CHAR(10), getdate(), 102),
					CONVERT(CHAR(8), getdate(), 108),			'0',
					'2',		@ls_slno,
					substring(@ls_dckdt,1,4) + '.' + substring(@ls_dckdt,5,2) + '.' + substring(@ls_dckdt,7,2),
					'00:00:00',	'Y')  
			If exists (select *	from	[ipismac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	DELIVERYNO = @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End
		
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S') 	-- 대구기계
			and substring(@ls_vndr,1,1) = 'D'	-- 내자
		begin
			If not exists (select *
					from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)
				Insert Into [ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
					(AreaCode,	Divisioncode,	SlNo,		
					DeliveryDate,
					SupplierCode,	ItemCode,	SupplierDeliveryQty,	QCGubun,
					JudgeFlag,	GoodQty,	BadQty,			LastEmp)
				Values (@ls_xplant,	@ls_div,	@ls_slno,	
					@ls_dckdt,
					@ls_vndr,	@ls_itno,	@ls_dckqt,		@ls_qccd,
					'9',		0,		0,			'SYSTEM')
			Else
				Update	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
				Set	DeliveryDate	= @ls_dckdt,
					SupplierCode	= @ls_vndr,
					ItemCode	= @ls_itno,
					SupplierDeliveryQty	= @ls_dckqt,
					LastDate = Getdate()
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
				
			If exists (select *	from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End			

		If ((@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y')  	-- 대구공조
			and substring(@ls_vndr,1,1) <> 'D'	-- 외자
		begin
			If not exists (select *
					from	[ipishvac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	DELIVERYNO = @ls_slno)
				INSERT INTO [ipishvac_svr\ipis].ipis.dbo.TQQCRESULT  
					( AREACODE,	DIVISIONCODE,	SUPPLIERCODE,		DELIVERYNO,
					ITEMCODE,	MAKEDATE,	
					CHARGENAME,	STANDARDREVNO,
					SUPPLIERLOTQTY,	KBCOUNT,	SUPPLIERDELIVERYQTY,	QCMETHOD,
					REMARK,		KDACREMARK,	
					JUDGEFLAG,	GOODQTY,
					BADQTY,		BADREASON,	BADMEMO,		INSPECTORCODE,
					CONFIRMCODE,	CONFIRMFLAG,	PRINTFLAG,		QCDATE,
					QCTIME,							QCLEADTIME,	
					QCKBFLAG,	SLNO,
					DELIVERYDATE,	
					DELIVERYTIME,	LASTEMP)  
				VALUES	( @ls_xplant,	@ls_div,	'I0000',		@ls_slno,
					@ls_itno,		CONVERT(CHAR(10), getdate(), 102),   
					'델파이',	'00',
					1,		0,		@ls_dckqt,		'1',
					@ls_vndr,	'외자품으로 자동 작성된 검사성적서입니다',
					'1',		@ls_dckqt,
					0,		' ',		' ',			'외자품',
					'외자품',	'Y',		'N',			CONVERT(CHAR(10), getdate(), 102),
					CONVERT(CHAR(8), getdate(), 108),			'0',
					'2',		@ls_slno,
					substring(@ls_dckdt,1,4) + '.' + substring(@ls_dckdt,5,2) + '.' + substring(@ls_dckdt,7,2),
					'00:00:00',	'Y')  
			If exists (select *	from	[ipishvac_svr\ipis].ipis.dbo.TQQCRESULT
						where	areacode = @ls_xplant
						and	divisioncode = @ls_div
						and	DELIVERYNO = @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End		
			
		If ((@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y') 	-- 대구공조
			and substring(@ls_vndr,1,1) = 'D'	-- 내자
		begin
			If not exists (select *
					from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
					(AreaCode,	Divisioncode,	SlNo,		
					DeliveryDate,
					SupplierCode,	ItemCode,	SupplierDeliveryQty,	QCGubun,
					JudgeFlag,	GoodQty,	BadQty,			LastEmp)
				Values (@ls_xplant,	@ls_div,	@ls_slno,	
					@ls_dckdt,
					@ls_vndr,	@ls_itno,	@ls_dckqt,		@ls_qccd,
					'9',		0,		0,			'SYSTEM')
			Else
				Update	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
				Set	DeliveryDate	= @ls_dckdt,
					SupplierCode	= @ls_vndr,
					ItemCode	= @ls_itno,
					SupplierDeliveryQty	= @ls_dckqt,
					LastDate = Getdate()
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
				
			If exists (select *	from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End			
	
		If @ls_xplant = 'J' 	-- 진천
			and	substring(@ls_vndr,1,1) <> 'D'	-- 외자
		begin
			If not exists (select *
					from	[ipisjin_svr].ipis.dbo.TQQCRESULT
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	DELIVERYNO = @ls_slno)
				INSERT INTO [ipisjin_svr].ipis.dbo.TQQCRESULT  
					( AREACODE,	DIVISIONCODE,	SUPPLIERCODE,		DELIVERYNO,
					ITEMCODE,	MAKEDATE,	
					CHARGENAME,	STANDARDREVNO,
					SUPPLIERLOTQTY,	KBCOUNT,	SUPPLIERDELIVERYQTY,	QCMETHOD,
					REMARK,		KDACREMARK,	
					JUDGEFLAG,	GOODQTY,
					BADQTY,		BADREASON,	BADMEMO,		INSPECTORCODE,
					CONFIRMCODE,	CONFIRMFLAG,	PRINTFLAG,		QCDATE,
					QCTIME,							QCLEADTIME,	
					QCKBFLAG,	SLNO,
					DELIVERYDATE,	
					DELIVERYTIME,	LASTEMP)  
				VALUES	( @ls_xplant,	@ls_div,	'I0000',		@ls_slno,
					@ls_itno,		CONVERT(CHAR(10), getdate(), 102),   
					'델파이',	'00',
					1,		0,		@ls_dckqt,		'1',
					@ls_vndr,	'외자품으로 자동 작성된 검사성적서입니다',
					'1',		@ls_dckqt,
					0,		' ',		' ',			'외자품',
					'외자품',	'Y',		'N',			CONVERT(CHAR(10), getdate(), 102),
					CONVERT(CHAR(8), getdate(), 108),			'0',
					'2',		@ls_slno,
					substring(@ls_dckdt,1,4) + '.' + substring(@ls_dckdt,5,2) + '.' + substring(@ls_dckdt,7,2),
					'00:00:00',	'Y')
			If exists (select *	from	[ipisjin_svr].ipis.dbo.TQQCRESULT
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	DELIVERYNO = @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End

		If @ls_xplant = 'J' 	-- 진천
			and	substring(@ls_vndr,1,1) = 'D'	-- 내자
		begin
			If not exists (select *
					from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)
				Insert Into [ipisjin_svr].ipis.dbo.tqbusinesstemp
					(AreaCode,	Divisioncode,	SlNo,		
					DeliveryDate,
					SupplierCode,	ItemCode,	SupplierDeliveryQty,	QCGubun,
					JudgeFlag,	GoodQty,	BadQty,			LastEmp)
				Values (@ls_xplant,	@ls_div,	@ls_slno,	
					@ls_dckdt,
					@ls_vndr,	@ls_itno,	@ls_dckqt,		@ls_qccd,
					'9',		0,		0,			'SYSTEM')
			Else
				Update	[ipisjin_svr].ipis.dbo.tqbusinesstemp
				Set	DeliveryDate	= @ls_dckdt,
					SupplierCode	= @ls_vndr,
					ItemCode	= @ls_itno,
					SupplierDeliveryQty	= @ls_dckqt,
					LastDate = Getdate()
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
				
			If exists (select *	from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				delete	from pdinv201_log
				where chgdate =	@ls_chgdate
		End
	
	End	-- 추가/수정 -----End

	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		
		If @ls_xplant = 'D' and @ls_div = 'A'	-- 대구전장
			and substring(@ls_vndr,1,1) <> 'D'	-- 외자
		Begin
				If exists (select *
						from	[ipisele_svr\ipis].ipis.dbo.TQQCRESULT
						where	areacode	= @ls_xplant
						and	divisioncode	= @ls_div
						and	slno		= @ls_slno)
					delete	from [ipisele_svr\ipis].ipis.dbo.TQQCRESULT  
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	deliveryno	= @ls_slno
			
				If not exists (select *
						from	[ipisele_svr\ipis].ipis.dbo.TQQCRESULT
						where	areacode	= @ls_xplant
						and	divisioncode	= @ls_div
						and	slno		= @ls_slno)
					Delete	from pdinv201_log
					Where ChgDate =	@ls_chgdate
			
		End
		
		If @ls_xplant = 'D' and @ls_div = 'A'	-- 대구전장
			and substring(@ls_vndr,1,1) = 'D'	-- 내자
		Begin
			If exists (select *
				from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno)
				delete	from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
				
			If not exists (select *
					from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End
				
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S') 	-- 대구기계
			and substring(@ls_vndr,1,1) <> 'D'	-- 외자
		Begin
			If exists (select *
					from	[ipismac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				delete	from [ipismac_svr\ipis].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
		
			If not exists (select *
					from	[ipismac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End
		
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S') 	-- 대구기계
			and substring(@ls_vndr,1,1) = 'D'	-- 내자
		Begin
			If exists (select *
				from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno)
				delete	from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
					
			If not exists (select *
					from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End
	

		If ((@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y') 	-- 대구공조
			and substring(@ls_vndr,1,1) <> 'D'	-- 외자
		Begin
			If exists (select *
					from	[ipishvac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				delete	from [ipishvac_svr\ipis].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
			
			If not exists (select *
					from	[ipishvac_svr\ipis].ipis.dbo.TQQCRESULT
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End
		
		If ((@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y') 	-- 대구공조
			and substring(@ls_vndr,1,1) = 'D'	-- 내자
		Begin
			If exists (select *
				from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno)
				delete	from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
			
			If not exists (select *
					from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End	
	
		If @ls_xplant = 'J' 	-- 진천
			and	substring(@ls_vndr,1,1) <> 'D'	-- 외자
			
		Begin
			If exists (select *
					from	[ipisjin_svr].ipis.dbo.TQQCRESULT
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				delete	from [ipisjin_svr].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
	
			If not exists (select *
					from	[ipisjin_svr].ipis.dbo.TQQCRESULT
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End
	
		If @ls_xplant = 'J' 	-- 진천
			and	substring(@ls_vndr,1,1) = 'D'	-- 내자
	
		Begin
			If exists (select *
				from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno)
				delete	from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
						
			If not exists (select *
					from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno)
				Delete	from pdinv201_log
				Where ChgDate =	@ls_chgdate
		End	
	
	End	-- 삭제 -----End		

End			-- While Loop -----End

if (select count(*) from pdinv201_log) = 0
	begin
		truncate table pdinv201_log
	End

Drop table #tmp_pdinv201

End		-- Procedure -----End
Go
