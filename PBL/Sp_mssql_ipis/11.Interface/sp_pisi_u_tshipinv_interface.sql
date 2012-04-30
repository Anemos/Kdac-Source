-- ����,���� �����ð�
/*
	File Name	: sp_pisi_u_tshipinv_interface.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tshipinv_interface
	Description	: Upload tshipinv_interface(��ü�԰�����) 
			  tshipinv_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tshipinv_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tshipinv_interface]
GO

/*
Execute sp_pisi_u_tshipinv_interface
*/

Create Procedure sp_pisi_u_tshipinv_interface

	
As
Begin


-- �뱸����
insert into tshipinv_interface
	(MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp)	
select	MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp 
from	[ipisele_svr\ipis].ipis.dbo.tshipinv_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tshipinv_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- �뱸���
insert into tshipinv_interface
	(MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp)	
select	MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tshipinv_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tshipinv_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- �뱸����
insert into tshipinv_interface
	(MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp)	
select	MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tshipinv_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tshipinv_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- ��õ
insert into tshipinv_interface
	(MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp)	
select	MoveConfirmDate,	MoveRequireNo,		SeqNo,		MISFlag,	
	InterfaceFlag,		TruckLoadQty,		LastEmp 
from	[ipisjin_svr].ipis.dbo.tshipinv_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tshipinv_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'
 
End		-- Procedure End
Go
