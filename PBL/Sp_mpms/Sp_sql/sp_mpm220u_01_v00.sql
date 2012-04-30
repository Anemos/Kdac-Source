/*
	File Name	: sp_mpm220u_01.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm220u_01
	Description	: PartList 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8) 
	Use Table	: tpartlist
	Initial		: 2004.03.31
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

declare @li_count int, @li_totcnt int
declare @li_detailno int

CREATE TABLE #count_tmp (
  [OrderNo]     [char]    (8)     NULL,
  [PartNo]      [char]    (6)     NULL,
  [Serial]      [int]             NULL,
  [Total]       [int]             NULL)

select * into #list_tmp
from tpartlist
where OrderNo = @ps_orderno
order by DetailNo

select @li_count = 0, @li_totcnt = @@rowcount, @li_detailno = -1

while @li_count < @li_totcnt
begin
  select top 1
    @li_count = @li_count + 1,
    @li_detailno  = aa.DetailNo
  from #list_tmp aa
  where aa.OrderNo = @ps_orderno and aa.DetailNo > @li_detailno

  insert into #count_tmp
  select @ps_orderno, aa.PartNo,  @li_count, @li_totcnt
  from #list_tmp aa
  where aa.DetailNo = @li_detailno
end

Select	Serial = convert(varchar(5), bb.Serial) + ' / ' + convert(varchar(5), bb.Total),
  PartNo	= aa.PartNo,
	PartName	= aa.PartName,
	DisplayName	= aa.PartName + '(' + aa.PartNo + ')',
	PlanQty   = aa.Qty1 + aa.Qty2
From	tpartlist	aa inner join #count_tmp bb
  on aa.OrderNo = bb.OrderNo and aa.PartNo = bb.PartNo
Where	aa.Orderno = @ps_orderno
Order by aa.detailno

drop table #list_tmp
drop table #count_tmp

Return

End		-- Procedure End

Go
