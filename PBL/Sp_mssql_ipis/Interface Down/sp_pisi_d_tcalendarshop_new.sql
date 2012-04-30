/*
	File Name	: sp_pisi_d_tcalendarshop_new.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tcalendarshop_new
	Description	: Download Shop Calendar - 월 1회 -> 20일 부터 말일까지 매일 1회
			  tcalendarshop, tpartcalendar, tcalendarwork
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tcalendarshop_new]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tcalendarshop_new]
GO

/*
Execute sp_pisi_d_tcalendarshop_new '2003.03'
*/

Create Procedure sp_pisi_d_tcalendarshop_new
	@ps_month		char(7)		-- 다음달

	
As
Begin

If Not Exists (Select * From labmaa)
	Begin
	Return
	End
	

-- 있으면 날리고 새로 넣는다...

delete	from [ipisele_svr\ipis].ipis.dbo.tcalendarshop
where applymonth = @ps_month

delete	from [ipisele_svr\ipis].ipis.dbo.tcalendarwork
where applymonth = @ps_month

delete	from [ipisele_svr\ipis].eis.dbo.tcalendarshop
where applymonth = @ps_month

delete	from [ipismac_svr\ipis].ipis.dbo.tcalendarshop
where applymonth = @ps_month

delete	from [ipismac_svr\ipis].ipis.dbo.tcalendarwork
where applymonth = @ps_month

delete	from [ipishvac_svr\ipis].ipis.dbo.tcalendarshop
where applymonth = @ps_month

delete	from [ipishvac_svr\ipis].ipis.dbo.tcalendarwork
where applymonth = @ps_month

delete	from [ipisyeo_svr\ipis].ipis.dbo.tcalendarshop
where applymonth = @ps_month

delete	from [ipisyeo_svr\ipis].ipis.dbo.tcalendarwork
where applymonth = @ps_month

delete	from [ipisjin_svr].ipis.dbo.tcalendarshop
where applymonth = @ps_month

delete	from [ipisjin_svr].ipis.dbo.tcalendarwork
where applymonth = @ps_month

------------ tcalendarshop
-- 대구전장
insert into [ipisele_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	gdiv,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('A')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	gdiv,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('A')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	gdiv,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('M','S')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	gdiv,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('M','S')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	gdiv,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('H','V')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	gdiv,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('H','V')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 군산조향
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'K',	'S',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('K')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'K',	'S',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('K')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 군산제동
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'K',	'M',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('K')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'K',	'M',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('K')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 군산공조
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'K',	'H',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('K')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'K',	'H',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('K')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 여주
insert into [ipisyeo_svr\ipis].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'Y',	'Y',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('Y')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'Y',	'Y',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('Y')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 진천조향
insert into [ipisjin_svr].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	'S',		
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('J')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	'S',		
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('J')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 진천제동
insert into [ipisjin_svr].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	'M',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('J')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	'M',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('J')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 진천공조
insert into [ipisjin_svr].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	'H',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('J')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	'H',
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa
where	gdiv in ('J')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month


------------ tcalendarwork
-- 대구전장
insert into [ipisele_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',		gdiv,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipisele_svr\ipis].ipis.dbo.tmstdivision b, 
	[ipisele_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv = b.divisioncode
and	b.divisioncode = c.divisioncode
and	b.areacode = 'D'
and	b.divisioncode in ('A')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',		gdiv,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipismac_svr\ipis].ipis.dbo.tmstdivision b, 
	[ipismac_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv = b.divisioncode
and	b.divisioncode = c.divisioncode
and	b.areacode = 'D'
and	b.divisioncode in ('M','S')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',		gdiv,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipishvac_svr\ipis].ipis.dbo.tmstdivision b, 
	[ipishvac_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv = b.divisioncode
and	b.divisioncode = c.divisioncode
and	b.areacode = 'D'
and	b.divisioncode in ('H','V')
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

-- 진천
insert into [ipisjin_svr].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	gdiv,		c.divisioncode,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipisjin_svr].ipis.dbo.tmstline c
where	a.gdiv = c.areacode

-- 여주
insert into [ipisyeo_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'Y',		gdiv,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipisyeo_svr\ipis].ipis.dbo.tmstdivision b, 
	[ipisyeo_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv = b.divisioncode
and	b.divisioncode = c.divisioncode
and	b.areacode = 'Y'
and	b.divisioncode = 'Y'
and	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) = @ps_month

Truncate Table labmaa

End		-- Procedure End
Go
