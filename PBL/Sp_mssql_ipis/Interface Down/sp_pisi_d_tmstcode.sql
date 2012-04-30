/*
	File Name	: sp_pisi_d_tmstcode.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstcode
	Description	: Download tmstcode
			  여주전자 서버추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstcode]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstcode]
GO

/*
Execute sp_pisi_d_tmstcode
*/

Create Procedure sp_pisi_d_tmstcode
	
	
As
Begin


If Not Exists (Select * From dac002)
	Begin
	Return
	End

-- 대구 전장

-- tmstcode
delete	from [ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	
	codeid,		
	codegroupname,		codename,	coderef01,	lastemp)
select	'SCUSTGUBUN',	
	case cocode
		when '' then 'Z'
		else cocode
		end,		
	'거래처구분',		coitname,	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'SLE010'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OBONBU',	cocode,		'본부',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER388'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'DAC092',	cocode,		'자재불출코드',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'DAC092'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OEMPCLASS',	cocode,		'직위',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER306'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OJIKJONG',	cocode,		'직종',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER302'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OJIKCHEK',	cocode,		'직책',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER353'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OITEMCLASS',	cocode,		'ITEM계정',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'INV020'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OSOURCE',	cocode,		'ITEM구입선',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'DAC040'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OITEMUNIT',	cocode,		'ITEM단위',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'DAC070'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OITEMTYPE',	cocode,		'ITEMTYPE',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'INV220'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OABCCODE',	cocode,		'ABC코드',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'INV225'

-- 대구 기계

-- tmstcode
delete	from [ipismac_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

insert into [ipismac_svr\ipis].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')


-- 대구 공조

-- tmstcode
delete	from [ipishvac_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

insert into [ipishvac_svr\ipis].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')


-- 진천

-- tmstcode
delete	from [ipisjin_svr].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

insert into [ipisjin_svr].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

-- 여주

-- tmstcode
delete	from [ipisyeo_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

insert into [ipisyeo_svr\ipis].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

-- EIS

-- tmstcode
delete	from [ipisele_svr\ipis].eis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')

insert into [ipisele_svr\ipis].eis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('거래처구분','본부','자재불출코드','직위','직종','직책',
	'ITEM계정','ITEM구입선','ITEM단위','ITEMTYPE','ABC코드')
		
Truncate Table	Dac002

End		-- Procedure End
GO
