/*
	File Name	: sp_mpm220u_02.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm220u_02
	Description	: 공정순서 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_partno char(6) 
	Use Table	: trouting
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm220u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm220u_02]
GO

/*
Execute sp_mpm220u_02 
*/

Create Procedure sp_mpm220u_02
  @ps_orderno char(8),
  @ps_partno  char(6)

As
Begin

select OperNo = aa.OperNo,
      OrderNo = aa.OrderNo,
      PlanQty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
      PartNo  = aa.PartNo,
      WcCode  = aa.WcCode,
      OutFlag = aa.OutFlag,
      WorkStart = aa.WorkStart,
      StdTime = aa.StdTime,
      StdHeatCost = aa.StdHeatCost,
      StdOutCost = aa.StdOutCost,
      WorkMatter = aa.WorkMatter,
      WorkStatus = aa.WorkStatus,
      ResultFlag = aa.ResultFlag,
      LastEmp = aa.LastEmp,
      LastDate = aa.LastDate
from trouting aa inner join tpartlist bb
    on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo
where aa.OrderNo = @ps_orderno and aa.PartNo = @ps_partno
order by aa.OperNo asc

Return

End		-- Procedure End

Go
