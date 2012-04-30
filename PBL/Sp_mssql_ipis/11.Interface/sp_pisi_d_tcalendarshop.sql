/*
	File Name	: sp_pisi_d_tcalendarshop.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tcalendarshop
	Description	: Download Shop Calendar - 월 1회
			  tcalendarshop, tpartcalendar, tcalendarwork	
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tcalendarshop]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tcalendarshop]
GO

/*
Execute sp_pisi_d_tcalendarshop
*/

Create Procedure sp_pisi_d_tcalendarshop
	@ps_month		char(7)		-- 다음달

	
As
Begin

If Not Exists (select * from [ipisele_svr\ipis].ipis.dbo.tcalendarshop
		where applymonth = @ps_month)

Begin
----------------------------------
-- tcalendarshop
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

-- EIS
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
where	gdiv in ('A','M','S','H','S')

insert into [ipisele_svr\ipis].eis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	gdiv,	b.divisioncode,		
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, [ipisele_svr\ipis].eis.dbo.tmstdivision b
where	gdiv in ('K','Y')
and	gdiv = b.areacode


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

-- 진천
insert into [ipisjin_svr].ipis.dbo.tcalendarshop
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	gdiv,	b.divisioncode,		
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, [ipisjin_svr].ipis.dbo.tmstdivision b
where	gdiv = 'J'
and	gdiv = areacode

----------------------------------
/* -- 2002.12.04 - tpartcalendar 안한다.
-- tpartcalendar
-- 대구전장
insert into [ipisele_svr\ipis].ipis.dbo.tpartcalendar
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	scdiv,		
	scdatec + scdatey + '.' + scdatem,
	scdatec + scdatey + '.' + scdatem + '.' + scdated,
	datepart(dayofyear, convert(datetime, scdatec + scdatey + '.' + scdatem + '.' + scdated)),
	scwork,		'SYSTEM'
from	tmiscalendarshop_old
where	scdiv in ('A')
and	scdatec + scdatey + '.' + scdatem = @ps_month

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tpartcalendar
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	scdiv,		
	scdatec + scdatey + '.' + scdatem,
	scdatec + scdatey + '.' + scdatem + '.' + scdated,
	datepart(dayofyear, convert(datetime, scdatec + scdatey + '.' + scdatem + '.' + scdated)),
	scwork,		'SYSTEM'
from	tmiscalendarshop_old
where	scdiv in ('M','S')
and	scdatec + scdatey + '.' + scdatem = @ps_month

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tpartcalendar
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',	scdiv,		
	scdatec + scdatey + '.' + scdatem,
	scdatec + scdatey + '.' + scdatem + '.' + scdated,
	datepart(dayofyear, convert(datetime, scdatec + scdatey + '.' + scdatem + '.' + scdated)),
	scwork,		'SYSTEM'
from	tmiscalendarshop_old
where	scdiv in ('H','V')
and	scdatec + scdatey + '.' + scdatem = @ps_month

-- 진천
insert into [ipisjin_svr].ipis.dbo.tpartcalendar
	(AreaCode,	DivisionCode,	
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'J',	
	case scdiv
		when 'B' then 'M'
		when 'L' then 'S'
		when 'T' then 'H'
		end,		
	scdatec + scdatey + '.' + scdatem,
	scdatec + scdatey + '.' + scdatem + '.' + scdated,
	datepart(dayofyear, convert(datetime, scdatec + scdatey + '.' + scdatem + '.' + scdated)),
	scwork,		'SYSTEM'
from	tmiscalendarshop_old
where	scdiv in ('B','L','T')
and	scdatec + scdatey + '.' + scdatem = @ps_month
*/

---------------------------
-- tcalendarwork
-- 대구전장
insert into [ipisele_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',		c.divisioncode,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipisele_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv = 'A'
and	a.gdiv = c.divisioncode

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',		c.divisioncode,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipismac_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv in ('M','S')
and	a.gdiv = c.divisioncode

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarwork
	(AreaCode,	DivisionCode,	WorkCenter,	LineCode,
	ApplyMonth,	
	ApplyDate,
	DayNo,		
	WorkGubun,	LastEmp)
select	'D',		c.divisioncode,		c.workcenter,	c.linecode,
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2),
	substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2),
	datepart(dayofyear, convert(datetime, substring(ghdt,1,4) + '.' + substring(ghdt,5,2) +'.'+ substring(ghdt,7,2))),
	case ghgb
		when '' then 'W'
		else 'H'
		end,
	'SYSTEM'
from	labmaa a, 
	[ipishvac_svr\ipis].ipis.dbo.tmstline c
where	a.gdiv in ('H','V')
and	a.gdiv = c.divisioncode

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
where	a.gdiv = 'J'
and	a.gdiv = c.areacode

End

End		-- Procedure End
Go
