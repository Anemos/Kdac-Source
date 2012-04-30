/*
	File Name	: sp_pisi_d_tmstsupplier_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstsupplier_movelog
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstsupplier_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstsupplier_movelog]
GO

/*
Execute sp_pisi_d_tmstsupplier_movelog
*/

Create Procedure sp_pisi_d_tmstsupplier_movelog
	
	
As
Begin

SET Xact_Abort Off

Begin Tran

insert
into
pdpur102_log(
	CHGDATE,	CHGCD,	VSRNO,		INSIDE,
	KBCD,		VANCD,	JSCD,		XSTOP, STSCD,
	DOWNDATE)
select	CHGDATE,	CHGCD,	VSRNO,		INSIDE,
	KBCD,		VANCD,	JSCD,		XSTOP, STSCD,
	DOWNDATE
from	pdpur102
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdpur102_log)
order by chgdate

if @@error <> 0
	begin
		RollBack Tran
		Return
	End

update	pdpur102
set	stscd	=	'Y'
From	Pdpur102	a,
	pdpur102_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
	begin
		RollBack Tran
		Return
	End

commit tran

End		-- Procedure End
Go
