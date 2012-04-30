-- 수정할것
/*
	File Name	: sp_pisi_d_tplanmonth.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tplanmonth
	Description	: Download Monthly Plan(월간생산계획) - 월 1회
			  tplanmonth	
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tplanmonth]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tplanmonth]
GO

/*
Execute sp_pisi_d_tplanmonth '2002.12'
*/

Create Procedure sp_pisi_d_tplanmonth
	@ps_month		char(7)		-- 다음달
	
As
Begin

If Not Exists (select * from [ipisele_svr\ipis].ipis.dbo.tcalendarshop
		where applymonth = @ps_month)

-- 월말 1회 download: 수정계획 = 계획
-- 월초 1일 1회 download : 수정계획만 update

Begin

-- 대구전장
-- 새 버전임
insert into [ipisele_svr\ipis].ipis.dbo.tplanmonth
	(PlanMonth,
	AreaCode,		DivisionCode,		ItemCode,		ChangeQty,
	ChangeQtyInM,		ChangeQtyOutM,		PlanQty,		PlanQtyInM,
	PlanQtyOutM,		PlanQtyM1,		PlanQtyInM1,		PlanQtyOutM1,
	PlanQtyM2,		PlanQtyInM2,		PlanQtyOutM2,		PlanQtyM3,
	PlanQtyInM3,		PlanQtyOutM3,		PlanQtyM4,		PlanQtyInM4,
	PlanQtyOutM4,		PlanQtyM5,		PlanQtyInM5,		PlanQtyOutM5,
	InvQtyBefore,		InvQtyAfter,		LastEmp)
select	dyear +'.'+ dmonth,
	dplant,			ddvsn,			ditno,			dplnq01,
	ddplnq01,		deplnq01,		dplnq01,			ddplnq01,
	deplnq01,		dplnq02,			ddplnq02,		deplnq03,
	dplnq03,			ddplnq03,		deplnq03,		dplnq04,
	ddplnq04,		deplnq04,		dplnq05,			ddplnq05,
	deplnq05,		dplnq06,			ddplnq06,		deplnq06,
	0,			0,			'SYSTEM'
from	mps004
where	dplant in ('D')
and	ddvsn in ('A')

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tplanmonth
	(PlanMonth,
	AreaCode,		DivisionCode,		ItemCode,		ChangeQty,
	ChangeQtyInM,		ChangeQtyOutM,		PlanQty,		PlanQtyInM,
	PlanQtyOutM,		PlanQtyM1,		PlanQtyInM1,		PlanQtyOutM1,
	PlanQtyM2,		PlanQtyInM2,		PlanQtyOutM2,		PlanQtyM3,
	PlanQtyInM3,		PlanQtyOutM3,		PlanQtyM4,		PlanQtyInM4,
	PlanQtyOutM4,		PlanQtyM5,		PlanQtyInM5,		PlanQtyOutM5,
	InvQtyBefore,		InvQtyAfter,		LastEmp)
select	dyear +'.'+ dmonth,
	dplant,			ddvsn,			ditno,			dplnq01,
	ddplnq01,		deplnq01,		dplnq01,			ddplnq01,
	deplnq01,		dplnq02,			ddplnq02,		deplnq03,
	dplnq03,			ddplnq03,		deplnq03,		dplnq04,
	ddplnq04,		deplnq04,		dplnq05,			ddplnq05,
	deplnq05,		dplnq06,			ddplnq06,		deplnq06,
	0,			0,			'SYSTEM'
from	mps004
where	dplant in ('D')
and	ddvsn in ('M','S')

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tplanmonth
	(PlanMonth,
	AreaCode,		DivisionCode,		ItemCode,		ChangeQty,
	ChangeQtyInM,		ChangeQtyOutM,		PlanQty,		PlanQtyInM,
	PlanQtyOutM,		PlanQtyM1,		PlanQtyInM1,		PlanQtyOutM1,
	PlanQtyM2,		PlanQtyInM2,		PlanQtyOutM2,		PlanQtyM3,
	PlanQtyInM3,		PlanQtyOutM3,		PlanQtyM4,		PlanQtyInM4,
	PlanQtyOutM4,		PlanQtyM5,		PlanQtyInM5,		PlanQtyOutM5,
	InvQtyBefore,		InvQtyAfter,		LastEmp)
