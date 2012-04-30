/*
  File Name : sp_mpm110u_03.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm110u_03
  Description : 의뢰처가 업체인 금형의뢰 이력
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm110u_03]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm110u_03]
GO

/*
Execute sp_mpm110u_03 'M0000'
*/

Create Procedure sp_mpm110u_03
  @ps_custcode char(5)

As
Begin

select custcode, custname, orderno, toolname, productno, productname,
  moldgubun, assetflag, urgentflag, ingstatus, orderqty
from tcustomer, torder
where custcode = orderdept and custcode = @ps_custcode
order by custcode, orderno

End   -- Procedure End
Go
