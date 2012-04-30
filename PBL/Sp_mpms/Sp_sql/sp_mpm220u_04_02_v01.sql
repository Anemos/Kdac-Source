/*
	File Name	: sp_mpm220u_04_02.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm220u_04_02
	Description	: 작업지시전표 출력(일괄) - Bottom 50 Percent
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_wccode varchar(4)
	Use Table	: trouting
	Initial		: 2004.08.16
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm220u_04_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm220u_04_02]
GO

/*
Execute sp_mpm220u_04_02 '@ps_orderno','@ps_wccode'
*/

Create Procedure sp_mpm220u_04_02
  @ps_orderno char(8),
  @ps_wccode varchar(4)

As
Begin

Select PrintDate = Convert(char(10),getdate(),102),
  OrderNo = aa.OrderNo,
  PartNo = bb.PartNo,
  PartName = bb.PartName,
  PlanQty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  Material = bb.Material,
  OperNo = cc.OperNo,
  WcCode = cc.WcCode,
  PostWcCode = ( Select Top 1 wccode from trouting
    where OrderNo = @ps_orderno and PartNo = bb.PartNo and
      OperNo > cc.OperNo
    order by OperNo ),
  StdTime = cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),
  WorkMatter = cc.WorkMatter,
  WorkStart = Convert(char(10),cc.WorkStart,102),
  WorkEmp = ' ',
  WorkEmpName = ' ',
  MchNo = ' ',
  WorkDate = ' ',
  BeginTime = ' ',
  EndTime = ' ',
  FinalQty = 0,
  ScrapQty = 0,
  JobTime = 0
From torder aa inner join tpartlist bb
  on aa.OrderNo = bb.OrderNo
  inner join trouting cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo 
Where cc.OrderNo = @ps_orderno and cc.WcCode like @ps_wccode and
      cc.WcCode <> 'THT' and cc.OutFlag <> 'P' and
      cast(bb.serialno as varchar(10)) + cc.PartNo + cc.Operno not in ( Select TOP 50 PERCENT cast(ee.serialno as varchar(10)) + dd.PartNo + dd.Operno
									From trouting dd inner join tpartlist ee
									  on dd.orderno = ee.orderno and dd.partno = ee.partno
									Where dd.OrderNo = @ps_orderno and dd.WcCode like @ps_wccode and
									      dd.WcCode <> 'THT' and dd.OutFlag <> 'P'
									order by dd.orderno, ee.serialno, dd.partno, dd.operno)
order by cc.orderno, bb.serialno, cc.partno, cc.operno

Return

End		-- Procedure End

Go
