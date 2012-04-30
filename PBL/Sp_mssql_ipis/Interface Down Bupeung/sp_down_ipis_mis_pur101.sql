/*
  File Name : sp_down_ipis_mis_pur101.SQL
  SYSTEM    : Interface System
  Procedure Name  : sp_down_ipis_mis_pur101
  Description : 협력업체/고객마스타, 대구전장인터페이스 JOB Schedule
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_down_ipis_mis_pur101]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_down_ipis_mis_pur101]
GO

/*
Execute sp_down_ipis_mis_pur101
*/

Create Procedure sp_down_ipis_mis_pur101

As
Begin

declare @max_chgdate varchar(30)

Select	*
into #tmp_pdpur101
from  tmispur101 aa inner join
  ( select scgubun as tmp_01, vsrno as tmp_02, max(chgdate) as maxchgdt from tmispur101
    group by scgubun, vsrno ) bb
  on aa.chgdate = bb.maxchgdt and aa.scgubun = bb.tmp_01 and
    aa.vsrno = bb.tmp_02
order by aa.chgdate

if @@error <> 0 or @@rowcount = 0
  Begin
  Return
  End

Select @max_chgdate = max(chgdate)
from #tmp_pdpur101

-- ipis customer
if Exists (select * From #tmp_pdpur101 Where scgubun	=	'C'	and len(vsrno) <= 6 )
  Begin
  -- 대구전장
  Delete  [ipisele_svr\ipis].ipis.dbo.tmstcustomer
  from [ipisele_svr\ipis].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipisele_svr\ipis].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 대구기계
  Delete  [ipismac_svr\ipis].ipis.dbo.tmstcustomer
  from [ipismac_svr\ipis].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipismac_svr\ipis].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 대구공조
  Delete  [ipishvac_svr\ipis].ipis.dbo.tmstcustomer
  from [ipishvac_svr\ipis].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipishvac_svr\ipis].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 부평물류
  Delete  [ipisbup_svr\ipis].ipis.dbo.tmstcustomer
  from [ipisbup_svr\ipis].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipisbup_svr\ipis].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 군산물류
  Delete  [ipiskun_svr\ipis].ipis.dbo.tmstcustomer
  from [ipiskun_svr\ipis].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipiskun_svr\ipis].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 여주전자
  Delete  [ipisyeo_svr\ipis].ipis.dbo.tmstcustomer
  from [ipisyeo_svr\ipis].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipisyeo_svr\ipis].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 진천
  Delete  [ipisjin_svr].ipis.dbo.tmstcustomer
  from [ipisjin_svr].ipis.dbo.tmstcustomer aa inner join #tmp_pdpur101 bb
    on aa.custcode = bb.vsrno
  where bb.scgubun = 'C' and len(bb.vsrno) <= 6

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End

  Insert into [ipisjin_svr].ipis.dbo.tmstcustomer
    ( CustCode,  CustName, CustShortName,
    CustGubun, 
    CustNo, CustAddress1,
    CustHeadName, CustFaxNo,  CustTelNo, CustPostNo, LastEmp)
  select substring(rtrim(vsrno),1,6), rtrim(vndnm), substring(rtrim(vndnm1),1,15),
    case digubun when '' then 'Z' else digubun end,
    rtrim(vndr), rtrim(addr),
    rtrim(prnm), faxn, teln, substring(vpost,1,6), 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'C' and chgcd in ('C','U') and len(vsrno) <= 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  End

-- ipis supplier
if Exists (select * From #tmp_pdpur101 Where scgubun	=	'S'	and len(vsrno) <= 5 )
  Begin
  -- 대구전장
  Delete  [ipisele_svr\ipis].ipis.dbo.tmstsupplier
  from [ipisele_svr\ipis].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipisele_svr\ipis].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 대구기계
  Delete  [ipismac_svr\ipis].ipis.dbo.tmstsupplier
  from [ipismac_svr\ipis].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipismac_svr\ipis].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 대구공조
  Delete  [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
  from [ipishvac_svr\ipis].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipishvac_svr\ipis].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 부평물류
  Delete  [ipisbup_svr\ipis].ipis.dbo.tmstsupplier
  from [ipisbup_svr\ipis].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipisbup_svr\ipis].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 군산물류
  Delete  [ipiskun_svr\ipis].ipis.dbo.tmstsupplier
  from [ipiskun_svr\ipis].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipiskun_svr\ipis].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 여주전자
  Delete  [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
  from [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipisyeo_svr\ipis].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  -- 진천
  Delete  [ipisjin_svr].ipis.dbo.tmstsupplier
  from [ipisjin_svr].ipis.dbo.tmstsupplier aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where bb.scgubun = 'S' and len(bb.vsrno) <= 5

  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipisjin_svr].ipis.dbo.tmstsupplier
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag, LastEmp)
  select  substring(rtrim(vsrno),1,5), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where scgubun = 'S' and chgcd in ('C','U') and len(vsrno) <= 5
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  End

--외자업체 정보 다운로드
-- 여주전자
if Exists (select * From #tmp_pdpur101 Where len(vsrno) > 6 )
  Begin
  Delete  [ipisyeo_svr\ipis].ipis.dbo.tmstsupplieroversea
  from [ipisyeo_svr\ipis].ipis.dbo.tmstsupplieroversea aa inner join #tmp_pdpur101 bb
    on aa.suppliercode = bb.vsrno
  where len(bb.vsrno) > 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  
  Insert into [ipisyeo_svr\ipis].ipis.dbo.tmstsupplieroversea
  (SupplierCode,      SupplierNo,   SupplierKorName,
  SupplierEngName,    SupplierAddress,  SupplierHeadName,
  SupplierNation,     SupplierTelNo,    SupplierFaxNo,
  SupplierTelexNo,    SupplierPostNo,
  SupplierInKDAC,     SupplierKBFlag,   SupplierVANFlag,
  LastEmp)
  select  rtrim(vsrno), rtrim(vndr), rtrim(vndnm),
  substring(rtrim(vndnm1),1,30), rtrim(addr), rtrim(prnm),
  rtrim(natn), teln, faxn,
  rtrim(tlxn), substring(vpost,1,7),
  '', '', '', 'SYSTEM'
  from #tmp_pdpur101
  where chgcd in ('C','U') and len(vsrno) > 6
  
  if @@error <> 0
    Begin
    Drop table #tmp_pdpur101
    Return
    End
  End

Delete  tmispur101
from tmispur101 aa inner join #tmp_pdpur101 bb
  on aa.scgubun = bb.scgubun and aa.vsrno = bb.vsrno
where aa.chgdate <= @max_chgdate

if (select count(*) from tmispur101) = 0
  begin
    truncate table tmispur101
  end

Drop table #tmp_pdpur101

End   -- Procedure End
Go
