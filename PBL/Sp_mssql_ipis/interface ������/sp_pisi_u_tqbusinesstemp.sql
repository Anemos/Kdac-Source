/*
	File Name	: sp_pisi_u_tqbusinesstemp.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tqbusinesstemp
	Description	: Upload tqbusinesstemp(���԰˻翩�� - �ŷ���ǥ�� temp) 
			  tqbusinesstemp
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tqbusinesstemp]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tqbusinesstemp]
GO

/*
Execute sp_pisi_u_tqbusinesstemp
*/

Create Procedure sp_pisi_u_tqbusinesstemp

	
As
Begin

-- �뱸����
insert into tqbusinesstemp
	(AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			InterfaceFlag,		LastEmp)	
select	AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			'Y',			LastEmp
from	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO not in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

delete	From	[ipisele_svr\ipis].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

-- �뱸���

insert into tqbusinesstemp
	(AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			InterfaceFlag,		LastEmp)	
select	AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			'Y',			LastEmp 
from	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO not in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

delete	[ipismac_svr\ipis].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

-- �뱸����

insert into tqbusinesstemp
	(AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			InterfaceFlag,		LastEmp)	
select	AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			'Y',			LastEmp 
from	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO not in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

delete	[ipishvac_svr\ipis].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

-- ��õ

insert into tqbusinesstemp
	(AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			InterfaceFlag,		LastEmp)	
select	AREACODE,	DIVISIONCODE,		SLNO,			DELIVERYDATE,	
	SUPPLIERCODE,	ITEMCODE,		SUPPLIERDELIVERYQTY,	JUDGEFLAG,
	GOODQTY,	BADQTY,			'Y',			LastEmp
from	[ipisjin_svr].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO not in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

delete	[ipisjin_svr].ipis.dbo.tqbusinesstemp
where	JUDGEFLAG <> '9'	and
	AREACODE+DIVISIONCODE+SLNO in (select AREACODE+DIVISIONCODE+SLNO From tqbusinesstemp)

End		-- Procedure End
Go
