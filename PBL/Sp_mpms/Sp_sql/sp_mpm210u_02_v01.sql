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

select SerialNo = serialno,
  DetailNo = detailno,
  SheetNo = sheetno,
  RevNo = revno,
  PartNo = partno,
  PartName = partname,
  Spec = spec,
  Material = material,
  Qty1 = qty1,
  Qty2 = qty2,
  Weight = weight,
  Weight2 = weight2,
  PartCost = partcost,
  Remark = remark,
  LastEmp = lastemp,
  LastDate = lastdate,
  OrderNo = orderno
from tpartlist
where OrderNo = @ps_orderno
order by SerialNo

Return

End   -- Procedure End
Go
