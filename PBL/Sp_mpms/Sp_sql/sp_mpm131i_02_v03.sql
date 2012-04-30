/*
  File Name : sp_mpm131i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm131i_02
  Description : Order�� �۾��Ϸ� ����ǥ(�Ϸ�)
  �������� �Ϸ�� Order�� ���� �� ������ ������.( �Ϸ��ϱ������� �����Ϻ��� �Ϸ��ϱ��� )
  2006.12 => ���ְ����� ���񿡼� ���� �и� ( OrderNo 20070000 ���� ). 
    ������ : �ѿ��� = ��������( ���� + ���ְ����� + �ΰǺ� + ������� ) * 1.2
    ������ : �ѿ��� = ��������( ���� + �ΰǺ� + ������� ) * 1.2 + ���ְ�����
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
    outcost = sum(tmp.outcost),
    matcost = sum(tmp.matcost + tmp.outcost),
    mancost = sum(tmp.mancost),
    mchcost = sum(tmp.mchcost),
    sumcost = sum(tmp.sumcost + tmp.outcost),
    totcost = sum(convert(decimal(10,0), (tmp.sumcost * 1.2) + tmp.outcost)),
    outcost1 = sum(tmp.outcost1),
    matcost1 = sum(tmp.matcost1 + tmp.outcost1),
    mancost1 = sum(tmp.mancost1),
    mchcost1 = sum(tmp.mchcost1),
    sumcost1 = sum(tmp.sumcost1 + tmp.outcost1),
    totcost1 = sum(convert(decimal(10,0), (tmp.sumcost1 * 1.2) + tmp.outcost1))
  from ( select bb.deptname as deptname, aa.orderdept as orderdept, cc.orderno, cc.partno,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.OutCost,0) else 0 end) as outcost,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0) end) as matcost,
      sum(isnull(cc.ManCost,0)) as mancost,
      sum(isnull(cc.MchCost,0)) as mchcost,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0) 
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0) end) as sumcost,
      sum(0) as outcost1,
      sum(0) as matcost1,
      sum(0) as mancost1,
      sum(0) as mchcost1,
      sum(0) as sumcost1
      from torder aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '1' and aa.assetflag = 'E'
      group by bb.deptname, aa.orderdept, cc.orderno, cc.partno

      union all
      -- �Ҹ𼺿������ ( ��뼺 )
      select bb.deptname as deptname, aa.orderdept as orderdept, '00000000', '000000',
      sum(0) as outcost,
      sum(isnull(aa.SubMatCost,0)) as matcost,
      sum(0) as mancost,
      sum(0) as mchcost,
      sum(isnull(aa.SubMatCost,0)) as sumcost,
      sum(0) as outcost1,
      sum(0) as matcost1,
      sum(0) as mancost1,
      sum(0) as mchcost1,
      sum(0) as sumcost1
      from tsubmatcost aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
      where aa.yearmm >= convert(char(6),convert(datetime,@ps_fromdt),112) and
          aa.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      group by bb.deptname, aa.orderdept

      union all

      select bb.deptname as deptname, aa.orderdept as orderdept, cc.orderno, cc.partno,
      sum(0) as outcost,
      sum(0) as matcost,
      sum(0) as mancost,
      sum(0) as mchcost,
      sum(0) as sumcost,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.OutCost,0) else 0 end) as outcost1,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0) end) as matcost1,
      sum(isnull(cc.ManCost,0)) as mancost1,
      sum(isnull(cc.MchCost,0)) as mchcost1,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0) end) as sumcost1
      from torder aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '1' and aa.assetflag = 'A'
      group by bb.deptname, aa.orderdept, cc.orderno, cc.partno

      union all

      select bb.custname as deptname, aa.orderdept as orderdept, cc.orderno, cc.partno,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.OutCost,0) else 0 end) as outcost,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0) end) as matcost,
      sum(isnull(cc.ManCost,0)) as mancost,
      sum(isnull(cc.MchCost,0)) as mchcost,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0) end) as sumcost,
      sum(0) as outcost1,
      sum(0) as matcost1,
      sum(0) as mancost1,
      sum(0) as mchcost1,
      sum(0) as sumcost1
      from torder aa left outer join tcustomer bb
        on aa.orderdept = bb.custcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '2' and aa.assetflag = 'E'
      group by bb.custname, aa.orderdept, cc.orderno, cc.partno

      union all

      select bb.custname as deptname, aa.orderdept as orderdept, cc.orderno, cc.partno,
      sum(0) as outcost,
      sum(0) as matcost,
      sum(0) as mancost,
      sum(0) as mchcost,
      sum(0) as sumcost,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.OutCost,0) else 0 end) as outcost1,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0) end) as matcost1,
      sum(isnull(cc.ManCost,0)) as mancost1,
      sum(isnull(cc.MchCost,0)) as mchcost1,
      sum(case when (aa.OrderNo >= '20070000') then isnull(cc.HeatCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0)
            else isnull(cc.HeatCost,0) + isnull(cc.OutCost,0) + isnull(cc.MatCost,0)
              + isnull(cc.ManCost,0) + isnull(cc.MchCost,0) end) as sumcost1
      from torder aa left outer join tcustomer bb
        on aa.orderdept = bb.custcode
        left outer join tmatcost cc
        on aa.orderno = cc.orderno and
          cc.yearmm <= convert(char(6),convert(datetime,@ps_todt),112)
      where convert(char(10),aa.startdate,102) <= @ps_todt and
        ( aa.enddate is not null and convert(char(10),aa.enddate,102) >= @ps_fromdt and
          convert(char(10),aa.enddate,102) <= @ps_todt ) and
        aa.deptgubun = '2' and aa.assetflag = 'A'
      group by bb.custname, aa.orderdept, cc.orderno, cc.partno
      ) tmp
    group by tmp.deptname, tmp.orderdept
End

Return

End   -- Procedure End
Go
