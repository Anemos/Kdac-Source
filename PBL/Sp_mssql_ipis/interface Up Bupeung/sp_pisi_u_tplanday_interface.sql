/*
	File Name	: sp_pisi_u_tplanday_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tplanday_interface
	Description	: Upload tplanday(web van 일일부품소요계획용) 
			  tplanday_interface
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tplanday_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tplanday_interface]
GO

/*
Execute sp_pisi_u_tplanday_interface '2002.12.31'
*/

Create Procedure sp_pisi_u_tplanday_interface
	@ps_date		char(10)		-- 일자
	
As
Begin

Declare	@ls_todate		char(10)

select	@ls_todate = convert(char(10), dateadd(day, 30, @ps_date), 102)


truncate table tplanday_interface


-- 대구전장

insert into tplanday_interface
	(PlanDay,	
	AreaCode,	DivisionCode,	ItemCode,	
	PlanQty,	ChangeQty)
select	substring(plandate,1,4)+substring(plandate,6,2)+substring(plandate,9,2),	
	areacode,	divisioncode,	itemcode,
	0,		sum(changeqty)
from	[ipisele_svr\ipis].ipis.dbo.tplanday
where	plandate > @ps_date and	plandate <= @ls_todate and
  areacode = 'D' and divisioncode = 'A'
group by plandate, areacode, divisioncode, itemcode
having	sum(changeqty) > 0

-- 대구기계

insert into tplanday_interface
	(PlanDay,	
	AreaCode,	DivisionCode,	ItemCode,	
	PlanQty,	ChangeQty)
select	substring(plandate,1,4)+substring(plandate,6,2)+substring(plandate,9,2),	
	areacode,	divisioncode,	itemcode,
	0,		sum(changeqty)
from	[ipismac_svr\ipis].ipis.dbo.tplanday
where	plandate > @ps_date and	plandate <= @ls_todate  and
  areacode = 'D' and divisioncode in ('M','S')
group by plandate, areacode, divisioncode, itemcode
having	sum(changeqty) > 0

-- 대구공조

insert into tplanday_interface
	(PlanDay,	
	AreaCode,	DivisionCode,	ItemCode,	
	PlanQty,	ChangeQty)
select	substring(plandate,1,4)+substring(plandate,6,2)+substring(plandate,9,2),	
	areacode,	divisioncode,	itemcode,
	0,		sum(changeqty)
from	[ipishvac_svr\ipis].ipis.dbo.tplanday
where	plandate > @ps_date and	plandate <= @ls_todate and
  areacode = 'D' and divisioncode in ('H','V')
group by plandate, areacode, divisioncode, itemcode
having	sum(changeqty) > 0

-- 진천

insert into tplanday_interface
	(PlanDay,	
	AreaCode,	DivisionCode,	ItemCode,	
	PlanQty,	ChangeQty)
select	substring(plandate,1,4)+substring(plandate,6,2)+substring(plandate,9,2),	
	areacode,	divisioncode,	itemcode,
	0,		sum(changeqty)
from	[ipisjin_svr].ipis.dbo.tplanday
where	plandate > @ps_date and	plandate <= @ls_todate and
  areacode = 'J'
group by plandate, areacode, divisioncode, itemcode
having	sum(changeqty) > 0
 
End		-- Procedure End
Go
