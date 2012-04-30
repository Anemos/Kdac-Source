/*
  File Name : sp_mpms_find_orderno.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpms_find_orderno
  Description : 완료상태가 아닌 금형의뢰정보 찾기
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(9), @ps_toolname varchar(100), @ps_productname varchar(50)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_find_orderno]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_find_orderno]
GO

/*
Execute sp_mpms_find_orderno @ps_orderno, @ps_toolname, @ps_productname
*/

Create Procedure sp_mpms_find_orderno
  @ps_orderno  varchar(9),
  @ps_toolname varchar(100),
  @ps_productname varchar(50)

As
Begin

select aa.orderno, aa.toolname, aa.productno, aa.productname, aa.orderdept,
  bb.deptname, aa.ingstatus
from torder aa left outer join tmstdept bb
      on aa.orderdept = bb.deptcode
where isnull(aa.deptgubun,'') = '1' and
      aa.orderno like @ps_orderno and aa.toolname like @ps_toolname and
      aa.productname like @ps_productname

union all

select aa.orderno, aa.toolname, aa.productno, aa.productname, aa.orderdept,
  bb.custname, aa.ingstatus
from torder aa left outer join tcustomer bb
      on aa.orderdept = bb.custcode
where isnull(aa.deptgubun,'') = '2' and
      aa.orderno like @ps_orderno and aa.toolname like @ps_toolname and
      aa.productname like @ps_productname

End   -- Procedure End
Go
