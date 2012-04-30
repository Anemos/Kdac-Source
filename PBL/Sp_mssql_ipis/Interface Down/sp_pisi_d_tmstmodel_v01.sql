SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/*
Execute sp_pisi_d_tmstmodel
*/

ALTER   Procedure sp_pisi_d_tmstmodel
	
	
As
Begin

set xact_abort off

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
	@ls_chgdate		varchar(30)

insert into invmaster
Select *
From	pdinv101_log
WHere	Cls	in	('23',	'43')	and
	chgdate	not in (select	chgdate	From	invmaster)
	
if @@error	<>	0
	Begin
	Return
	End
	
Delete	From	Pdinv101_log
Where	cls	in	('23',	'43')	and
	chgdate	in (select	chgdate	From	invmaster)
	
if @@error	<>	0
	Begin
	Return
	End

Delete	From	Pdinv101_log
Where	cls	in	('21',	'41')

-- BATCH PROCESS
-- ELE SERVER
DELETE [ipisele_svr\ipis].ipis.dbo.tmstmodel
FROM [ipisele_svr\ipis].ipis.dbo.tmstmodel AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

DELETE [ipisele_svr\ipis].ipis.dbo.tmstitemcost
FROM [ipisele_svr\ipis].ipis.dbo.tmstitemcost AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

INSERT INTO [ipisele_svr\ipis].ipis.dbo.tmstmodel
	(AreaCode,	DivisionCode,	ProductGroup,ModelGroup,ProductCode,ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit,ConvertFactor,	AverageUnitCost,AbcCode,
	Location,	Planner,	LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2), substring(AA.pdcd, 1, 3),
	AA.itno,	AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
	AA.wloc,	AA.xplan, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
				
