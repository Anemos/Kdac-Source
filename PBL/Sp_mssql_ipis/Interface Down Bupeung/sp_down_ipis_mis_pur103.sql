/*
  File Name : sp_down_ipis_mis_pur103.SQL
  SYSTEM    : Interface System
  Procedure Name  : sp_down_ipis_mis_pur103
  Description : 업체별구매단가(PartCost), 대구전장인터페이스 JOB Schedule
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_down_ipis_mis_pur103]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_down_ipis_mis_pur103]
GO

/*
Execute sp_down_ipis_mis_pur103
*/

Create Procedure sp_down_ipis_mis_pur103

As
Begin

declare @max_chgdate varchar(30)

Select  *
into  #tmp_pdpur103
from  tmispur103 aa inner join 
  ( select vsrno as tmp_01, itno as tmp_02, max(chgdate) as maxchgdt from tmispur103
    group by vsrno, itno ) bb
  on aa.chgdate = bb.maxchgdt and aa.vsrno = bb.tmp_01 and
    aa.itno = bb.tmp_02
order by aa.chgdate

if @@error <> 0 or @@rowcount = 0
  Begin
  Return
  End

Select @max_chgdate = max(chgdate)
from #tmp_pdpur103

-- 대구전장
delete [ipisele_svr\ipis].ipis.dbo.tmstpartcost
from [ipisele_svr\ipis].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipisele_svr\ipis].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

-- 대구기계
delete [ipismac_svr\ipis].ipis.dbo.tmstpartcost
from [ipismac_svr\ipis].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipismac_svr\ipis].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5 and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

-- 대구공조
delete [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
from [ipishvac_svr\ipis].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End


-- 부평물류
delete [ipisbup_svr\ipis].ipis.dbo.tmstpartcost
from [ipisbup_svr\ipis].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipisbup_svr\ipis].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

-- 군산물류
delete [ipiskun_svr\ipis].ipis.dbo.tmstpartcost
from [ipiskun_svr\ipis].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipiskun_svr\ipis].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

-- 여주전자 (내자)
delete [ipisyeo_svr\ipis].ipis.dbo.tmstpartcost
from [ipisyeo_svr\ipis].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipisyeo_svr\ipis].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

-- 여주전자 (외자)
delete [ipisyeo_svr\ipis].ipis.dbo.tmstpartcostoversea
from [ipisyeo_svr\ipis].ipis.dbo.tmstpartcostoversea aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) > 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipisyeo_svr\ipis].ipis.dbo.tmstpartcostoversea
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(eadjdt, 1, 4)+'.'+substring(eadjdt, 5, 2)+'.'+substring(eadjdt, 7,2),
  ecurr,    ecost,    esheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  >   5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

-- 진천
delete [ipisjin_svr].ipis.dbo.tmstpartcost
from [ipisjin_svr].ipis.dbo.tmstpartcost aa inner join #tmp_pdpur103 bb
  on aa.suppliercode = bb.vsrno and aa.itemcode = bb.itno
where len(bb.vsrno) <= 5

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Insert Into [ipisjin_svr].ipis.dbo.tmstpartcost
  (SupplierCode,  ItemCode,
  ApplyDate,
  CurrentUnit,  UnitCost, SheetNo,  ARR,    XPAY,
  VZERO,    QCGubun,
  QCApplyDate,
  QCInDate,
  PQTY,   XRATE,    ShareRate,  StartGubun, ChangeCost,
  FPURNO,
  FPINDT,
  FCOST,    PURNO,
  PINDT,
  RQNO,   SRNO,   SRNO1,
  DKDT,
  LCOST,    XSTOP,    LastEmp)
select  vsrno,  itno,
  substring(dadjdt, 1, 4)+'.'+substring(dadjdt, 5, 2)+'.'+substring(dadjdt, 7,2),
  dcurr,    dcost,    dsheet,   arr,    xpay,
  vzero,    qccd,
  substring(adjdt, 1, 4)+'.'+substring(adjdt, 5, 2)+'.'+substring(adjdt, 7,2),
  substring(frpdt, 1, 4)+'.'+substring(frpdt, 5, 2)+'.'+substring(frpdt, 7,2),
  pqty,   xrate,    shrt,   strt,   chcs,
  fpurno,
  substring(fpindt, 1, 4)+'.'+substring(fpindt, 5, 2)+'.'+substring(fpindt, 7,2),
  fcost,    purno,
  substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
  rqno,   srno,   srno1,
  substring(dkdt, 1, 4)+'.'+substring(dkdt, 5, 2)+'.'+substring(dkdt, 7,2),
  lcost,    xstop,    'SYSTEM'
from  #tmp_pdpur103
where len(vsrno)  <=  5  and chgcd in ('C','U')

if @@error  <>  0
  Begin
  Drop table #tmp_pdpur103
  Return
  End

Delete  tmispur103
from tmispur103 aa inner join #tmp_pdpur103 bb
  on aa.vsrno = bb.vsrno and aa.itno = bb.itno
where aa.chgdate <= @max_chgdate

if (select count(*) from tmispur103) = 0
  begin
    truncate table tmispur103
  end

Drop table #tmp_pdpur103

End   -- Procedure End
Go
