/*
	File Name	: sp_pisi_d_tmstsupplier.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstsupplier
	Description	: Download Costomer/Supplier Master
			  tmstcostomer/tmstsupplier
			  여주전자 서버 추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstsupplier]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstsupplier]
GO

/*
Execute sp_pisi_d_tmstsupplier
*/

Create Procedure sp_pisi_d_tmstsupplier
	
	
As
Begin

SET Xact_Abort Off

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
from	pdpur102_log aa inner join 
	( select vsrno, max(chgdate) as maxchgdt from pdpur102_log
		group by vsrno ) bb
	on aa.chgdate = bb.maxchgdt and aa.vsrno = bb.vsrno
order by aa.chgdate

--대구전장
--eis
Update [ipisele_svr\ipis].eis.dbo.tmstsupplier
  Set	SupplierInKDAC 	= bb.inside,
  SupplierKBFlag 	= bb.kbcd,				
  SupplierVANFlag = bb.vancd,	
  JSCode 		= bb.jscd,
  Xstop     = bb.xstop,
  LastDate 	= Getdate()
From [ipisele_svr\ipis].eis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where	aa.SupplierCode 	= bb.vsrno

if @@error	<>	0
  Return

--대구전장
--ipis
Update [ipisele_svr\ipis].ipis.dbo.tmstsupplier
  Set	SupplierInKDAC 	= bb.inside,
  SupplierKBFlag 	= bb.kbcd,				
  SupplierVANFlag = bb.vancd,	
  JSCode 		= bb.jscd,
  Xstop     = bb.xstop,
  LastDate 	= Getdate()
From [ipisele_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where	aa.SupplierCode 	= bb.vsrno
			
if @@error	<>	0
  Return

--대구기계
--ipis
Update [ipismac_svr\ipis].ipis.dbo.tmstsupplier
  Set	SupplierInKDAC 	= bb.inside,
  SupplierKBFlag 	= bb.kbcd,				
  SupplierVANFlag = bb.vancd,	
  JSCode 		= bb.jscd,
  Xstop     = bb.xstop,
  LastDate 	= Getdate()
From [ipismac_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where	aa.SupplierCode 	= bb.vsrno
			
if @@error	<>	0
  Return

--대구공조
--ipis
Update [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
  Set	SupplierInKDAC 	= bb.inside,
  SupplierKBFlag 	= bb.kbcd,				
  SupplierVANFlag = bb.vancd,	
  JSCode 		= bb.jscd,
  Xstop     = bb.xstop,
  LastDate 	= Getdate()
From [ipishvac_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where	aa.SupplierCode 	= bb.vsrno

if @@error	<>	0
  Return

--여주전자
--ipis
Update [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
  Set	SupplierInKDAC 	= bb.inside,
  SupplierKBFlag 	= bb.kbcd,				
  SupplierVANFlag = bb.vancd,	
  JSCode 		= bb.jscd,
  Xstop     = bb.xstop,
  LastDate 	= Getdate()
From [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where	aa.SupplierCode 	= bb.vsrno

if @@error	<>	0
  Return

--진천
--ipis
Update [ipisjin_svr].ipis.dbo.tmstsupplier
  Set	SupplierInKDAC 	= bb.inside,
  SupplierKBFlag 	= bb.kbcd,				
  SupplierVANFlag = bb.vancd,	
  JSCode 		= bb.jscd,
  Xstop     = bb.xstop,
  LastDate 	= Getdate()
From [ipisjin_svr].ipis.dbo.tmstsupplier aa, #tmp_pdpur102 bb
Where	aa.SupplierCode 	= bb.vsrno

if @@error	<>	0
  Return

truncate table pdpur102_log

Drop table #tmp_pdpur102

End		-- Procedure End
Go
