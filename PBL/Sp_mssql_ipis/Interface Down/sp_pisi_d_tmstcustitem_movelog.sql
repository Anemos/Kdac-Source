/*
	File Name	: sp_pisi_d_tmstcustitem_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstcustitem_movelog
	Description	: Download Customer Item
			  tmstcustitem
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstcustitem_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstcustitem_movelog]
GO

/*
Execute sp_pisi_d_tmstcustitem_movelog
*/

Create Procedure sp_pisi_d_tmstcustitem_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran


insert
into
pdsle101_log(
	CHGDATE,	CHGCD,		CUSTCD,	CITNO,
	CITNM,		XPLANT,		DIV,		ITNO,
	STSCD,		DOWNDATE)
select	CHGDATE,	CHGCD,		CUSTCD,	CITNO,
	CITNM,		XPLANT,		DIV,		ITNO,
	STSCD,		DOWNDATE
from	pdsle101
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle101_log)
order by chgdate

if @@error <> 0
	Begin
		RollBack Tran
		Return
	End
	
Update	pdsle101
Set	stscd	=	'Y'
From	Pdsle101	a,
	pdsle101_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
	begin
		RollBack Tran
		Return
	End

commit tran

End		-- Procedure End
Go
