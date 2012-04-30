/*
	File Name	: sp_pisi_d_tmstproduct.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstproduct
	Description	: Download tmstproduct, tmstproductgroup, tmstmodelgroup
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstproduct]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstproduct]
GO

/*
Execute sp_pisi_d_tmstproduct
*/

Create Procedure sp_pisi_d_tmstproduct
	
	
As
Begin

if Not	Exists	(select * From dac004)
	Begin
	Return
	End
	

-- 대구 전장
exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproductgroup'

-- tmstproductgroup
insert	into [ipisele_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	'D',		'A',		a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b 
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D', ' ')	and
	a.Prplant	in	('A', ' ') 	and
	len(a.prprcd)	= 	2
order by a.prprcd

exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstmodelgroup'

-- tmstmodelgroup
insert	into [ipisele_svr\ipis].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,		LastEmp)
select 	'D',			'A',		substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D', ' ')	and
	a.Prplant	in	('A', ' ') 	and
	len(a.prprcd)	= 	3
order by a.prprcd

exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproduct'

-- tmstproduct
insert	into [ipisele_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'D',			'A',			substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)), 'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D', ' ')	and
	a.Prplant	in	('A', ' ') 	and
	len(a.prprcd)	= 	4
order by a.prprcd

-- tmstcode
delete	from [ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroup = 'OPRODUCT'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,	codename,	
	lastemp)
select	Distinct 'OPRODUCT',	a.prprcd,	'PRODUCT',	rtrim(ltrim(b.prname)),
	'SYSTEM'
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd


-- 대구 기계
exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproductgroup'

-- tmstproductgroup
insert	into [ipismac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	 'D',		a.prplant,	a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D')		and
	a.Prplant	in	('M', 'S') 	and
	len(a.prprcd)	= 	2
order by a.prprcd

exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstmodelgroup'

-- tmstmodelgroup
insert	into [ipismac_svr\ipis].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,	LastEmp)
select 	'D',			a.prplant,	substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D')		and
	a.Prplant	in	('M', 'S') 	and
	len(a.prprcd)	= 	3
order by a.prprcd

exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproduct'

-- tmstproduct
insert	into [ipismac_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'D',			a.prplant,		substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D')		and
	a.Prplant	in	('M', 'S') 	and
	len(a.prprcd)	= 	4
order by a.prprcd

-- tmstcode
delete	from [ipismac_svr\ipis].ipis.dbo.tmstcode
where	codegroup = 'OPRODUCT'

insert into [ipismac_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,	codename,	
	lastemp)
select	Distinct 'OPRODUCT',	a.prprcd,	'PRODUCT',	rtrim(ltrim(b.prname)),
	'SYSTEM'
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd


-- 대구 공조
exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproductgroup'

-- tmstproductgroup
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	'D',		a.prplant,	a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D')		and
	a.Prplant	in	('H', 'V') 	and
	len(a.prprcd)	= 	2
order by a.prprcd

exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstmodelgroup'

-- tmstmodelgroup
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,	LastEmp)
select 	'D',			a.prplant,	substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D')		and
	a.Prplant	in	('H', 'V') 	and
	len(a.prprcd)	= 	3
order by a.prprcd

exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproduct'

-- tmstproduct
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'D',			a.prplant,		substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('D')		and
	a.Prplant	in	('H', 'V') 	and
	len(a.prprcd)	= 	4
order by a.prprcd

-- tmstcode
delete	from [ipishvac_svr\ipis].ipis.dbo.tmstcode
where	codegroup = 'OPRODUCT'

insert into [ipishvac_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,	codename,	
	lastemp)
select	Distinct 'OPRODUCT',	a.prprcd,	'PRODUCT',	rtrim(ltrim(b.prname)),
	'SYSTEM'
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd


-- 여주

-- tmstproductgroup
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	'Y',		'Y',		a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('Y')		and
	a.Prplant	in	('Y') 	and
	len(a.prprcd)	= 	2
order by a.prprcd

-- tmstmodelgroup
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,	LastEmp)
select 	'Y',			'Y',		substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('Y')		and
	a.Prplant	in	('Y') 	and
	len(a.prprcd)	= 	3
order by a.prprcd

-- tmstproduct
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'Y',			'Y',			substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('Y')		and
	a.Prplant	in	('Y') 	and
	len(a.prprcd)	= 	4
order by a.prprcd


-- 군산

-- tmstproductgroup
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	'K',		a.prplant,	a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('K')		and
	len(a.prprcd)	= 	2
order by a.prprcd

-- tmstmodelgroup
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,	LastEmp)
select 	'K',			a.prplant,	substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)), 'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('K')		and
	len(a.prprcd)	= 	3
order by a.prprcd

