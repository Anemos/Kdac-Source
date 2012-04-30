/*
	File Name	: sp_pisi_d_invtrans.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_invtrans
	Description	: Download 공무자재 trans
			  invtrans
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_invtrans]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_invtrans]
GO

/*
Execute sp_pisi_d_invtrans
*/

Create Procedure sp_pisi_d_invtrans
	
	
As
Begin

Begin Tran

Insert into invtrans(CHGDATE,	CHGCD,	SLIPTYPE,	SRNO,		SRNO1,	SRNO2,
		  XPLANT,	DIV,	ITNO,		INVSTCD,	TQTY4,	INVSTCD1,
		  SLIPGUBUN,	STSCD,	DOWNDATE)
Select	CHGDATE,	CHGCD,	SLIPTYPE,	SRNO,		SRNO1,	SRNO2,
	XPLANT,		DIV,	ITNO,		INVSTCD,	TQTY4,	INVSTCD1,
	SLIPGUBUN,	STSCD,	DOWNDATE
 from pdinv401
Where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from invtrans)
order by chgdate


if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

Update	pdinv401
Set	Stscd	=	'Y'
From	Pdinv401	a,
	invtrans	b
where 	a.chgdate = b.chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

commit Tran

--exec cmms..sp_part_trans_down

End		-- Procedure End
Go
