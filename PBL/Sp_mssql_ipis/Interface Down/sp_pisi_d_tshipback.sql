/*
	File Name	: sp_pisi_d_tshipback.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tshipback
	Description	: Download Item
			  tmstitem
			  여주공장 서버추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tshipback]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tshipback]
GO

/*
Execute sp_pisi_d_tshipback
*/

Create Procedure sp_pisi_d_tshipback
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgdate		char(30),
	@ls_chgcd		char(1),
	@ls_csrno		varchar(8),
	@ls_csrno1		varchar(2),
	@ls_csrno2		varchar(2),
	@ls_dtype		varchar(1),
	@ls_citno		varchar(20),
	@ls_itno		varchar(12),
	@ls_scustcd		varchar(6),
	@ls_srno		varchar(11),
	@ls_xplant		char(1),
	@ls_div			char(1),
	@ls_stype		char(1),
	@ls_cnlcd		char(1),
	@ls_invoice		varchar(20),
	@ls_dcqty		numeric(5, 1),
	@ls_scqty		numeric(5, 1),
	@ls_rcqty		numeric(5, 1),
	@ls_slno		varchar(11),
	@ls_date		varchar(30),
	@ls_ErrorCode		Char(2)

Select	*
into	#tmp_pdsle501
from	pdsle501_log
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	
	select @ls_errorcode	=	'00'
	
	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_csrno	= csrno,
		@ls_csrno1	= csrno1,
		@ls_csrno2	= csrno2,
		@ls_dtype	= dtype,
		@ls_citno	= citno,
		@ls_itno	= itno,
		@ls_scustcd	= scustcd,
		@ls_srno	= srno,
		@ls_xplant	= xplant,
		@ls_div		= div,
		@ls_stype	= stype,
		@ls_cnlcd	= cnlcd,
		@ls_invoice	= invoice,
		@ls_dcqty	= dcqty*(-1),	-- 무조건 마이너스를 곱한다	2003.02.26
		@ls_scqty	= scqty*(-1),	-- 무조건 마이너스를 곱한다	2003.02.26
		@ls_rcqty	= rcqty*(-1),	-- 무조건 마이너스를 곱한다	2002.12.16
		@ls_slno	= substring(slno,1,4)+'.'+substring(slno,5,2)+'.'+substring(slno,7,2),
		@ls_date	= chgdate
	From	#tmp_pdSle501
	Where	chgdate > @ls_date

	if (select Count(*) From pdsle501_log
	   Where  Chgdate < @ls_Chgdate	and
	   	  csrno		=	@ls_Csrno	and
	   	  Csrno1	=	@ls_Csrno1	and
	   	  csrno2	=	@ls_csrno2)	>	0
	   Begin
	   Continue
	   End
	
	If @ls_chgcd = 'A' 	-- 추가
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
			-- 대구전장
			Begin
				insert into [ipisele_svr\ipis].ipis.dbo.tshipback
					(CSRNo,		CSRNo1,		CSRNo2,		DType,
					CItNo,		ItNo,		SCustCD,	SRNo,		
					XPlant,		Div,		SType,
					RCQty,		RPDT,		CNLCD,		INVOICE,	
					NormalQty,	RepairQty,	DefectQty,	LastEmp)
				values( @ls_csrno,	@ls_csrno1,	@ls_csrno2,	@ls_dtype,
					@ls_citno,	@ls_itno,	@ls_scustcd,	@ls_srno,
					@ls_xplant,	@ls_div,	@ls_stype,
					@ls_dcqty,	@ls_slno,	@ls_cnlcd,	@ls_invoice,	
					0,			0,	0,		'SYSTEM')	
			
				if Exists (Select * From [ipisele_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
			

		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
			-- 대구기계
			Begin
				insert into [ipismac_svr\ipis].ipis.dbo.tshipback
					(CSRNo,		CSRNo1,		CSRNo2,		DType,
					CItNo,		ItNo,		SCustCD,	SRNo,		
					XPlant,		Div,		SType,
					RCQty,		RPDT,		CNLCD,		INVOICE,	
					NormalQty,	RepairQty,	DefectQty,	LastEmp)
				values( @ls_csrno,	@ls_csrno1,	@ls_csrno2,	@ls_dtype,
					@ls_citno,	@ls_itno,	@ls_scustcd,	@ls_srno,
					@ls_xplant,	@ls_div,	@ls_stype,
					@ls_dcqty,	@ls_slno,	@ls_cnlcd,	@ls_invoice,	
					0,			0,	0,		'SYSTEM')	
			
				if Exists (Select * From [ipismac_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
	
		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or (@ls_xplant = 'K')
			-- 대구공조
			Begin
				insert into [ipishvac_svr\ipis].ipis.dbo.tshipback
					(CSRNo,		CSRNo1,		CSRNo2,		DType,
					CItNo,		ItNo,		SCustCD,	SRNo,		
					XPlant,		Div,		SType,
					RCQty,		RPDT,		CNLCD,		INVOICE,	
					NormalQty,	RepairQty,	DefectQty,	LastEmp)
				values( @ls_csrno,	@ls_csrno1,	@ls_csrno2,	@ls_dtype,
					@ls_citno,	@ls_itno,	@ls_scustcd,	@ls_srno,
					@ls_xplant,	@ls_div,	@ls_stype,
					@ls_dcqty,	@ls_slno,	@ls_cnlcd,	@ls_invoice,	
					0,			0,	0,		'SYSTEM')	
			
				if Exists (Select * From [ipishvac_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
			
		If @ls_xplant = 'J'
			-- 진천
			Begin
				insert into [ipisjin_svr].ipis.dbo.tshipback
					(CSRNo,		CSRNo1,		CSRNo2,		DType,
					CItNo,		ItNo,		SCustCD,	SRNo,		
					XPlant,		Div,		SType,
					RCQty,		RPDT,		CNLCD,		INVOICE,	
					NormalQty,	RepairQty,	DefectQty,	LastEmp)
				values( @ls_csrno,	@ls_csrno1,	@ls_csrno2,	@ls_dtype,
					@ls_citno,	@ls_itno,	@ls_scustcd,	@ls_srno,
					@ls_xplant,	@ls_div,	@ls_stype,
					@ls_dcqty,	@ls_slno,	@ls_cnlcd,	@ls_invoice,	
					0,			0,	0,		'SYSTEM')	
			
				if Exists (Select * From [ipisjin_svr].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
			
		If @ls_xplant = 'Y'
			-- 여주전자
			Begin
				insert into [ipisyeo_svr\ipis].ipis.dbo.tshipback
					(CSRNo,		CSRNo1,		CSRNo2,		DType,
					CItNo,		ItNo,		SCustCD,	SRNo,		
					XPlant,		Div,		SType,
					RCQty,		RPDT,		CNLCD,		INVOICE,	
					NormalQty,	RepairQty,	DefectQty,	LastEmp)
				values( @ls_csrno,	@ls_csrno1,	@ls_csrno2,	@ls_dtype,
					@ls_citno,	@ls_itno,	@ls_scustcd,	@ls_srno,
					@ls_xplant,	@ls_div,	@ls_stype,
					@ls_dcqty,	@ls_slno,	@ls_cnlcd,	@ls_invoice,	
					0,			0,	0,		'SYSTEM')	
			
				if Exists (Select * From [ipisyeo_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
			
	End	-- 추가 end
	
	If @ls_chgcd = 'R' 	-- 수정
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
			-- 대구전장
			Begin
			
			update	[ipisele_svr\ipis].ipis.dbo.tshipback
			set	DType	= @ls_dtype,
				CItNo	= @ls_citno,
				ItNo	= @ls_itno,
				SCustCD	= @ls_scustcd,				
				XPlant	= @ls_xplant,
				Div	= @ls_div,
				SType	= @ls_stype,
				RCQty	= @ls_dcqty,
				RPDT	= @ls_slno,
				CNLCD	= @ls_cnlcd,
				INVOICE	= @ls_invoice,
				SRNo	= @ls_srno,
				LastDate = Getdate()
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
			
			if Exists (Select * From [ipisele_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2	and
							DType	= 	@ls_dtype	and
							CItNo	= 	@ls_citno	and
							ItNo	= 	@ls_itno	and
							SCustCD	= 	@ls_scustcd	and
							XPlant	= 	@ls_xplant	and
							Div	= 	@ls_div		and
							SType	= 	@ls_stype	and
							RCQty	=	@ls_dcqty	and
							RPDT	= 	@ls_slno	and
							CNLCD	= 	@ls_cnlcd	and
							INVOICE	=	@ls_invoice	and
							SRNo	= 	@ls_srno)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
			-- 대구기계
			Begin
			
			update	[ipismac_svr\ipis].ipis.dbo.tshipback
			set	DType	= @ls_dtype,
				CItNo	= @ls_citno,
				ItNo	= @ls_itno,
				SCustCD	= @ls_scustcd,				
				XPlant	= @ls_xplant,
				Div	= @ls_div,
				SType	= @ls_stype,
				RCQty	= @ls_dcqty,
				RPDT	= @ls_slno,
				CNLCD	= @ls_cnlcd,
				INVOICE	= @ls_invoice,
				SRNo	= @ls_srno,
				LastDate = Getdate()
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
			
			if Exists (Select * From [ipismac_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2	and
							DType	= 	@ls_dtype	and
							CItNo	= 	@ls_citno	and
							ItNo	= 	@ls_itno	and
							SCustCD	= 	@ls_scustcd	and
							XPlant	= 	@ls_xplant	and
							Div	= 	@ls_div		and
							SType	= 	@ls_stype	and
							RCQty	=	@ls_dcqty	and
							RPDT	= 	@ls_slno	and
							CNLCD	= 	@ls_cnlcd	and
							INVOICE	=	@ls_invoice	and
							SRNo	= 	@ls_srno)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End

		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or (@ls_xplant = 'K')
			-- 대구공조
			Begin
			
			update	[ipishvac_svr\ipis].ipis.dbo.tshipback
			set	DType	= @ls_dtype,
				CItNo	= @ls_citno,
				ItNo	= @ls_itno,
				SCustCD	= @ls_scustcd,				
				XPlant	= @ls_xplant,
				Div	= @ls_div,
				SType	= @ls_stype,
				RCQty	= @ls_dcqty,
				RPDT	= @ls_slno,
				CNLCD	= @ls_cnlcd,
				INVOICE	= @ls_invoice,
				SRNo	= @ls_srno,
				LastDate = Getdate()
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
			
			if Exists (Select * From [ipishvac_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2	and
							DType	= 	@ls_dtype	and
							CItNo	= 	@ls_citno	and
							ItNo	= 	@ls_itno	and
							SCustCD	= 	@ls_scustcd	and
							XPlant	= 	@ls_xplant	and
							Div	= 	@ls_div		and
							SType	= 	@ls_stype	and
							RCQty	=	@ls_dcqty	and
							RPDT	= 	@ls_slno	and
							CNLCD	= 	@ls_cnlcd	and
							INVOICE	=	@ls_invoice	and
							SRNo	= 	@ls_srno)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End

		If @ls_xplant = 'J'
			-- 진천
			Begin
			
			update	[ipisjin_svr].ipis.dbo.tshipback
			set	DType	= @ls_dtype,
				CItNo	= @ls_citno,
				ItNo	= @ls_itno,
				SCustCD	= @ls_scustcd,				
				XPlant	= @ls_xplant,
				Div	= @ls_div,
				SType	= @ls_stype,
				RCQty	= @ls_dcqty,
				RPDT	= @ls_slno,
				CNLCD	= @ls_cnlcd,
				INVOICE	= @ls_invoice,
				SRNo	= @ls_srno,
				LastDate = Getdate()
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
			
			if Exists (Select * From [ipisjin_svr].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2	and
							DType	= 	@ls_dtype	and
							CItNo	= 	@ls_citno	and
							ItNo	= 	@ls_itno	and
							SCustCD	= 	@ls_scustcd	and
							XPlant	= 	@ls_xplant	and
							Div	= 	@ls_div		and
							SType	= 	@ls_stype	and
							RCQty	=	@ls_dcqty	and
							RPDT	= 	@ls_slno	and
							CNLCD	= 	@ls_cnlcd	and
							INVOICE	=	@ls_invoice	and
							SRNo	= 	@ls_srno)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
	
	  If @ls_xplant = 'Y'
			-- 여주전자
			Begin
			
			update	[ipisyeo_svr\ipis].ipis.dbo.tshipback
			set	DType	= @ls_dtype,
				CItNo	= @ls_citno,
				ItNo	= @ls_itno,
				SCustCD	= @ls_scustcd,				
				XPlant	= @ls_xplant,
				Div	= @ls_div,
				SType	= @ls_stype,
				RCQty	= @ls_dcqty,
				RPDT	= @ls_slno,
				CNLCD	= @ls_cnlcd,
				INVOICE	= @ls_invoice,
				SRNo	= @ls_srno,
				LastDate = Getdate()
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
			
			if Exists (Select * From [ipisyeo_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2	and
							DType	= 	@ls_dtype	and
							CItNo	= 	@ls_citno	and
							ItNo	= 	@ls_itno	and
							SCustCD	= 	@ls_scustcd	and
							XPlant	= 	@ls_xplant	and
							Div	= 	@ls_div		and
							SType	= 	@ls_stype	and
							RCQty	=	@ls_dcqty	and
							RPDT	= 	@ls_slno	and
							CNLCD	= 	@ls_cnlcd	and
							INVOICE	=	@ls_invoice	and
							SRNo	= 	@ls_srno)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
	
	end	-- 수정 end
		
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
			-- 대구전장
			Begin
				delete	
				from	[ipisele_svr\ipis].ipis.dbo.tshipback
				where	CSRNo	= @ls_csrno
				and	CSRNo1	= @ls_csrno1
				and	CSRNo2	= @ls_csrno2
			
				if Not Exists (Select * From [ipisele_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
			-- 대구기계
			Begin
				delete	
				from	[ipismac_svr\ipis].ipis.dbo.tshipback
				where	CSRNo	= @ls_csrno
				and	CSRNo1	= @ls_csrno1
				and	CSRNo2	= @ls_csrno2
			
				if Not Exists (Select * From [ipismac_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End

		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or (@ls_xplant = 'K')
			-- 대구공조
			Begin
				delete	
				from	[ipishvac_svr\ipis].ipis.dbo.tshipback
				where	CSRNo	= @ls_csrno
				and	CSRNo1	= @ls_csrno1
				and	CSRNo2	= @ls_csrno2
			
				if Not Exists (Select * From [ipishvac_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End

		If @ls_xplant = 'J'
			-- 진천
			Begin
				delete	
				from	[ipisjin_svr].ipis.dbo.tshipback
				where	CSRNo	= @ls_csrno
				and	CSRNo1	= @ls_csrno1
				and	CSRNo2	= @ls_csrno2
			
				if Not Exists (Select * From [ipisjin_svr].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
			
		If @ls_xplant = 'Y'
			-- 여주전자
			Begin
				delete	
				from	[ipisyeo_svr\ipis].ipis.dbo.tshipback
				where	CSRNo	= @ls_csrno
				and	CSRNo1	= @ls_csrno1
				and	CSRNo2	= @ls_csrno2
			
				if Not Exists (Select * From [ipisyeo_svr\ipis].ipis.dbo.tshipback
						Where	CSRNO	=	@ls_Csrno	and
							CSRNO1	=	@ls_Csrno1	and
							CSRNO2	=	@ls_Csrno2)
					Begin
						delete	from pdsle501_log
						where chgdate =	@ls_chgdate
					End
			End
			
	end	-- 삭제 end

End			-- While Loop End

if (select count(*) from pdsle501_log) = 0
	begin
		truncate table pdsle501_log
	end

Drop table #tmp_pdsle501

End		-- Procedure End
Go
