/*
	File Name	: sp_pisi_d_tsrcomment_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrcomment_movelog
	Description	: Download SR Header
			  tsrheader - pdsle305
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrcomment_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrcomment_movelog]
GO

/*
Execute sp_pisi_d_tsrcomment_movelog
*/

Create Procedure sp_pisi_d_tsrcomment_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran
	
insert
into
pdsle305_log(
	CHGDATE,	CHGCD,	SRNO,	GUBUN,
	COMMENT,	STSCD,	DOWNDATE)
select	CHGDATE,	CHGCD,	SRNO,	GUBUN,
	COMMENT,	STSCD,	DOWNDATE
from
pdsle305
where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle305_log)
order by chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

Update	pdsle305
Set	stscd	=	'Y'
From	Pdsle305	a,
	Pdsle305_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
	begin
	RollBack Tran
	Return
	End
			

Commit Tran

End		-- Procedure End
Go
