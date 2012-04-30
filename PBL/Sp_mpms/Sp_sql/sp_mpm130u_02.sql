/*
  File Name : sp_mpm130u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm130u_02
  Description : 재료비 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(8)
              @ps_todt char(8)
              @ps_orderno char(8) 의뢰번호
              @ps_partno char(6)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm130u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm130u_02]
GO

/*
Execute sp_mpm130u_02 '20040701','20040730','20040002','001006'
*/

Create Procedure sp_mpm130u_02
  @ps_fromdt char(8),
  @ps_todt char(8),
  @ps_orderno char(8),
  @ps_partno char(6)
As
Begin

select OrderNo = bb.OrderNo, 
  PartNo = bb.PartNo, 
  OperNo = bb.OperNo,
  WcCode = bb.WcCode,
  Jtime = Sum(isnull(bb.JobTime,0)),
  HeatCost = Sum(isnull(bb.HeatCost,0)),
  OutCost = Sum(isnull(bb.OutCost,0)),
  ManCost = Sum(convert(decimal(10,0),isnull(bb.JobTime,0) * isnull(aa.laborcost,0) / 60)),
  MchCost = Sum(convert(decimal(10,0),isnull(bb.JobTime,0) * isnull(cc.hourcost,0) / 60)) 
into #jobtime
from torder aa inner join tworkjob bb
  on aa.orderno = bb.orderno
  inner join tmachine cc
  on cc.wccode = bb.wccode and cc.mchno = bb.mchno
where bb.OrderNo = @ps_orderno and bb.PartNo = @ps_partno and
  bb.workdate >= @ps_fromdt and bb.workdate <= @ps_todt
group by bb.Orderno, bb.PartNo, bb.OperNo,bb.WcCode

select OrderNo = aa.OrderNo,
  PartNo = aa.PartNo, 
  PartName = aa.PartName, 
  OperNo = bb.OperNo,
  WcCode = bb.WcCode,
  JobTime = convert(decimal(6,1),isnull(cc.Jtime,0) / 60),
  TBS = case bb.WcCode when 'TBS' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TLA = case bb.WcCode when 'TLA' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TDM = case bb.WcCode when 'TDM' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TPM = case bb.WcCode when 'TPM' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TBM = case bb.WcCode when 'TBM' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TMM = case bb.WcCode when 'TMM' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TJB = case bb.WcCode when 'TJB' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  THT = case bb.WcCode when 'THT' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TUG = case bb.WcCode when 'TUG' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TSG = case bb.WcCode when 'TSG' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TJG = case bb.WcCode when 'TJG' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TVG = case bb.WcCode when 'TVG' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TWC = case bb.WcCode when 'TWC' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TED = case bb.WcCode when 'TED' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TLP = case bb.WcCode when 'TLP' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  TAM = case bb.WcCode when 'TAM' then convert(decimal(6,1),isnull(cc.Jtime,0) / 60) else 0 end,
  HeatCost = isnull(cc.HeatCost,0), 
  OutCost = isnull(cc.OutCost,0),
  ManCost = isnull(cc.ManCost,0),
  MchCost = isnull(cc.MchCost,0)
from tpartlist aa inner join trouting bb
  on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo
  left outer join #jobtime cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo and 
    bb.OperNo = cc.OperNo
where bb.OrderNo = @ps_orderno and bb.PartNo = @ps_partno
order by aa.PartNo, bb.OperNo
  

End   -- Procedure End
Go
