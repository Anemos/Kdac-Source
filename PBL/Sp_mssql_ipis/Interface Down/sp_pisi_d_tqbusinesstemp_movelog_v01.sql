/*
	File Name	: sp_pisi_d_tqbusinesstemp_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tqbusinesstemp_movelog
	Description	: Download 납품현황
			  tqbusinesstemp
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.11.15
	Author		: kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tqbusinesstemp_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tqbusinesstemp_movelog]
GO

/*
Execute sp_pisi_d_tqbusinesstemp_movelog
*/

Create Procedure sp_pisi_d_tqbusinesstemp_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran

insert
into	pdinv201_log(
	CHGDATE,	CHGCD,		XPLANT,
	DIV,		SLNO,		DCKDT,
	VNDR,		ITNO,   QCCD,     DCKQT,
	DCAMT,  BLNO,   FOBAMT,
	STSCD,  DOWNDATE )
select 	CHGDATE,	CHGCD,		XPLANT,
	DIV,		SLNO,		DCKDT,
	VNDR,		ITNO,   QCCD,     DCKQT,
	DCAMT,  BLNO,   FOBAMT,
	STSCD,  DOWNDATE
from	pdinv201
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdinv201_log)
order by chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End
	
Update	pdinv201
Set	Stscd	=	'Y'
From	Pdinv201	a,
	Pdinv201_log	b
where 	a.chgdate = b.chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End


commit Tran

End		-- Procedure End
Go
