/*
	File Name	: sp_pisi_u_tshipback_interface.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tshipback_interface
	Description	: Upload tshipback_interface(�����������) 
			  tshipback_interface
			  �������� �����߰� : 2004.04.20
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tshipback_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tshipback_interface]
GO

/*
Execute sp_pisi_u_tshipback_interface
*/

Create Procedure sp_pisi_u_tshipback_interface

	
As
Begin

-- �뱸����

insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun 
from	[ipisele_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'	and
	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface)

update	[ipisele_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface
		where	interfaceflag = 'Y')

-- �뱸���

insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp, ShipGubun)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp, ShipGubun 
from	[ipismac_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'	and
	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface)

update	[ipismac_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface
		where	interfaceflag = 'Y')


-- �뱸����

insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun 
from	[ipishvac_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'	and
	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface)

update	[ipishvac_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface
		where	interfaceflag = 'Y')

-- ��������

insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun 
from	[ipisyeo_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'	and
	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface)

update	[ipisyeo_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface
		where	interfaceflag = 'Y')

-- ��õ

insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp,	ShipGubun 
from	[ipisjin_svr].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'	and
	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface)

update	[ipisjin_svr].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CSRNO + CSRNO1 + CSRNO2 + SRNo + BillNo + InvGubunFlag + cast(SeqNo as char(1)) + MISFlag
		from	tshipback_interface
		where	interfaceflag = 'Y')
 
End		-- Procedure End

GO
