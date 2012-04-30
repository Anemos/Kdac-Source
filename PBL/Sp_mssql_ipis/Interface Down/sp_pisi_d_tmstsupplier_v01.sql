/*
	File Name	: sp_pisi_d_tmstsupplier.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstsupplier
	Description	: Download Costomer/Supplier Master
			  tmstcostomer/tmstsupplier
			  여주전자 서버 추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstsupplier]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstsupplier]
GO

/*
Execute sp_pisi_d_tmstsupplier
*/

Create Procedure sp_pisi_d_tmstsupplier
	
	
As
Begin

SET Xact_Abort Off

Declare	@ls_chgdate	VarChar(30),
	@ls_chgcd	VarChar(1),
	@ls_vsrno	VarChar(8),
	@ls_inside	VarChar(1),
	@ls_kbcd	VarChar(1),
	@ls_vancd	VarChar(1),
	@ls_jscd	VarChar(1),
	@ls_xstop VarChar(1),
	@i		int,
	@li_loop_count	int


Select	*
into	#tmp_pdpur102
from	pdpur102_log
order by chgdate

		
Select @i = 0, @li_loop_count = @@RowCount, @ls_chgdate = ''

While @i < @li_loop_count
Begin
	
	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_vsrno	= vsrno,
		@ls_inside	= inside,
		@ls_kbcd	= kbcd,
		@ls_vancd	= vancd,
		@ls_jscd	= jscd,
		@ls_xstop = xstop
	From	#tmp_pdpur102
	Where	chgdate > @ls_chgdate

		
	if (select Count(*) From pdpur102_log
	   Where  Chgdate	<	@ls_Chgdate	and
	   	  vsrno		=	@ls_vsrno)	 > 0
	   Begin
	   Continue
	   End

	--대구전장
	--eis

	If exists (select * from [ipisele_svr\ipis].eis.dbo.tmstsupplier
		   where	suppliercode	=	@ls_vsrno)
		Begin
			Update [ipisele_svr\ipis].eis.dbo.tmstsupplier
			Set	SupplierInKDAC 	= @ls_inside,
				SupplierKBFlag 	= @ls_kbcd,				
				SupplierVANFlag = @ls_vancd,	
				JSCode 		= @ls_jscd,
				Xstop     = @ls_xstop,
				LastDate 	= Getdate()
			Where	SupplierCode 	= @ls_vsrno

			if @@error	<>	0
				Begin
				Continue
				End
		End

	--대구전장
	--ipis
	If exists (select * from [ipisele_svr\ipis].ipis.dbo.tmstsupplier
		   where	suppliercode	=	@ls_vsrno)
		Begin
			Update [ipisele_svr\ipis].ipis.dbo.tmstsupplier
			Set	SupplierInKDAC 	= @ls_inside,
				SupplierKBFlag 	= @ls_kbcd,				
				SupplierVANFlag = @ls_vancd,	
				JSCode 		= @ls_jscd,
				Xstop     = @ls_xstop,
				LastDate 	= Getdate()
			Where	SupplierCode 	= @ls_vsrno
			
			if @@error	<>	0
				Begin
				Continue
				End

		End

	--대구기계
	--ipis
	If exists (select * from [ipismac_svr\ipis].ipis.dbo.tmstsupplier
		   where	suppliercode	=	@ls_vsrno)
		Begin
			Update [ipismac_svr\ipis].ipis.dbo.tmstsupplier
			Set	SupplierInKDAC 	= @ls_inside,
				SupplierKBFlag 	= @ls_kbcd,				
				SupplierVANFlag = @ls_vancd,	
				JSCode 		= @ls_jscd,
				Xstop     = @ls_xstop,
				LastDate 	= Getdate()
			Where	SupplierCode 	= @ls_vsrno

			if @@error	<>	0
				Begin
				Continue
				End

		End

	--대구공조
	--ipis
	If exists (select * from [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
		   where	suppliercode	=	@ls_vsrno)
		Begin
			Update [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
			Set	SupplierInKDAC 	= @ls_inside,
				SupplierKBFlag 	= @ls_kbcd,				
				SupplierVANFlag = @ls_vancd,	
				JSCode 		= @ls_jscd,
				Xstop     = @ls_xstop,
				LastDate 	= Getdate()
			Where	SupplierCode 	= @ls_vsrno

			if @@error	<>	0
				Begin
				Continue
				End

		End

  --여주전자
	--ipis
	If exists (select * from [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
		   where	suppliercode	=	@ls_vsrno)
		Begin
			Update [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
			Set	SupplierInKDAC 	= @ls_inside,
				SupplierKBFlag 	= @ls_kbcd,				
				SupplierVANFlag = @ls_vancd,	
				JSCode 		= @ls_jscd,
				Xstop     = @ls_xstop,
				LastDate 	= Getdate()
			Where	SupplierCode 	= @ls_vsrno

			if @@error	<>	0
				Begin
				Continue
				End

		End

	--진천
	--ipis
	If exists (select * from [ipisjin_svr].ipis.dbo.tmstsupplier
		   where	suppliercode	=	@ls_vsrno)
		Begin
			Update [ipisjin_svr].ipis.dbo.tmstsupplier
			Set	SupplierInKDAC 	= @ls_inside,
				SupplierKBFlag 	= @ls_kbcd,				
				SupplierVANFlag = @ls_vancd,	
				JSCode 		= @ls_jscd,
				Xstop     = @ls_xstop,
				LastDate 	= Getdate()
			Where	SupplierCode 	= @ls_vsrno

			if @@error	<>	0
				Begin
				Continue
				End

		End

	Delete From	pdpur102_log
	where	chgdate	=	@ls_chgdate

	
End			-- While Loop End

if (select count(*) from pdpur102_log) = 0
	begin
		truncate table pdpur102_log
	end

Drop table #tmp_pdpur102

End		-- Procedure End
Go
