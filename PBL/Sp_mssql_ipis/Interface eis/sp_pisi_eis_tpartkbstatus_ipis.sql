/*
	File Name	: sp_pisi_eis_tpartkbstatus_ipis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartkbstatus_ipis
	Description	: EIS Upload tpartkbstatus(IPISELE Server)
			  tpartkbstatus
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartkbstatus_ipis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartkbstatus_ipis]
GO

/*
Execute sp_pisi_eis_tpartkbstatus_ipis
*/

Create Procedure sp_pisi_eis_tpartkbstatus_ipis
	
As
Begin

-- 각 서버에서 통째로 날리고 insert 한다
select	*
into	#tmp_tpartkbstatus
from	tpartkbstatus
where	lastemp = 'Y'

delete	from [ipisele_svr\ipis].eis.dbo.tpartkbstatus
where	partkbno in (select	partkbno
			from	#tmp_tpartkbstatus)

insert into [ipisele_svr\ipis].eis.dbo.tpartkbstatus
select * from #tmp_tpartkbstatus

update	tpartkbstatus
set	lastemp = 'N'
from	tpartkbstatus, #tmp_tpartkbstatus
where	tpartkbstatus.partkbno = #tmp_tpartkbstatus.partkbno

Drop table #tmp_tpartkbstatus

End		-- Procedure End
Go
