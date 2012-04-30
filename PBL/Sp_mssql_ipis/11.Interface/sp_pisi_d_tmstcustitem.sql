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

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_area		char(1),
	@ls_division		char(1),
	@ls_custcd		char(6),
	@ls_citno		varchar(20),
	@ls_citnm		varchar(30),
	@ls_itno		varchar(12),
	@ls_date		varchar(30)
	
Select	*
into	#tmp_pdsle101
from	pdsle101
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''


While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_date	= chgdate,
		@ls_chgcd	= chgcd,
		@ls_area	= xplant,
		@ls_division	= div,
		@ls_custcd	= custcd,
		@ls_citno	= citno,
		@ls_citnm	= citnm,
		@ls_itno	= itno
	From	pdsle101
	Where	chgdate > @ls_date

	If @ls_chgcd = 'A' 	-- 추가
	Begin
	
		If @ls_area = 'D' 
		  Begin
			If @ls_division = 'A'
				Insert Into [ipisele_svr\ipis].ipis.dbo.tmstcustitem
					(CustCode,	CustItemCode,	CustItemName,
					AreaCode,	DivisionCode,	ItemCode,
					LastEmp)
				Values (@ls_custcd,	@ls_citno,	@ls_citnm,
					@ls_area,	@ls_division,	@ls_itno,
					'SYSTEM')
			If @ls_division = 'M' or @ls_division = 'S'	
				Insert Into [ipismac_svr\ipis].ipis.dbo.tmstcustitem
					(CustCode,	CustItemCode,	CustItemName,
					AreaCode,	DivisionCode,	ItemCode,
					LastEmp)
				Values (@ls_custcd,	@ls_citno,	@ls_citnm,
					@ls_area,	@ls_division,	@ls_itno,
					'SYSTEM')
			If @ls_division = 'H' or @ls_division = 'V'	
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
					(CustCode,	CustItemCode,	CustItemName,
					AreaCode,	DivisionCode,	ItemCode,
					LastEmp)
				Values (@ls_custcd,	@ls_citno,	@ls_citnm,
					@ls_area,	@ls_division,	@ls_itno,
					'SYSTEM')
		  End
		Else
		  Begin
			If @ls_area = 'K'
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
					(CustCode,	CustItemCode,	CustItemName,
					AreaCode,	DivisionCode,	ItemCode,
					LastEmp)
				Values (@ls_custcd,	@ls_citno,	@ls_citnm,
					@ls_area,	@ls_division,	@ls_itno,
					'SYSTEM')
			If @ls_area = 'J'
				Insert Into [ipisjin_svr].ipis.dbo.tmstcustitem
					(CustCode,	CustItemCode,	CustItemName,
					AreaCode,	DivisionCode,	ItemCode,
					LastEmp)
				Values (@ls_custcd,	@ls_citno,	@ls_citnm,
					@ls_area,	@ls_division,	@ls_itno,
					'SYSTEM')
		  End			
					
		
	End	-- If @ls_chgcd = 'A' End
	
	If @ls_chgcd = 'R' 	-- 수정
	Begin
	
		If @ls_area = 'D' 
		  Begin
			If @ls_division = 'A'
				Update	[ipisele_svr\ipis].ipis.dbo.tmstcustitem
				Set	CustItemName = @ls_citnm,
					ItemCode = @ls_itno,
					LastDate = Getdate()
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
			If @ls_division = 'M' or @ls_division = 'S'	
				Update	[ipismac_svr\ipis].ipis.dbo.tmstcustitem
				Set	CustItemName = @ls_citnm,
					ItemCode = @ls_itno,
					LastDate = Getdate()
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
			If @ls_division = 'H' or @ls_division = 'V'	
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
				Set	CustItemName = @ls_citnm,
					ItemCode = @ls_itno,
					LastDate = Getdate()
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
		  End
		Else
		  Begin
		  	If @ls_area = 'K'
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstcustitem
				Set	CustItemName = @ls_citnm,
					ItemCode = @ls_itno,
					LastDate = Getdate()
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
			If @ls_area = 'J'
				Update	[ipisjin_svr].ipis.dbo.tmstcustitem
				Set	CustItemName = @ls_citnm,
					ItemCode = @ls_itno,
					LastDate = Getdate()
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
		  End		
					
		
	End	-- If @ls_chgcd = 'R' End

	If @ls_chgcd = 'D' 	-- 삭제
	Begin
	
		If @ls_area = 'D' 
		  Begin
			If @ls_division = 'A'
				Delete	from [ipisele_svr\ipis].ipis.dbo.tmstcustitem
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
			If @ls_division = 'M' or @ls_division = 'S'	
				Delete	from [ipismac_svr\ipis].ipis.dbo.tmstcustitem
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
			If @ls_division = 'H' or @ls_division = 'V'	
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
		  End
		Else  
		  Begin
			If @ls_area = 'K'
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
			If @ls_area = 'J'
				Delete	from [ipisjin_svr].ipis.dbo.tmstcustitem
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	custcode = @ls_custcd
				and	custitemcode = @ls_citno
		  End		
				
	End	-- If @ls_chgcd = 'D' End

End			-- While Loop End

Drop table #tmp_pdsle101

End		-- Procedure End
Go
