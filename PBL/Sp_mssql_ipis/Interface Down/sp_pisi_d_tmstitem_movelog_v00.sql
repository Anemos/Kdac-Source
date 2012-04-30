/*
	File Name	: sp_pisi_d_tmstitem_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstitem_movelog
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstitem_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstitem_movelog]
GO

/*
Execute sp_pisi_d_tmstitem_movelog
*/

Create Procedure sp_pisi_d_tmstitem_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran

insert into pdinv002_log
select * from pdinv002
where	len(rtrim(itno)) > 0	and
	stscd = 'N'		and
	chgdate	not in	(select chgdate	from pdinv002_log)
order by chgdate

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End
	
Update	pdinv002
Set	stscd	=	'Y'
From	Pdinv002	a,
	Pdinv002_log	b
where 	a.chgdate = b.chgdate	

if @@error <> 0
	Begin
	RollBack Tran
	Return
	End

Commit Tran

End		-- Procedure End
Go
