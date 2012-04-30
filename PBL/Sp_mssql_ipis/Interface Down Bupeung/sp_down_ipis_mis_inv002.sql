/*
  File Name : sp_down_ipis_mis_inv002.SQL
  SYSTEM    : Interface System
  Procedure Name  : sp_down_ipis_mis_inv002
  Description : 품목마스타, 대구전장인터페이스 JOB Schedule
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_down_ipis_mis_inv002]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_down_ipis_mis_inv002]
GO

/*
Execute sp_down_ipis_mis_inv002
*/

Create Procedure sp_down_ipis_mis_inv002

As
Begin

declare @max_chgdate varchar(30)

Select  *
Into  #tmp_pdinv002_log
From  tmisinv002
Where itno+chgdate in (select itno+max(chgdate) from tmisinv002 where stscd = 'N'
            group by itno)
order by chgdate

if @@error <> 0 or @@rowcount = 0
  Begin
  Return
  End

Select @max_chgdate = max(chgdate)
from #tmp_pdinv002_log

-- 대구전장
--ipis

delete [ipisele_svr\ipis].ipis.dbo.tmstitem
from [ipisele_svr\ipis].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipisele_svr\ipis].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

-- 대구기계
--ipis

delete [ipismac_svr\ipis].ipis.dbo.tmstitem
from [ipismac_svr\ipis].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipismac_svr\ipis].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

-- 대구공조
--ipis

delete [ipishvac_svr\ipis].ipis.dbo.tmstitem
from [ipishvac_svr\ipis].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

-- 부평물류
--ipis

delete [ipisbup_svr\ipis].ipis.dbo.tmstitem
from [ipisbup_svr\ipis].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipisbup_svr\ipis].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

-- 군산물류
--ipis

delete [ipiskun_svr\ipis].ipis.dbo.tmstitem
from [ipiskun_svr\ipis].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipiskun_svr\ipis].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

-- 여주전자
--ipis

delete [ipisyeo_svr\ipis].ipis.dbo.tmstitem
from [ipisyeo_svr\ipis].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipisyeo_svr\ipis].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

-- 진천
--ipis

delete [ipisjin_svr].ipis.dbo.tmstitem
from [ipisjin_svr].ipis.dbo.tmstitem aa inner join #tmp_pdinv002_log bb
  on aa.itemcode = bb.itno

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

Insert Into [ipisjin_svr].ipis.dbo.tmstitem
  (ItemCode,  ItemName, ItemSpec,
  ItemUnit, ItemType, LastEmp, ItemRevno)
select   Itno,    Itnm,   Spec,
   Xunit,   Xtype,    'SYSTEM', Rvno
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
  Begin
  Drop table #tmp_pdinv002_log
  Return
  End

update tmisinv002
set stscd = 'Y'
from tmisinv002 aa inner join #tmp_pdinv002_log bb
  on aa.itno = bb.itno
where aa.chgdate <= @max_chgdate

Drop table #tmp_pdinv002_log

End   -- Procedure End
Go
