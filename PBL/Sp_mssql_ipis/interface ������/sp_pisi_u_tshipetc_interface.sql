/*
	File Name	: sp_pisi_u_tshipetc_interface.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tshipetc_interface
	Description	: Upload tshipetc_interface(�系���� �� �ݳ�����) 
			  tshipetc_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tshipetc_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tshipetc_interface]
GO

/*
Execute sp_pisi_u_tshipetc_interface
*/

Create Procedure sp_pisi_u_tshipetc_interface

	
As
Begin

-- �뱸����

insert into tshipetc_interface
	(AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp)	
select	AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp 
from	[ipisele_svr\ipis].ipis.dbo.tshipetc_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface)


update	[ipisele_svr\ipis].ipis.dbo.tshipetc_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface
		where	interfaceflag = 'Y')

-- �뱸���

insert into tshipetc_interface
	(AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp)	
select	AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tshipetc_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface)

update	[ipismac_svr\ipis].ipis.dbo.tshipetc_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface
		where	interfaceflag = 'Y')

-- �뱸����

insert into tshipetc_interface
	(AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp)	
select	AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tshipetc_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface)

update	[ipishvac_svr\ipis].ipis.dbo.tshipetc_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface
		where	interfaceflag = 'Y')

-- ��õ

insert into tshipetc_interface
	(AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp)	
select	AreaCode,	DivisionCode,	InputDate,	InputFlag,	ConfirmNo,
	SeqNo,		MisFlag,	InterfaceFlag,	DeptCode,	ProjectNo,
	ItemCode,	InvGubunFlag,	EtcQty,		Reason,		LastEmp 
from	[ipisjin_svr].ipis.dbo.tshipetc_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface)

update	[ipisjin_svr].ipis.dbo.tshipetc_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + InputDate + InputFlag + ConfirmNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipetc_interface
		where	interfaceflag = 'Y')
 
End		-- Procedure End
Go
