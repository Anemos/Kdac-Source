/*
	File Name	: sp_pisi_all_tpartkbhis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_all_tpartkbhis
	Description	: 전공장 Upload tpartkbhis
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: interface
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use interface

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_all_tpartkbhis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_all_tpartkbhis]
GO

/*
Execute sp_pisi_all_tpartkbhis
*/

Create Procedure sp_pisi_all_tpartkbhis
	
As
Begin

truncate table tpartkbhis_tmp

-- create tpartkbhis_tmp data
insert into tpartkbhis_tmp
select  *
from  [ipisele_svr\ipis].ipis.dbo.tpartkbhis
where lastemp = 'Y'

insert into tpartkbhis_tmp
select  *
from  [ipismac_svr\ipis].ipis.dbo.tpartkbhis
where lastemp = 'Y'

insert into tpartkbhis_tmp
select  *
from  [ipishvac_svr\ipis].ipis.dbo.tpartkbhis
where lastemp = 'Y'

insert into tpartkbhis_tmp
select  *
from  [ipisjin_svr].ipis.dbo.tpartkbhis
where lastemp = 'Y'

-- create tpartkbhis_all
delete  [ipisele_svr\ipis].ipis.dbo.tpartkbhis_all
from [ipisele_svr\ipis].ipis.dbo.tpartkbhis_all aa inner join tpartkbhis_tmp bb
  on aa.Partkbno = bb.Partkbno and aa.applydate = bb.applydate and aa.partorderseq = bb.partorderseq

insert into [ipisele_svr\ipis].ipis.dbo.tpartkbhis_all
select * from tpartkbhis_tmp

if @@ERROR <> 0
  return

-- ele server flag update
update  [ipisele_svr\ipis].ipis.dbo.tpartkbhis
set lastemp = 'N'
from [ipisele_svr\ipis].ipis.dbo.tpartkbhis aa, tpartkbhis_tmp bb
where aa.partkbno = bb.partkbno
and aa.applydate = bb.applydate
and aa.partorderseq = bb.partorderseq
and aa.lastemp = 'Y'

-- mac server flag update
update  [ipismac_svr\ipis].ipis.dbo.tpartkbhis
set lastemp = 'N'
from [ipismac_svr\ipis].ipis.dbo.tpartkbhis aa, tpartkbhis_tmp bb
where aa.partkbno = bb.partkbno
and aa.applydate = bb.applydate
and aa.partorderseq = bb.partorderseq
and aa.lastemp = 'Y'

-- hvac server
update  [ipishvac_svr\ipis].ipis.dbo.tpartkbhis
set lastemp = 'N'
from [ipishvac_svr\ipis].ipis.dbo.tpartkbhis aa, tpartkbhis_tmp bb
where aa.partkbno = bb.partkbno
and aa.applydate = bb.applydate
and aa.partorderseq = bb.partorderseq
and aa.lastemp = 'Y'

-- jin server
update  [ipisjin_svr].ipis.dbo.tpartkbhis
set lastemp = 'N'
from [ipisjin_svr].ipis.dbo.tpartkbhis aa, tpartkbhis_tmp bb
where aa.partkbno = bb.partkbno
and aa.applydate = bb.applydate
and aa.partorderseq = bb.partorderseq
and aa.lastemp = 'Y'

End		-- Procedure End
Go
