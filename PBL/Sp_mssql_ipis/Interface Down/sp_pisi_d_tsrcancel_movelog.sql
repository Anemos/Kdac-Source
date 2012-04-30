/*
	File Name	: sp_pisi_d_tsrcancel_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrcancel_movelog
	Description	: Download SR Cancel
			  tsrcancel - pdsle304
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
	
	
	HISTORY적용
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrcancel_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrcancel_movelog]
GO

/*
Execute sp_pisi_d_tsrcancel_movelog
*/

Create Procedure sp_pisi_d_tsrcancel_movelog
	
	
As
Begin

SET XACT_ABORT OFF

begin tran

insert
into	pdsle304_log(
	CHGDATE,	CHGCD,	CSRNO,	XPLANT,
	DIV,		STYPE,	SRNO,	CITNO,
	SUSE,		ORDNO,	PDCD,	ITNO,
	SRQTY,		SAQTY,	CAQTY,	SRDT,
	KITCD,		PSRNO,	STSCD,	DOWNDATE)
select  CHGDATE,	CHGCD,	CSRNO,	XPLANT,
	DIV,		STYPE,	SRNO,	CITNO,
	SUSE,		ORDNO,	PDCD,	ITNO,
	SRQTY,		SAQTY,	CAQTY,	SRDT,
	KITCD,		PSRNO,	STSCD,	DOWNDATE
from	pdsle304 
where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle304_log)
order by chgdate

if @@error <> 0
   Begin
   RollBack Tran
   Return
   End

update pdsle304
Set	stscd	=	'Y'
From	Pdsle304	a,
	pdsle304_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
   Begin
   RollBack Tran
   Return
   End

commit tran
   
End		-- Procedure End
Go