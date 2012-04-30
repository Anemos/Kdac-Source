/*
  File Name : sp_mpm210u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm210u_02
  Description : PartList 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno char(8) 의뢰번호
  Use Table :
  Initial   : 2004.03
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

declare @li_count int, @li_totcnt int
declare @li_detailno int

CREATE TABLE #partlist (
  [SerialNo]    [int]             NULL,
  [DetailNo]    [int]             NULL,
  [SheetNo]     [int]             NULL,
  [RevNo]       [char]    (2)     NULL,
  [PartNo]      [char]    (6)     NULL,
  [PartName]    [varchar] (50)    NULL,
  [Spec]        [varchar] (100)   NULL,
  [Material]    [varchar] (20)    NULL,
  [Qty1]        [numeric] (5,0)   NULL,
  [Qty2]        [numeric] (5,0)   NULL,
  [Weight]      [numeric] (8,1)   NULL,
  [PartCost]    [numeric] (11,2)  NULL,
  [Remark]      [varchar] (255)   NULL,
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime]        NULL,
  [OrderNo]     [char]    (8)     NULL, )

select * into #list
from tpartlist
where OrderNo = @ps_orderno
order by DetailNo

select @li_count = 0, @li_totcnt = @@rowcount, @li_detailno = -1

while @li_count < @li_totcnt
begin
  select top 1
    @li_count = @li_count + 1,
    @li_detailno  = aa.DetailNo
  from #list aa
  where aa.OrderNo = @ps_orderno and aa.DetailNo > @li_detailno

  insert into #partlist
  select @li_count, aa.DetailNo, aa.SheetNo, aa.RevNo, aa.PartNo,
    aa.PartName, aa.Spec, aa.Material, aa.Qty1, aa.Qty2, aa.Weight,
    aa.PartCost, aa.Remark, aa.LastEmp, aa.LastDate, aa.OrderNo
  from #list aa
  where aa.DetailNo = @li_detailno
end

select * from #partlist

drop table #partlist

End   -- Procedure End
Go
