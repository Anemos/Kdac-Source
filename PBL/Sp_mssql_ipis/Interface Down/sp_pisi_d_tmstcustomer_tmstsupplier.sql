/*
	File Name	: sp_pisi_d_tmstcustomer_tmstsupplier.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tmstcustomer_tmstsupplier
	Description	: Download Costomer/Supplier Master
			  tmstcostomer/tmstsupplier
			  �������� �����߰� : 2004.04.19
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

SET XACT_ABORT OFF

Declare	@i			Int,
	@li_loop_count		Int,	
	@ls_chgcd		char(1),
	@ls_scgubun		char(1),
	@ls_vsrno		varchar(8),	-- customer / supplier code
	@ls_vndr		varchar(10),	-- supplier no
	@ls_vndnm		varchar(50),
	@ls_vndnm1		varchar(50),
	@ls_addr		varchar(100),
	@ls_prnm		varchar(30),
	@ls_natn		varchar(20),
	@ls_teln		varchar(20),
	@ls_faxn		varchar(20),
	@ls_tlxn		varchar(20),
	@ls_vpost		varchar(7),
	@ls_digubun		char(1),
	@ls_chgdate		varchar(30)
	
Select	*
into	#tmp_pdpur101
from	pdpur101_log
order by chgdate

	
Select @i = 0, @li_loop_count = @@RowCount, @ls_chgdate = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_scgubun	= scgubun,
		@ls_vsrno	= ltrim(rtrim(vsrno)),
		@ls_vndr	= ltrim(rtrim(vndr)),
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
		@ls_chgdate	= chgdate
	From	#tmp_pdpur101
	Where	chgdate > @ls_chgdate
	
	if (select Count(*) From pdpur101_log
	   Where  Chgdate	<	@ls_Chgdate	and
	   	  scgubun	=	@ls_scgubun	and
	   	  vsrno		=	@ls_vsrno) > 0
	   Begin
	   Continue
	   End
	
	-- �뱸����
	-- ipis

	If @ls_scgubun = 'C'	-- customer
	Begin
		if len(@ls_vsrno) <= 6
		begin
		  
			-- �ϴ� ������...
			-- �뱸����		

			-- eis
			Delete	[ipisele_svr\ipis].eis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno

			if @@error <> 0
				Begin
				Continue
				End

			-- ipis
			Delete	[ipisele_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End

			-- �뱸���		
			-- ipis
			Delete	[ipismac_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End

			-- �뱸����		
			-- ipis
			Delete	[ipishvac_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End

      -- ��������
      -- ipis
			Delete	[ipisyeo_svr\ipis].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End

			-- �뱸��õ	
			-- ipis
			Delete	[ipisjin_svr].ipis.dbo.tmstcustomer
			Where	CustCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End
					
			If @ls_chgcd = 'A' or @ls_chgcd = 'R' 	-- �߰� �Ǵ� ����
			Begin
				-- �뱸����
				-- eis
				Insert into [ipisele_svr\ipis].eis.dbo.tmstcustomer
					(CustCode,	CustName,	CustShortName,	
					CustGubun,	
					CustNo,		CustAddress1,
					CustHeadName,	CustFaxNo,	CustTelNo,	
					CustPostNo,	LastEmp)
				Values	(substring(@ls_vsrno,1,6), @ls_vndnm,	substring(@ls_vndnm1,1,15),		
					@ls_digubun,	
					@ls_vndr,	@ls_addr,
					@ls_prnm,	@ls_faxn,	@ls_teln,		
					substring(@ls_vpost, 1, 6),		'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End
					
				-- �뱸����
				-- ipis
				Insert into [ipisele_svr\ipis].ipis.dbo.tmstcustomer
					(CustCode,	CustName,	CustShortName,	
					CustGubun,	
					CustNo,		CustAddress1,
					CustHeadName,	CustFaxNo,	CustTelNo,	
					CustPostNo,	LastEmp)
				Values	(substring(@ls_vsrno,1,6), @ls_vndnm,	substring(@ls_vndnm1,1,15),		
					@ls_digubun,	
					@ls_vndr,	@ls_addr,
					@ls_prnm,	@ls_faxn,	@ls_teln,		
					substring(@ls_vpost, 1, 6),		'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End
					
				-- �뱸���
				-- ipis
				Insert into [ipismac_svr\ipis].ipis.dbo.tmstcustomer
					(CustCode,	CustName,	CustShortName,	
					CustGubun,	
					CustNo,		CustAddress1,
					CustHeadName,	CustFaxNo,	CustTelNo,	
					CustPostNo,	LastEmp)
				Values	(substring(@ls_vsrno,1,6), @ls_vndnm,	substring(@ls_vndnm1,1,15),		
					@ls_digubun,	
					@ls_vndr,	@ls_addr,
					@ls_prnm,	@ls_faxn,	@ls_teln,		
					substring(@ls_vpost, 1, 6),		'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End
					
				-- �뱸����
				-- ipis
				Insert into [ipishvac_svr\ipis].ipis.dbo.tmstcustomer
					(CustCode,	CustName,	CustShortName,	
					CustGubun,	
					CustNo,		CustAddress1,
					CustHeadName,	CustFaxNo,	CustTelNo,	
					CustPostNo,	LastEmp)
				Values	(substring(@ls_vsrno,1,6), @ls_vndnm,	substring(@ls_vndnm1,1,15),		
					@ls_digubun,	
					@ls_vndr,	@ls_addr,
					@ls_prnm,	@ls_faxn,	@ls_teln,		
					substring(@ls_vpost, 1, 6),		'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End

        -- ��������
				-- ipis
				Insert into [ipisyeo_svr\ipis].ipis.dbo.tmstcustomer
					(CustCode,	CustName,	CustShortName,	
					CustGubun,	
					CustNo,		CustAddress1,
					CustHeadName,	CustFaxNo,	CustTelNo,	
					CustPostNo,	LastEmp)
				Values	(substring(@ls_vsrno,1,6), @ls_vndnm,	substring(@ls_vndnm1,1,15),		
					@ls_digubun,	
					@ls_vndr,	@ls_addr,
					@ls_prnm,	@ls_faxn,	@ls_teln,		
					substring(@ls_vpost, 1, 6),		'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End

				-- ��õ
				-- ipis
				Insert into [ipisjin_svr].ipis.dbo.tmstcustomer
					(CustCode,	CustName,	CustShortName,	
					CustGubun,	
					CustNo,		CustAddress1,
					CustHeadName,	CustFaxNo,	CustTelNo,	
					CustPostNo,	LastEmp)
				Values	(substring(@ls_vsrno,1,6), @ls_vndnm,	substring(@ls_vndnm1,1,15),		
					@ls_digubun,	
					@ls_vndr,	@ls_addr,
					@ls_prnm,	@ls_faxn,	@ls_teln,		
					substring(@ls_vpost, 1, 6),		'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End

			End
		End
	End	-- @ls_scgubun = 'C'	-- customer END

	If @ls_scgubun = 'S'	-- supplier
	Begin
		if len(@ls_vsrno) <= 5
		begin
			-- �뱸����		
			-- eis			
			Delete	[ipisele_svr\ipis].eis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno
		
			if @@error <> 0
				Begin
				Continue
				End

			-- �뱸����		
			-- ipis			
			Delete	[ipisele_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End
			
			-- �뱸���		
			-- ipis			
			Delete	[ipismac_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno
	
			if @@error <> 0
				Begin
				Continue
				End

			-- �뱸����		
			-- ipis			
			Delete	[ipishvac_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			if @@error <> 0
				Begin
				Continue
				End

      -- ��������		
			-- ipis			
			Delete	[ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno

			if @@error <> 0
				Begin
				Continue
				End

			-- �뱸��õ
			-- ipis			
			Delete	[ipisjin_svr].ipis.dbo.tmstsupplier
			Where	SupplierCode = @ls_vsrno
			
			if @@error <> 0
				Begin
				Continue
				End
			
			If @ls_chgcd = 'A' or @ls_chgcd = 'R'	-- �߰� or ����
			Begin		
				-- �뱸����
				-- eis
				Insert into [ipisele_svr\ipis].eis.dbo.tmstsupplier
					(SupplierCode,			SupplierNo,		SupplierKorName,	
					SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					SupplierTelexNo,		SupplierPostNo,		
					SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					LastEmp)
				Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					@ls_natn,			@ls_teln,		@ls_faxn,
					@ls_tlxn,			substring(@ls_vpost, 1, 7),
					'',				'',			'',
					'SYSTEM')	
	
				if @@error <> 0
					Begin
					Continue
					End
	
				-- �뱸����
				-- ipis
				Insert into [ipisele_svr\ipis].ipis.dbo.tmstsupplier
					(SupplierCode,			SupplierNo,		SupplierKorName,	
					SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					SupplierTelexNo,		SupplierPostNo,		
					SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					LastEmp)
				Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					@ls_natn,			@ls_teln,		@ls_faxn,
					@ls_tlxn,			substring(@ls_vpost, 1, 7),
					'',				'',			'',
					'SYSTEM')	
				
				if @@error <> 0
					Begin
					Continue
					End

				-- �뱸���
				-- ipis
				Insert into [ipismac_svr\ipis].ipis.dbo.tmstsupplier
					(SupplierCode,			SupplierNo,		SupplierKorName,	
					SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					SupplierTelexNo,		SupplierPostNo,		
					SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					LastEmp)
				Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					@ls_natn,			@ls_teln,		@ls_faxn,
					@ls_tlxn,			substring(@ls_vpost, 1, 7),
					'',				'',			'',
					'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End
				
				-- �뱸����
				-- ipis
				Insert into [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
					(SupplierCode,			SupplierNo,		SupplierKorName,	
					SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					SupplierTelexNo,		SupplierPostNo,		
					SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					LastEmp)
				Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					@ls_natn,			@ls_teln,		@ls_faxn,
					@ls_tlxn,			substring(@ls_vpost, 1, 7),
					'',				'',			'',
					'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End

        -- ��������
				-- ipis
				Insert into [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
					(SupplierCode,			SupplierNo,		SupplierKorName,	
					SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					SupplierTelexNo,		SupplierPostNo,		
					SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					LastEmp)
				Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					@ls_natn,			@ls_teln,		@ls_faxn,
					@ls_tlxn,			substring(@ls_vpost, 1, 7),
					'',				'',			'',
					'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End

				-- ��õ
				-- ipis
				Insert into [ipisjin_svr].ipis.dbo.tmstsupplier
					(SupplierCode,			SupplierNo,		SupplierKorName,	
					SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					SupplierTelexNo,		SupplierPostNo,		
					SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					LastEmp)
				Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					@ls_natn,			@ls_teln,		@ls_faxn,
					@ls_tlxn,			substring(@ls_vpost, 1, 7),
					'',				'',			'',
					'SYSTEM')	

				if @@error <> 0
					Begin
					Continue
					End
				
			End	-- �߰� �Ǵ� ���� end	
		End
		Else
		  Begin --���ھ�ü ���� �ٿ�ε�
		    -- ��������		
			  -- ipis			
			  Delete	[ipisyeo_svr\ipis].ipis.dbo.tmstsupplieroversea
			  Where	SupplierCode = @ls_vsrno

			  if @@error <> 0
				  Begin
				  Continue
				  End
				  
				If @ls_chgcd = 'A' or @ls_chgcd = 'R'	-- �߰� or ����
				  Begin
				    -- ��������
				    -- ipis
				    Insert into [ipisyeo_svr\ipis].ipis.dbo.tmstsupplieroversea
					    (SupplierCode,			SupplierNo,		SupplierKorName,	
					    SupplierEngName,		SupplierAddress,	SupplierHeadName,	
					    SupplierNation,			SupplierTelNo,		SupplierFaxNo,
					    SupplierTelexNo,		SupplierPostNo,		
					    SupplierInKDAC,			SupplierKBFlag,		SupplierVANFlag,
					    LastEmp)
				    Values	(@ls_vsrno, 			@ls_vndr,		@ls_vndnm,	
					    substring(@ls_vndnm1,1,30),	@ls_addr,		@ls_prnm,
					    @ls_natn,			@ls_teln,		@ls_faxn,
					    @ls_tlxn,			substring(@ls_vpost, 1, 7),
					    '',				'',			'',
					    'SYSTEM')	

				    if @@error <> 0
					    Begin
					      Continue
					    End
				  End
		  End
	End	-- @ls_scgubun = 'S'	-- supplier end			

Delete	from pdpur101_log
where chgdate =	@ls_chgdate

End			-- While Loop End

if (select count(*) from pdpur101_log) = 0
	begin
		truncate table pdpur101_log
	end
	
Drop table #tmp_pdpur101

End		-- Procedure End
Go
