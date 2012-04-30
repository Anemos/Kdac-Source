/*
  File Name : sp_mpsg050u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg050u_02
  Description : (재작업지시서) 처리해야할 공정순서 가져오기
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_ptype char(10),
              @ps_stype  char(2),
              @ps_srno   char(10),
              @ps_wccode char(3)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg050u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg050u_02]
GO

/*
Execute sp_mpsg050u_02
  @ps_ptype   = 'B',
  @ps_stype   = 'WC',
  @ps_srno    = '0000000000',
  @ps_wccode    = 'TWC'
*/

Create Procedure sp_mpsg050u_02
  @ps_ptype  char(1),
  @ps_stype  char(2),
  @ps_srno   char(10),
  @ps_wccode char(3)

As
Begin

/*########################################################################################

처리할 공정정보 정보

Stype = 'XX' : 데이타를 입력하기 위한 허수값임.
########################################################################################*/

Select Top 1 Stype = cc.Stype,
    Srno = cc.Srno,
    OrderNo = dd.OrderNo,
    PartNo = dd.PartNo,
    OperNo = dd.ReOperNo,
    WcCode = dd.WcCode,
    WorkDate = convert(varchar(10),getdate(),102),
    WorkEmp = cc.WorkEmp,
    MchNo = cc.MchNo,
    HeatCost = case bb.WcCode when 'THT' then bb.StdHeatCost else 0 end,
    OutCost = 0,
    ScrapQty = 0,
    FinalQty = isnull(ee.scrapqty,0),
    JobTime = isnull(cc.JobTime,0),
    MchTime1 = 0,
    MchTime2 = 0,
    MchTime3 = 0,
    ResultFlag = 'A',
    ProcessRatio = 0,
    LastEmp = cc.LastEmp,
    WorkMatter = bb.WorkMatter,
    Ptype = @ps_ptype
From tpartlist aa inner join trouting bb
  on aa.orderno = bb.orderno and aa.partno = bb.partno
  inner join tbaddetail dd
  on bb.orderno = dd.orderno and bb.partno = dd.partno and
    bb.operno = dd.reoperno
  inner join tbadhead ee
  on dd.stype = ee.stype and dd.srno = ee.srno
  left outer join tworkjob cc
  on bb.operno = cc.operno and bb.orderno = cc.orderno and
    bb.partno = cc.partno and cc.Stype = 'XX'
Where dd.Stype = @ps_stype and dd.srno = @ps_srno and
      bb.WcCode = @ps_wccode and dd.WorkStatus <> 'C'
Order by dd.ReOperNo

End   -- Procedure End
Go
