/*
	File Name	: sp_pisi_u_tshipsheet_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tshipsheet_interface
	Description	: Upload tshipsheet_interface(출하정보) 
			  tshipsheet_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tshipsheet_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tshipsheet_interface]
GO

/*
Execute sp_pisi_u_tshipsheet_interface
*/

Create Procedure sp_pisi_u_tshipsheet_interface

	
As
Begin


-- 대구전장
insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipisele_svr\ipis].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 대구기계
insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 대구공조
insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'

-- 진천
insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipisjin_svr].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	interfaceflag = 'Y'
 
End		-- Procedure End
Go
