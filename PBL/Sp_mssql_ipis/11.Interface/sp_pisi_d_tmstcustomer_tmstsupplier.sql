/*
	File Name	: sp_pisi_d_tmstcustomer_tmstsupplier.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstcustomer_tmstsupplier
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstcustomer_tmstsupplier]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstcustomer_tmstsupplier]
GO

/*
Execute sp_pisi_d_tmstcustomer_tmstsupplier
*/

Create Procedure sp_pisi_d_tmstcustomer_tmstsupplier
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,	
	@ls_chgcd		char(1),
	@ls_scgubun		char(1),
	@ls_vsrno		varchar(8),	-- customer / supplier code
	@ls_vndr		varchar(10),	-- supplier no
	@ls_vndnm		varchar(30),
	@ls_vndnm1		varchar(50),
	@ls_addr		varchar(100),
	@ls_prnm		varchar(20),
	@ls_natn		varchar(20),
	@ls_teln		varchar(20),
	@ls_faxn		varchar(20),
	@ls_tlxn		varchar(20),
	@ls_vpost		varchar(7),
	@ls_digubun		char(1),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdpur101
from	pdpur101
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_scgubun	= scgubun,
		@ls_vsrno	= vsrno,
		@ls_vndr	= vndr,
		@ls_vndnm	= ltrim(rtrim(vndnm)),
		@ls_vndnm1	= ltrim(rtrim(vndnm1)),
		@ls_addr	= ltrim(rtrim(addr)),
		@ls_prnm	= ltrim(rtrim(prnm)),
		@ls_natn	= natn,
		@ls_teln	= teln,
		@ls_faxn	= faxn,
		@ls_tlxn	= tlxn,
		@ls_vpost	= vpost,
		@ls_digubun	= case digubun
					when '' then 'Z'
					else digubun
					end,
		@ls_date	= chgdate
	From	#tmp_pdpur101
	Where	chgdate > @ls_date

	If @ls_scgubun = 'C'	-- customer
	Begin
		
		If @ls_chgcd = 'A' 	-- 추가
		Begin
			-- 대구전장
			Insert into [ipisele_svr\ipis].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')	
			
			-- 대구기계
			Insert into [ipismac_svr\ipis].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')
		
			-- 대구공조
			Insert into [ipishvac_svr\ipis].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')
		
			-- 진천
			Insert into [ipisjin_svr].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')
		
		End	-- @ls_chgcd = 'A' 	-- 추가 end
		
		If @ls_chgcd = 'R' 	-- 수정
		Begin
		
			-- 대구전장		
			Delete	[ipisele_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
		
			Insert into [ipisele_svr\ipis].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')	
			
			-- 대구기계		
			Delete	[ipismac_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

			Insert into [ipismac_svr\ipis].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')
		
			-- 대구공조		
			Delete	[ipishvac_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

			Insert into [ipishvac_svr\ipis].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')
		
			-- 진천		
			Delete	[ipisjin_svr].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

			-- 진천
			Insert into [ipisjin_svr].ipis.dbo.tmstcustomer
				(CustCode,	CustName,	CustShortName,	
				CustGubun,	
				CustNo,		CustAddress1,
				CustHeadName,	CustFaxNo,	CustTelNo,	
				CustPostNo,	LastEmp)
			Values	(@ls_vsrno,	@ls_vndnm,	@ls_vndnm1,		
				@ls_digubun,	
				@ls_vndr,	@ls_addr,
				@ls_prnm,	@ls_faxn,	@ls_teln,		
				substring(@ls_vpost, 1, 6),		'SYSTEM')
			
		End	-- 수정 end
		
		If @ls_chgcd = 'D' 	-- 삭제
		Begin
			-- 대구전장		
			Delete	[ipisele_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
		
			-- 대구기계		
			Delete	[ipismac_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

			-- 대구공조		
			Delete	[ipishvac_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

			-- 진천		
			Delete	[ipisjin_svr].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

		End	-- 삭제 end
	End	-- @ls_scgubun = 'C'	-- customer END

	If @ls_scgubun = 'S'	-- supplier
	Begin
		
		If @ls_chgcd = 'A' 	-- 추가
		Begin		
			-- 대구전장
			Insert into [ipisele_svr\ipis].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	
				
			-- 대구기계
			Insert into [ipismac_svr\ipis].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	

			-- 대구공조
			Insert into [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	

			-- 진천
			Insert into [ipisjin_svr].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	
		End	-- 추가 end	

		If @ls_chgcd = 'R' 	-- 수정
		Begin		
			-- 대구전장		
			Delete	[ipisele_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno
		
			Insert into [ipisele_svr\ipis].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	

			-- 대구기계		
			Delete	[ipismac_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			Insert into [ipismac_svr\ipis].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	

			-- 대구공조		
			Delete	[ipishvac_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			Insert into [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	

			-- 진천		
			Delete	[ipisjin_svr].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			Insert into [ipisjin_svr].ipis.dbo.tmstsupplier
				(SupplierCode,		SupplierNo,		SupplierKorName,	
				SupplierEngName,	SupplierAddress,	SupplierHeadName,	
				SupplierNation,		SupplierTelNo,		SupplierFaxNo,
				SupplierTelexNo,	SupplierPostNo,		
				SupplierInKDAC,		SupplierKBFlag,		SupplierVANFlag,	LastEmp)
			Values	(@ls_vsrno,		@ls_vndr,		@ls_vndnm,	
				@ls_vndnm1,		@ls_addr,		@ls_prnm,
				@ls_natn,		@ls_teln,		@ls_faxn,
				@ls_tlxn,		substring(@ls_vpost, 1, 6),
				'',			'',			'',			'SYSTEM')	
				
		End	-- 수정 end
		
		If @ls_chgcd = 'D' 	-- 삭제
		Begin
			-- 대구전장		
			Delete	[ipisele_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno
		
			-- 대구기계		
			Delete	[ipismac_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			-- 대구공조		
			Delete	[ipishvac_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			-- 진천		
			Delete	[ipisjin_svr].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

		End	-- 삭제 end
	End	-- @ls_scgubun = 'S'	-- supplier end			
	
End			-- While Loop End

Drop table #tmp_pdpur101

End		-- Procedure End
Go
