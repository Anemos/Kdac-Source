/*
  File Name : sp_mpm132i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm132i_02
  Description : 부서,모델별 완료집계표
  적용년월을 기준으로 하여 완료된 Order에 대한 집계
  2006.12 => 외주가공비를 재료비에서 별도 분리 ( OrderNo 20070000 부터 ). 
    변경전 : 총원가 = 제조원가( 재료비 + 외주가공비 + 인건비 + 제조경비 ) * 1.2
    변경후 : 총원가 = 제조원가( 재료비 + 인건비 + 제조경비 ) * 1.2 + 외주가공비
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(10), @ps_todt char(10)
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm132i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm132i_02]
GO

/*
Execute sp_mpm132i_02 '2004.08.01','2004.08.27'
*/

Create Procedure sp_mpm132i_02
  @ps_fromdt char(10),
  @ps_todt char(10)
As
Begin

--get StdTime, MatCost, SubMatCost by Group by Orderno, PartNo
select OrderDept = tmp.OrderDept,
    DeptGubun = tmp.DeptGubun,
    OrderNo = tmp.OrderNo,
    PartNo = tmp.PartNo,
    StdTime = Sum(tmp.StdTime),
    JobTime = Sum(tmp.JobTime),
    OutCost = Sum(tmp.OutCost),
    MatCost = Sum(tmp.MatCost),
    ManCost = Sum(tmp.ManCost),
    MchCost = Sum(tmp.MchCost),
    SumCost = Sum(tmp.SumCost),
    TotCost = Sum(convert(decimal(10,0), (tmp.SumCost * 1.2) + tmp.OutCost))
into #sum_tmp
from
( select OrderDept = aa.OrderDept,
    DeptGubun = aa.DeptGubun,
    OrderNo = aa.OrderNo,
    PartNo = bb.PartNo,
    StdTime = Sum(convert(decimal(6,1),isnull(bb.StdTime * (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)),0) / 60 )),
    JobTime = Sum(0),
    OutCost = Sum(0),
    MatCost = Sum(0),
    ManCost = Sum(0),
    MchCost = Sum(0),
    SumCost = Sum(0)
  from torder aa inner join trouting bb
    on aa.orderno = bb.orderno
    inner join tpartlist cc
    on bb.orderno = cc.orderno and bb.partno = cc.partno
  where convert(char(10),aa.startdate,102) <= @ps_todt and
        aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
        convert(char(10),aa.enddate,102) <= @ps_todt
  group by aa.OrderDept, aa.DeptGubun, aa.OrderNo, bb.PartNo

  union all

  select OrderDept = aa.OrderDept,
    DeptGubun = aa.DeptGubun,
    OrderNo = aa.OrderNo,
    PartNo = bb.PartNo,
    StdTime = Sum(0),
    JobTime = Sum(isnull(bb.JobHour,0)),
    OutCost = Sum(case when (aa.OrderNo >= '20070000') then isnull(bb.OutCost,0) else 0 end),
    MatCost = Sum(case when (aa.OrderNo >= '20070000') then isnull(bb.MatCost,0) + isnull(bb.HeatCost,0)
                    else isnull(bb.MatCost,0) + isnull(bb.HeatCost,0) + isnull(bb.OutCost,0) end),
    ManCost = Sum(isnull(bb.ManCost,0)),
    MchCost = Sum(isnull(bb.MchCost,0)),
    SumCost = Sum(case when (aa.OrderNo >= '20070000') then isnull(bb.MatCost,0) + isnull(bb.HeatCost,0) + isnull(bb.ManCost,0) + isnull(bb.MchCost,0)
                    else isnull(bb.MatCost,0) + isnull(bb.HeatCost,0) + isnull(bb.OutCost,0) + isnull(bb.ManCost,0) + isnull(bb.MchCost,0) end)
  from torder aa left outer join tmatcost bb
    on aa.orderno = bb.orderno and
      bb.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
  where convert(char(10),aa.startdate,102) <= @ps_todt and
        aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
        convert(char(10),aa.enddate,102) <= @ps_todt
  group by aa.OrderDept, aa.DeptGubun, aa.OrderNo, bb.PartNo

  union all

  select OrderDept = aa.OrderDept,
    DeptGubun = '1',
    OrderNo = '00000000',
    PartNo = '000000',
    StdTime = Sum(0),
    JobTime = Sum(0),
    OutCost = Sum(0),
    MatCost = Sum(isnull(aa.SubMatCost,0)),
    ManCost = Sum(0),
    MchCost = Sum(0),
    SumCost = Sum(isnull(aa.SubMatCost,0))
  from tsubmatcost aa
  where aa.yearmm >= convert(char(6),convert(datetime,@ps_fromdt),112) and
    aa.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
  group by aa.OrderDept

) tmp
group by tmp.orderdept, tmp.deptgubun, tmp.orderno, tmp.partno

select fromdt = @ps_fromdt,
  todt = @ps_todt,
  ToolName = aa.ToolName,
  OrderDept = cc.OrderDept,
  DeptName = dd.DeptName,
  ProductName = case cc.OrderNo when '00000000' then '소모성재료비'
                  else aa.ProductName end,
  OrderNo = cc.OrderNo,
  StartDate = Convert(char(10), aa.StartDate, 102),
  EndDate = Convert(char(10), aa.EndDate, 102),
  DueDate = Convert(char(10), aa.DueDate, 102),
  PartNo = cc.PartNo,
  PartName = bb.PartName,
  Material = bb.Material,
  Qty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  StdTime = cc.StdTime,
  JobTime = cc.JobTime,
  OutCost = cc.OutCost,
  MatCost = cc.MatCost,
  ManCost = cc.ManCost,
  MchCost = cc.MchCost,
  SumCost = cc.SumCost,
  TotCost = cc.TotCost,
  AccessCost = aa.AccessCost,
  Remark = aa.Remark
from torder aa inner join tpartlist bb
  on aa.orderno = bb.orderno
  right outer join #sum_tmp cc
  on cc.orderno = bb.orderno and cc.partno = bb.partno
  inner join tmstdept dd
  on cc.orderdept = dd.deptcode
where cc.deptgubun = '1'

union all

select fromdt = @ps_fromdt,
  todt = @ps_todt,
  ToolName = aa.ToolName,
  OrderDept = cc.OrderDept,
  DeptName = dd.CustName,
  ProductName = aa.ProductName,
  OrderNo = cc.OrderNo,
  StartDate = Convert(char(10), aa.StartDate, 102),
  EndDate = Convert(char(10), aa.EndDate, 102),
  DueDate = Convert(char(10), aa.DueDate, 102),
  PartNo = cc.PartNo,
  PartName = bb.PartName,
  Material = bb.Material,
  Qty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  StdTime = cc.StdTime,
  JobTime = cc.JobTime,
  OutCost = cc.OutCost,
  MatCost = cc.MatCost,
  ManCost = cc.ManCost,
  MchCost = cc.MchCost,
  SumCost = cc.SumCost,
  TotCost = cc.TotCost,
  AccessCost = aa.AccessCost,
  Remark = aa.Remark
from torder aa inner join tpartlist bb
  on aa.orderno = bb.orderno
  right outer join #sum_tmp cc
  on cc.orderno = bb.orderno and cc.partno = bb.partno
  inner join tcustomer dd
  on cc.orderdept = dd.custcode
where cc.deptgubun = '2'

drop table #sum_tmp

Return

End   -- Procedure End
Go
