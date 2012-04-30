/*
  File Name : sp_mpm134i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm134i_01
  Description : 12개월 불량발생내역
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_yyyy char(4)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm134i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm134i_01]
GO

/*
Execute sp_mpm134i_01 '%','2004.04.01','2004.05.06'
*/

Create Procedure sp_mpm134i_01
  @ps_orderno varchar(8),
  @ps_applyfrom varchar(10),
  @ps_applyto varchar(10)
As
Begin

declare @ld_fromdt datetime, @ld_todt datetime

select @ld_fromdt = convert(datetime,@ps_applyfrom,102)
select @ld_todt = convert(datetime,@ps_applyto,102)

select OrderNo = bb.OrderNo, 
  PartNo = bb.PartNo, 
  OperNo = bb.OperNo,
  WcCode = bb.WcCode,
  Jtime = Sum(bb.JobTime) 
into #jobtime
from torder aa left outer join tworkjob bb
  on aa.orderno = bb.orderno
where aa.OrderNo like @ps_orderno and aa.enddate >= @ld_fromdt and
  aa.enddate <= @ld_todt
group by bb.Orderno, bb.PartNo, bb.OperNo,bb.WcCode

select ApplyFrom = @ps_applyfrom,
  Applyto = @ps_applyto,
  OrderNo = aa.OrderNo,
  ToolName = dd.ToolName,
  ProductName = dd.ProductName,
  OrderDept = dd.OrderDept,
  StartDate = Convert(char(10), dd.StartDate, 102),
  EndDate = Convert(char(10), dd.EndDate, 102),
  DueDate = Convert(char(10), dd.DueDate, 102),
  PartNo = aa.PartNo, 
  PartName = aa.PartName,
  Material = aa.Material,
  Qty = isnull(aa.Qty1,0) + isnull(aa.Qty2,0), 
  OperNo = bb.OperNo, 
  TBS = case bb.WcCode when 'TBS' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TLA = case bb.WcCode when 'TLA' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TDM = case bb.WcCode when 'TDM' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TPM = case bb.WcCode when 'TPM' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TBM = case bb.WcCode when 'TBM' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TMM = case bb.WcCode when 'TMM' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TJB = case bb.WcCode when 'TJB' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  THT = case bb.WcCode when 'THT' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TUG = case bb.WcCode when 'TUG' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TSG = case bb.WcCode when 'TSG' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TJG = case bb.WcCode when 'TJG' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TVG = case bb.WcCode when 'TVG' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TDG = case bb.WcCode when 'TDG' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TWC = case bb.WcCode when 'TWC' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TED = case bb.WcCode when 'TED' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TLP = case bb.WcCode when 'TLP' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TCG = case bb.WcCode when 'TCG' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  TAM = case bb.WcCode when 'TAM' then convert(decimal(8,1),cc.Jtime / 60 ) else 0 end,
  HeatCost = isnull(bb.HeatCost,0), 
  OutCost = isnull(bb.OutCost,0),
  MaterialCost = isnull(bb.MatCost,0),
  ManCost = isnull(bb.ManCost,0),
  MchCost = isnull(bb.MchCost,0),
  ProfitCost = isnull(bb.ProfitCost,0)
from torder dd inner join tpartlist aa
  on dd.orderno = aa.orderno
  inner join trouting bb
  on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo
  left outer join #jobtime cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo and 
    bb.OperNo = cc.OperNo
where dd.OrderNo like @ps_orderno and dd.enddate >= @ld_fromdt
  and dd.enddate <= @ld_todt
order by aa.OrderNo,aa.PartNo, bb.OperNo
  
drop table #jobtime

End   -- Procedure End
Go
