/*
  File Name : sp_mpsg060u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg060u_01
  Description : 실적데이타 조회 - 실적수정용
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_stype  char(2),
              @ps_srno char(10),
              @ps_wccode char(3)
  Use Table :
  Initial   : 2006.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg060u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg060u_01]
GO

/*
Execute sp_mpsg060u_01
  @ps_stype      = 'WC',
  @ps_srno       = '0000214526',
  @ps_wccode    = 'TWC'
*/

Create Procedure sp_mpsg060u_01
  @ps_stype  char(2),
  @ps_srno char(10),
  @ps_wccode char(3)

As
Begin

/*########################################################################################

등록된 실적 정보

########################################################################################*/

Select Stype = cc.Stype,
    Srno = cc.Srno,
    OrderNo = cc.OrderNo,
    PartNo = cc.PartNo,
    OperNo = cc.OperNo,
    WcCode = cc.WcCode,
    WorkDate = convert(varchar(10),cast(cc.workdate as datetime),102),
    WorkEmp = cc.WorkEmp,
    MchNo = cc.MchNo,
    HeatCost = cc.HeatCost,
    OutCost = cc.OutCost,
    ScrapQty = cc.ScrapQty,
    FinalQty = cc.FinalQty,
    JobTime = isnull(cc.JobTime,0),
    MchTime1 = cc.MchTime1,
    MchTime2 = cc.MchTime2,
    MchTime3 = cc.MchTime3,
    ResultFlag = cc.ResultFlag,
    ProcessRatio = ( Select Sum(ProcessRatio) From Tworkjob
                    Where Operno = cc.operno and partno = cc.partno and operno = cc.operno ),
    BadStype = cc.BadStype,
    BadSrno = cc.BadSrno,
    LastEmp = cc.LastEmp
From tworkjob cc
Where cc.Stype = @ps_stype and cc.Srno = @ps_srno and cc.wccode = @ps_wccode

End   -- Procedure End
Go
