/*
	File Name	: sp_pisi_d_tmstworkcenter_ipis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstworkcenter_ipis
	Description	: Download workcenter master
			  tmstworkcenter - 일간단위 갱신
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use IPIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstworkcenter_ipis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstworkcenter_ipis]
GO

/*
Execute sp_pisi_d_tmstworkcenter_ipis
*/

Create Procedure sp_pisi_d_tmstworkcenter_ipis
	
	
As
Begin

-- IPIS tmstworkcenter
insert into tmstworkcenter
	(AreaCode,		DivisionCode,		WorkCenter,	WorkCenterName,
	WorkCenterGubun1, 	WorkCenterGubun2,	LastEmp)
select	areacode,		divisioncode,		deptcode,	ltrim(rtrim(deptname4)),
	'K',			
	case directgubun
		when 'I' then ''
		when 'D' then 'A'
		end,			'SYSTEM'	
from	tmstdept
where	substring(deptcode, 4, 1) <> '0'
and	areacode in (select areacode from tmstworkcenter)
and	divisioncode in (select divisioncode from tmstworkcenter)
and	deptcode not in (select workcenter from tmstworkcenter)

update	tmstworkcenter
set	workcentername = ltrim(rtrim(tmstdept.deptname4))
from	tmstworkcenter, tmstdept
where	tmstworkcenter.workcenter = tmstdept.deptcode

update	tmstworkcenter
set	workcentergubun2 = 'B'
where	workcentername like '%개선%' 
or	workcentername like '%물류%' 


-- EIS tmstworkcenter
delete	from [ipisele_svr\ipis].eis.dbo.tmstworkcenter
where	areacode in (select areacode from tmstworkcenter)
and	divisioncode in (select divisioncode from tmstworkcenter)

insert into [ipisele_svr\ipis].eis.dbo.tmstworkcenter
select	*
from	tmstworkcenter


-- EIS tmstline
delete	from [ipisele_svr\ipis].eis.dbo.tmstline
where	areacode in (select areacode from tmstline)
and	divisioncode in (select divisioncode from tmstline)

insert into [ipisele_svr\ipis].eis.dbo.tmstline
select	*
from	tmstline

End		-- Procedure End
Go
