/*
  File Name : sp_mpsg050u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg050u_01
  Description : (정상작업지시서) 처리해야할 공정순서 가져오기
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_ptype char(1),
              @ps_orderno char(8),
              @ps_partno char(6),
              @ps_wccode char(3)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg050u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg050u_01]
GO

/*
Execute sp_mpsg050u_01
  @ps_ptype     = 'A',
  @ps_orderno   = '20040105',
  @ps_partno    = '019000',
  @ps_wccode    = 'TWC'
*/

Create Procedure sp_mpsg050u_01
  @ps_ptype char(1),
  @ps_orderno char(8),
  @ps_partno char(6),
  @ps_wccode char(3)

As
Begin

/*########################################################################################

처리할 공정정보 정보

Stype = 'XX' : 데이타를 입력하기 위한 허수값임.
########################################################################################*/

If @ps_ptype = 'C'
  Select Stype = null,
    Srno = null,
    OrderNo = aa.OrderNo,
    PartNo = aa.PartNo,
    OperNo = null,
    WcCode = null,
    WorkDate = convert(varchar(10),getdate(),102),
    WorkEmp = null,
    MchNo = null,
    HeatCost = null,
    OutCost = 0,
    ScrapQty = 0,
    FinalQty = isnull(aa.Qty1,0) + isnull(aa.Qty2,0),
    JobTime = 0,
    MchTime1 = 0,
    MchTime2 = 0,
    MchTime3 = 0,
    ResultFlag = 'A',
    ProcessRatio = 0,
    BadStype = '',
    BadSrno = '',
    LastEmp = '',
    WorkMatter = '',
    Ptype = @ps_ptype
  From tpartlist aa
  Where aa.OrderNo = @ps_orderno and aa.PartNo = @ps_partno
Else
  Select Top 1 Stype = cc.Stype,
    Srno = cc.Srno,
    OrderNo = bb.OrderNo,
    PartNo = bb.PartNo,
    OperNo = bb.OperNo,
    WcCode = bb.WcCode,
    WorkDate = convert(varchar(10),getdate(),102),
    WorkEmp = cc.WorkEmp,
    MchNo = cc.MchNo,
    HeatCost = case bb.WcCode when 'THT' then bb.StdHeatCost else 0 end,
    OutCost = 0,
    ScrapQty = 0,
    FinalQty = isnull(aa.Qty1,0) + isnull(aa.Qty2,0),
    JobTime = isnull(cc.JobTime,0),
    MchTime1 = 0,
    MchTime2 = 0,
    MchTime3 = 0,
    ResultFlag = 'A',
    ProcessRatio = 0,
    BadStype = cc.BadStype,
    BadSrno = cc.BadSrno,
    LastEmp = cc.LastEmp,
    WorkMatter = bb.WorkMatter,
    Ptype = @ps_ptype
  From tpartlist aa inner join trouting bb
    on aa.orderno = bb.orderno and aa.partno = bb.partno
    left outer join tworkjob cc
    on bb.operno = cc.operno and bb.orderno = cc.orderno and
      bb.partno = cc.partno and cc.Stype = 'XX'
  Where aa.OrderNo = @ps_orderno and aa.PartNo = @ps_partno and
      bb.WcCode = @ps_wccode and bb.WorkStatus <> 'C'
  Order by bb.OperNo

End   -- Procedure End
Go
