/*
	File Name	: sp_pisi_eis_tmhmonthtarget_ipis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhmonthtarget_ipis
	Description	: EIS Upload tmhmonthtarget(IPISELE Server)
			  tmhmonthtarget
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhmonthtarget_ipis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhmonthtarget_ipis]
GO

/*
Execute sp_pisi_eis_tmhmonthtarget_ipis
*/

Create Procedure sp_pisi_eis_tmhmonthtarget_ipis
	
As
Begin

-- 각 서버에서 통째로 날리고 insert 한다
select	*
into	#tmp_tmhmonthtarget
from	tmhmonthtarget
where	lastemp = 'Y'

delete	from [ipisele_svr\ipis].eis.dbo.tmhmonthtarget
where	AreaCode+DivisionCode+WorkCenter+ItemCode+subLineCode+subLineNo+tarMonth in 
	(select	AreaCode+DivisionCode+WorkCenter+ItemCode+subLineCode+subLineNo+tarMonth
	from	#tmp_tmhmonthtarget)

insert into [ipisele_svr\ipis].eis.dbo.tmhmonthtarget
select * from #tmp_tmhmonthtarget

update	tmhmonthtarget
set	lastemp = 'N'
from	tmhmonthtarget, #tmp_tmhmonthtarget
where	tmhmonthtarget.areacode = #tmp_tmhmonthtarget.areacode
and	tmhmonthtarget.divisioncode = #tmp_tmhmonthtarget.divisioncode
and	tmhmonthtarget.workcenter = #tmp_tmhmonthtarget.workcenter
and	tmhmonthtarget.itemcode = #tmp_tmhmonthtarget.itemcode
and	tmhmonthtarget.sublinecode = #tmp_tmhmonthtarget.sublinecode
and	tmhmonthtarget.sublineno = #tmp_tmhmonthtarget.sublineno
and	tmhmonthtarget.tarmonth = #tmp_tmhmonthtarget.tarmonth

Drop table #tmp_tmhmonthtarget

End		-- Procedure End
Go
