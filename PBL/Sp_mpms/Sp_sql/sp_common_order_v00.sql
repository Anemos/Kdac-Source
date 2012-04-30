/*
  File Name : sp_common_order.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_common_order
  Description : 개별 금형의뢰정보 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno char(8) 의뢰번호
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_common_order]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_common_order]
GO

/*
Execute sp_common_order '20040005'
*/

Create Procedure sp_common_order
  @ps_orderno char(8)
As
Begin

declare @ls_gubun char(1)

select @ls_gubun = isnull(deptgubun,'') from torder
where orderno = @ps_orderno

if @ls_gubun = '1'

select aa.orderno, aa.toolname, aa.productno, aa.productname, aa.drawingno,
  aa.designman, cc.empname, aa.moldgubun, aa.assetflag, aa.orderdept,
  bb.deptname as deptname, aa.deptgubun, aa.orderman, aa.ordertelno,
  aa.urgentflag, aa.ingstatus, aa.orderqty, aa.foredate, aa.duedate,
  aa.accesscost, aa.laborcost, aa.remark, aa.startdate, aa.enddate,
  aa.lastemp, aa.lastdate
from torder aa left outer join tmstdept bb
      on aa.orderdept = bb.deptcode left outer join tmstemp cc
      on aa.designman = cc.empno
where aa.orderno = @ps_orderno

else

select aa.orderno, aa.toolname, aa.productno, aa.productname, aa.drawingno,
  aa.designman, cc.empname, aa.moldgubun, aa.assetflag, aa.orderdept,
  bb.custname as deptname, aa.deptgubun, aa.orderman, aa.ordertelno,
  aa.urgentflag, aa.ingstatus, aa.orderqty, aa.foredate, aa.duedate,
  aa.accesscost, aa.laborcost, aa.remark, aa.startdate, aa.enddate,
  aa.lastemp, aa.lastdate
from torder aa left outer join tcustomer bb
      on aa.orderdept = bb.custcode left outer join tmstemp cc
      on aa.designman = cc.empno
where aa.orderno = @ps_orderno

End   -- Procedure End
Go