INSERT INTO [ipisele_svr\ipis].ipis.dbo.tmstitemcost
	(AreaCode,	DivisionCode, ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,	
	AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
		AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
	
-- HVAC SERVER
DELETE [ipishvac_svr\ipis].ipis.dbo.tmstmodel
FROM [ipishvac_svr\ipis].ipis.dbo.tmstmodel AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

DELETE [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
FROM [ipishvac_svr\ipis].ipis.dbo.tmstitemcost AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

INSERT INTO [ipishvac_svr\ipis].ipis.dbo.tmstmodel
	(AreaCode,	DivisionCode,	ProductGroup,ModelGroup,ProductCode,ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit,ConvertFactor,	AverageUnitCost,AbcCode,
	Location,	Planner,	LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2), substring(AA.pdcd, 1, 3),
	AA.itno,	AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
	AA.wloc,	AA.xplan, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
			
INSERT INTO [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
	(AreaCode,	DivisionCode, ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,	
	AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
	   
-- MAC SERVER
DELETE [ipismac_svr\ipis].ipis.dbo.tmstmodel
FROM [ipismac_svr\ipis].ipis.dbo.tmstmodel AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

DELETE [ipismac_svr\ipis].ipis.dbo.tmstitemcost
FROM [ipismac_svr\ipis].ipis.dbo.tmstitemcost AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

INSERT INTO [ipismac_svr\ipis].ipis.dbo.tmstmodel
	(AreaCode,	DivisionCode,	ProductGroup,ModelGroup,ProductCode,ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit,ConvertFactor,	AverageUnitCost,AbcCode,
	Location,	Planner,	LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2), substring(AA.pdcd, 1, 3),
	AA.itno,	AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
	AA.wloc,	AA.xplan, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
				
INSERT INTO [ipismac_svr\ipis].ipis.dbo.tmstitemcost
	(AreaCode,	DivisionCode, ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,	
	AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
	
-- JIN SERVER
DELETE [ipisjin_svr].ipis.dbo.tmstmodel
FROM [ipisjin_svr].ipis.dbo.tmstmodel AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

DELETE [ipisjin_svr].ipis.dbo.tmstitemcost
FROM [ipisjin_svr].ipis.dbo.tmstitemcost AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE XPLANT = 'D' AND DIV = 'A' AND CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

INSERT INTO [ipisjin_svr].ipis.dbo.tmstmodel
	(AreaCode,	DivisionCode,	ProductGroup,ModelGroup,ProductCode,ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit,ConvertFactor,	AverageUnitCost,AbcCode,
	Location,	Planner,	LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2), substring(AA.pdcd, 1, 3),
	AA.itno,	AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
	AA.wloc,	AA.xplan, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
			
INSERT INTO [ipisjin_svr].ipis.dbo.tmstitemcost
	(AreaCode,	DivisionCode, ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit, UnitCost, LastEmp)
SELECT AA.xplant, AA.div, AA.itno,	
	AA.cls, AA.srce, AA.xunit, AA.saud, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE xplant = 'D' AND div = 'A' AND chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1   
if @@error <> 0
	return
	
-- EIS SERVER
DELETE [ipisele_svr\ipis].eis.dbo.tmstmodel
FROM [ipisele_svr\ipis].eis.dbo.tmstmodel AA INNER JOIN 
		( SELECT  XPLANT, DIV, ITNO , COUNT(*) as chk_cnt  FROM PDINV101_LOG
			WHERE CHGCD IN ('A','R','D')
			GROUP BY XPLANT, DIV,ITNO ) BB
		ON AA.areacode = BB.xplant AND AA.divisioncode = BB.div AND
			 AA.itemcode = BB.itno
WHERE BB.chk_cnt = 1

INSERT INTO [ipisele_svr\ipis].eis.dbo.tmstmodel
	(AreaCode,	DivisionCode,	ProductGroup,ModelGroup,ProductCode,ItemCode,	
	ItemClass,	ItemBuySource,	ItemUnit,ConvertFactor,	AverageUnitCost,AbcCode,
	Location,	Planner,	LastEmp)
SELECT AA.xplant, AA.div, substring(AA.pdcd, 1, 2), substring(AA.pdcd, 1, 3),
	AA.itno,	AA.cls, AA.srce, AA.xunit, AA.convqty, AA.saud, AA.abccd,
	AA.wloc,	AA.xplan, 'SYSTEM'
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE chgcd IN ('A','R')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1
if @@error <> 0 
	return
				
-- Delete pdinv101_log 
DELETE pdinv101_log  
FROM pdinv101_log AA, 
	( SELECT xplant, div, itno, count(*) as chk_cnt
		FROM pdinv101_log
		WHERE chgcd IN ('A','R','D')
		GROUP BY xplant, div, itno ) BB
WHERE AA.xplant = BB.xplant AND AA.div = BB.div AND
			AA.itno   = BB.itno   AND BB.chk_cnt = 1
if @@error <> 0
	return
			
-- END
	
Select	*
into	#tmp_pdinv101
from	pdinv101_log
order by chgdate
	
Select @i = 0, @li_loop_count = @@RowCount, @ls_chgdate = ''

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
		@ls_chgdate	= chgdate
	From	#tmp_pdinv101
	Where	chgdate > @ls_chgdate

	if @@error	<>	0
		Begin
		Continue
		End
		
	if (select Count(*) From pdinv101_log
	   Where  Chgdate	<	@ls_Chgdate	and
	   	  xplant	=	@ls_area	and
	   	  div		=	@ls_division	and
	   	  itno		=	@ls_itno) > 0
	   Begin
	   Continue
	   End
	
	If len(@ls_modelgroup) = 2
		Begin
		select @ls_modelgroup = @ls_modelgroup + '9'
		End

	If @ls_chgcd = 'A' or @ls_chgcd = 'R' 	-- 추가	or 수정
	Begin
	
		If @ls_area = 'D' and @ls_division = 'A'
		Begin
			Delete	from [ipisele_svr\ipis].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno
	
			if @@error	<>	0
				Begin
				Continue
				End
				
			Delete	from [ipisele_svr\ipis].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno
	
			if @@error	<>	0
				Begin
				Continue
				End

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
				
			if @@error	<>	0
				Begin
				Continue
				End

			Insert Into [ipisele_svr\ipis].ipis.dbo.tmstitemcost
				(AreaCode,	DivisionCode,	ItemCode,	
				ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
			Values (@ls_area,	@ls_division,	@ls_itno,
				@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')

			if @@error	<>	0
				Begin
				Continue
				End

		end		
				
		If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')	
		Begin
			Delete	from [ipismac_svr\ipis].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
			Delete	from [ipismac_svr\ipis].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
	
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
				
			if @@error	<>	0
				Begin
				Continue
				End

			Insert Into [ipismac_svr\ipis].ipis.dbo.tmstitemcost
				(AreaCode,	DivisionCode,	ItemCode,	
				ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
			Values (@ls_area,	@ls_division,	@ls_itno,
				@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')

			if @@error	<>	0
				Begin
				Continue
				End

		end		
				
		If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or
		   (@ls_area = 'Y' or @ls_area = 'K')
		Begin
			Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
			Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
	
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

			if @@error	<>	0
				Begin
				Continue
				End
				
			Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
				(AreaCode,	DivisionCode,	ItemCode,	
				ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
			Values (@ls_area,	@ls_division,	@ls_itno,
				@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')

			if @@error	<>	0
				Begin
				Continue
				End

		end		
				
		If @ls_area = 'J'
		Begin
			Delete	from [ipisjin_svr].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
			Delete	from [ipisjin_svr].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
	
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

			if @@error	<>	0
				Begin
				Continue
				End
				
			Insert Into [ipisjin_svr].ipis.dbo.tmstitemcost
				(AreaCode,	DivisionCode,	ItemCode,	
				ItemClass,	ItemBuySource,	ItemUnit,	UnitCost,	LastEmp)
			Values (@ls_area,	@ls_division,	@ls_itno,
				@ls_cls,	@ls_srce,	@ls_xunit,	@ld_saud,	'SYSTEM')

			if @@error	<>	0
				Begin
				Continue
				End

		end		
		  
		Delete	from [ipisele_svr\ipis].eis.dbo.tmstmodel
		Where	areacode	=	@ls_area
		and	divisioncode	=	@ls_division
		and	itemcode	=	@ls_itno

		if @@error	<>	0
			Begin
			Continue
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

		if @@error	<>	0
			Begin
			Continue
			End
		
	End	-- If @ls_chgcd = 'R' End

	If @ls_chgcd = 'D' 	-- 삭제
	Begin
	
		If @ls_area = 'D' and @ls_division = 'A'
		begin
			Delete	from [ipisele_svr\ipis].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
			Delete	from [ipisele_svr\ipis].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End

		end	
				
		If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')	
		begin
			Delete	from [ipismac_svr\ipis].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
			Delete	from [ipismac_svr\ipis].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
		end
				
		If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V')) or (@ls_area = 'Y' or @ls_area = 'K')
		begin
			Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End

			Delete	from [ipishvac_svr\ipis].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End

		end
				
		If @ls_area = 'J'
		begin
			Delete	from [ipisjin_svr].ipis.dbo.tmstmodel
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End
			
			Delete	from [ipisjin_svr].ipis.dbo.tmstitemcost
			Where	areacode	=	@ls_area
			and	divisioncode	=	@ls_division
			and	itemcode	=	@ls_itno

			if @@error	<>	0
				Begin
				Continue
				End

		end

		Delete	from [ipisele_svr\ipis].eis.dbo.tmstmodel
		Where	areacode	=	@ls_area
		and	divisioncode	=	@ls_division
		and	productcode	=	@ls_pdcd
		and	itemcode	=	@ls_itno

		if @@error	<>	0
			Begin
			Continue
			End
				
	End	-- If @ls_chgcd = 'D' End

delete	from pdinv101_log
where chgdate =	@ls_chgdate

End			-- While Loop End

if (select count(*) from pdinv101_log) = 0
	begin
		truncate table pdinv101_log
	end
	
Drop table #tmp_pdinv101

End		-- Procedure End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

