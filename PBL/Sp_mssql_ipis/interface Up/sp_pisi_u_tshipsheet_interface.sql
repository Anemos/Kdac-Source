/*
	File Name	: sp_pisi_u_tshipsheet_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tshipsheet_interface
	Description	: Upload tshipsheet_interface(출하정보) 
			  tshipsheet_interface
			  여주전자 서버추가 : 2004.04.20
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
where	interfaceflag = 'Y'	and
	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface)

update	[ipisele_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface
		where	interfaceflag = 'Y')

-- 대구기계

insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'	and
	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface)

update	[ipismac_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface
		where	interfaceflag = 'Y')

-- 대구공조

insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'	and
	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface)

update	[ipishvac_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface
		where	interfaceflag = 'Y')

-- 여주전자

insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipisyeo_svr\ipis].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'	and
	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface)

update	[ipisyeo_svr\ipis].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface
		where	interfaceflag = 'Y')

-- 진천

insert into tshipsheet_interface
	(ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp)	
select	ShipDate,	AreaCode,	DivisionCode,	SRNo,		SeqNo,
	MISFlag,	InterfaceFlag,	ShipSheetNo,	KitGubun,	ShipQty,	LastEmp 
from	[ipisjin_svr].ipis.dbo.tshipsheet_interface
where	interfaceflag = 'Y'	and
	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface)

update	[ipisjin_svr].ipis.dbo.tshipsheet_interface
set	interfaceflag = 'N'
where	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
	in 	(select	ShipDate + AreaCode + DivisionCode + SRNo + ShipSheetNo + cast(SeqNo as char(1)) + MISFlag
		from	tshipsheet_interface
		where	interfaceflag = 'Y')
End		-- Procedure End
Go
