/*
	File Name	: sp_pisi_d_tsrorder_move.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrorder_move
	Description	: Download sr 이체
			  tsrorder, tsrheader
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
	@ls_chgdate		char(30),
	@ls_inputdate   char(10),
	@ls_inputtime   char(5),
	@ls_chgcd		char(1),
	@ls_srno		varchar(12),
	@ls_csrno		Varchar(8),
	@ls_csrno1		Varchar(2),
	@ls_csrno2		Varchar(2),
	@ls_xplant		char(1),	-- 의뢰 공장 지역
	@ls_div			char(1),	-- 의뢰 공장
	@ls_pdcd		varchar(4),
	@ls_itno		varchar(12),
	@ls_dudt		char(10),
	@ls_reqqt		int,
	@ls_cls			char(2),
	@ls_src			char(2),
	@ls_lot			int,
	@ls_slno		varchar(11),
	@ls_xplant1		char(1),	-- 불출 공장 지역
	@ls_div1		char(1),	-- 불출 공장
	@ls_istscd		char(1),	-- 이체구분(W-이체,C-이체Cancel)
	@ls_date		varchar(30)

	
select *
into	#tmp_pdinv601
from	pdinv601_log
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin

	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_inputdate = convert(char(10), cast( substring(chgdate,1,10) as datetime),102),
		@ls_inputtime = substring(chgdate,12,5),
		@ls_chgcd	= chgcd,
		@ls_srno	= rtrim(substring(srno, 1, 11)),	-- 11자리 2002.12.16
		@ls_csrno	= rtrim(substring(srno, 1, 8)),	-- 8자리 2002.12.16
		@ls_csrno1	= rtrim(substring(srno, 9, 2)),	-- 2자리 2002.12.16
		@ls_csrno2	= rtrim(substring(srno, 11, 2)),-- 2자리 2002.12.16
		@ls_xplant	= case istscd
									when 'C' then xplant1
									else xplant end,
		@ls_div		= case istscd
								when 'C' then div1
								else div end,
		@ls_pdcd	= pdcd,
		@ls_itno	= itno,
		@ls_dudt	= substring(dudt, 1, 4)+'.'+substring(dudt, 5, 2)+'.'+substring(dudt, 7, 2),
		@ls_reqqt	= reqqt,
		@ls_cls		= cls,
		@ls_src		= src,
		@ls_lot		= lot,
		@ls_slno	= slno,
		@ls_xplant1	= case istscd
									when 'C' then xplant
									else xplant1 end,
		@ls_div1	= case istscd
								when 'C' then div
								else div1 end,
		@ls_istscd	= istscd,
		@ls_date	= chgdate
	From	#tmp_pdinv601
	Where	chgdate > @ls_date

	If	(Select	count(*)
		 From	pdinv601_log
		 Where	chgdate 	<	@ls_chgdate	and
			srno		=	@ls_srno ) > 0
		begin
		continue
		end

	If @ls_chgcd = 'A' 	-- 추가
	Begin
		If @ls_xplant1 = 'D' and @ls_div1 = 'A'		-- 불출지역, 불출공장서버로 간다.
		begin
			-- 대구전장
				
			--이체
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin	
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
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
			
				If exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipisele_svr\ipis].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2,		Srno, Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2, ' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipisele_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End	
		end
			
		If (@ls_xplant1 = 'D' and (@ls_div1 = 'M' or @ls_div1 = 'S'))
		begin
			-- 대구기계
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
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
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
					
				If exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
				
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipismac_svr\ipis].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2, Srno,	Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2, ' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipismac_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End		
		end
		
		If (@ls_xplant1 = 'D' and (@ls_div1 = 'H' or @ls_div1 = 'V'))
		begin
			-- 대구공조
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
			
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
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
					
				If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipishvac_svr\ipis].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2, Srno,	Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2, ' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End	
		end
		
		If @ls_xplant1 = 'B'
		begin
			-- 부평물류
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
			
				If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
	
				insert into [ipisbup_svr\ipis].ipis.dbo.tsrorder
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
	
				If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tsrheader
						where	checksrno =  @ls_slno)
	
				insert into [ipisbup_svr\ipis].ipis.dbo.tsrheader
					(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
					SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
					
				If exists (select * from [ipisbup_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipisbup_svr\ipis].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2, Srno,	Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2, ' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipisbup_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End	
		end
		
		-- 군산물류
		If @ls_xplant1 = 'K'
		begin
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
			
				If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
	
				insert into [ipiskun_svr\ipis].ipis.dbo.tsrorder
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
	
				If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tsrheader
						where	checksrno =  @ls_slno)
	
				insert into [ipiskun_svr\ipis].ipis.dbo.tsrheader
					(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
					SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
					
				If exists (select * from [ipiskun_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipiskun_svr\ipis].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2, Srno,	Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2, ' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipiskun_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End	
		end
		
		If @ls_xplant1 = 'J'
		begin
			-- 진천
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
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
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
					
				If exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipisjin_svr].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipisjin_svr].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2, Srno,	Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2,	' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipisjin_svr].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End	
		end		
			
		If @ls_xplant1 = 'Y'
		begin
			-- 여주전자
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
			
				If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
	
				insert into [ipisyeo_svr\ipis].ipis.dbo.tsrorder
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
	
				If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrheader
						where	checksrno =  @ls_slno)
	
				insert into [ipisyeo_svr\ipis].ipis.dbo.tsrheader
					(SRAreaCode,		SRDivisionCode,		ShipGubun, 		
					SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
					ShipDate, 		CheckSRNo,		LastEmp, InputDate, InputTime)
				values	(@ls_xplant1,		@ls_div1,		'M',			
					substring(@ls_srno,4,1),substring(@ls_srno,5,1),substring(@ls_srno,6,3),substring(@ls_srno,9,2),
					@ls_dudt,		@ls_slno,			'SYSTEM', @ls_inputdate, @ls_inputtime)
					
				If exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrorder
					where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			--이체Cancel
						
			if @ls_istscd	=	'C'
			Begin	
				If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
	
				insert into [ipisyeo_svr\ipis].ipis.dbo.tShipBack
					(Csrno,			Csrno1,		Csrno2, Srno,	Billno, Itno,
					 Scustcd,		Xplant,		Div,		Dtype, Stype,
					 Rcqty,			Rpdt,		Invoice,	Normalqty,
					 Repairqty,		Defectqty,	Lastemp)
				values	(@ls_csrno,		@ls_Csrno1,	@ls_Csrno2, ' ', ' ', @ls_Itno,
					 @ls_xplant + @ls_div,	@ls_xplant1,	@ls_div1,	'M', ' ',
					 @ls_reqqt,		@ls_dudt,	@ls_slno,	0,
					 0,			0,		'SYSTEM')
				
				If exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_csrno	and
							csrno1	=	@ls_csrno1	and
							csrno2	=	@ls_csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End	
		end
			
	End	-- 추가 end
		
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		If @ls_xplant1 = 'D' and @ls_div1 = 'A'
		begin
			-- 대구전장
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
					
				delete	
				from	[ipisele_svr\ipis].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipisele_svr\ipis].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipisele_svr\ipis].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipisele_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
		end	
		
		If @ls_xplant1 = 'D' and (@ls_div1 = 'M' or @ls_div1 = 'S')
		begin
			-- 대구기계
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
				delete	
				from	[ipismac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipismac_svr\ipis].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipismac_svr\ipis].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipismac_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
		end	
			
		If (@ls_xplant1 = 'D' and (@ls_div1 = 'H' or @ls_div1 = 'V'))
		begin
			-- 대구공조
			if	( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
				delete	
				from	[ipishvac_svr\ipis].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipishvac_svr\ipis].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				
				If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipishvac_svr\ipis].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipishvac_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End		
		end	
    
    -- 부평물류
    If @ls_xplant1 = 'B'
		begin
			if	( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
				delete	
				from	[ipisbup_svr\ipis].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipisbup_svr\ipis].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				
				If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipisbup_svr\ipis].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipisbup_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End		
		end	
    
    -- 군산물류
    If @ls_xplant1 = 'K'
		begin
			if	( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
				delete	
				from	[ipiskun_svr\ipis].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipiskun_svr\ipis].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				
				If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipiskun_svr\ipis].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipiskun_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End		
		end
    
		If @ls_xplant1 = 'J'
		begin
			if ( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
				-- 진천
				delete	
				from	[ipisjin_svr].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipisjin_svr].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				
				If not exists (select * from [ipisjin_svr].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipisjin_svr].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipisjin_svr].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
		end	
			
		If @ls_xplant1 = 'Y'
		begin
			-- 여주전자
			if	( @ls_istscd	=	'W' or @ls_istscd	=	'T' )
			Begin
				
				delete	
				from	[ipisyeo_svr\ipis].ipis.dbo.tsrorder
				where	checksrno	= @ls_srno
	
				delete	
				from	[ipisyeo_svr\ipis].ipis.dbo.tsrheader
				where	checksrno	= @ls_srno
				
				
				If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tsrorder
						where	srno = @ls_srno and checksrno =  @ls_slno)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End
			
			if @ls_istscd	=	'C'
			Begin
				delete	
				from	[ipisyeo_svr\ipis].ipis.dbo.tShipBack
				where	csrno	=	@ls_Csrno	and
					csrno1	=	@ls_Csrno1	and
					csrno2	=	@ls_Csrno2
				
				If not exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tShipBack
						where	csrno	=	@ls_Csrno	and
							csrno1	=	@ls_Csrno1	and
							csrno2	=	@ls_Csrno2)
					delete from pdinv601_log
					where chgdate = @ls_chgdate
			End		
		end
			
	end	-- 삭제 end
			
End			-- While Loop End

if (select count(*) from pdinv601_log) = 0
	begin
		truncate table pdinv601_log
	end

drop table #tmp_pdinv601

End		-- Procedure End
Go
