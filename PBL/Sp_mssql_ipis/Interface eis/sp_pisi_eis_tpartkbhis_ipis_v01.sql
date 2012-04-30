/*
  File Name : sp_pisi_eis_tpartkbhis_ipis.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_eis_tpartkbhis_ipis
  Description : EIS Upload tpartkbhis
        tpartkbhis
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2006. 05
  Author    : Kiss Kim
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

exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tpartkbhis_tmp'

insert into [ipisele_svr\ipis].eis.dbo.tpartkbhis_tmp
select  *
from  tpartkbhis
where lastemp = 'Y'

-- 각 서버에서 통째로 날리고 insert 한다

delete  [ipisele_svr\ipis].eis.dbo.tpartkbhis
from [ipisele_svr\ipis].eis.dbo.tpartkbhis aa inner join [ipisele_svr\ipis].eis.dbo.tpartkbhis_tmp bb
  on aa.Partkbno = bb.Partkbno and aa.applydate = bb.applydate and aa.partorderseq = bb.partorderseq


insert into [ipisele_svr\ipis].eis.dbo.tpartkbhis
select * from  [ipisele_svr\ipis].eis.dbo.tpartkbhis_tmp

update  tpartkbhis
set lastemp = 'N'
from tpartkbhis aa, [ipisele_svr\ipis].eis.dbo.tpartkbhis_tmp bb
where aa.partkbno = bb.partkbno
and aa.applydate = bb.applydate
and aa.partorderseq = bb.partorderseq


End   -- Procedure End
Go
