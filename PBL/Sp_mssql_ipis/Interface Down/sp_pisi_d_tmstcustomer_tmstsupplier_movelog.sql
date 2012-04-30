/*
	File Name	: sp_pisi_d_tmstcustomer_tmstsupplier_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstcustomer_tmstsupplier_movelog
	Description	: Download Costomer/Supplier Master
			  tmstcostomer/tmstsupplier
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstcustomer_tmstsupplier_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstcustomer_tmstsupplier_movelog]
GO

/*
Execute sp_pisi_d_tmstcustomer_tmstsupplier_movelog
*/

Create Procedure sp_pisi_d_tmstcustomer_tmstsupplier_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran

insert
into	pdpur101_log(
	CHGDATE,	CHGCD,		SCGUBUN,
	VSRNO,		VNDR,		VNDNM,
	VNDNM1,		ADDR,		PRNM,
	NATN,		TELN,		FAXN,
	TLXN,		VPOST,		DIGUBUN,
	STSCD,		DOWNDATE)
select 	CHGDATE,	CHGCD,		SCGUBUN,
	VSRNO,		VNDR,		VNDNM,
	VNDNM1,		ADDR,		PRNM,
	NATN,		TELN,		FAXN,
	TLXN,		VPOST,		DIGUBUN,
	STSCD,		DOWNDATE
from	pdpur101
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdpur101_log)
order by chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End
	
Update	pdpur101
Set	Stscd	=	'Y'
From	Pdpur101	a,
	Pdpur101_log	b
where 	a.chgdate = b.chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

commit Tran

End		-- Procedure End
Go
