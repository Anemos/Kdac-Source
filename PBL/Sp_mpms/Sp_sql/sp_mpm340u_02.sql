/*
  File Name : sp_mpm340u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm340u_02
  Description : 개인별작업현황 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_workgubun char(1), @ps_workdate char(10)
  Use Table :
  Initial   : 2006.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm340u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm340u_02]
GO

/*
Execute sp_mpm340u_02
  @ps_workgubun   = 'A',
  @ps_workdate   = '2006.05.10'
*/

Create Procedure sp_mpm340u_02
  @ps_workgubun char(4),    /* 조구분 */
  @ps_workdate char(10)    /* 적용일 */


As
Begin

/*########################################################################################
tworkjob 에서 작업실적을 조회한다.
########################################################################################*/

SELECT WorkEmp = cc.WorkEmp,
  OrderNo = cc.OrderNo,
  PartNo = cc.PartNo,
  OperNo = cc.OperNo,
  WcCode = cc.WcCode,
  PartName = bb.PartName,
  FinalQty = cc.FinalQty,
  JobTime = cc.JobTime,
  ProcessRatio = cc.ProcessRatio,
  ToolName = aa.ToolName
FROM TORDER aa INNER JOIN TPARTLIST bb
  ON aa.OrderNo = bb.OrderNo
  INNER JOIN TWORKJOB cc
  ON bb.OrderNo = cc.OrderNo AND bb.PartNo = cc.PartNo
  INNER JOIN TWORKCENTER dd
  ON cc.wccode = dd.wccode AND dd.wcgubun = @ps_workgubun
WHERE cc.WorkDate = Convert(char(8),cast(@ps_workdate as datetime),112)
ORDER BY cc.OrderNo, cc.PartNo, cc.OperNo

End   -- Procedure End
Go
