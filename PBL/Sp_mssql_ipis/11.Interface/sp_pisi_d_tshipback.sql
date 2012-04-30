/*
	File Name	: sp_pisi_d_tshipback.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tshipback
	Description	: Download Item
			  tmstitem
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
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdsle501
from	pdsle501
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
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
		@ls_dcqty	= dcqty,
		@ls_scqty	= scqty,
		@ls_rcqty	= rcqty*(-1),	-- 무조건 마이너스를 곱한다	2002.12.16
--		@ls_rcqty	= case 
--					when @ls_dcqty > 0 then @ls_dcqty*-1
--					else @ls_dcqty
--					end,
		@ls_slno	= substring(slno,1,4)+'.'+substring(slno,5,2)+'.'+substring(slno,7,2),
--		@ls_slno	= slno,		-- rpdt로 넣는다	2002.12.16
		@ls_date	= chgdate
	From	#tmp_pdsle501
	Where	chgdate > @ls_date
--	and	rcqty < 0

	If @ls_chgcd = 'A' 	-- 추가
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
			-- 대구전장
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
			
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
			-- 대구기계
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

		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or (@ls_xplant = 'K' or @ls_xplant = 'Y')
			-- 대구공조
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

		If @ls_xplant = 'J'
			-- 진천
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
			
	End	-- 추가 end
	
	If @ls_chgcd = 'R' 	-- 수정
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
			-- 대구전장
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
				
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
			-- 대구기계
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

		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or (@ls_xplant = 'K' or @ls_xplant = 'Y')
			-- 대구공조
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

		If @ls_xplant = 'J'
			-- 진천
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
		
	end	-- 수정 end
		
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
		If @ls_xplant = 'D' and @ls_div = 'A'
			-- 대구전장
			delete	
			from	[ipisele_svr\ipis].ipis.dbo.tshipback
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
		
		If @ls_xplant = 'D' and (@ls_div = 'M' or @ls_div = 'S')
			-- 대구기계
			delete	
			from	[ipismac_svr\ipis].ipis.dbo.tshipback
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2

		If (@ls_xplant = 'D' and (@ls_div = 'H' or @ls_div = 'V')) or (@ls_xplant = 'K' or @ls_xplant = 'Y')
			-- 대구공조
			delete	
			from	[ipishvac_svr\ipis].ipis.dbo.tshipback
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2

		If @ls_xplant = 'J'
			-- 진천
			delete	
			from	[ipisjin_svr].ipis.dbo.tshipback
			where	CSRNo	= @ls_csrno
			and	CSRNo1	= @ls_csrno1
			and	CSRNo2	= @ls_csrno2
			
	end	-- 삭제 end
			
End			-- While Loop End

Drop table #tmp_pdsle501

End		-- Procedure End
Go
