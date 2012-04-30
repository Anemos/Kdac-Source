/*
	File Name	: sp_pisi_u_tmstpartkb_interface.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tmstpartkb_interface
	Description	: Upload tmstpartkb_interface(���簣�� update) 
			  tmstpartkb_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tmstpartkb_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tmstpartkb_interface]
GO

/*
Execute sp_pisi_u_tmstpartkb_interface
*/

Create Procedure sp_pisi_u_tmstpartkb_interface

	
As
Begin

------------- ���� �߻��� ó��

-- �뱸����
insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- �뱸���
insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- �뱸����
insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- ��õ
insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipisjin_svr].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'
 
End		-- Procedure End
Go