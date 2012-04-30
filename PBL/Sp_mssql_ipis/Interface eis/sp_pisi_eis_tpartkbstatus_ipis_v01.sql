/*
  File Name : sp_pisi_eis_tpartkbstatus_ipis.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_eis_tpartkbstatus_ipis
  Description : EIS Upload tpartkbstatus(IPISELE Server)
        tpartkbstatus
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2002. 11. 12
  Author    : Kiss Kim
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

exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tpartkbstatus_tmp'
-- 각 서버에서 통째로 날리고 insert 한다
insert into [ipisele_svr\ipis].eis.dbo.tpartkbstatus_tmp
select  *
from  tpartkbstatus
where lastemp = 'Y'

delete  [ipisele_svr\ipis].eis.dbo.tpartkbstatus
from [ipisele_svr\ipis].eis.dbo.tpartkbstatus aa inner join [ipisele_svr\ipis].eis.dbo.tpartkbstatus_tmp bb
  on aa.partkbno = bb.partkbno

insert into [ipisele_svr\ipis].eis.dbo.tpartkbstatus
select * from [ipisele_svr\ipis].eis.dbo.tpartkbstatus_tmp

update  tpartkbstatus
set lastemp = 'N'
from  tpartkbstatus aa, [ipisele_svr\ipis].eis.dbo.tpartkbstatus_tmp bb
where aa.partkbno = bb.partkbno


End   -- Procedure End
Go
