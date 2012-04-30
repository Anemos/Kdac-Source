/*
	File Name	: sp_pisi_d_tcalendarshop.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tcalendarshop
	Description	: Download Shop Calendar - �� 1ȸ
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
	@ps_month		char(7)		-- ������

	
As
Begin

If Not Exists (select * from [ipisele_svr\ipis].ipis.dbo.tcalendarshop
		where applymonth = @ps_month)

Begin

------------ tcalendarshop
-- �뱸����
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

-- �뱸���
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

-- �뱸����
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

-- ��������
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

-- ��������
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

-- �������
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

-- ����
insert into [ipishvac_svr\ipis].ipis.dbo.tcalendarshop
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

-- ��õ����
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

-- ��õ����
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

-- ��õ����
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
-- �뱸����
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

-- �뱸���
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

-- �뱸����
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

-- ��õ
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

End

End		-- Procedure End
Go