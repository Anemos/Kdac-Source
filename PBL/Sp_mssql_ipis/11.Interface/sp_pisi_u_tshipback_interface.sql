/*
	File Name	: sp_pisi_u_tshipback_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tshipback_interface
	Description	: Upload tshipback_interface(출하취소정보) 
			  tshipback_interface
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


-- 대구전장
insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp 
from	[ipisele_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 대구기계
insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 대구공조
insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 진천
insert into tshipback_interface
	(CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp)	
select	CSRNO,		CSRNO1,		CSRNO2,		SRNo,			BillNo,		
	InvGubunFlag,	SeqNo,		MisFlag,	InterfaceFlag,		CancelConfirmDate,
	CancelQty,	LastEmp 
from	[ipisjin_svr].ipis.dbo.tshipback_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tshipback_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'
 
End		-- Procedure End
Go
