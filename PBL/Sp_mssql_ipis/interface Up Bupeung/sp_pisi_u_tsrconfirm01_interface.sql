/*
	File Name	: sp_pisi_u_tsrconfirm01_interface.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tsrconfirm01_interface
	Description	: Upload tsrconfirm01_interface(���簣�� update) 
			  tsrconfirm01_interface
			  �������� �����߰� : 2004.04.19
			  ���򹰷� �����߰� : 2005.10
			  ���깰�� �����߰� : 2005.10
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
-- �뱸����

insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipisele_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')


-- �뱸���

insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipismac_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')


-- �뱸����

insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipishvac_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')

-- ���򹰷�
insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipisbup_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipisbup_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')

-- ���깰��
insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipiskun_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipiskun_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')

-- ��������

insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipisyeo_svr\ipis].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipisyeo_svr\ipis].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')

-- ��õ

insert into tsrconfirm01_interface
	(ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp)
select	ConfirmDate,	SRNO,		SeqNo,			MISFlag,
	InterfaceFlag,	AreaCode,	DivisionCode,		LastEmp
from	[ipisjin_svr].ipis.dbo.tsrconfirm01_interface
where	interfaceflag = 'Y'	and
	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface)

update	[ipisjin_svr].ipis.dbo.tsrconfirm01_interface
set	interfaceflag = 'N'
where	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ConfirmDate + SRNo + cast(SeqNo as char(1)) + MISFlag
		from	tsrconfirm01_interface
		where	interfaceflag = 'Y')

End		-- Procedure End
Go
