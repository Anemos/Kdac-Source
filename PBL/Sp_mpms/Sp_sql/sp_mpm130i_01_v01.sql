/*
  File Name : sp_mpm130i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm130i_01
  Description : 원가정보(진행)
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(10) - 적용시작일
              @ps_todt char(10) - 적용완료일
              @ps_orderno varchar(9) - 의뢰번호
              @ps_deptcode varchar(6) - 의뢰부서
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm130i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm130i_01]
GO

/*
Execute sp_mpm130i_01 '2004.04.01','2004.05.06','%','%'
*/

Create Procedure sp_mpm130i_01
  @ps_applyfrom char(10),
  @ps_applyto char(10),
  @ps_orderno varchar(9),
  @ps_deptcode varchar(6)
As
Begin

declare @ld_fromdt datetime, @ld_todt datetime

select @ld_fromdt = convert(datetime,@ps_applyfrom,102)
select @ld_todt = convert(datetime,@ps_applyto,102)

Begin
--get orderno which ingstatus is not 'C' and startdate is bigger than @ps_applyto
select OrderNo = aa.OrderNo,
  ToolName = aa.ToolName,
  ProductName = aa.ProductName,
  OrderDept = aa.OrderDept,
  StartDate = aa.StartDate,
  EndDate = aa.EndDate,
  DueDate = aa.DueDate,
  LaborCost = isnull(aa.LaborCost,0)
into #order_tmp
from torder aa
where aa.OrderNo like @ps_orderno and aa.OrderDept like @ps_deptcode and
  aa.startdate >= @ld_fromdt and aa.startdate <= @ld_todt and
  ( aa.enddate is null or aa.enddate > @ld_todt )
  
