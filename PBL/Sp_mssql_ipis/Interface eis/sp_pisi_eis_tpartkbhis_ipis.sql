/*
	File Name	: sp_pisi_eis_tpartkbhis_ipis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartkbhis_ipis
	Description	: EIS Upload tpartkbhis
			  tpartkbhis
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartkbhis_ipis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartkbhis_ipis]
GO

/*
Execute sp_pisi_eis_tpartkbhis_ipis
*/

Create Procedure sp_pisi_eis_tpartkbhis_ipis
	
As
Begin

-- 각 서버에서 통째로 날리고 insert 한다
select	*
into	#tmp_tpartkbhis
from	tpartkbhis
where	lastemp = 'Y'

delete	from [ipisele_svr\ipis].eis.dbo.tpartkbhis
where	PartKBNo+ApplyDate+Cast(PartOrderSeq as varchar(10)) in 
	(select	PartKBNo+ApplyDate+Cast(PartOrderSeq as varchar(10))
	from	#tmp_tpartkbhis)

insert into [ipisele_svr\ipis].eis.dbo.tpartkbhis
select * from #tmp_tpartkbhis

update	tpartkbhis
set	lastemp = 'N'
from	tpartkbhis, #tmp_tpartkbhis
where	tpartkbhis.partkbno = #tmp_tpartkbhis.partkbno
and	tpartkbhis.applydate = #tmp_tpartkbhis.applydate
and	tpartkbhis.partorderseq = #tmp_tpartkbhis.partorderseq

Drop table #tmp_tpartkbhis

End		-- Procedure End
Go
