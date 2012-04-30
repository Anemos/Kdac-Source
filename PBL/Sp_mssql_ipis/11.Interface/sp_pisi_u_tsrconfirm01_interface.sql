/*
	File Name	: sp_pisi_u_tsrconfirm01_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tsrconfirm01_interface
	Description	: Upload tsrconfirm01_interface(자재간판 update) 
			  tsrconfirm01_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tsrconfirm01_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tsrconfirm01_interface]
GO

/*
Execute sp_pisi_u_tsrconfirm01_interface
*/

Create Procedure sp_pisi_u_tsrconfirm01_interface

	
As
Begin


-- 대구전장
insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')


-- 대구기계
insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')


-- 대구공조
insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')


-- 진천
insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipisjin_svr].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')
 
End		-- Procedure End
Go
