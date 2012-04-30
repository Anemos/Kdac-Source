/*
  File Name : sp_mpm130u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm130u_01
  Description : 재료비 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_yyyymm char(6), @ps_orderno varchar(9)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm130u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm130u_01]
GO

/*
Execute sp_mpm130u_01 '200403', '%'
*/

Create Procedure sp_mpm130u_01
  @ps_yyyymm char(6),
  @ps_orderno varchar(9)
As
Begin

select YearMm = bb.YearMm,
  OrderNo = bb.OrderNo,
  PartNo = bb.PartNo, 
  PartName = aa.PartName, 
  JobHour = isnull(bb.JobHour,0), 
  HeatCost = isnull(bb.HeatCost,0), 
  OutCost = isnull(bb.OutCost,0),
  MatCost = isnull(bb.MatCost,0),
  ManCost = isnull(bb.ManCost,0),
  MchCost = isnull(bb.MchCost,0),
  SumCost = (isnull(bb.HeatCost,0) + isnull(bb.OutCost,0) + isnull(bb.MatCost,0)
    + isnull(bb.ManCost,0) + isnull(bb.MchCost,0)),
  TotCost = convert(decimal(10,0),(isnull(bb.HeatCost,0) + isnull(bb.OutCost,0)
    + isnull(bb.MatCost,0) + isnull(bb.ManCost,0) + isnull(bb.MchCost,0)) * 1.2)
from tpartlist aa inner join tmatcost bb
  on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo
where bb.YearMm = @ps_yyyymm and bb.OrderNo like @ps_orderno
order by bb.PartNo
  

End   -- Procedure End
Go
