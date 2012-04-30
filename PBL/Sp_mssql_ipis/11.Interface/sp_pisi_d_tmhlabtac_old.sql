/*
	File Name	: sp_pisi_d_tmhlabtac.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tmhlabtac
	Description	: Download ���� ����Ÿ - ����
			  tmhlabtac
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmhlabtac]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmhlabtac]
GO

/*
Execute sp_pisi_d_tmhlabtac '2002.11.28'
*/

Create Procedure sp_pisi_d_tmhlabtac
	@ps_date		char(10)		-- ����
	
As
Begin

-- �뱸����
If Not Exists (select * from [ipisele_svr\ipis].ipis.dbo.tmhlabtac
		where dgday = @ps_date)
insert into [ipisele_svr\ipis].ipis.dbo.tmhlabtac
	(dgempno,	dgday,		
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	excflag)
select	empno,		dgyy+'.'+dgmm+'.'+dgdd,
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	null
from	tmislabtac
where	dgyy+'.'+dgmm+'.'+dgdd = @ps_date

If Not Exists (select * from [ipismac_svr\ipis].ipis.dbo.tmhlabtac
		where dgday = @ps_date)

-- �뱸���
insert into [ipismac_svr\ipis].ipis.dbo.tmhlabtac
	(dgempno,	dgday,		
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	excflag)
select	empno,		dgyy+'.'+dgmm+'.'+dgdd,
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	null
from	tmislabtac
where	dgyy+'.'+dgmm+'.'+dgdd = @ps_date


If Not Exists (select * from [ipishvac_svr\ipis].ipis.dbo.tmhlabtac
		where dgday = @ps_date)
-- �뱸����
insert into [ipishvac_svr\ipis].ipis.dbo.tmhlabtac
	(dgempno,	dgday,		
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	excflag)
select	empno,		dgyy+'.'+dgmm+'.'+dgdd,
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	null
from	tmislabtac
where	dgyy+'.'+dgmm+'.'+dgdd = @ps_date


If Not Exists (select * from [ipisjin_svr].ipis.dbo.tmhlabtac
		where dgday = @ps_date)
-- ��õ
insert into [ipisjin_svr].ipis.dbo.tmhlabtac
	(dgempno,	dgday,		
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	excflag)
select	empno,		dgyy+'.'+dgmm+'.'+dgdd,
	dgdiv,		dgdepte,
	dgempgb,	dgdaygb,	dgtimer,	dgcd1r,
	dgcd2r,		dgcd3r,		dgdngbr,	dgotr,
	dgntr,		dgjor,		dgsangr,	dgjuhur,
	dghumur,	dgspcr,		dgjir,		dgoor,
	dgpor,		dgjtr,		dggunbor,	dgmur,
	dgclass,	dgindt,		dgintime,	dginusr,
	dgupdt,		dguptime,	dgupusr,	null
from	tmislabtac
where	dgyy+'.'+dgmm+'.'+dgdd = @ps_date


Else	-- ������ update

Begin

-- �뱸����
update	[ipisele_svr\ipis].ipis.dbo.tmhlabtac
set	dgtimer = tmislabtac.dgtimer,	dgcd1r = tmislabtac.dgcd1r,
	dgcd2r = tmislabtac.dgcd2r,	dgcd3r = tmislabtac.dgcd3r,
	dgdngbr = tmislabtac.dgdngbr,	dgotr = tmislabtac.dgotr,
	dgntr = tmislabtac.dgntr,	dgjor = tmislabtac.dgjor,
	dgsangr = tmislabtac.dgsangr,	dgjuhur = tmislabtac.dgjuhur,
	dghumur = tmislabtac.dghumur,	dgspcr = tmislabtac.dgspcr,
	dgjir = tmislabtac.dgjir,	dgoor = tmislabtac.dgoor,
	dgpor = tmislabtac.dgpor,	dgjtr = tmislabtac.dgjtr,
	dggunbor = tmislabtac.dggunbor,	dgmur = tmislabtac.dgmur,
	dgclass = tmislabtac.dgclass,	dgindt = tmislabtac.dgindt,
	dgintime = tmislabtac.dgintime,	dginusr = tmislabtac.dginusr,
	dgupdt = tmislabtac.dgupdt,	dguptime = tmislabtac.dguptime,	
	dgupusr = tmislabtac.dgupusr
from	[ipisele_svr\ipis].ipis.dbo.tmhlabtac, tmislabtac	
where	dgempno = tmislabtac.empno
and	dgday = @ps_date
and	dgday = tmislabtac.dgyy+'.'+tmislabtac.dgmm+'.'+tmislabtac.dgdd	 