--summary standardtime
select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  StdMatCost = isnull(bb.PartCost,0),
  StdTime = Sum(convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 )),
  StdMchCost = Sum(0),
  StdManCost = Sum(convert(decimal(10,0),(isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60) * isnull(aa.laborcost,0))),
  StdHeatCost = Sum(isnull(cc.StdHeatCost,0)),
  StdOutCost = Sum(isnull(cc.StdOutCost,0)),
  TBS = Sum(case cc.WcCode when 'TBS' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TLA = Sum(case cc.WcCode when 'TLA' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TDM = Sum(case cc.WcCode when 'TDM' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TPM = Sum(case cc.WcCode when 'TPM' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TBM = Sum(case cc.WcCode when 'TBM' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TMM = Sum(case cc.WcCode when 'TMM' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TJB = Sum(case cc.WcCode when 'TJB' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  THT = Sum(case cc.WcCode when 'THT' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TUG = Sum(case cc.WcCode when 'TUG' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TSG = Sum(case cc.WcCode when 'TSG' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TJG = Sum(case cc.WcCode when 'TJG' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TVG = Sum(case cc.WcCode when 'TVG' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TWC = Sum(case cc.WcCode when 'TWC' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TED = Sum(case cc.WcCode when 'TED' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TLP = Sum(case cc.WcCode when 'TLP' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end),
  TAM = Sum(case cc.WcCode when 'TAM' then convert(decimal(6,1),isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0) / 60 ) else 0 end)
into #std_tmp1
from #order_tmp aa inner join tpartlist bb
  on aa.orderno = bb.orderno
  inner join trouting cc
  on bb.orderno = cc.orderno and bb.partno = cc.partno
group by bb.OrderNo, bb.PartNo, bb.PartCost


-- get Summary Job Time
select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  TBS = Sum(case cc.WcCode when 'TBS' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TLA = Sum(case cc.WcCode when 'TLA' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TDM = Sum(case cc.WcCode when 'TDM' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TPM = Sum(case cc.WcCode when 'TPM' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TBG = Sum(case cc.WcCode when 'TBG' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TBM = Sum(case cc.WcCode when 'TBM' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TMM = Sum(case cc.WcCode when 'TMM' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TJB = Sum(case cc.WcCode when 'TJB' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  THT = Sum(case cc.WcCode when 'THT' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TUG = Sum(case cc.WcCode when 'TUG' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TSG = Sum(case cc.WcCode when 'TSG' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TJG = Sum(case cc.WcCode when 'TJG' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TVG = Sum(case cc.WcCode when 'TVG' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TWC = Sum(case cc.WcCode when 'TWC' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TED = Sum(case cc.WcCode when 'TED' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TLP = Sum(case cc.WcCode when 'TLP' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end),
  TAM = Sum(case cc.WcCode when 'TAM' then convert(decimal(8,1),isnull(cc.JobTime,0) / 60 ) else 0 end)
into #job_tmp1
from #order_tmp aa inner join tpartlist bb
  on bb.orderno = aa.orderno
  left outer join tworkjob cc
  on cc.orderno = bb.orderno and cc.partno = bb.partno
  inner join tmachine dd
  on cc.wccode = dd.wccode and cc.mchno = dd.mchno
group by bb.OrderNo, bb.PartNo

-- Get Job Cost
select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  JobTime = sum(isnull(bb.JobHour,0)),
  JobHeatCost = sum(isnull(bb.HeatCost,0)),
  JobOutCost = sum(isnull(bb.OutCost,0)),
  JobMatCost = sum(isnull(bb.MatCost,0)),
  JobManCost = sum(isnull(bb.ManCost,0)),
  JobMchCost = sum(isnull(bb.MchCost,0))
into #job_tmp2
from #order_tmp aa inner join tmatcost bb
  on aa.orderno = bb.orderno
where bb.yearmm <= convert(char(6),@ld_todt,112)
group by bb.orderno, bb.partno

select ApplyFrom = @ps_applyfrom,
  Applyto = @ps_applyto,
  OrderNo = aa.OrderNo,
  ToolName = aa.ToolName,
  ProductName = aa.ProductName,
  OrderDept = aa.OrderDept,
  StartDate = Convert(char(10), aa.StartDate, 102),
  EndDate = Convert(char(10), aa.EndDate, 102),
  DueDate = Convert(char(10), aa.DueDate, 102),
  PartNo = bb.PartNo, 
  PartName = bb.PartName,
  Material = bb.Material,
  Qty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  FinalQty = 0,
  StdTime  =  cc.StdTime,
  MatCost1 =  (cc.StdMatCost + cc.StdHeatCost + cc.StdOutCost),
  ManCost1 =  cc.StdManCost,
  MchCost1 =  cc.StdMchCost,
  SumCost1 =  (cc.StdMatCost + cc.StdManCost + cc.StdMchCost 
    + cc.StdHeatCost + cc.StdOutCost),
  TotCost1 =  convert(decimal(10,0),(cc.StdMatCost + cc.StdManCost + cc.StdMchCost 
    + cc.StdHeatCost + cc.StdOutCost) * 1.2),
  TBS1 = cc.TBS,
  TLA1 = cc.TLA,
  TDM1 = cc.TDM,
  TPM1 = cc.TPM,
  TBM1 = cc.TBM,
  TMM1 = cc.TMM,
  TJB1 = cc.TJB,
  THT1 = cc.THT,
  TUG1 = cc.TUG,
  TSG1 = cc.TSG,
  TJG1 = cc.TJG,
  TVG1 = cc.TVG,
  TWC1 = cc.TWC,
  TED1 = cc.TED,
  TLP1 = cc.TLP,
  TAM1 = cc.TAM,
  JobTime  =  ee.JobTime,
  MatCost2 =  (ee.JobMatCost + ee.JobHeatCost + ee.JobOutCost),
  ManCost2 =  ee.JobManCost,
  MchCost2 =  ee.JobMchCost,
  SumCost2 =  (ee.JobMatCost + ee.JobManCost + ee.JobMchCost
    + ee.JobHeatCost + ee.JobOutCost),
  TotCost2 =  convert(decimal(10,0),(ee.JobMatCost + ee.JobManCost + ee.JobMchCost
    + ee.JobHeatCost + ee.JobOutCost) * 1.2),
  TBS2 = dd.TBS,
  TLA2 = dd.TLA,
  TDM2 = dd.TDM,
  TPM2 = dd.TPM,
  TBM2 = dd.TBM,
  TMM2 = dd.TMM,
  TJB2 = dd.TJB,
  THT2 = dd.THT,
  TUG2 = dd.TUG,
  TSG2 = dd.TSG,
  TJG2 = dd.TJG,
  TVG2 = dd.TVG,
  TWC2 = dd.TWC,
  TED2 = dd.TED,
  TLP2 = dd.TLP,
  TAM2 = dd.TAM,
  EndChk = ( select count(*) from trouting
    where orderno = aa.orderno and partno = bb.partno and
      workstatus <> 'C' )
from #order_tmp aa inner join tpartlist bb
  on bb.orderno = aa.orderno
  left outer join #std_tmp1 cc
  on bb.orderno = cc.orderno and bb.partno = cc.partno
  left outer join #job_tmp1 dd
  on bb.orderno = dd.orderno and bb.partno = dd.partno
  left outer join #job_tmp2 ee
  on bb.orderno = ee.orderno and bb.partno = ee.partno
order by bb.OrderNo, bb.PartNo

End

drop table #order_tmp
drop table #std_tmp1
drop table #job_tmp1
drop table #job_tmp2

End   -- Procedure End
Go
