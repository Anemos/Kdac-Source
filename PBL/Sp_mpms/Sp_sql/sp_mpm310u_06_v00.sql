/*
	File Name	: sp_mpm310u_06.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm310u_06
	Description	: 작업지시서 출력(일괄)
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8)
	Use Table	: tworkjob
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm310u_06]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm310u_06]
GO

/*
Execute sp_mpm310u_06 '@ps_orderno'
*/

Create Procedure sp_mpm310u_06
  @ps_orderno char(8)

As
Begin

declare @li_count int, @li_totcnt int
declare @li_detailno int, @ls_deptgubun char(1)
declare @ls_deptname varchar(40)

select @ls_deptgubun = deptgubun from torder
where orderno = @ps_orderno

if @ls_deptgubun = '1'
  select @ls_deptname = bb.deptname
  from torder aa left outer join tmstdept bb
        on aa.orderdept = bb.deptcode
  where aa.orderno = @ps_orderno
else
  select @ls_deptname = bb.custname
  from torder aa left outer join tcustomer bb
      on aa.orderdept = bb.custcode
  where aa.orderno = @ps_orderno

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

Select PrintDate = Convert(char(10),getdate(),102),
  Serial = dd.Serial,
  Total = dd.Total,
  OrderDept = aa.OrderDept,
  DeptName = @ls_deptname,
  OrderMan = aa.OrderMan,
  MoldGubun = aa.MoldGubun,
  OrderTelno = aa.OrderTelno,
  OrderNo = aa.OrderNo,
  DueDate = Convert(char(10),aa.Duedate,102),
  PartNo = bb.PartNo,
  PartName = bb.PartName,
  PlanQty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  ToolName = aa.ToolName,
  ProductNo = aa.ProductNo,
  ProductName = aa.ProductName,
  Material = bb.Material,
  OperNo = cc.OperNo,
  WcCode = cc.WcCode,
  WorkMatter = cc.WorkMatter,
  WorkStart = Convert(char(10),cc.WorkStart,102),
  WorkDate = ' ',
  WorkEmp = ' ',
  MchNo = ' ',
  JobTime = ' ',
  JobMemo = ' ' 
From torder aa inner join tpartlist bb
  on aa.OrderNo = bb.OrderNo
  inner join trouting cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo
  inner join #count_tmp dd
  on bb.OrderNo = dd.OrderNo and bb.PartNO = dd.PartNo
Where cc.OrderNo = @ps_orderno and cc.OperNo <> '000'

drop table #list_tmp
drop table #count_tmp

Return

End		-- Procedure End

Go
