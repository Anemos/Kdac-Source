/*
  File Name : sp_mpm130u_calc.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm130u_calc
  Description : 재료비 분배
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(8)
              @ps_todt char(8),
              @ps_empno char(8)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm130u_calc]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm130u_calc]
GO

/*
Execute sp_mpm130u_calc '20040401','20040430','000030'
*/

Create Procedure sp_mpm130u_calc
  @ps_fromdt char(8),
  @ps_todt char(8),
  @ps_empno char(6)
As
Begin

declare @ls_yyyymm char(6)
declare @lc_laborcost numeric(8,0)

select @ls_yyyymm = substring(@ps_fromdt,1,6)
select @lc_laborcost = laborcost from tmonthjob
where yearmm = @ls_yyyymm

--calculate apply yyymm
select OrderNo = aa.OrderNo,
  PartNo = aa.PartNo,
  OutCost = Sum(Case aa.MatCls
              When 'P' then aa.tramt
              else 0 end),
  MatCost = Sum(Case aa.MatCls
              When 'M' then aa.tramt
              When 'T' then aa.tramt
              else 0 end)
into #cost_tmp
from titemstore aa inner join tpartlist bb
  on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo
where aa.tdte4 >= @ps_fromdt and aa.tdte4 <= @ps_todt
group by aa.OrderNo, aa.PartNo

select OrderNo = dd.OrderNo,
  PartNo = dd.PartNo,
  HeatCost = Sum(isnull(bb.HeatCost,0)),
  JobHour = Sum(convert(decimal(6,1),isnull(bb.JobTime,0) / 60)),
  ManCost = Sum(convert(decimal(10,0),isnull(bb.JobTime,0) * @lc_laborcost / 60)),
  MchCost = Sum(convert(decimal(10,0),isnull(bb.JobTime,0) * isnull(cc.hourcost,0) / 60))
into #job_cost
from torder aa inner join tpartlist dd
  on aa.orderno = dd.orderno
  left outer join tworkjob bb
  on dd.orderno = bb.orderno and dd.partno = bb.partno and
    bb.WorkDate >= @ps_fromdt and bb.WorkDate <= @ps_todt
  left outer join tmachine cc
  on cc.wccode = bb.wccode and cc.mchno = bb.mchno
where convert(char(6),aa.startdate,112) <= @ls_yyyymm and
  ( aa.enddate is null or convert(char(6),aa.enddate,112) >= @ls_yyyymm )
group by dd.Orderno, dd.PartNo

delete tmatcost
where YearMm = @ls_yyyymm

insert into tmatcost
( YearMm, OrderNo, PartNo, JobHour, HeatCost, OutCost, MatCost,
  ManCost, MchCost, LastEmp, LastDate )
select @ls_yyyymm, aa.OrderNo, aa.PartNo, aa.JobHour, aa.HeatCost,
  isnull(bb.OutCost,0), isnull(bb.MatCost,0), aa.ManCost, aa.MchCost,
  @ps_empno, getdate()
from #job_cost aa left outer join #cost_tmp bb
  on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo

drop table #cost_tmp
drop table #job_cost

return
End   -- Procedure End
Go
