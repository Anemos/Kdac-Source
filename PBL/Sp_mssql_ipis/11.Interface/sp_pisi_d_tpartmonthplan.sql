/*
	File Name	: sp_pisi_d_tpartmonthplan.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tpartmonthplan
	Description	: Download Part Monthly Plan(월간자재소요계획) - 월 1회
			  tpartmonthplan
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tpartmonthplan]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tpartmonthplan]
GO

/*
Execute sp_pisi_d_tpartmonthplan
*/

Create Procedure sp_pisi_d_tpartmonthplan
	@ps_month		char(7)		-- 다음달
	
As
Begin

If Not Exists (select * from [ipisele_svr\ipis].ipis.dbo.tpartmonthplan
		where applymonth = @ps_month)

Begin

-- 대구전장
insert into [ipisele_svr\ipis].ipis.dbo.tpartmonthplan
	(ApplyMonth,
	AreaCode,		DivisionCode,		ItemCode,	
	PartForecastQty,	
	ChangeDate,		
	LastEmp)
select	eyearc+eyeary+'.'+eyearm,
	'D',		ediv,			eitno,		
	sum(emqty),			
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd,
	'SYSTEM'
from	tmispartmonthplan
where	ediv in ('A')
and	eyearc+eyeary+'.'+eyearm = @ps_month
group by eyearc+eyeary+'.'+eyearm,
	ediv,			eitno,		
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tpartmonthplan
	(ApplyMonth,
	AreaCode,		DivisionCode,		ItemCode,	
	PartForecastQty,	
	ChangeDate,		
	LastEmp)
select	eyearc+eyeary+'.'+eyearm,
	'D',		ediv,			eitno,		
	sum(emqty),			
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd,
	'SYSTEM'
from	tmispartmonthplan
where	ediv in ('M','S')
and	eyearc+eyeary+'.'+eyearm = @ps_month
group by eyearc+eyeary+'.'+eyearm,
	ediv,			eitno,		
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tpartmonthplan
	(ApplyMonth,
	AreaCode,		DivisionCode,		ItemCode,	
	PartForecastQty,	
	ChangeDate,		
	LastEmp)
select	eyearc+eyeary+'.'+eyearm,
	'D',		ediv,			eitno,		
	sum(emqty),			
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd,
	'SYSTEM'
from	tmispartmonthplan
where	ediv in ('H','V')
and	eyearc+eyeary+'.'+eyearm = @ps_month
group by eyearc+eyeary+'.'+eyearm,
	ediv,			eitno,		
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd

-- 진천
insert into [ipisjin_svr].ipis.dbo.tpartmonthplan
	(ApplyMonth,
	AreaCode,		
	DivisionCode,		
	ItemCode,	
	PartForecastQty,	
	ChangeDate,		
	LastEmp)
select	eyearc+eyeary+'.'+eyearm,
	'J',	
	case 
		when ediv = 'B' then 'M'
		when ediv = 'L' then 'S'
		when ediv = 'T' then 'H'
		else ediv
		end,	
	eitno,		
	sum(emqty),			
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd,
	'SYSTEM'
from	tmispartmonthplan
where	ediv in ('B','L','T')
and	eyearc+eyeary+'.'+eyearm = @ps_month
group by eyearc+eyeary+'.'+eyearm,
	ediv,			eitno,		
	eupdtc+eupdty+'.'+eupdtm+'.'+eupdtd

End
 
End		-- Procedure End
Go
