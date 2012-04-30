/*
  File Name : sp_mpm131i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm131i_02
  Description : Order별 작업완료 집계표(완료)
  적용년월에 완료된 Order에 대한 총 누적을 보여줌.( 완료일기준으로 시작일부터 완료일까지 )
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(10), @ps_todt char(10)
  Use Table :
  Initial   : 2004.10
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm131i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm131i_02]
GO

/*
Execute sp_mpm131i_02 '2004.08.01','2004.08.27'
*/

Create Procedure sp_mpm131i_02
  @ps_fromdt char(10),
  @ps_todt char(10)
As
Begin

Begin
  select fromdt = @ps_fromdt,
    todt = @ps_todt,
    deptname = tmp.deptname,
    orderdept = tmp.orderdept,
    matcost = sum(tmp.matcost),
    mancost = sum(tmp.mancost),
    mchcost = sum(tmp.mchcost),
    sumcost = sum(tmp.sumcost),
    totocost = sum(tmp.totcost),
    matcost1 = sum(tmp.matcost1),
    mancost1 = sum(tmp.mancost1),
    mchcost1 = sum(tmp.mchcost1),
    sumcost1 = sum(tmp.sumcost1),
    totcost1 = sum(convert(decimal(10,0),tmp.totcost1))
  from ( select bb.deptname as deptname, aa.orderdept as orderdept,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0)
        + isnull(cc.MatCost,0)) as matcost,
      sum(isnull(cc.ManCost,0)) as mancost,
      sum(isnull(cc.MchCost,0)) as mchcost,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) as sumcost,
      sum(convert(decimal(10,0),(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) * 1.2)) as totcost,
      sum(0) as matcost1,
      sum(0) as mancost1,
      sum(0) as mchcost1,
      sum(0) as sumcost1,
      sum(0) as totcost1
      from torder aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '1' and aa.assetflag = 'E'
      group by bb.deptname, aa.orderdept

      union all
      -- 소모성원자재비 ( 비용성 )
      select bb.deptname as deptname, aa.orderdept as orderdept,
      sum(isnull(aa.SubMatCost,0)) as matcost,
      sum(0) as mancost,
      sum(0) as mchcost,
      sum(isnull(aa.SubMatCost,0)) as sumcost,
      sum(convert(decimal(10,0),isnull(aa.SubMatCost,0) * 1.2)) as totcost,
      sum(0) as matcost1,
      sum(0) as mancost1,
      sum(0) as mchcost1,
      sum(0) as sumcost1,
      sum(0) as totcost1
      from tsubmatcost aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
      where aa.yearmm >= convert(char(6),convert(datetime,@ps_fromdt),112) and
          aa.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      group by bb.deptname, aa.orderdept

      union all

      select bb.deptname as deptname,
      aa.orderdept as orderdept,
      sum(0) as matcost,
      sum(0) as mancost,
      sum(0) as mchcost,
      sum(0) as sumcost,
      sum(0) as totcost,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0)
        + isnull(cc.MatCost,0)) as matcost1,
      sum(isnull(cc.ManCost,0)) as mancost1,
      sum(isnull(cc.MchCost,0)) as mchcost1,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) as sumcost1,
      sum(convert(decimal(10,0),(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) * 1.2)) as totcost1
      from torder aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '1' and aa.assetflag = 'A'
      group by bb.deptname, aa.orderdept

      union all

      select bb.custname as deptname,
      aa.orderdept as orderdept,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0)
        + isnull(cc.MatCost,0)) as matcost,
      sum(isnull(cc.ManCost,0)) as mancost,
      sum(isnull(cc.MchCost,0)) as mchcost,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) as sumcost,
      sum(convert(decimal(10,0),(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) * 1.2)) as totcost,
      sum(0) as matcost1,
      sum(0) as mancost1,
      sum(0) as mchcost1,
      sum(0) as sumcost1,
      sum(0) as totcost1
      from torder aa left outer join tcustomer bb
        on aa.orderdept = bb.custcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '2' and aa.assetflag = 'E'
      group by bb.custname, aa.orderdept

      union all

      select bb.custname as deptname,
      aa.orderdept as orderdept,
      sum(0) as matcost,
      sum(0) as mancost,
      sum(0) as mchcost,
      sum(0) as sumcost,
      sum(0) as totcost,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0)
        + isnull(cc.MatCost,0)) as matcost1,
      sum(isnull(cc.ManCost,0)) as mancost1,
      sum(isnull(cc.MchCost,0)) as mchcost1,
      sum(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) as sumcost1,
      sum(convert(decimal(10,0),(isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
        + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)) * 1.2)) as totcost1
      from torder aa left outer join tcustomer bb
        on aa.orderdept = bb.custcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '2' and aa.assetflag = 'A'
      group by bb.custname, aa.orderdept
      ) tmp
    group by tmp.deptname, tmp.orderdept
End

Return

End   -- Procedure End
Go
