/*
	File Name	: sp_pisi_d_tmstcustitem.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstcustitem
	Description	: Download Customer Item
			  tmstcustitem
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstcustitem]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstcustitem]
GO

/*
Execute sp_pisi_d_tmstcustitem
*/

Create Procedure sp_pisi_d_tmstcustitem
	
	
As
Begin

SET XACT_ABORT OFF

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_area		char(1),
	@ls_division		char(1),
	@ls_custcd		char(6),
	@ls_citno		varchar(20),
	@ls_citnm		varchar(30),
	@ls_itno		varchar(12),
	@ls_chgdate		varchar(30)
	
Select	*
into	#tmp_pdsle101
from	pdsle101_log
Order By	chgdate

	
Select @i = 0, @li_loop_count = @@RowCount, @ls_chgdate = ''


While @i < @li_loop_count
Begin

	Select	Top 1
		@i		= @i + 1,
		@ls_chgdate	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_area	= xplant,
		@ls_division	= div,
		@ls_custcd	= custcd,
		@ls_citno	= citno,
		@ls_citnm	= citnm,
		@ls_itno	= itno
	From	#tmp_pdsle101
	Where	chgdate > @ls_chgdate
	
	if exists (select * From pdsle101_log
	   Where  Chgdate	<	@ls_Chgdate	and
	   	  custcd	=	@ls_custcd	and
	   	  citno		=	@ls_citno)
  	   Begin
	   Continue
	   End

	If @ls_chgcd = 'A' or @ls_chgcd = 'R' 	-- 추가 또는 수정
	Begin
	
		If @ls_area = 'D' and @ls_division = 'A'
			Begin
			if Not Exists (select * From [ipisele_svr\ipis].ipis.dbo.tmstcustitem
				   Where  custcode	=	@ls_custcd	and
				   	  custitemcode	=	@ls_citno)
				Begin
				Insert Into [ipisele_svr\ipis].ipis.dbo.tmstcustitem
						(CustCode,	CustItemCode,	CustItemName,
						AreaCode,	DivisionCode,	ItemCode,
						LastEmp)
					Values (@ls_custcd,	@ls_citno,	@ls_citnm,
						@ls_area,	@ls_division,	@ls_itno,
						'SYSTEM')

				if @@error <> 0
					Begin
					Continue
					End
						
				delete	from pdsle101_log
				where 	chgdate		=	@ls_Chgdate	and
					custcd+citno	in
					(Select Custcode+CustitemCode
						From	[ipisele_svr\ipis].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno)

					if @@error <> 0
						Begin
						Continue
						End

				End
			Else
				Begin
				Update	[ipisele_svr\ipis].ipis.dbo.tmstcustitem
				Set	Areacode	=	@ls_area,
					DivisionCode	=	@ls_division,
					CustItemName	=	@ls_citnm,
					ItemCode	=	@ls_itno,
					LastDate	=	Getdate()
				Where	Custcode	=	@ls_custcd	and
					custitemcode	=	@ls_citno

				if @@error <> 0
					Begin
					Continue
					End
				
				If Exists (Select * From 
							[ipisele_svr\ipis].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno	and
							Areacode	=	@ls_area	and
							DivisionCode	=	@ls_division	and
							CustItemName	=	@ls_citnm	and
							ItemCode	=	@ls_itno)
						begin
						delete	from pdsle101_log
							where 	chgdate		=	@ls_Chgdate

						if @@error <> 0
							Begin
							Continue
							End

						end
				
				End
			End
			
		If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
			Begin
			if Not Exists (select *	From	[ipismac_svr\ipis].ipis.dbo.tmstcustitem
				   Where  custcode	=	@ls_custcd	and
				   	  CustItemCode	=	@ls_citno)
				Begin
				Insert Into [ipismac_svr\ipis].ipis.dbo.tmstcustitem
						(CustCode,	CustItemCode,	CustItemName,
						AreaCode,	DivisionCode,	ItemCode,
						LastEmp)
					Values (@ls_custcd,	@ls_citno,	@ls_citnm,
						@ls_area,	@ls_division,	@ls_itno,
						'SYSTEM')

				if @@error <> 0
					Begin
					Continue
					End
				
				delete	from pdsle101_log
				where 	chgdate		=	@ls_Chgdate	and
					custcd+citno	in
					(Select Custcode+CustitemCode
						From	[ipismac_svr\ipis].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno)

				if @@error <> 0
					Begin
					Continue
					End

				End
			Else
				Begin
				Update	[ipismac_svr\ipis].ipis.dbo.tmstcustitem
				Set	Areacode	=	@ls_area,
					DivisionCode	=	@ls_division,
					CustItemName	=	@ls_citnm,
					ItemCode	=	@ls_itno,
					LastDate	=	Getdate()
				Where	Custcode	=	@ls_custcd	and
					custitemcode	=	@ls_citno

				if @@error <> 0
					Begin
					Continue
					End
				
				If Exists (Select * From 
							[ipismac_svr\ipis].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno	and
							Areacode	=	@ls_area	and
							DivisionCode	=	@ls_division	and
							CustItemName	=	@ls_citnm	and
							ItemCode	=	@ls_itno)
						begin
						delete	from pdsle101_log
							where 	chgdate		=	@ls_Chgdate

						if @@error <> 0
							Begin
							Continue
							End

						end
				
							
				End
			End
		
		If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or
		   @ls_area = 'K' or @ls_area = 'Y'
			Begin
			if Not Exists (select *	From	[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
				   Where  custcode	=	@ls_custcd	and
				   	  custitemcode	=	@ls_citno)
				Begin
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
						(CustCode,	CustItemCode,	CustItemName,
						AreaCode,	DivisionCode,	ItemCode,
						LastEmp)
					Values (@ls_custcd,	@ls_citno,	@ls_citnm,
						@ls_area,	@ls_division,	@ls_itno,
						'SYSTEM')

				if @@error <> 0
					Begin
					Continue
					End
				
				delete	from pdsle101_log
				where 	chgdate		=	@ls_Chgdate	and
					custcd+citno	in
					(Select Custcode+CustitemCode
						From	[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno)

				if @@error <> 0
					Begin
					Continue
					End

				End
			Else
				Begin
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
				Set	Areacode	=	@ls_area,
					DivisionCode	=	@ls_division,
					CustItemName	=	@ls_citnm,
					ItemCode	=	@ls_itno,
					LastDate	=	Getdate()
				Where	Custcode	=	@ls_custcd	and
					custitemcode	=	@ls_citno

				if @@error <> 0
					Begin
					Continue
					End
				
				If Exists (Select * From 
							[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno	and
							Areacode	=	@ls_area	and
							DivisionCode	=	@ls_division	and
							CustItemName	=	@ls_citnm	and
							ItemCode	=	@ls_itno)
						begin
						delete	from pdsle101_log
							where 	chgdate		=	@ls_Chgdate

						if @@error <> 0
							Begin
							Continue
							End

						end
				End
			End
		
		If @ls_area = 'J'
			Begin
			if Not Exists (select *	From	[ipisjin_svr].ipis.dbo.tmstcustitem
				   Where  custcode	=	@ls_custcd	and
				   	  custitemcode	=	@ls_citno)
				Begin
				Insert Into [ipisjin_svr].ipis.dbo.tmstcustitem
						(CustCode,	CustItemCode,	CustItemName,
						AreaCode,	DivisionCode,	ItemCode,
						LastEmp)
					Values (@ls_custcd,	@ls_citno,	@ls_citnm,
						@ls_area,	@ls_division,	@ls_itno,
						'SYSTEM')

				if @@error <> 0
					Begin
					Continue
					End
						
				delete	from pdsle101_log
				where 	chgdate		=	@ls_Chgdate	and
					custcd+citno	in
					(Select Custcode+CustitemCode
						From	[ipisjin_svr].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno)

				if @@error <> 0
					Begin
					Continue
					End

				End
			Else
				Begin
				Update	[ipisjin_svr].ipis.dbo.tmstcustitem
				Set	Areacode	=	@ls_area,
					DivisionCode	=	@ls_division,
					CustItemName	=	@ls_citnm,
					ItemCode	=	@ls_itno,
					LastDate	=	Getdate()
				Where	Custcode	=	@ls_custcd	and
					custitemcode	=	@ls_citno

				if @@error <> 0
					Begin
					Continue
					End
				
				If Exists (Select * From 
							[ipisjin_svr].ipis.dbo.tmstcustitem
						Where	Custcode	=	@ls_custcd	and
							CustitemCode	=	@ls_citno	and
							Areacode	=	@ls_area	and
							DivisionCode	=	@ls_division	and
							CustItemName	=	@ls_citnm	and
							ItemCode	=	@ls_itno)
						begin
						delete	from pdsle101_log
							where 	chgdate		=	@ls_Chgdate

						if @@error <> 0
							Begin
							Continue
							End

						end
				End
			End
					
		
	End	-- If @ls_chgcd = 'A'or 'R' End
	
	If @ls_chgcd = 'D' 	-- 삭제
	Begin
	
		If @ls_area = 'D' and @ls_Division = 'A' 
			Begin
			Delete	from [ipisele_svr\ipis].ipis.dbo.tmstcustitem
				Where	custcode	=	@ls_custcd	and
					custitemcode	=	@ls_citno

			if @@error <> 0
				Begin
				Continue
				End
			
			If Not Exists (Select * From 
						[ipisele_svr\ipis].ipis.dbo.tmstcustitem
					Where	Custcode	=	@ls_custcd	and
						CustitemCode	=	@ls_citno)
				begin
				delete	from pdsle101_log
					where 	chgdate		=	@ls_Chgdate

				if @@error <> 0
					Begin
					Continue
					End

				end
			End
					
		If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')	
			Begin
			Delete	from [ipismac_svr\ipis].ipis.dbo.tmstcustitem
			Where	custcode	=	@ls_custcd	and
				custitemcode	=	@ls_citno

			if @@error <> 0
				Begin
				Continue
				End
			
			If Not Exists (Select * From 
						[ipismac_svr\ipis].ipis.dbo.tmstcustitem
					Where	Custcode	=	@ls_custcd	and
						CustitemCode	=	@ls_citno)
				begin
				delete	from pdsle101_log
					where 	chgdate		=	@ls_Chgdate

				if @@error <> 0
					Begin
					Continue
					End

				end
			End
				
		If (@ls_area = 'D' and	(@ls_division = 'H' or @ls_division = 'V')) or
		    @ls_area = 'K' or @ls_area = 'Y'
			Begin
			Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
			Where	custcode	= @ls_custcd	and
				custitemcode	= @ls_citno
			
			if @@error <> 0
				Begin
				Continue
				End

			If Not Exists (Select * From 
						[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
					Where	Custcode	=	@ls_custcd	and
						CustitemCode	=	@ls_citno)
				begin
				delete	from pdsle101_log
					where 	chgdate		=	@ls_Chgdate

				if @@error <> 0
					Begin
					Continue
					End

				end
			End
		
		If @ls_area = 'J'
			Begin
			Delete	from [ipisjin_svr].ipis.dbo.tmstcustitem
			Where	custcode	=	@ls_custcd and
				custitemcode	=	@ls_citno

			if @@error <> 0
				Begin
				Continue
				End
		  	
		  	If Not Exists (Select * From 
						[ipisjin_svr].ipis.dbo.tmstcustitem
					Where	Custcode	=	@ls_custcd	and
						CustitemCode	=	@ls_citno)
				begin
				delete	from pdsle101_log
					where 	chgdate		=	@ls_Chgdate

				if @@error <> 0
					Begin
					Continue
					End

				end
			End
				
	End	-- If @ls_chgcd = 'D' End

End			-- While Loop End

if (select count(*) from pdsle101_log) = 0
	begin
		truncate table pdsle101_log
	end

Drop table #tmp_pdsle101

End		-- Procedure End
Go
