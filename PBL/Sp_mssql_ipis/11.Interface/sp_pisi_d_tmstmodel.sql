/*
	File Name	: sp_pisi_d_tmstmodel.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstmodel
	Description	: Download Model Master
			  tmstmodel, invmaster(설비 Interface용)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstmodel]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstmodel]
GO

/*
Execute sp_pisi_d_tmstmodel
*/

Create Procedure sp_pisi_d_tmstmodel
	
	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_chgcd		char(1),
	@ls_area		char(1),
	@ls_division		char(1),
	@ls_pdcd		varchar(4),
	@ls_itno		varchar(12),
	@ls_cls			char(2),
	@ls_srce		char(2),
	@ls_xunit		char(2),
	@ld_convqty		decimal(13,4),
	@ld_saud		decimal(9,0),
	@ls_productgroup	char(2),
	@ls_modelgroup		char(3),
	@ls_abc			char(1),
	@ls_loc			varchar(5),
	@ls_xplan		varchar(2),
	@ls_date		varchar(30)

Select	*
into	#tmp_pdinv101
from	pdinv101
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_date = ''

insert into invmaster
select *
from	#tmp_pdinv101
where	cls in ('23','43')


While @i < @li_loop_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_chgcd	= chgcd,
		@ls_area	= xplant,
		@ls_division	= div,
		@ls_productgroup= substring(pdcd, 1, 2),
		@ls_modelgroup	= substring(pdcd, 1, 3),
		@ls_pdcd	= pdcd,
		@ls_itno	= itno,
		@ls_cls		= cls,
		@ls_srce	= srce,
		@ls_xunit	= xunit,
		@ld_convqty	= convqty,
		@ld_saud	= saud,
		@ls_abc		= abccd,
		@ls_loc		= wloc,
		@ls_xplan	= xplan,
		@ls_date	= chgdate
	From	#tmp_pdinv101
	Where	chgdate > @ls_date

	If len(@ls_modelgroup) = 2
		select @ls_modelgroup = @ls_modelgroup + '9'
	
	If @ls_chgcd = 'A' 	-- 추가
	Begin
	
		If @ls_area = 'D' 
		  Begin
			If @ls_division = 'A'
				begin
				Insert Into [ipisele_svr\ipis].ipis.dbo.tmstmodel
					(AreaCode,	DivisionCode,	ProductGroup,	
					ModelGroup,	ProductCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	
					ConvertFactor,	AverageUnitCost,AbcCode,
					Location,	Planner,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_productgroup,
					@ls_modelgroup,	@ls_pdcd,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,
					@ld_convqty,	@ld_saud,	@ls_abc,
					@ls_loc,	@ls_xplan,	'SYSTEM')
					
				Insert Into [ipisele_svr\ipis].ipis.dbo.tmstitemcost
					(AreaCode,	DivisionCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')
				end
					
			If @ls_division = 'M' or @ls_division = 'S'	
				begin
				Insert Into [ipismac_svr\ipis].ipis.dbo.tmstmodel
					(AreaCode,	DivisionCode,	ProductGroup,	
					ModelGroup,	ProductCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	
					ConvertFactor,	AverageUnitCost,AbcCode,
					Location,	Planner,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_productgroup,
					@ls_modelgroup,	@ls_pdcd,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,
					@ld_convqty,	@ld_saud,	@ls_abc,
					@ls_loc,	@ls_xplan,	'SYSTEM')
					
				Insert Into [ipismac_svr\ipis].ipis.dbo.tmstitemcost
					(AreaCode,	DivisionCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')
				end	
					
			If @ls_division = 'H' or @ls_division = 'V'	
				begin
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstmodel
					(AreaCode,	DivisionCode,	ProductGroup,	
					ModelGroup,	ProductCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	
					ConvertFactor,	AverageUnitCost,AbcCode,
					Location,	Planner,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_productgroup,
					@ls_modelgroup,	@ls_pdcd,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,
					@ld_convqty,	@ld_saud,	@ls_abc,
					@ls_loc,	@ls_xplan,	'SYSTEM')
					
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
					(AreaCode,	DivisionCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')
				end	
					
		  End
		Else
		  Begin
			If @ls_area = 'K' or @ls_area = 'Y'
				begin
				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstmodel
					(AreaCode,	DivisionCode,	ProductGroup,	
					ModelGroup,	ProductCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	
					ConvertFactor,	AverageUnitCost,AbcCode,
					Location,	Planner,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_productgroup,
					@ls_modelgroup,	@ls_pdcd,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,
					@ld_convqty,	@ld_saud,	@ls_abc,
					@ls_loc,	@ls_xplan,	'SYSTEM')

				Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
					(AreaCode,	DivisionCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')
				end	
					
			If @ls_area = 'J'
				begin
				Insert Into [ipisjin_svr].ipis.dbo.tmstmodel
					(AreaCode,	DivisionCode,	ProductGroup,	
					ModelGroup,	ProductCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	
					ConvertFactor,	AverageUnitCost,AbcCode,
					Location,	Planner,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_productgroup,
					@ls_modelgroup,	@ls_pdcd,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,
					@ld_convqty,	@ld_saud,	@ls_abc,
					@ls_loc,	@ls_xplan,	'SYSTEM')

				Insert Into [ipisjin_svr].ipis.dbo.tmstitemcost
					(AreaCode,	DivisionCode,	ItemCode,	
					ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
				Values (@ls_area,	@ls_division,	@ls_itno,
					@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')
				end	
					
		  End			

		Insert Into [ipisele_svr\ipis].eis.dbo.tmstmodel
			(AreaCode,	DivisionCode,	ProductGroup,	
			ModelGroup,	ProductCode,	ItemCode,	
			ItemClass,	ItemBuySource,	ItemUnit,	
			ConvertFactor,	AverageUnitCost,AbcCode,
			Location,	Planner,	LastEmp)
		Values (@ls_area,	@ls_division,	@ls_productgroup,
			@ls_modelgroup,	@ls_pdcd,	@ls_itno,
			@ls_cls,	@ls_srce,	@ls_xunit,
			@ld_convqty,	@ld_saud,	@ls_abc,
			@ls_loc,	@ls_xplan,	'SYSTEM')
					
		
	End	-- If @ls_chgcd = 'A' End
	
	If @ls_chgcd = 'R' 	-- 수정
	Begin
	
		If @ls_area = 'D' 
		  Begin
			If @ls_division = 'A'
				begin
				Update	[ipisele_svr\ipis].ipis.dbo.tmstmodel
				Set	ProductGroup = @ls_productgroup,
					ModelGroup = @ls_modelgroup,
					ProductCode = @ls_pdcd,
					ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					ItemUnit = @ls_xunit,
					ConvertFactor = @ld_convqty,
					AverageUnitCost = @ld_saud,
					Abccode = @ls_abc,
					Location = @ls_loc,
					Planner = @ls_xplan
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				
				Update	[ipisele_svr\ipis].ipis.dbo.tmstitemcost
				Set	ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					UnitCost = @ld_saud
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
			If @ls_division = 'M' or @ls_division = 'S'	
				begin
				Update	[ipismac_svr\ipis].ipis.dbo.tmstmodel
				Set	ProductGroup = @ls_productgroup,
					ModelGroup = @ls_modelgroup,
					ProductCode = @ls_pdcd,
					ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					ItemUnit = @ls_xunit,
					ConvertFactor = @ld_convqty,
					AverageUnitCost = @ld_saud,
					Abccode = @ls_abc,
					Location = @ls_loc,
					Planner = @ls_xplan
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno

				Update	[ipismac_svr\ipis].ipis.dbo.tmstitemcost
				Set	ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					UnitCost = @ld_saud
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
			If @ls_division = 'H' or @ls_division = 'V'	
				begin
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstmodel
				Set	ProductGroup = @ls_productgroup,
					ModelGroup = @ls_modelgroup,
					ProductCode = @ls_pdcd,
					ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					ItemUnit = @ls_xunit,
					ConvertFactor = @ld_convqty,
					AverageUnitCost = @ld_saud,
					Abccode = @ls_abc,
					Location = @ls_loc,
					Planner = @ls_xplan
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstitemcost
				Set	ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					UnitCost = @ld_saud
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
		  End
		Else
		  Begin
		  	If @ls_area = 'K'
		  		begin
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstmodel
				Set	ProductGroup = @ls_productgroup,
					ModelGroup = @ls_modelgroup,
					ProductCode = @ls_pdcd,
					ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					ItemUnit = @ls_xunit,
					ConvertFactor = @ld_convqty,
					AverageUnitCost = @ld_saud,
					Abccode = @ls_abc,
					Location = @ls_loc,
					Planner = @ls_xplan
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				
				Update	[ipishvac_svr\ipis].ipis.dbo.tmstitemcost
				Set	ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					UnitCost = @ld_saud
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
			If @ls_area = 'J'
				begin
				Update	[ipisjin_svr].ipis.dbo.tmstmodel
				Set	ProductGroup = @ls_productgroup,
					ModelGroup = @ls_modelgroup,
					ProductCode = @ls_pdcd,
					ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					ItemUnit = @ls_xunit,
					ConvertFactor = @ld_convqty,
					AverageUnitCost = @ld_saud,
					Abccode = @ls_abc,
					Location = @ls_loc,
					Planner = @ls_xplan
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				
				Update	[ipisjin_svr].ipis.dbo.tmstitemcost
				Set	ItemClass = @ls_cls,
					ItemBuySource = @ls_srce,
					UnitCost = @ld_saud
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
		  End		
		  
		Update	[ipisele_svr\ipis].eis.dbo.tmstmodel
		Set	ProductGroup = @ls_productgroup,
			ModelGroup = @ls_modelgroup,
			ProductCode = @ls_pdcd,
			ItemClass = @ls_cls,
			ItemBuySource = @ls_srce,
			ItemUnit = @ls_xunit,
			ConvertFactor = @ld_convqty,
			AverageUnitCost = @ld_saud,
			Abccode = @ls_abc,
			Location = @ls_loc,
			Planner = @ls_xplan
		Where	areacode = @ls_area
		and	divisioncode = @ls_division
		and	itemcode = @ls_itno
		  
					
		
	End	-- If @ls_chgcd = 'R' End

	If @ls_chgcd = 'D' 	-- 삭제
	Begin
	
		If @ls_area = 'D' 
		  Begin
			If @ls_division = 'A'
				begin
				Delete	from [ipisele_svr\ipis].ipis.dbo.tmstmodel
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	productcode = @ls_pdcd
				and	itemcode = @ls_itno
				
				Delete	from [ipisele_svr\ipis].ipis.dbo.tmstitemcost
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
			If @ls_division = 'M' or @ls_division = 'S'	
				begin
				Delete	from [ipismac_svr\ipis].ipis.dbo.tmstmodel
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	productcode = @ls_pdcd
				and	itemcode = @ls_itno
				
				Delete	from [ipismac_svr\ipis].ipis.dbo.tmstitemcost
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
			If @ls_division = 'H' or @ls_division = 'V'	
				begin
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstmodel
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	productcode = @ls_pdcd
				and	itemcode = @ls_itno

				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
		  End
		Else  
		  Begin
			If @ls_area = 'K'
				begin
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstmodel
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	productcode = @ls_pdcd
				and	itemcode = @ls_itno
				
				Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
			If @ls_area = 'J'
				begin
				Delete	from [ipisjin_svr].ipis.dbo.tmstmodel
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	productcode = @ls_pdcd
				and	itemcode = @ls_itno
				
				Delete	from [ipisjin_svr].ipis.dbo.tmstitemcost
				Where	areacode = @ls_area
				and	divisioncode = @ls_division
				and	itemcode = @ls_itno
				end
				
		  End		

		Delete	from [ipisele_svr\ipis].eis.dbo.tmstmodel
		Where	areacode = @ls_area
		and	divisioncode = @ls_division
		and	productcode = @ls_pdcd
		and	itemcode = @ls_itno
				
	End	-- If @ls_chgcd = 'D' End

End			-- While Loop End

Drop table #tmp_pdinv101

End		-- Procedure End
Go
