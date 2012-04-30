/*
	File Name	: sp_pisi_d_tmstcode.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tmstcode
	Description	: Download tmstcode
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

-- �뱸 ����

-- tmstcode
delete	from [ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	
	codeid,		
	codegroupname,		codename,	coderef01,	lastemp)
select	'SCUSTGUBUN',	
	case cocode
		when '' then 'Z'
		else cocode
		end,		
	'�ŷ�ó����',		coitname,	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'SLE010'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OBONBU',	cocode,		'����',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER388'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'DAC092',	cocode,		'��������ڵ�',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'DAC092'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OEMPCLASS',	cocode,		'����',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER306'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OJIKJONG',	cocode,		'����',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER302'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OJIKCHEK',	cocode,		'��å',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'PER353'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OITEMCLASS',	cocode,		'ITEM����',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'INV020'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OSOURCE',	cocode,		'ITEM���Լ�',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'DAC040'

insert into [ipisele_svr\ipis].ipis.dbo.tmstcode
	(codegroup,	codeid,		codegroupname,		codename,	
	coderef01,	lastemp)
select	'OITEMUNIT',	cocode,		'ITEM����',		coitname,
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
select	'OABCCODE',	cocode,		'ABC�ڵ�',		coitname,
	coitnamee,	'SYSTEM'
from	dac002
where	cogubun = 'INV225'

-- �뱸 ���

-- tmstcode
delete	from [ipismac_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

insert into [ipismac_svr\ipis].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')


-- �뱸 ����

-- tmstcode
delete	from [ipishvac_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

insert into [ipishvac_svr\ipis].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')


-- ��õ

-- tmstcode
delete	from [ipisjin_svr].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

insert into [ipisjin_svr].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

-- ����

-- tmstcode
delete	from [ipisyeo_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

insert into [ipisyeo_svr\ipis].ipis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

-- EIS

-- tmstcode
delete	from [ipisele_svr\ipis].eis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')

insert into [ipisele_svr\ipis].eis.dbo.tmstcode
select	* 
from	[ipisele_svr\ipis].ipis.dbo.tmstcode
where	codegroupname in ('�ŷ�ó����','����','��������ڵ�','����','����','��å',
	'ITEM����','ITEM���Լ�','ITEM����','ITEMTYPE','ABC�ڵ�')
		
Truncate Table	Dac002

End		-- Procedure End
GO
