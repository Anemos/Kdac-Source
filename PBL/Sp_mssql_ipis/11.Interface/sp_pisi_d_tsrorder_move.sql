/*
	File Name	: sp_pisi_d_tsrorder_move.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrorder_move
	Description	: Download sr 이체
			  tsrorder, tsrheader
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim

	-- SRAreaCode, SRDivisionCode - 불출공장
	-- MoveAreaCode, MoveDivisionCode - 의뢰공장
	-- CustCode(거래처) - 의뢰지역 + 의뢰공장 
	-- 데이타는 불출공장 서버로...
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrorder_move]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrorder_move]
GO

/*
Execute sp_pisi_d_tsrorder_move
*/

Create Procedure sp_pisi_d_tsrorder_move
	
	
As
Begin


Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_srno		varchar(12),
	@ls_xplant		char(1),	-- 의뢰 공장 지역
	@ls_div			char(1),	-- 의뢰 공장
	@ls_pdcd		varchar(4),
	@ls_itno		varchar(12),
	@ls_dudt		char(10),
	@ls_reqqt		int,
	@ls_cls			char(2),
	@ls_src			char(2),
	@ls_lot			int,
	@ls_slno		varchar(10),
	@ls_xplant1		char(1),	-- 불출 공장 지역
	@ls_div1		char(1),	-- 불출 공장
	@ls_date		varchar(30)

/*	
-- SR 이체 down log table
Insert	into pdinv601_log		
Select	*
from	pdinv601
order by chgdate

Truncate table pdinv601

Insert	into pdinv601
	(CHGDATE,	CHGCD,		SRNO,		XPLANT,		DIV,
	PDCD,		ITNO,		DUDT,		REQQT,		CLS,
	SRC,		LOT,		SLNO,		XPLANT1,	DIV1,
	STSCD,		DOWNDATE)
Select	CHGDATE,	CHGCD,		SRNO,		XPLANT,		DIV,
	PDCD,		ITNO,		DUDT,		REQQT,		CLS,
	SRC,		LOT,		SLNO,		XPLANT1,	DIV1,
	STSCD,		DOWNDATE
from	pdinv601_log
where	stscd = 'N'
order by chgdate
*/

