/*
  File Name : sp_mpm120u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm120u_01
  Description : 금형의뢰정보 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(9)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm120u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm120u_01]
GO

/*
Execute sp_mpm120u_01
*/

Create Procedure sp_mpm120u_01
  @ps_orderno varchar(9)

As
Begin

select aa.orderno, aa.toolname, aa.productno, aa.productname, aa.orderdept,
  bb.deptname, aa.orderman, aa.ordertelno, aa.ingstatus, aa.duedate
from torder aa left outer join tmstdept bb
      on aa.orderdept = bb.deptcode
where aa.orderno like @ps_orderno and aa.deptgubun = '1'

union all

select aa.orderno, aa.toolname, aa.productno, aa.productname, aa.orderdept,
  bb.custname, aa.orderman, aa.ordertelno, aa.ingstatus, aa.duedate
from torder aa left outer join tcustomer bb
      on aa.orderdept = bb.custcode
where aa.orderno like @ps_orderno and aa.deptgubun = '2'

End   -- Procedure End
Go
