-- eis..tprdratekb_t -> 아침 9시 1번 1주일치 delete & insert
/*
	File Name	: sp_pisi_eis_tprdratekb_t.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tprdratekb_t
	Description	: EIS Upload tprdratekb
			  tprdratekb
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tprdratekb_t]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tprdratekb_t]
GO

/*
Execute sp_pisi_eis_tprdratekb_t
*/

Create Procedure sp_pisi_eis_tprdratekb_t

	
As
Begin

Declare	@ls_today		char(10),
	@ls_lastday		char(10)


select	@ls_today = convert(char(10), getdate(), 102)
select	@ls_lastday = convert(char(10), getdate() - 7, 102)

-- EIS data 삭제
Delete	tprdratekb_t
where	prddate between @ls_lastday and @ls_today

-- 대구전장
Insert	into tprdratekb_t
select	*
from	[ipisele_svr\ipis].ipis.dbo.tprdratekb
where	prddate between @ls_lastday and @ls_today
	
-- 대구기계
Insert	into tprdratekb_t
select	*
from	[ipismac_svr\ipis].ipis.dbo.tprdratekb
where	prddate between @ls_lastday and @ls_today

-- 대구공장
Insert	into tprdratekb_t
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tprdratekb
where	prddate between @ls_lastday and @ls_today

-- 진천
Insert	into tprdratekb_t
select	*
from	[ipisjin_svr].ipis.dbo.tprdratekb
where	prddate between @ls_lastday and @ls_today
 
End		-- Procedure End

GO
