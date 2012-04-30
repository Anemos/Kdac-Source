SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*
Execute sp_pisi_d_tqbusinesstemp
*/

ALTER  Procedure sp_pisi_d_tqbusinesstemp
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_xplant		char(1),
	@ls_div			char(1),
	@ls_slno		varchar(12),
	@ls_dckdt		char(10),
	@ls_vndr		varchar(10),
	@ls_itno		varchar(12),
	@ls_dckqt		decimal(11,1),
	@ls_date		varchar(30),
	@ls_class		varchar(5),
	@ls_qccd		char(1)
	
Select	*
into	#tmp_pdinv201
from	pdinv201
order by chgdate	
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_xplant	= xplant,
		@ls_div		= div,
		@ls_slno	= slno,
		@ls_dckdt	= substring(dckdt, 1, 4) + substring(dckdt, 5, 2) + substring(dckdt, 7, 2),
		@ls_vndr	= vndr,
--		@ls_vndr	= case substring(vndr, 1, 1)	-- 외자인경우에는 I0000		2002.12.16
--					when 'D' then vndr
--					else 'I0000'
--					end,
		@ls_itno	= ltrim(rtrim(itno)),
		@ls_dckqt	= dckqt,
		@ls_qccd	= qccd,
		@ls_date	= chgdate
	From	#tmp_pdinv201
	Where	chgdate > @ls_date

/*	-- model master와 언밸런스날수도 있으므로 확인 보류
	-- 추가조건 item master join해서 itemclass 가 '24', '20' 인 놈은 취급 안한다...
	If @ls_xplant = 'D' and (@ls_div = 'A')
		Select	@ls_class = itemclass
		From	[ipisele_svr\ipis].ipis.dbo.tmstmodel
		Where	areacode = @ls_xplant
		and	divisioncode = @ls_div
		and	itemcode = @ls_itno
	If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
		Select	@ls_class = itemclass
		From	[ipismac_svr\ipis].ipis.dbo.tmstmodel
		Where	areacode = @ls_xplant
		and	divisioncode = @ls_div
		and	itemcode = @ls_itno
	If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or @ls_xplant = 'K' or @ls_xplant = 'Y'
		Select	@ls_class = itemclass
		From	[ipishvac_svr\ipis].ipis.dbo.tmstmodel
		Where	areacode = @ls_xplant
		and	divisioncode = @ls_div
		and	itemcode = @ls_itno
	If @ls_xplant = 'J'
		Select	@ls_class = itemclass
		From	[ipisele_svr\ipis].ipis.dbo.tmstmodel
		Where	areacode = @ls_xplant
		and	divisioncode = @ls_div
		and	itemcode = @ls_itno
*/		

--	If (rtrim(@ls_class) <> '24' and rtrim(@ls_class) <> '22') 
--	Begin
	
	If @ls_chgcd = 'A' or @ls_chgcd = 'R'	-- 추가 또는 수정건이면 있으면 insert 없으면 update
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'	-- 대구전장
		begin
			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
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
				end		
			
			Else 
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
					Set	DeliveryDate	= @ls_dckdt,
						SupplierCode	= @ls_vndr,
						ItemCode	= @ls_itno,
--						SupplierDeliveryQty	= SupplierDeliveryQty + @ls_dckqt,
						SupplierDeliveryQty	= @ls_dckqt,
						LastDate = Getdate()
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno
					
				end	
		end			

		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S') 	-- 대구기계
		begin
					
			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
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
				end
			Else 
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
--						SupplierDeliveryQty	= SupplierDeliveryQty + @ls_dckqt,
						SupplierDeliveryQty	= @ls_dckqt,
						LastDate = Getdate()
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno
				end	
		end			

		If @ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V') 	-- 대구공조
		begin

			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
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
				end	
			
			Else 
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
--						SupplierDeliveryQty	= SupplierDeliveryQty + @ls_dckqt,
						SupplierDeliveryQty	= @ls_dckqt,
						LastDate = Getdate()
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno
					
				end	
		end			
	
		If @ls_xplant = 'J' 	-- 진천
		begin
					
			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
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
				end	
			
			Else 
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
--						SupplierDeliveryQty	= SupplierDeliveryQty + @ls_dckqt,
						SupplierDeliveryQty	= @ls_dckqt,
						LastDate = Getdate()
					where	areacode	= @ls_xplant
					and	divisioncode	= @ls_div
					and	slno		= @ls_slno
				end	
		end			
			
	End	-- 추가/수정 end

	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		
		If @ls_xplant = 'D' and @ls_div = 'A'	-- 대구전장
			begin
			If exists (select *
					from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)		
		
			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
				delete	from [ipisele_svr\ipis].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
			Else				
				delete	from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
			end	
	
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S') 	-- 대구기계
			begin
			If exists (select *
					from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)		

			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
				delete	from [ipismac_svr\ipis].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
			Else				
				delete	from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
			end	

		If @ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V') 	-- 대구공조
			begin
			If exists (select *
					from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)		

			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
				delete	from [ipishvac_svr\ipis].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
			Else				
				delete	from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
			end	

		If @ls_xplant = 'J' 	-- 진천
			begin
			If exists (select *
					from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
					where	areacode = @ls_xplant
					and	divisioncode = @ls_div
					and	slno = @ls_slno)		

			If substring(@ls_vndr,1,1) <> 'D'	-- 외자
				delete	from [ipisjin_svr].ipis.dbo.TQQCRESULT  
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	deliveryno	= @ls_slno
			Else				
				delete	from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
				where	areacode	= @ls_xplant
				and	divisioncode	= @ls_div
				and	slno		= @ls_slno
			end	

	End	-- 삭제 end		

--	End 	-- 새조건(itemclass check) end	-- 보류
End			-- While Loop End

--Truncate table pdinv201

Drop table #tmp_pdinv201

End		-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