-- tmstproduct
insert	into [ipishvac_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'K',			a.prplant,		substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('K')		and
	len(a.prprcd)	= 	4
order by a.prprcd


-- 진천
exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstproductgroup'

-- tmstproductgroup
insert	into [ipisjin_svr].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	'J',		a.prplant,	a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('J')		and
	len(a.prprcd)	= 	2
order by a.prprcd

exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstmodelgroup'

-- tmstmodelgroup
insert	into [ipisjin_svr].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,	LastEmp)
select 	'J',			a.prplant,	substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('J')		and
	len(a.prprcd)	= 	3
order by a.prprcd

exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstproduct'

-- tmstproduct
insert	into [ipisjin_svr].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'J',			a.prplant,		substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('J')		and
	len(a.prprcd)	= 	4
order by a.prprcd

-- tmstcode
delete	from [ipisjin_svr].ipis.dbo.tmstcode
where	codegroup = 'OPRODUCT'

insert into [ipisjin_svr].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,	codename,	
	lastemp)
select	Distinct 'OPRODUCT',	a.prprcd,	'PRODUCT',	rtrim(ltrim(b.prname)),
	'SYSTEM'
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd

-- 여주
exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproductgroup'

-- tmstproductgroup
insert	into [ipisyeo_svr\ipis].ipis.dbo.tmstproductgroup
	(AreaCode,	DivisionCode,	ProductGroup,	ProductGroupName,	LastEmp)
select 	'Y',		a.prplant,	a.prprcd,	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('Y')		and
	len(a.prprcd)	= 	2
order by a.prprcd

exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstmodelgroup'

-- tmstmodelgroup
insert	into [ipisyeo_svr\ipis].ipis.dbo.tmstmodelgroup
	(AreaCode,		DivisionCode,	ProductGroup,			ModelGroup,
	ModelGroupName,	LastEmp)
select 	'Y',			a.prplant,	substring(a.prprcd,1,2),	a.prprcd,		
	rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('Y')		and
	len(a.prprcd)	= 	3
order by a.prprcd

exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstproduct'

-- tmstproduct
insert	into [ipisyeo_svr\ipis].ipis.dbo.tmstproduct
	(AreaCode,		DivisionCode,		ProductGroup,			ModelGroup,
	ProductCode,		ProductName,		LastEmp)
select 	'Y',			a.prplant,		substring(a.prprcd,1,2),	substring(a.prprcd,1,3),
	a.prprcd,		rtrim(ltrim(b.prname)),	'SYSTEM' 
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd	and
	a.prarea	in	('Y')		and
	len(a.prprcd)	= 	4
order by a.prprcd

-- tmstcode
delete	from [ipisyeo_svr\ipis].ipis.dbo.tmstcode
where	codegroup = 'OPRODUCT'

insert into [ipisyeo_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,	codename,	
	lastemp)
select	Distinct 'OPRODUCT',	a.prprcd,	'PRODUCT',	rtrim(ltrim(b.prname)),
	'SYSTEM'
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd


-- EIS
exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tmstproductgroup'

-- tmstproductgroup
insert	into [ipisele_svr\ipis].eis.dbo.tmstproductgroup
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstproductgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstproductgroup
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstproductgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstproductgroup
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstproductgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstproductgroup
select	*
from	[ipisjin_svr].ipis.dbo.tmstproductgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstproductgroup
select	*
from	[ipisyeo_svr\ipis].ipis.dbo.tmstproductgroup

exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tmstmodelgroup'

-- tmstmodelgroup
insert	into [ipisele_svr\ipis].eis.dbo.tmstmodelgroup
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstmodelgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstmodelgroup
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstmodelgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstmodelgroup
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstmodelgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstmodelgroup
select	*
from	[ipisjin_svr].ipis.dbo.tmstmodelgroup

insert	into [ipisele_svr\ipis].eis.dbo.tmstmodelgroup
select	*
from	[ipisyeo_svr\ipis].ipis.dbo.tmstmodelgroup

exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tmstproduct'

-- tmstproduct
insert	into [ipisele_svr\ipis].eis.dbo.tmstproduct
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstproduct

insert	into [ipisele_svr\ipis].eis.dbo.tmstproduct
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstproduct

insert	into [ipisele_svr\ipis].eis.dbo.tmstproduct
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstproduct

insert	into [ipisele_svr\ipis].eis.dbo.tmstproduct
select	*
from	[ipisjin_svr].ipis.dbo.tmstproduct

insert	into [ipisele_svr\ipis].eis.dbo.tmstproduct
select	*
from	[ipisyeo_svr\ipis].ipis.dbo.tmstproduct

-- tmstcode
delete	from [ipisele_svr\ipis].eis.dbo.tmstcode
where	codegroup = 'OPRODUCT'

insert into [ipisele_svr\ipis].eis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,	codename,	
	lastemp)
select	Distinct 'OPRODUCT',	a.prprcd,	'PRODUCT',	rtrim(ltrim(b.prname)),
	'SYSTEM'
from	dac004 a, dac007 b
where	a.prprcd	=	b.prprcd

Truncate Table	dac004
Truncate Table	Dac007


End		-- Procedure End

GO
