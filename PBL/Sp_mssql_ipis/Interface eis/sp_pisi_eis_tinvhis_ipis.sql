/*
	File Name	: sp_pisi_eis_tinvhis_ipis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tinvhis_ipis
	Description	: EIS Upload tinvhis
			  tinvhis
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tinvhis_ipis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tinvhis_ipis]
GO

/*
Execute sp_pisi_eis_tinvhis_ipis
*/

Create Procedure sp_pisi_eis_tinvhis_ipis

	
As
Begin

-- 각 서버에서 통째로 날리고 insert 한다
select	*
into	#tmp_tinvhis
from	tinvhis
where	lastemp = 'Y'

delete	from [ipisele_svr\ipis].eis.dbo.tinvhis
where	ApplyMonth + Areacode + DivisionCode + ItemCode in
	(select	ApplyMonth + Areacode + DivisionCode + ItemCode
	from	#tmp_tinvhis)

insert into [ipisele_svr\ipis].eis.dbo.tinvhis
select * from #tmp_tinvhis

update	tinvhis
set	lastemp = 'N'
from	tinvhis, #tmp_tinvhis
where	tinvhis.ApplyMonth = #tmp_tinvhis.ApplyMonth
and	tinvhis.AreaCode = #tmp_tinvhis.AreaCode
and	tinvhis.DivisionCode = #tmp_tinvhis.DivisionCode
and	tinvhis.ItemCode = #tmp_tinvhis.ItemCode

Drop table #tmp_tinvhis

End		-- Procedure End
Go
