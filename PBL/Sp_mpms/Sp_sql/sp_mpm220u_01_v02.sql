/*
	File Name	: sp_mpm220u_01.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm220u_01
	Description	: PartList 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8) 
	Use Table	: tpartlist
	Initial		: 2004.09
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm220u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm220u_01]
GO

/*
Execute sp_mpm220u_01 
*/

Create Procedure sp_mpm220u_01
  @ps_orderno char(8)

As
Begin

declare @li_totcnt int

select @li_totcnt = count(*)
from tpartlist
where OrderNo = @ps_orderno

Select	Serial = convert(varchar(5), aa.SerialNo) + ' / ' + convert(varchar(5), @li_totcnt),
  PartNo	= aa.PartNo,
	PartName	= aa.PartName,
	DisplayName	= aa.PartName + '(' + aa.PartNo + ')',
	PlanQty   = aa.Qty1 + aa.Qty2,
	OutFlag   = aa.OutFlag,
	OrderNo   = aa.OrderNo
From	tpartlist	aa
Where	aa.Orderno = @ps_orderno
Order by aa.serialno

Return

End		-- Procedure End

Go