-- �뱸���
update	[ipismac_svr\ipis].ipis.dbo.tmhlabtac
set	dgtimer = tmislabtac.dgtimer,	dgcd1r = tmislabtac.dgcd1r,
	dgcd2r = tmislabtac.dgcd2r,	dgcd3r = tmislabtac.dgcd3r,
	dgdngbr = tmislabtac.dgdngbr,	dgotr = tmislabtac.dgotr,
	dgntr = tmislabtac.dgntr,	dgjor = tmislabtac.dgjor,
	dgsangr = tmislabtac.dgsangr,	dgjuhur = tmislabtac.dgjuhur,
	dghumur = tmislabtac.dghumur,	dgspcr = tmislabtac.dgspcr,
	dgjir = tmislabtac.dgjir,	dgoor = tmislabtac.dgoor,
	dgpor = tmislabtac.dgpor,	dgjtr = tmislabtac.dgjtr,
	dggunbor = tmislabtac.dggunbor,	dgmur = tmislabtac.dgmur,
	dgclass = tmislabtac.dgclass,	dgindt = tmislabtac.dgindt,
	dgintime = tmislabtac.dgintime,	dginusr = tmislabtac.dginusr,
	dgupdt = tmislabtac.dgupdt,	dguptime = tmislabtac.dguptime,	
	dgupusr = tmislabtac.dgupusr
from	[ipismac_svr\ipis].ipis.dbo.tmhlabtac, tmislabtac
where	dgempno = tmislabtac.empno
and	dgday = @ps_date
and	dgday = tmislabtac.dgyy+'.'+tmislabtac.dgmm+'.'+tmislabtac.dgdd	 

-- �뱸����
update	[ipishvac_svr\ipis].ipis.dbo.tmhlabtac
set	dgtimer = tmislabtac.dgtimer,	dgcd1r = tmislabtac.dgcd1r,
	dgcd2r = tmislabtac.dgcd2r,	dgcd3r = tmislabtac.dgcd3r,
	dgdngbr = tmislabtac.dgdngbr,	dgotr = tmislabtac.dgotr,
	dgntr = tmislabtac.dgntr,	dgjor = tmislabtac.dgjor,
	dgsangr = tmislabtac.dgsangr,	dgjuhur = tmislabtac.dgjuhur,
	dghumur = tmislabtac.dghumur,	dgspcr = tmislabtac.dgspcr,
	dgjir = tmislabtac.dgjir,	dgoor = tmislabtac.dgoor,
	dgpor = tmislabtac.dgpor,	dgjtr = tmislabtac.dgjtr,
	dggunbor = tmislabtac.dggunbor,	dgmur = tmislabtac.dgmur,
	dgclass = tmislabtac.dgclass,	dgindt = tmislabtac.dgindt,
	dgintime = tmislabtac.dgintime,	dginusr = tmislabtac.dginusr,
	dgupdt = tmislabtac.dgupdt,	dguptime = tmislabtac.dguptime,	
	dgupusr = tmislabtac.dgupusr
from	[ipishvac_svr\ipis].ipis.dbo.tmhlabtac, tmislabtac
where	dgempno = tmislabtac.empno
and	dgday = @ps_date
and	dgday = tmislabtac.dgyy+'.'+tmislabtac.dgmm+'.'+tmislabtac.dgdd	 

-- ��õ
update	[ipisjin_svr].ipis.dbo.tmhlabtac
set	dgtimer = tmislabtac.dgtimer,	dgcd1r = tmislabtac.dgcd1r,
	dgcd2r = tmislabtac.dgcd2r,	dgcd3r = tmislabtac.dgcd3r,
	dgdngbr = tmislabtac.dgdngbr,	dgotr = tmislabtac.dgotr,
	dgntr = tmislabtac.dgntr,	dgjor = tmislabtac.dgjor,
	dgsangr = tmislabtac.dgsangr,	dgjuhur = tmislabtac.dgjuhur,
	dghumur = tmislabtac.dghumur,	dgspcr = tmislabtac.dgspcr,
	dgjir = tmislabtac.dgjir,	dgoor = tmislabtac.dgoor,
	dgpor = tmislabtac.dgpor,	dgjtr = tmislabtac.dgjtr,
	dggunbor = tmislabtac.dggunbor,	dgmur = tmislabtac.dgmur,
	dgclass = tmislabtac.dgclass,	dgindt = tmislabtac.dgindt,
	dgintime = tmislabtac.dgintime,	dginusr = tmislabtac.dginusr,
	dgupdt = tmislabtac.dgupdt,	dguptime = tmislabtac.dguptime,	
	dgupusr = tmislabtac.dgupusr
from	[ipisjin_svr].ipis.dbo.tmhlabtac, tmislabtac
where	dgempno = tmislabtac.empno
and	dgday = @ps_date
and	dgday = tmislabtac.dgyy+'.'+tmislabtac.dgmm+'.'+tmislabtac.dgdd	 

End
 
End		-- Procedure End
Go
