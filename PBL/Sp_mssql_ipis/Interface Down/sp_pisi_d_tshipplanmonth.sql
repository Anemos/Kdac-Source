/*
	File Name	: sp_pisi_d_tshipplanmonth.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tshipplanmonth
	Description	: Download Ship Plan Year/Month - 월 1회
			  EIS tshipplanyear / tshipplanmonth
			  여주전자 서버추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tshipplanmonth]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tshipplanmonth]
GO

/*
Execute sp_pisi_d_tshipplanmonth '2003.02'
*/

Create Procedure sp_pisi_d_tshipplanmonth
	@ps_month		char(7)

	
As
Begin

If Exists (Select * From mps003)
	Begin
	Return
	End
	
-- EIS database에만 넣는다

-- tshipplanmonth

Delete	From	[ipisele_svr\ipis].eis.dbo.tshipplanmonth
where planmonth = @ps_month

insert into eis..tshipplanmonth
	(PlanMonth,	AreaCode,	DivisionCode,	ItemGubun,	ItemCode,
	CustCode,	PlanInQty,	PlanInUnit,	PlanInCost,	PlanOutQty,
	PlanOutUnit,	PlanOutCost,	KITItem,		LastEmp)
select 	cyear+'.'+cmonth,	cplant,		cdvsn,		'1',		citno,
	ccust,		cqtyd01,		ccstd01,		camtd01,	cqtye01,
	ccste01,		camte01,	'1',		'SYSTEM'
from	mps003
Where	cyear+'.'+cmonth = @ps_month


-- tshipplanyear
Delete	From	[ipisele_svr\ipis].eis.dbo.tshipplanyear
where planmonth = @ps_month

insert into eis..tshipplanyear
	(PlanMonth,	
	AreaCode,	DivisionCode,	ItemCode,	CustCode,	
	PlanInQty,	PlanInUnit,	PlanInCost,	PlanOutQty,
	PlanOutUnit,	PlanOutCost,	LastEmp)
select	planmonth,	
	Areacode,	DivisionCode,	ItemCode,	CustCode,	
	PlanInQty,	PlanInUnit,	PlanInCost,	PlanOutQty,
	PlanOutUnit,	PlanOutCost,	'SYSTEM'
from	eis..tshipplanmonth
where	planmonth = @ps_month

update	eis..tshipplanyear
set	PlanInQty	= rqty0,	
	PlanInUnit	= rupc0,	
	PlanInCost	= ramt0
from	sle201, eis..tshipplanyear
where	planmonth = substring(cym,1,4)+'.'+substring(cym,5,2)
and	planmonth = @ps_month
and	areacode = xplant
and	divisioncode = div
and	itemcode = itno
and	custcode = custcd
and	suse = 'D'
and	(rqty0 > 0 and rupc0 > 0 and ramt0 > 0)


update	eis..tshipplanyear
set	PlanoutQty	= rqty0,	
	PlanoutUnit	= rupc0,	
	PlanoutCost	= ramt0
from	sle201, eis..tshipplanyear
where	planmonth = substring(cym,1,4)+'.'+substring(cym,5,2)
and	planmonth = @ps_month
and	areacode = xplant
and	divisioncode = div
and	itemcode = itno
and	custcode = custcd
and	suse = 'E'
and	(rqty0 > 0 and rupc0 > 0 and ramt0 > 0)

Truncate Table mps003

End		-- Procedure End
Go
