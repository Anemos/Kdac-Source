/*
	File Name	: sp_pisi_d_tshipback_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tshipback_movelog
	Description	: Download Item
			  tmstitem
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tshipback_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tshipback_movelog]
GO

/*
Execute sp_pisi_d_tshipback_movelog
*/

Create Procedure sp_pisi_d_tshipback_movelog
	
	
As
Begin

SET XACT_ABORT OFF

begin Tran

insert
into pdsle501_log(
	CHGDATE,	CHGCD,	CSRNO,	CSRNO1,		CSRNO2,
	DTYPE,		CITNO,	ITNO,	SCUSTCD,	SRNO,
	XPLANT,		DIV,	STYPE,	CNLCD,		INVOICE,
	DCQTY,		SCQTY,	RCQTY,	SLNO,		STSCD,
	DOWNDATE)
select	CHGDATE,	CHGCD,	CSRNO,	CSRNO1,		CSRNO2,
	DTYPE,		CITNO,	ITNO,	SCUSTCD,	SRNO,
	XPLANT,		DIV,	STYPE,	CNLCD,		INVOICE,
	DCQTY,		SCQTY,	RCQTY,	SLNO,		'N',
	''
from pdsle501
where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle501_log)
order by chgdate

if @@error <> 0
   Begin
	RollBack Tran
	Return
   End

update pdsle501
Set	stscd	=	'Y'
From	Pdsle501	a,
	pdsle501_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
   Begin
	RollBack Tran
	Return
   End

commit tran

End		-- Procedure End
Go
