/*
  File Name : sp_mpm210u_04.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm210u_04
  Description : PartList 출력
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno char(8) 의뢰번호
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm210u_04]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm210u_04]
GO

/*
Execute sp_mpm210u_04 '20040005'
*/

Create Procedure sp_mpm210u_04
  @ps_orderno char(8)
As
Begin

declare @li_count int, @li_totcnt int
declare @li_detailno int
declare @ls_toolname  varchar(100)

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

select @ls_toolname = ToolName
from torder
where orderno = @ps_orderno

select * into #list
from tpartlist
where OrderNo = @ps_orderno
order by DetailNo

select @li_count = 0, @li_totcnt = @@rowcount, @li_detailno = -1
if @li_totcnt < 50
  select @li_totcnt = 50
else
  select @li_totcnt = (50 * (@li_totcnt / 50)) + 50
while @li_count < @li_totcnt
begin
  select @li_count = @li_count + 1
  select top 1
    @li_detailno  = isnull(aa.DetailNo, (@li_detailno + 1))
  from #list aa
  where aa.OrderNo = @ps_orderno and aa.DetailNo > @li_detailno
  
  if @@rowcount = 0
    insert into #partlist( serialno )
    values( @li_count )
  else
    insert into #partlist
    select @li_count, aa.DetailNo, aa.SheetNo, aa.RevNo, aa.PartNo,
      aa.PartName, aa.Spec, aa.Material, aa.Qty1, aa.Qty2, aa.Weight,
      aa.PartCost, aa.Remark, aa.LastEmp, aa.LastDate, aa.OrderNo
    from #list aa
    where aa.DetailNo = @li_detailno
end

select OrderNo = @ps_orderno,
    ToolName = @ls_toolname,
    SerialNo = aa.SerialNo,
    DetailNo = aa.DetailNo,
    SheetNo = aa.SheetNo,
    PartNo = aa.PartNo,
    PartName = aa.PartName,
    Spec  = aa.Spec,
    Material = aa.Material,
    Qty1 = aa.Qty1,
    Qty2 = aa.Qty2,
    Ht  = 0,
    St  = 0,
    Bs  = 0,
    La  = 0,
    Dm  = 0,
    Pm  = 0,
    Bm  = 0,
    Mm  = 0,
    Jb  = 0,
    Ug  = 0,
    Sg  = 0,
    Jg  = 0,
    Vg  = 0,
    Wc  = 0,
    Edm  = 0,
    Lp  = 0,
    Am  = 0,
    Weight = aa.Weight,
    Remark = aa.Remark
    from #partlist aa

drop table #partlist
drop table #list

End   -- Procedure End
Go
