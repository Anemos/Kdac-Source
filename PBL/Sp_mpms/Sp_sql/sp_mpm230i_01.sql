/*
	File Name	: sp_mpm230i_01.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm230i_01
	Description	: PartList History 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8) 
	Use Table	: tpartlist, tpartlisthist
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm230i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm230i_01]
GO

/*
Execute sp_mpm230i_01 
*/

Create Procedure sp_mpm230i_01
  @ps_orderno char(8)

As
Begin

select aa.DetailNo, aa.SheetNo, aa.RevNo, aa.PartNo, aa.RevEmp, aa.RevDate,
    aa.PartName, aa.Spec, aa.Material, aa.Qty1, aa.Qty2, aa.Weight,
    aa.PartCost, aa.Remark, aa.LastEmp, aa.LastDate, aa.OrderNo
from tpartlisthist aa
where aa.OrderNo = @ps_orderno
Order by aa.DetailNo, aa.RevNo

Return

End		-- Procedure End

Go
