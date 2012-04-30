/*
  File Name : sp_mpm133i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm133i_01
  Description : 월별 부서별 M/H 현황
  적용년월을 기준으로 하여 당월진행, 당월완료, 전월진행, 당월실투입시간을 계산
  계산공식 : 당월진행(기말 curingtime) = 전월진행(기초 posingtime) + 당월실투입시간(투입 curjobtime) - 당월완료(사용 endjobtime)
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_yyyymm char(6)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm133i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm133i_01]
GO

/*
Execute sp_mpm133i_01 '200404'
*/

Create Procedure sp_mpm133i_01
  @ps_yyyymm char(6)
As
Begin

--get CurIngTime, CurEndTime, PosIngTime by Group by OrderDept, DeptGubun
select OrderDept = tmp.OrderDept,
    DeptGubun = tmp.DeptGubun, 
    CurIngTime = Sum(tmp.CurIngTime),
    CurEndTime = Sum(tmp.CurEndTime),
    PosIngTime = Sum(tmp.PosIngTime)
into #sum_tmp
from 
( select OrderNo = aa.OrderNo,
    OrderDept = aa.OrderDept,
    DeptGubun = aa.DeptGubun,
    PartNo = bb.PartNo,
    CurIngTime = Sum(isnull(bb.JobHour,0)),
    CurEndTime = Sum(0),
    PosIngTime = Sum(0)
  from torder aa inner join tmatcost bb
    on aa.orderno = bb.orderno and bb.yearmm <= @ps_yyyymm
  where convert(char(6),aa.startdate,112) <= @ps_yyyymm and
    (aa.enddate is null or convert(char(6),aa.enddate,112) > @ps_yyyymm)
  group by aa.OrderNo, aa.OrderDept, aa.DeptGubun, bb.PartNo
  
  union all
  
  select OrderNo = aa.OrderNo,
    OrderDept = aa.OrderDept,
    DeptGubun = aa.DeptGubun,
    PartNo = bb.PartNo,
    CurIngTime = Sum(0),
    CurEndTime = Sum(isnull(bb.JobHour,0)),
    PosIngTime = Sum(0)
  from torder aa inner join tmatcost bb
    on aa.orderno = bb.orderno and bb.yearmm <= @ps_yyyymm
  where convert(char(6),aa.startdate,112) <= @ps_yyyymm and
    (aa.enddate is not null and convert(char(6),aa.enddate,112) = @ps_yyyymm)
  group by aa.OrderNo, aa.OrderDept, aa.DeptGubun, bb.PartNo
  
  union all
  
  select OrderNo = aa.OrderNo,
    OrderDept = aa.OrderDept,
    DeptGubun = aa.DeptGubun,
    PartNo = bb.PartNo,
    CurIngTime = Sum(0),
    CurEndTime = Sum(0),
    PosIngTime = Sum(isnull(bb.JobHour,0))
  from torder aa inner join tmatcost bb
    on aa.orderno = bb.orderno and bb.yearmm < @ps_yyyymm
  where convert(char(6),aa.startdate,112) < @ps_yyyymm and
    ( (aa.enddate is null) or
    (aa.enddate is not null and convert(char(6),aa.enddate,112) >= @ps_yyyymm) )
  group by aa.OrderNo, aa.OrderDept, aa.DeptGubun, bb.PartNo

) tmp
group by tmp.orderdept, tmp.deptgubun

select yyyymm = @ps_yyyymm,
  OrderDept = aa.OrderDept,
  DeptName = bb.DeptName,
  CurIngTime = aa.CurIngTime,
  CurEndTime = aa.CurEndTime,
  PosIngTime = aa.PosIngTime,
  CurJobTime = (aa.CurIngTime + aa.CurEndTime - aa.PosIngTime)
from #sum_tmp aa inner join tmstdept bb
  on aa.orderdept = bb.deptcode and aa.deptgubun = '1'

union all

select yyyymm = @ps_yyyymm,
  OrderDept = aa.OrderDept,
  DeptName = bb.CustName,
  CurIngTime = aa.CurIngTime,
  CurEndTime = aa.CurEndTime,
  PosIngTime = aa.PosIngTime,
  CurJobTime = (aa.CurIngTime + aa.CurEndTime - aa.PosIngTime)
from #sum_tmp aa inner join tcustomer bb
  on aa.orderdept = bb.custcode and aa.deptgubun = '2'
 
drop table #sum_tmp

Return

End   -- Procedure End
Go
