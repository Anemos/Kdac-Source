/*
	File Name	: sp_pisi_u_tstock_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tstock_interface
	Description	: Upload tstock_interface(제품입고정보)) 
			  tstock_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tstock_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tstock_interface]
GO

/*
Execute sp_pisi_u_tstock_interface
*/

Create Procedure sp_pisi_u_tstock_interface

	
As
Begin


-- 대구전장
insert into tstock_interface
	(KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp)
select	KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp 
from	[ipisele_svr\ipis].ipis.dbo.tstock_interface
where	interfaceflag = 'Y'

update	[ipisele_svr\ipis].ipis.dbo.tstock_interface
set	interfaceflag = 'N'
where	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
	in 	(select	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
		from	tstock_interface
		where	interfaceflag = 'Y')


-- 대구기계
insert into tstock_interface
	(KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp)
select	KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tstock_interface
where	interfaceflag = 'Y'

update	[ipismac_svr\ipis].ipis.dbo.tstock_interface
set	interfaceflag = 'N'
where	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
	in 	(select	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
		from	tstock_interface
		where	interfaceflag = 'Y')


-- 대구공조
insert into tstock_interface
	(KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp)
select	KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tstock_interface
where	interfaceflag = 'Y'

update	[ipishvac_svr\ipis].ipis.dbo.tstock_interface
set	interfaceflag = 'N'
where	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
	in 	(select	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
		from	tstock_interface
		where	interfaceflag = 'Y')


-- 진천
insert into tstock_interface
	(KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp)
select	KBNo,		KBReleaseDate,	KBReleaseSeq,	SeqNo,		MISFlag,
	InterfaceFlag,	StockDate,	AreaCode,	DivisionCode,	WorkCenter,
	LineCode,	ItemCode,	StockQty,	LastEmp 
from	[ipisjin_svr].ipis.dbo.tstock_interface
where	interfaceflag = 'Y'

update	[ipisjin_svr].ipis.dbo.tstock_interface
set	interfaceflag = 'N'
where	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
	in 	(select	KBNo + KBReleaseDate + cast(KBReleaseSeq as char(1)) + cast(SeqNo as char(1)) + MISFlag
		from	tstock_interface
		where	interfaceflag = 'Y')

 
End		-- Procedure End
Go
