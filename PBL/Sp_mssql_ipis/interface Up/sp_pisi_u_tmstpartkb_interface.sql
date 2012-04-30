/*
	File Name	: sp_pisi_u_tmstpartkb_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tmstpartkb_interface
	Description	: Upload tmstpartkb_interface(자재간판 update) 
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

-- 대구전장

insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface)
order by lastdate asc
		
update	[ipisele_svr\ipis].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface
		where	interfaceflag = 'Y')

-- 대구기계

insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface)
order by lastdate asc

update	[ipismac_svr\ipis].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface
		where	interfaceflag = 'Y')

-- 대구공조

insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface)
order by lastdate asc

update	[ipishvac_svr\ipis].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface
		where	interfaceflag = 'Y')

-- 진천

insert into tmstpartkb_interface
	(AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp)
select	AreaCode,	DivisionCode,		ItemCode,		ApplyFrom,			
	SeqNo,		MISFlag,		InterfaceFlag,		LastEmp
from	[ipisjin_svr].ipis.dbo.tmstpartkb_interface
where	interfaceflag = 'Y'	and
	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	not in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface)
order by lastdate asc

update	[ipisjin_svr].ipis.dbo.tmstpartkb_interface
set	interfaceflag = 'N'
where	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
	in 	(select	AreaCode + DivisionCode + ItemCode + ApplyFrom + cast(SeqNo as char(1)) + MISFlag
		from	tmstpartkb_interface
		where	interfaceflag = 'Y')

End		-- Procedure End
Go