select	dyear +'.'+ dmonth,
	dplant,			ddvsn,			ditno,			dplnq01,
	ddplnq01,		deplnq01,		dplnq01,			ddplnq01,
	deplnq01,		dplnq02,			ddplnq02,		deplnq03,
	dplnq03,			ddplnq03,		deplnq03,		dplnq04,
	ddplnq04,		deplnq04,		dplnq05,			ddplnq05,
	deplnq05,		dplnq06,			ddplnq06,		deplnq06,
	0,			0,			'SYSTEM'
from	mps004
where	(dplant in ('D') and	ddvsn in ('H','V')) or (dplant in ('K') and ddvsn in ('S','M','H'))

-- 진천
insert into [ipisjin_svr].ipis.dbo.tplanmonth
	(PlanMonth,
	AreaCode,		DivisionCode,		ItemCode,		ChangeQty,
	ChangeQtyInM,		ChangeQtyOutM,		PlanQty,		PlanQtyInM,
	PlanQtyOutM,		PlanQtyM1,		PlanQtyInM1,		PlanQtyOutM1,
	PlanQtyM2,		PlanQtyInM2,		PlanQtyOutM2,		PlanQtyM3,
	PlanQtyInM3,		PlanQtyOutM3,		PlanQtyM4,		PlanQtyInM4,
	PlanQtyOutM4,		PlanQtyM5,		PlanQtyInM5,		PlanQtyOutM5,
	InvQtyBefore,		InvQtyAfter,		LastEmp)
select	dyear +'.'+ dmonth,
	dplant,			ddvsn,			ditno,			dplnq01,
	ddplnq01,		deplnq01,		dplnq01,			ddplnq01,
	deplnq01,		dplnq02,			ddplnq02,		deplnq03,
	dplnq03,			ddplnq03,		deplnq03,		dplnq04,
	ddplnq04,		deplnq04,		dplnq05,			ddplnq05,
	deplnq05,		dplnq06,			ddplnq06,		deplnq06,
	0,			0,			'SYSTEM'
from	mps004
where	dplant in ('J')

End
/*
Else	
-- 있으면 ------------> 수정할것
-- 월초 1일 1회 download : 수정계획만 update(changeqty ?)

Begin
-- 대구전장
update	[ipisele_svr\ipis].ipis.dbo.tplanmonth
set	ChangeQty = tmisplanmonth.cpplnm1, 
	ChangeQtyInM = tmisplanmonth.cinplnm1,
	ChangeQtyOutM = tmisplanmonth.cexplnm1
from	[ipisele_svr\ipis].ipis.dbo.tplanmonth, tmisplanmonth	
where	planmonth = @ps_month	
and	areacode = 'D'
and	divisioncode = tmisplanmonth.cdvsn
and	itemcode = tmisplanmonth.citnm

-- 대구기계
update	[ipismac_svr\ipis].ipis.dbo.tplanmonth
set	ChangeQty = tmisplanmonth.cpplnm1, 
	ChangeQtyInM = tmisplanmonth.cinplnm1,
	ChangeQtyOutM = tmisplanmonth.cexplnm1
from	[ipismac_svr\ipis].ipis.dbo.tplanmonth, tmisplanmonth	
where	planmonth = @ps_month	
and	areacode = 'D'
and	divisioncode = tmisplanmonth.cdvsn
and	itemcode = tmisplanmonth.citnm

-- 대구공조
update	[ipishvac_svr\ipis].ipis.dbo.tplanmonth
set	ChangeQty = tmisplanmonth.cpplnm1, 
	ChangeQtyInM = tmisplanmonth.cinplnm1,
	ChangeQtyOutM = tmisplanmonth.cexplnm1
from	[ipishvac_svr\ipis].ipis.dbo.tplanmonth, tmisplanmonth	
where	planmonth = @ps_month	
and	areacode = 'D'
and	divisioncode = tmisplanmonth.cdvsn
and	itemcode = tmisplanmonth.citnm

-- 진천
update	[ipisjin_svr].ipis.dbo.tplanmonth
set	ChangeQty = tmisplanmonth.cpplnm1, 
	ChangeQtyInM = tmisplanmonth.cinplnm1,
	ChangeQtyOutM = tmisplanmonth.cexplnm1
from	[ipisjin_svr].ipis.dbo.tplanmonth, tmisplanmonth	
where	planmonth = @ps_month	
and	areacode = 'J'
and	((divisioncode = 'B' and tmisplanmonth.cdvsn = 'M') or
	 (divisioncode = 'L' and tmisplanmonth.cdvsn = 'S') or
	 (divisioncode = 'T' and tmisplanmonth.cdvsn = 'M'))
and	itemcode = tmisplanmonth.citnm

End
*/ 
End		-- Procedure End
Go
