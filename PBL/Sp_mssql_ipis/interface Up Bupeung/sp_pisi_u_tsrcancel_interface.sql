/*
	File Name	: sp_pisi_u_tsrcancel_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tsrcancel_interface
	Description	: Upload tsrcancel_interface(취소 SR 확정) 
			  tsrcancel_interface
			  여주전자 서버추가 : 2004.04.19
			  부평물류 서버추가 : 2005.10
			  군산물류 서버추가 : 2005.10
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

-- 대구전장

insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipisele_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipisele_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

-- 대구기계

insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipismac_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipismac_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

-- 대구공조

insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipishvac_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipishvac_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

-- 부평물류
insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipisbup_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipisbup_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipisbup_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

-- 군산물류
insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipiskun_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipiskun_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipiskun_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

-- 여주전자

insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipisyeo_svr\ipis].ipis.dbo.tsrcancel_interface a,
	[ipisyeo_svr\ipis].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipisyeo_svr\ipis].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')

-- 진천

insert into tsrcancel_interface
	(CancelDate,	AreaCode,		DivisionCode,		SRNO,			
	CheckSRNo,	CancelGubun,		SeqNo,			MISFlag,
	InterfaceFlag,	ItemCode,		ConfirmFlag,		LastEmp)
select	a.CancelDate,	a.AreaCode,		a.DivisionCode,		a.SRNO,
	b.CheckSRNo,	a.CancelGubun,		a.SeqNo,		a.MISFlag,
	a.InterfaceFlag,a.ItemCode,		a.ConfirmFlag,		a.LastEmp
from	[ipisjin_svr].ipis.dbo.tsrcancel_interface a,
	[ipisjin_svr].ipis.dbo.tsrcancel b
where	a.srno = b.srno		and
	a.interfaceflag = 'Y'	and
	a.CancelDate + a.AreaCode + a.DivisionCode + a.SRNo + a.CancelGubun + cast(a.SeqNo as char(1)) + a.MISFlag
	not in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface)

update	[ipisjin_svr].ipis.dbo.tsrcancel_interface
set	interfaceflag = 'N'
where	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
	in 	(select	CancelDate + AreaCode + DivisionCode + SRNo + CancelGubun + cast(SeqNo as char(1)) + MISFlag
		from	tsrcancel_interface
		where	interfaceflag = 'Y')


End		-- Procedure End
Go
