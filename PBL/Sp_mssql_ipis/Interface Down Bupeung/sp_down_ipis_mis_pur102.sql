/*
  File Name : sp_down_ipis_mis_pur102.SQL
  SYSTEM    : Interface System
  Procedure Name  : sp_down_ipis_mis_pur102
  Description : 업체(발주관련기본정보), 대구전장인터페이스 JOB Schedule
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_down_ipis_mis_pur102]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_down_ipis_mis_pur102]
GO

/*
Execute sp_down_ipis_mis_pur102
*/

Create Procedure sp_down_ipis_mis_pur102

As
Begin

declare @max_chgdate varchar(30)

select chgdate = aa.chgdate,
  chgcd = aa.chgcd,
  vsrno = aa.vsrno,
  inside = aa.inside,
  kbcd = aa.kbcd,
  vancd = aa.vancd,
  jscd = aa.jscd,
  xstop = aa.xstop,
  stscd = aa.stscd,
  downdate = aa.downdate
into #tmp_pdpur102
from  tmispur102 aa inner join
  ( select vsrno, max(chgdate) as maxchgdt from tmispur102
    group by vsrno ) bb
  on aa.chgdate = bb.maxchgdt and aa.vsrno = bb.vsrno
order by aa.chgdate

if @@error <> 0 or @@rowcount = 0
  Begin
  Return
  End

Select @max_chgdate = max(chgdate)
from #tmp_pdpur102

--대구전장
--ipis
Update [ipisele_svr\ipis].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipisele_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

--대구기계
--ipis
Update [ipismac_svr\ipis].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipismac_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

--대구공조
--ipis
Update [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipishvac_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

--부평물류
--ipis
Update [ipisbup_svr\ipis].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipisbup_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

--군산물류
--ipis
Update [ipiskun_svr\ipis].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipiskun_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

--여주전자
--ipis
Update [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

--진천
--ipis
Update [ipisjin_svr].ipis.dbo.tmstsupplier
  Set SupplierInKDAC  = bb.inside,
  SupplierKBFlag  = bb.kbcd,
  SupplierVANFlag = bb.vancd,
  JSCode    = bb.jscd,
  Xstop     = bb.xstop,
  LastDate  = Getdate()
From [ipisjin_svr].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where aa.SupplierCode   = bb.vsrno

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur102
  Return
  End

Delete  tmispur102
from tmispur102 aa inner join #tmp_pdpur102 bb
  on aa.vsrno = bb.vsrno
where aa.chgdate <= @max_chgdate

if (select count(*) from tmispur102) = 0
  begin
    truncate table tmispur102
  end

Drop table #tmp_pdpur102

End   -- Procedure End
Go
