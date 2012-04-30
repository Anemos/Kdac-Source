/*
	File Name	: sp_mpm320u_03.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm320u_03
	Description	: 재작업지시서 출력
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_stype char(2), @ps_srno char(10)
	Use Table	: tbadhead
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm320u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm320u_03]
GO

/*
Execute sp_mpm320u_03 '@ps_stype','@ps_srno'
*/

Create Procedure sp_mpm320u_03
  @ps_stype char(2),
  @ps_srno  char(10)

As
Begin

Select PrintDate = Convert(char(10),getdate(),102),
  OrderNo = aa.OrderNo,
  BadOperNo = cc.BadOperNo,
  BadReason = cc.BadReason,
  BadWcCode = cc.WcCode,
  PartNo = bb.PartNo,
  PartName = bb.PartName,
  PlanQty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  BadQty = cc.ScrapQty,
  ToolName = aa.ToolName,
  Material = bb.Material,
  OperNo = dd.ReOperNo,
  WcCode = dd.WcCode,
  WorkDate = ' ',
  WorkEmp = ' ',
  MchNo = ' ',
  JobTime = ' ',
  JobMemo = ' ',
  Stype = @ps_stype,
  Srno = @ps_srno
From torder aa inner join tpartlist bb
  on aa.OrderNo = bb.OrderNo
  inner join tbadhead cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo
  inner join tbaddetail dd
  on cc.OrderNo = dd.Orderno and cc.PartNo = dd.PartNo and
    cc.BadOperNo = dd.BadOperNo and cc.BadDate = dd.BadDate
Where cc.Stype = @ps_stype and cc.Srno = @ps_srno

Return

End		-- Procedure End

Go
