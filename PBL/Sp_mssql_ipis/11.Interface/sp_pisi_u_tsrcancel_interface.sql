/*
	File Name	: sp_pisi_u_tsrcancel_interface.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tsrcancel_interface
	Description	: Upload tsrcancel_interface(��� SR Ȯ��) 
			  tsrcancel_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tsrcancel_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tsrcancel_interface]
GO

/*
Execute sp_pisi_u_tsrcancel_interface
*/

Create Procedure sp_pisi_u_tsrcancel_interface

	
As
Begin

--CancelDate, AreaCode, DivisionCode, SRNo, CancelGubun

-- �뱸����
insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipisele_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno
and	a.interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')


-- �뱸���
insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipismac_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno
and	a.interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')


-- �뱸����
insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipishvac_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno
and	a.interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')


-- ��õ
insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipisjin_svr].ipis.dbo.tsrcancel_interface a,
	[ipisjin_svr].ipis.dbo.tsrcancel b
where	a.srno = b.srno
and	a.interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

 
End		-- Procedure End
Go
