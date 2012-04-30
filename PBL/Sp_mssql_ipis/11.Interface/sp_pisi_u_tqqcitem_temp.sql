/*
	File Name	: sp_pisi_u_tqqcitem_temp.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tqqcitem_temp
	Description	: Upload Tqqcitem_temp(수입검사 무검사품) 
			  tqqcitem_temp
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tqqcitem_temp]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tqqcitem_temp]
GO

/*
Execute sp_pisi_u_tqqcitem_temp
*/

Create Procedure sp_pisi_u_tqqcitem_temp

	
As
Begin

-- 대구전장
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tqqcitem_temp

/* -- 삭제하자
update	[ipisele_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipisele_svr\ipis].ipis.dbo.tqqcitem_temp

-- 대구기계
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tqqcitem_temp

/*
update	[ipismac_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete from [ipismac_svr\ipis].ipis.dbo.tqqcitem_temp

-- 대구공조
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tqqcitem_temp

/*
update	[ipishvac_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete from [ipishvac_svr\ipis].ipis.dbo.tqqcitem_temp

-- 진천
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipisjin_svr].ipis.dbo.tqqcitem_temp

/*
update	[ipisjin_svr].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete from [ipisjin_svr].ipis.dbo.tqqcitem_temp
 
End		-- Procedure End
Go
