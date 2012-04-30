/*
  File Name : sp_mpm210u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm210u_02
  Description : PartList 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno char(8) 의뢰번호
  Use Table :
  Initial   : 2004.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm210u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm210u_02]
GO

/*
Execute sp_mpm210u_02 '20040005'
*/

Create Procedure sp_mpm210u_02
  @ps_orderno char(8)
As
Begin

select SerialNo = aa.serialno,
  DetailNo = aa.detailno,
  SheetNo = aa.sheetno,
  RevNo = aa.revno,
  PartNo = aa.partno,
  PartName = aa.partname,
  Spec = aa.spec,
  Material = aa.material,
  Qty1 = aa.qty1,
  Qty2 = aa.qty2,
  Weight = cast(((isnull(aa.Qty1,0) + isnull(aa.Qty2,0)) * isnull(aa.Weight,0)) AS NUMERIC(11,3)),
  Weight2 = cast(((isnull(aa.Qty1,0) + isnull(aa.Qty2,0)) * isnull(aa.Weight2,0)) AS NUMERIC(11,3)),
  PartCost = cast(((isnull(aa.Qty1,0) + isnull(aa.Qty2,0))
        * isnull(aa.Weight2,0) * isnull(bb.HeatPrice,0)) AS NUMERIC(11,0)),
  PartCost2 = cast(((isnull(aa.Qty1,0) + isnull(aa.Qty2,0))
        * isnull(aa.Weight2,0) * isnull(bb.UnitPrice,0)) AS NUMERIC(11,0)),
  Remark = aa.remark,
  LastEmp = aa.lastemp,
  LastDate = aa.lastdate,
  OrderNo = aa.orderno,
  OutFlag = aa.outflag,
  OutMaterialFlag = aa.outmaterialflag
from tpartlist aa left outer join tmaterialprice bb
  on aa.material = bb.material
where aa.OrderNo = @ps_orderno
order by aa.SerialNo

Return

End   -- Procedure End
Go
