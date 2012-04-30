/*
  File Name : sp_mpm250u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm250u_01
  Description : 외주가공발주관리 - 발주내역
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(9) - 의뢰번호
  Use Table :
  Initial   : 2006.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm250u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm250u_01]
GO

/*
Execute sp_mpm250u_01 '%'
*/

Create Procedure sp_mpm250u_01
  @ps_orderno varchar(9)

As
Begin

select SerialNo = aa.SerialNo,
  OrderNo = aa.OrderNo,
  PurItno = aa.PurItno,
  PurSrno = aa.PurSrno,
  OutStatus = aa.OutStatus,
  OutCost = aa.OutCost,
  OrderEmp = aa.OrderEmp,
  OrderEmpName = ( select empname from tmstemp where empno = orderemp ),
  OrderDate = aa.OrderDate,
  IncomeEmp = aa.IncomeEmp,
  IncomeEmpName = ( select empname from tmstemp where empno = incomeemp ),
  IncomeDate = aa.IncomeDate
from toutorder aa
where aa.OrderNo like @ps_orderno
order by aa.SerialNo

End   -- Procedure End
Go
