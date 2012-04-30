/*
	File Name	: sp_pisi_u_tqqcitem_temp.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tqqcitem_temp
	Description	: Upload Tqqcitem_temp(수입검사 무검사품) 
			  tqqcitem_temp
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
order by lastdate asc

/* -- 삭제하자
update	[ipisele_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipisele_svr\ipis].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

-- 대구기계
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipismac_svr\ipis].ipis.dbo.tqqcitem_temp
order by lastdate asc

/*
update	[ipismac_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipismac_svr\ipis].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

-- 대구공조
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipishvac_svr\ipis].ipis.dbo.tqqcitem_temp
order by lastdate asc

/*
update	[ipishvac_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipishvac_svr\ipis].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

-- 부평물류
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipisbup_svr\ipis].ipis.dbo.tqqcitem_temp
order by lastdate asc

/*
update	[ipisbup_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipisbup_svr\ipis].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

-- 군산물류
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipiskun_svr\ipis].ipis.dbo.tqqcitem_temp
order by lastdate asc

/*
update	[ipiskun_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipiskun_svr\ipis].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

-- 여주전자
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipisyeo_svr\ipis].ipis.dbo.tqqcitem_temp
order by lastdate asc

/*
update	[ipisyeo_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipisyeo_svr\ipis].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

-- 진천
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipisjin_svr].ipis.dbo.tqqcitem_temp
order by lastdate asc

/*
update	[ipisjin_svr].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipisjin_svr].ipis.dbo.tqqcitem_temp
where areacode + divisioncode + itemcode + suppliercode in (
  select areacode + divisioncode + itemcode + suppliercode from tqqcitem_temp
  where uploadflag = 'N' )

End		-- Procedure End
Go
