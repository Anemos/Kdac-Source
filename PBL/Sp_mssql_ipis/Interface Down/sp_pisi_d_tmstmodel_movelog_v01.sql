/*
	File Name	: sp_pisi_d_tmstmodel_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstmodel_movelog
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstmodel_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstmodel_movelog]
GO

/*
Execute sp_pisi_d_tmstmodel_movelog
*/

Create Procedure sp_pisi_d_tmstmodel_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran

insert
into	pdinv101_log(
	CHGDATE,	CHGCD,		XPLANT,
	DIV,		PDCD,		ITNO,
	CLS,		SRCE,		XUNIT,
	CONVQTY,	SAUD,		ABCCD,
	WLOC,		XPLAN,		STSCD,
	DOWNDATE)
select 	CHGDATE,	CHGCD,		XPLANT,
	DIV,		PDCD,		ITNO,
	CLS,		SRCE,		XUNIT,
	CONVQTY,	SAUD,		ABCCD,
	WLOC,		XPLAN,		STSCD,
	DOWNDATE
from	pdinv101
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdinv101_log)
order by chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

insert into invmaster
select *
from	pdinv101
where	cls in ('23','43')	and
	stscd = 'N'

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End
	
Update	pdinv101
Set	Stscd	=	'Y'
From	Pdinv101	a,
	Pdinv101_log	b
where 	a.chgdate = b.chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

commit Tran

End		-- Procedure End
Go