select *
into	#tmp_pdinv601
from	pdinv601
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(substring(srno, 1, 11)),	-- 11자리 2002.12.16
		@ls_xplant	= xplant,
		@ls_div		= div,
		@ls_pdcd	= pdcd,
		@ls_itno	= itno,
		@ls_dudt	= substring(dudt, 1, 4)+'.'+substring(dudt, 5, 2)+'.'+substring(dudt, 7, 2),
		@ls_reqqt	= reqqt,
		@ls_cls		= cls,
		@ls_src		= src,
		@ls_lot		= lot,
		@ls_slno	= slno,
		@ls_xplant1	= xplant1,
		@ls_div1	= div1,
		@ls_date	= chgdate
	From	#tmp_pdinv601
	Where	chgdate > @ls_date

	If @ls_chgcd = 'A' 	-- 추가
	Begin
		If @ls_xplant1 = 'D' and @ls_div1 = 'A'		-- 불출지역, 불출공장서버로 간다.
		begin
			-- 대구전장
			If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)

			insert into [ipisele_svr\ipis].ipis.dbo.tsrorder
				(SRNo,			PCGubun,		PSRNo,			KitGubun,
				SRAreaCode, 		SRDivisionCode,		ShipGubun,		
				SRYear,			SRMonth,		SRSerial,		SRSplitCount,
				AreaCode,		DivisionCode,		ProductGroup,		ModelGroup,
				ProductCode,		ItemCode,		CustCode,		
				ApplyFrom,		ShipEditNo,		ShipOrderQty,		ShipRemainQty,
				ShipEndGubun,		SRCancelGubun,		CustomerItemNo,		ItemClass,
				ItemBuySource,		MoveLotQty,		MoveRequireNo,		MoveAreaCode,		
				MoveDivisionCode,	ShipUsage,		CheckSRNo,		stcd,		LastEmp)
			values	(@ls_srno,		'P',			@ls_srno,		'N',
				@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,2,1),substring(@ls_srno,3,1),substring(@ls_srno,4,3),substring(@ls_srno,7,2),
				@ls_xplant1,		@ls_div1,		substring(@ls_pdcd,1,2),substring(@ls_pdcd,1,3),
				substring(@ls_pdcd,1,4),@ls_itno, 		@ls_xplant + @ls_div,	
				@ls_dudt,		1,			@ls_reqqt,		@ls_reqqt,	
				'N',			'N',			@ls_itno, 		@ls_cls,
				@ls_src,		@ls_lot,		@ls_slno,		@ls_xplant,
				@ls_div,		'D',			@ls_slno,		'N',		'SYSTEM')

			If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrheader
					where	checksrno =  @ls_slno)
					
			insert into [ipisele_svr\ipis].ipis.dbo.tsrheader
				(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
				SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
				ShipDate, 		CheckSRNo,		LastEmp)
			values	(@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
				@ls_dudt,		@ls_slno,			'SYSTEM')
		end
			
		If (@ls_xplant1 = 'D' and (@ls_div1 = 'M' or @ls_div1 = 'S'))
		begin
			-- 대구기계
			If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)

			insert into [ipismac_svr\ipis].ipis.dbo.tsrorder
				(SRNo,			PCGubun,		PSRNo,			KitGubun,
				SRAreaCode, 		SRDivisionCode,		ShipGubun,		
				SRYear,			SRMonth,		SRSerial,		SRSplitCount,
				AreaCode,		DivisionCode,		ProductGroup,		ModelGroup,
				ProductCode,		ItemCode,		CustCode,		
				ApplyFrom,		ShipEditNo,		ShipOrderQty,		ShipRemainQty,
				ShipEndGubun,		SRCancelGubun,		CustomerItemNo,		ItemClass,
				ItemBuySource,		MoveLotQty,		MoveRequireNo,		MoveAreaCode,		
				MoveDivisionCode,	ShipUsage,		CheckSRNo,		stcd,		LastEmp)
			values	(@ls_srno,		'P',			@ls_srno,		'N',
				@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,2,1),substring(@ls_srno,3,1),substring(@ls_srno,4,3),substring(@ls_srno,7,2),
				@ls_xplant1,		@ls_div1,		substring(@ls_pdcd,1,2),substring(@ls_pdcd,1,3),
				substring(@ls_pdcd,1,4),@ls_itno, 		@ls_xplant + @ls_div,	
				@ls_dudt,		1,			@ls_reqqt,		@ls_reqqt,	
				'N',			'N',			@ls_itno, 		@ls_cls,
				@ls_src,		@ls_lot,		@ls_slno,		@ls_xplant,
				@ls_div,		'D',			@ls_slno,		'N',		'SYSTEM')

			If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrheader
					where	checksrno =  @ls_slno)

			insert into [ipismac_svr\ipis].ipis.dbo.tsrheader
				(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
				SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
				ShipDate, 		CheckSRNo,		LastEmp)
			values	(@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
				@ls_dudt,		@ls_slno,			'SYSTEM')
		end
		
		If (@ls_xplant1 = 'D' and (@ls_div1 = 'H' or @ls_div1 = 'V')) or (@ls_xplant1 = 'K') or (@ls_xplant1 = 'Y')
		begin
			-- 대구공조
			If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)

			insert into [ipishvac_svr\ipis].ipis.dbo.tsrorder
				(SRNo,			PCGubun,		PSRNo,			KitGubun,
				SRAreaCode, 		SRDivisionCode,		ShipGubun,		
				SRYear,			SRMonth,		SRSerial,		SRSplitCount,
				AreaCode,		DivisionCode,		ProductGroup,		ModelGroup,
				ProductCode,		ItemCode,		CustCode,		
				ApplyFrom,		ShipEditNo,		ShipOrderQty,		ShipRemainQty,
				ShipEndGubun,		SRCancelGubun,		CustomerItemNo,		ItemClass,
				ItemBuySource,		MoveLotQty,		MoveRequireNo,		MoveAreaCode,		
				MoveDivisionCode,	ShipUsage,		CheckSRNo,		stcd,		LastEmp)
			values	(@ls_srno,		'P',			@ls_srno,		'N',
				@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,2,1),substring(@ls_srno,3,1),substring(@ls_srno,4,3),substring(@ls_srno,7,2),
				@ls_xplant1,		@ls_div1,		substring(@ls_pdcd,1,2),substring(@ls_pdcd,1,3),
				substring(@ls_pdcd,1,4),@ls_itno, 		@ls_xplant + @ls_div,	
				@ls_dudt,		1,			@ls_reqqt,		@ls_reqqt,	
				'N',			'N',			@ls_itno, 		@ls_cls,
				@ls_src,		@ls_lot,		@ls_slno,		@ls_xplant,
				@ls_div,		'D',			@ls_slno,		'N',		'SYSTEM')

			If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrheader
					where	checksrno =  @ls_slno)

			insert into [ipishvac_svr\ipis].ipis.dbo.tsrheader
				(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
				SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
				ShipDate, 		CheckSRNo,		LastEmp)
			values	(@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
				@ls_dudt,		@ls_slno,			'SYSTEM')
		end
		
		If @ls_xplant1 = 'J'
		begin
			-- 진천
			If not exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)

			insert into [ipisjin_svr].ipis.dbo.tsrorder
				(SRNo,			PCGubun,		PSRNo,			KitGubun,
				SRAreaCode, 		SRDivisionCode,		ShipGubun,		
				SRYear,			SRMonth,		SRSerial,		SRSplitCount,
				AreaCode,		DivisionCode,		ProductGroup,		ModelGroup,
				ProductCode,		ItemCode,		CustCode,		
				ApplyFrom,		ShipEditNo,		ShipOrderQty,		ShipRemainQty,
				ShipEndGubun,		SRCancelGubun,		CustomerItemNo,		ItemClass,
				ItemBuySource,		MoveLotQty,		MoveRequireNo,		MoveAreaCode,		
				MoveDivisionCode,	ShipUsage,		CheckSRNo,		stcd,		LastEmp)
			values	(@ls_srno,		'P',			@ls_srno,		'N',
				@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,2,1),substring(@ls_srno,3,1),substring(@ls_srno,4,3),substring(@ls_srno,7,2),
				@ls_xplant1,		@ls_div1,		substring(@ls_pdcd,1,2),substring(@ls_pdcd,1,3),
				substring(@ls_pdcd,1,4),@ls_itno, 		@ls_xplant + @ls_div,	
				@ls_dudt,		1,			@ls_reqqt,		@ls_reqqt,	
				'N',			'N',			@ls_itno, 		@ls_cls,
				@ls_src,		@ls_lot,		@ls_slno,		@ls_xplant,
				@ls_div,		'D',			@ls_slno,		'N',		'SYSTEM')

			If not exists (select * from [ipisjin_svr].ipis.dbo.tsrheader
					where	checksrno =  @ls_slno)

			insert into [ipisjin_svr].ipis.dbo.tsrheader
				(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
				SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
				ShipDate, 		CheckSRNo,		LastEmp)
			values	(@ls_xplant1,		@ls_div1,		'M',			
				substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
				@ls_dudt,		@ls_slno,			'SYSTEM')
		end		
			
	End	-- 추가 end
		
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		If @ls_xplant1 = 'D' and @ls_div1 = 'A'
		begin
			-- 대구전장
			delete	
			from	[ipisele_svr\ipis].ipis.dbo.tsrorder
			where	checksrno	= @ls_srno

			delete	
			from	[ipisele_svr\ipis].ipis.dbo.tsrheader
			where	checksrno	= @ls_srno
		end	
		
		If @ls_xplant1 = 'D' and (@ls_div1 = 'M' or @ls_div1 = 'S')
		begin
			-- 대구기계
			delete	
			from	[ipismac_svr\ipis].ipis.dbo.tsrorder
			where	checksrno	= @ls_srno

			delete	
			from	[ipismac_svr\ipis].ipis.dbo.tsrheader
			where	checksrno	= @ls_srno
		end	
			
		If (@ls_xplant1 = 'D' and (@ls_div1 = 'H' or @ls_div1 = 'V')) or (@ls_xplant1 = 'K') or (@ls_xplant1 = 'Y')
		begin
			-- 대구공조
			delete	
			from	[ipishvac_svr\ipis].ipis.dbo.tsrorder
			where	checksrno	= @ls_srno

			delete	
			from	[ipishvac_svr\ipis].ipis.dbo.tsrheader
			where	checksrno	= @ls_srno
		end	

		If @ls_xplant1 = 'J'
		begin
			-- 진천
			delete	
			from	[ipisjin_svr].ipis.dbo.tsrorder
			where	checksrno	= @ls_srno

			delete	
			from	[ipisjin_svr].ipis.dbo.tsrheader
			where	checksrno	= @ls_srno
		end	
			
	end	-- 삭제 end
			
End			-- While Loop End

drop table #tmp_pdinv601

End		-- Procedure End
Go
