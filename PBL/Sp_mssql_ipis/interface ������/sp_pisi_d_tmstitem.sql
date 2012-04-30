/*
	File Name	: sp_pisi_d_tmstitem.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstitem
	Description	: Download Item
			  tmstitem
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstitem]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstitem]
GO

/*
Execute sp_pisi_d_tmstitem
*/

Create Procedure sp_pisi_d_tmstitem
	
	
As
Begin

SET XACT_ABORT OFF

Select	*
Into	#tmp_pdinv002_log
From	pdinv002_log
Where	itno+chgdate in (select itno+max(chgdate) from pdinv002_log
       			group by itno)
order by chgdate

if @@error <> 0
	Begin
	Return
	End
	
-- 대구전장	
--ipis

delete from [ipisele_svr\ipis].ipis.dbo.tmstitem
where itemcode in (select itno from #tmp_pdinv002_log)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisele_svr\ipis].ipis.dbo.tmstitem
	(ItemCode,	ItemName,	ItemSpec,
	ItemUnit,	ItemType,	LastEmp)
select   Itno,		Itnm,		Spec,
	 Xunit,		Xtype,		'SYSTEM'
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End

-- 대구전장	
--eis

delete from [ipisele_svr\ipis].eis.dbo.tmstitem
where itemcode in (select itno from #tmp_pdinv002_log)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisele_svr\ipis].eis.dbo.tmstitem
	(ItemCode,	ItemName,	ItemSpec,
	ItemUnit,	ItemType,	LastEmp)
select   Itno,		Itnm,		Spec,
	 Xunit,		Xtype,		'SYSTEM'
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End

-- 대구기계	
--ipis

delete from [ipismac_svr\ipis].ipis.dbo.tmstitem
where itemcode in (select itno from #tmp_pdinv002_log)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipismac_svr\ipis].ipis.dbo.tmstitem
	(ItemCode,	ItemName,	ItemSpec,
	ItemUnit,	ItemType,	LastEmp)
select   Itno,		Itnm,		Spec,
	 Xunit,		Xtype,		'SYSTEM'
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End

-- 대구공조	
--ipis

delete from [ipishvac_svr\ipis].ipis.dbo.tmstitem
where itemcode in (select itno from #tmp_pdinv002_log)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstitem
	(ItemCode,	ItemName,	ItemSpec,
	ItemUnit,	ItemType,	LastEmp)
select   Itno,		Itnm,		Spec,
	 Xunit,		Xtype,		'SYSTEM'
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End
	
-- 여주전자	
--ipis

delete from [ipisyeo_svr\ipis].ipis.dbo.tmstitem
where itemcode in (select itno from #tmp_pdinv002_log)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisyeo_svr\ipis].ipis.dbo.tmstitem
	(ItemCode,	ItemName,	ItemSpec,
	ItemUnit,	ItemType,	LastEmp)
select   Itno,		Itnm,		Spec,
	 Xunit,		Xtype,		'SYSTEM'
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End

-- 진천
--ipis

delete from [ipisjin_svr].ipis.dbo.tmstitem
where itemcode in (select itno from #tmp_pdinv002_log)

if @@error <> 0
	Begin
	Return
	End

Insert Into [ipisjin_svr].ipis.dbo.tmstitem
	(ItemCode,	ItemName,	ItemSpec,
	ItemUnit,	ItemType,	LastEmp)
select   Itno,		Itnm,		Spec,
	 Xunit,		Xtype,		'SYSTEM'
from #tmp_pdinv002_log
where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End

delete from pdinv002_log
where chgcd = 'D'

if @@error <> 0
	Begin
	Return
	End

Delete from pdinv002_log
Where chgcd <> 'D'

if @@error <> 0
	Begin
	Return
	End

if (select count(*) from pdinv002_log) = 0
 	begin
 	truncate table pdinv002_log
 	end

Drop table #tmp_pdinv002_log

End		-- Procedure End
Go
