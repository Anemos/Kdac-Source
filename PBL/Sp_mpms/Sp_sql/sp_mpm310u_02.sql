/*
	File Name	: sp_mpm310u_02.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm310u_02
	Description	: 공정작업 지시사항
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_partno char(6), @ps_operno char(3) 
	Use Table	: trouting
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm310u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm310u_02]
GO

/*
Execute sp_mpm310u_02 '@ps_orderno','@ps_partno','@ps_operno'
*/

Create Procedure sp_mpm310u_02
  @ps_orderno char(8),
  @ps_partno  char(6),
  @ps_operno  char(3)

As
Begin

Select PartNo = A.PartNo,
    PartName = B.PartName,
    PlanQty = isnull(B.Qty1,0) + isnull(B.Qty2,0),
    WorkMatter = A.WorkMatter,
    StdTime = (A.StdTime * (isnull(B.Qty1,0) + isnull(B.Qty2,0))),
    OutFlag = A.OutFlag,
    Material = B.Material,
    WorkStart = A.WorkStart,
    WorkStatus = A.WorkStatus
From	trouting  A, tpartlist B
Where	A.OrderNo = B.OrderNo and A.PartNo = B.PartNo and
      A.Orderno = @ps_orderno and 
      A.PartNo = @ps_partno and A.OperNo = @ps_operno

Return

End		-- Procedure End

Go
