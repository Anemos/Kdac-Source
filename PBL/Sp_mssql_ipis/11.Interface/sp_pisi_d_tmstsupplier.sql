/*
	File Name	: sp_pisi_d_tmstsupplier.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstsupplier
	Description	: Download Costomer/Supplier Master
			  tmstcostomer/tmstsupplier
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

Declare	@i			Int,
	@li_loop_count		Int,	
	@ls_chgcd		char(1),
	@ls_vsrno		varchar(8),	-- customer / supplier code
	@ls_inside		char(1),
	@ls_kbcd		char(1),
	@ls_vancd		char(1),
	@ls_jscd		char(1),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdpur102
from	pdpur102
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_vsrno	= vsrno,
		@ls_inside	= inside,
		@ls_kbcd	= kbcd,
		@ls_vancd	= vancd,
		@ls_jscd	= jscd,
		@ls_date	= chgdate
	From	pdpur102
	Where	chgdate > @ls_date

---------------------- 확인할 것 !!!
--	If @ls_chgcd = 'A' or @ls_chgcd = 'R' 	-- 추가 or 수정
--	Begin
	
		-- 대구전장
		Update [ipisele_svr\ipis].ipis.dbo.tmstsupplier
		Set	SupplierInKDAC = @ls_inside,
			SupplierKBFlag = @ls_kbcd,				
			SupplierVANFlag = @ls_vancd,	
			JSCode = @ls_jscd,
			LastDate = Getdate()
		Where	SupplierCode = @ls_vsrno
		
		-- 대구기계
		Update [ipismac_svr\ipis].ipis.dbo.tmstsupplier
		Set	SupplierInKDAC = @ls_inside,
			SupplierKBFlag = @ls_kbcd,				
			SupplierVANFlag = @ls_vancd,	
			JSCode = @ls_jscd,
			LastDate = Getdate()
		Where	SupplierCode = @ls_vsrno

		-- 대구공조
		Update [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
		Set	SupplierInKDAC = @ls_inside,
			SupplierKBFlag = @ls_kbcd,				
			SupplierVANFlag = @ls_vancd,	
			JSCode = @ls_jscd,
			LastDate = Getdate()
		Where	SupplierCode = @ls_vsrno

		-- 진천
		Update [ipisjin_svr].ipis.dbo.tmstsupplier
		Set	SupplierInKDAC = @ls_inside,
			SupplierKBFlag = @ls_kbcd,				
			SupplierVANFlag = @ls_vancd,	
			JSCode = @ls_jscd,
			LastDate = Getdate()
		Where	SupplierCode = @ls_vsrno
--	End	-- 추가/수정 end	
	
End			-- While Loop End

Drop table #tmp_pdpur102

End		-- Procedure End
Go
