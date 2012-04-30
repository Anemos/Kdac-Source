/*
	File Name	: sp_pisi_d_tmstitem.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tmstitem
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstitem]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstitem]
GO

/*
Execute sp_pisi_d_tmstitem
*/

Create Procedure sp_pisi_d_tmstitem
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_itno		varchar(12),
	@ls_itnm		varchar(50),
	@ls_spec		varchar(50),
	@ls_xunit		varchar(2),
	@ls_xtype		char(1),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdinv002
from	pdinv002
where	len(rtrim(itno)) > 0
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_itno	= rtrim(itno),
		@ls_itnm	= ltrim(rtrim(itnm)),
		@ls_spec	= ltrim(rtrim(spec)),
		@ls_xunit	= xunit,
		@ls_xtype	= xtype,
		@ls_date	= chgdate
	From	#tmp_pdinv002
	Where	chgdate > @ls_date

		If @ls_chgcd = 'A' 	-- �߰�
			Begin
	
			-- �뱸����
			Insert Into [ipisele_svr\ipis].ipis.dbo.tmstitem
				(ItemCode,	ItemName,	ItemSpec,
				ItemUnit,	ItemType,	LastEmp)
			Values (@ls_itno,	@ls_itnm,	@ls_spec,
				@ls_xunit,	@ls_xtype,	'SYSTEM')

			Insert Into [ipisele_svr\ipis].eis.dbo.tmstitem
				(ItemCode,	ItemName,	ItemSpec,
				ItemUnit,	ItemType,	LastEmp)
			Values (@ls_itno,	@ls_itnm,	@ls_spec,
				@ls_xunit,	@ls_xtype,	'SYSTEM')
	
			-- �뱸���
			Insert Into [ipismac_svr\ipis].ipis.dbo.tmstitem
				(ItemCode,	ItemName,	ItemSpec,
				ItemUnit,	ItemType,	LastEmp)
			Values (@ls_itno,	@ls_itnm,	@ls_spec,
				@ls_xunit,	@ls_xtype,	'SYSTEM')
	
			-- �뱸����
			Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitem
				(ItemCode,	ItemName,	ItemSpec,
				ItemUnit,	ItemType,	LastEmp)
			Values (@ls_itno,	@ls_itnm,	@ls_spec,
				@ls_xunit,	@ls_xtype,	'SYSTEM')
	
			-- ��õ
			Insert Into [ipisjin_svr].ipis.dbo.tmstitem
				(ItemCode,	ItemName,	ItemSpec,
				ItemUnit,	ItemType,	LastEmp)
			Values (@ls_itno,	@ls_itnm,	@ls_spec,
				@ls_xunit,	@ls_xtype,	'SYSTEM')
				
			End	-- �߰� end
				
		Else
			If @ls_chgcd = 'R' 	-- ����
				Begin

				-- �뱸����	
				Delete	from [ipisele_svr\ipis].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno

				Delete	from [ipisele_svr\ipis].eis.dbo.tmstitem
				Where	itemcode = @ls_itno

				Insert Into [ipisele_svr\ipis].ipis.dbo.tmstitem
					(ItemCode,	ItemName,	ItemSpec,
					ItemUnit,	ItemType,	LastEmp)
				Values (@ls_itno,	@ls_itnm,	@ls_spec,
					@ls_xunit,	@ls_xtype,	'SYSTEM')
	
				Insert Into [ipisele_svr\ipis].eis.dbo.tmstitem
					(ItemCode,	ItemName,	ItemSpec,
					ItemUnit,	ItemType,	LastEmp)
				Values (@ls_itno,	@ls_itnm,	@ls_spec,
					@ls_xunit,	@ls_xtype,	'SYSTEM')
				
				-- �뱸���	
				Delete	from [ipismac_svr\ipis].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno

				Insert Into [ipismac_svr\ipis].ipis.dbo.tmstitem
					(ItemCode,	ItemName,	ItemSpec,
					ItemUnit,	ItemType,	LastEmp)
				Values (@ls_itno,	@ls_itnm,	@ls_spec,
					@ls_xunit,	@ls_xtype,	'SYSTEM')
				
				-- �뱸����	
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno

				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitem
					(ItemCode,	ItemName,	ItemSpec,
					ItemUnit,	ItemType,	LastEmp)
				Values (@ls_itno,	@ls_itnm,	@ls_spec,
					@ls_xunit,	@ls_xtype,	'SYSTEM')
				
				-- ��õ	
				Delete	from [ipisjin_svr].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno

				Insert Into [ipisjin_svr].ipis.dbo.tmstitem
					(ItemCode,	ItemName,	ItemSpec,
					ItemUnit,	ItemType,	LastEmp)
				Values (@ls_itno,	@ls_itnm,	@ls_spec,
					@ls_xunit,	@ls_xtype,	'SYSTEM')
				
				End	-- ���� end	
			
			Else
					
			If @ls_chgcd = 'D' 	-- ����
				Begin
				
				-- �뱸����	
				Delete	from [ipisele_svr\ipis].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno

				Delete	from [ipisele_svr\ipis].eis.dbo.tmstitem
				Where	itemcode = @ls_itno
				
				-- �뱸���	
				Delete	from [ipismac_svr\ipis].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno
				
				-- �뱸����	
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno
				
				-- ��õ	
				Delete	from [ipisjin_svr].ipis.dbo.tmstitem
				Where	itemcode = @ls_itno
			
				End	-- ���� end	

End			-- While Loop End

Drop table #tmp_pdinv002

End		-- Procedure End
Go
