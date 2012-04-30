/*
	File Name	: sp_mpm120u_03p.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm120u_03p
	Description	: 긴급작업지시서 출력
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_partno char(6)
	Use Table	: tworkjob
	Initial		: 2004.09
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm120u_03p]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm120u_03p]
GO

/*
Execute sp_mpm120u_03p '@ps_orderno','@ps_partno'
*/

Create Procedure sp_mpm120u_03p
  @ps_orderno char(8),
  @ps_partno  char(6)

As
Begin

declare @li_count int, @li_totcnt int
declare @li_detailno int, @ls_deptgubun char(1)
declare @ls_deptname varchar(40)

select @ls_deptgubun = deptgubun from torder
where orderno = @ps_orderno

select @li_totcnt = count(*)
from tpartlist
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

Select PrintDate = Convert(char(10),getdate(),102),
  Serial = bb.SerialNo,
  Total = @li_totcnt,
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
  left outer join trouting cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo
Where bb.OrderNo = @ps_orderno and bb.PartNo = @ps_partno

Return

End		-- Procedure End

Go
