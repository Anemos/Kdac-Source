/*
	File Name	: sp_pisi_d_pdsle401_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_pdsle401_movelog
	Description	: Download 영업납품확인
			  tshipsheet update - pdsle401
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_pdsle401_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_pdsle401_movelog]
GO

/*
Execute sp_pisi_d_pdsle401_movelog
*/

Create Procedure sp_pisi_d_pdsle401_movelog
	
	
As
Begin
set xact_abort off

begin tran

Insert	into pdsle401_log
	(CHGDATE,	CHGCD,		SADT,		XPLANT,		DIV,
	CSRNO,		SLNO,		DCQTY,		STSCD,		DOWNDATE)
Select	CHGDATE,	CHGCD,		SADT,		XPLANT,		DIV,
	CSRNO,		SLNO,		DCQTY,		STSCD,		DOWNDATE
from	pdsle401
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle401_log)
order by chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

Update	pdsle401
Set	Stscd	=	'Y'
From	Pdsle401	a,
	Pdsle401_log	b
where 	a.chgdate = b.chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

commit Tran

End		-- Procedure End
Go
