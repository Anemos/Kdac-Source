/*
	File Name	: sp_pisi_d_tmhlabtac_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmhlabtac_movelog
	Description	: Download 근태 데이타 - 매일
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmhlabtac_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmhlabtac_movelog]
GO

/*
Execute sp_pisi_d_tmhlabtac_movelog
*/

Create Procedure sp_pisi_d_tmhlabtac_movelog
	
As
Begin

Set xact_abort off

begin tran

--수정
update	tmislabtac_log
set	DGDIV		=	A.DGDIV,	DGBUMUN		=	A.DGBUMUN,
	DGDEPTE		=	A.DGDEPTE,	DGDEPTI		=	A.DGDEPTI,
	DGEMPGB		=	' ',	DGDAYGB		=	A.DGDAYGB,
	DGTIMEP		=	A.DGTIMEP,	DGCD1P		=	A.DGCD1P,
	DGCD2P		=	A.DGCD2P,	DGCD3P		=	A.DGCD3P,
	DGDNGBP		=	A.DGDNGBP,	DGOTP		=	A.DGOTP,
	DGJOP		=	A.DGJOP,	DGSANGP		=	A.DGSANGP,
	DGJUHUP		=	A.DGJUHUP,	DGHUMUP		=	A.DGHUMUP,
	DGSPCP		=	A.DGSPCP,	DGEGB		=	A.DGEGB,
	DGTIMER		=	A.DGTIMER,	DGCD1R		=	A.DGCD1R,
	DGCD2R		=	A.DGCD2R,	DGCD3R		=	A.DGCD3R,
	DGDNGBR		=	A.DGDNGBR,	DGOTR		=	A.DGOTR,
	DGNTR		=	A.DGNTR,	DGJOR		=	A.DGJOR,
	DGSANGR		=	A.DGSANGR,	DGJUHUR		=	A.DGJUHUR,
	DGHUMUR		=	A.DGHUMUR,	DGSPCR		=	A.DGSPCR,
	DGJIR		=	A.DGJIR,	DGOOR		=	A.DGOOR,
	DGPOR		=	A.DGPOR,	DGJTR		=	A.DGJTR,
	DGGUNBOR	=	A.DGGUNBOR,	DGMUR		=	A.DGMUR,
	DGCLASS		=	A.DGCLASS,	DGKUBHO		=	A.DGKUBHO,
	DGSERNO		=	A.DGSERNO,	DGINDT		=	A.DGINDT,
	DGINTIME	=	A.DGINTIME,	DGINUSR		=	A.DGINUSR,
	DGUPDT		=	A.DGUPDT,	DGUPTIME	=	A.DGUPTIME,
	DGUPUSR		=	A.DGUPUSR,	DGINDTP		=	A.DGINDTP,
	DGINTIMEP	=	A.DGINTIMEP,	DGINUSRP	=	A.DGINUSRP,
	DGUPDTP		=	A.DGUPDTP,	DGUPTIMEP	=	A.DGUPTIMEP,
	DGUPUSRP	=	A.DGUPUSRP,	DGEXTD		=	A.DGEXTD
from	tmislabtac	a,
	tmislabtac_log	b
where	a.empno		=	b.empno	and
	a.dgyy		=	b.dgyy	and
	a.dgmm		=	b.dgmm	and
	a.dgdd		=	b.dgdd

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End
	
-- 추가	
insert into tmislabtac_log
	    (empno,	dgyy,		dgmm,		dgdd,
	     DGDIV,	DGBUMUN,	DGDEPTE,	DGDEPTI,
	     DGEMPGB,	DGDAYGB,	DGTIMEP,	DGCD1P,
	     DGCD2P,	DGCD3P,		DGDNGBP,	DGOTP,
	     DGJOP,	DGSANGP,	DGJUHUP,	DGHUMUP,
	     DGSPCP,	DGEGB,		DGTIMER,	DGCD1R,
	     DGCD2R,	DGCD3R,		DGDNGBR,	DGOTR,
	     DGNTR,	DGJOR,		DGSANGR,	DGJUHUR,
	     DGHUMUR,	DGSPCR,		DGJIR,		DGOOR,
	     DGPOR,	DGJTR,		DGGUNBOR,	DGMUR,
	     DGCLASS,	DGKUBHO,	DGSERNO,	DGINDT,
	     DGINTIME,	DGINUSR,	DGUPDT,		DGUPTIME,
	     DGUPUSR,	DGINDTP,	DGINTIMEP,	DGINUSRP,
	     DGUPDTP,	DGUPTIMEP,	DGUPUSRP,	DGEXTD)
Select	     empno,	dgyy,		dgmm,		dgdd,
	     DGDIV,	DGBUMUN,	DGDEPTE,	DGDEPTI,
	     ' ',	DGDAYGB,	DGTIMEP,	DGCD1P,
	     DGCD2P,	DGCD3P,		DGDNGBP,	DGOTP,
	     DGJOP,	DGSANGP,	DGJUHUP,	DGHUMUP,
	     DGSPCP,	DGEGB,		DGTIMER,	DGCD1R,
	     DGCD2R,	DGCD3R,		DGDNGBR,	DGOTR,
	     DGNTR,	DGJOR,		DGSANGR,	DGJUHUR,
	     DGHUMUR,	DGSPCR,		DGJIR,		DGOOR,
	     DGPOR,	DGJTR,		DGGUNBOR,	DGMUR,
	     DGCLASS,	DGKUBHO,	DGSERNO,	DGINDT,
	     DGINTIME,	DGINUSR,	DGUPDT,		DGUPTIME,
	     DGUPUSR,	DGINDTP,	DGINTIMEP,	DGINUSRP,
	     DGUPDTP,	DGUPTIMEP,	DGUPUSRP,	DGEXTD
from tmislabtac

where empno+dgyy+dgmm+dgdd	not in
	(select empno+dgyy+dgmm+dgdd	from	tmislabtac_log)

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End
	
Update	tmislabtac
Set	dgextd	=	'Y'
From	tmislabtac	a,
	tmislabtac_log	b
where 	a.empno	=	b.empno	and
	a.dgyy	=	b.dgyy	and
	a.dgmm	=	b.dgmm	and
	a.dgdd	=	b.dgdd	

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

commit Tran
	
End		-- Procedure End
Go
