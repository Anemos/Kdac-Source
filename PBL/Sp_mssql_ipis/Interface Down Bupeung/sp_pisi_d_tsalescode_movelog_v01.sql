/*
	File Name	: sp_pisi_d_tsalescode_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsalescode_movelog
	Description	: Download SR salescode move log
			  tsrheader - pdsle307
			  여주전자 서버추가 : 2004.04.19
			  부평물류 서버추가 : 2005.08
			  군산물류 서버추가 : 2005.10
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsalescode_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsalescode_movelog]
GO

/*
Execute sp_pisi_d_tsalescode_movelog
*/

Create Procedure sp_pisi_d_tsalescode_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran
	
insert
into
pdsle307_log(
	CHGDATE,	CHGCD,	COGUBUN,	COCODE,
	DESC1,		DESC2,	DESC3,		DESC4,
	EXTD,		STSCD,	DOWNDATE,   DESC5)
select	CHGDATE,	CHGCD,	COGUBUN,	COCODE,
	DESC1,		DESC2,	DESC3,		DESC4,
	EXTD,		'N',	'',  DESC5
from	pdsle307
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle307_log)
order by chgdate

if @@error <> 0
	begin
		RollBack Tran
		Return
	End

Update	pdsle307
Set	stscd	=	'Y'
From	Pdsle307	a,
	pdsle307_log	b
Where	a.chgdate	=	b.chgdate
if @@error <> 0
	begin
		RollBack Tran
		Return
	End

commit tran

End		-- Procedure End
Go
