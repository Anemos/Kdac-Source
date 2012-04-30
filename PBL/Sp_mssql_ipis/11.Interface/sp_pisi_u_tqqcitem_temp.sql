/*
	File Name	: sp_pisi_u_tqqcitem_temp.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tqqcitem_temp
	Description	: Upload Tqqcitem_temp(���԰˻� ���˻�ǰ) 
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

-- �뱸����
insert into tqqcitem_temp
	(AreaCode,		DivisionCode, 		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		UploadFlag,	LastEmp)
select	areacode,		divisioncode,		ItemCode,	SupplierCode,
	ProductGroup,		ModelGroup,		ApplyDateFrom,	ApplyDateTo,
	RecStatus,		QCGubun,		'N',		LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tqqcitem_temp

/* -- ��������
update	[ipisele_svr\ipis].ipis.dbo.tqqcitem_temp
set	recstatus = 'Y'
where	recstatus <> 'Y'
*/

delete	from [ipisele_svr\ipis].ipis.dbo.tqqcitem_temp

-- �뱸���
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

-- �뱸����
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

-- ��õ
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
