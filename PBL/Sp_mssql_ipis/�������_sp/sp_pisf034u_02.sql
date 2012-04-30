/*
  File Name : sp_pisf034u_02.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf034u_02
  Description : 공무자재반출증작성  ( New : 2003.07.15 )
  Use DataBase  : CMMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf034u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf034u_02]
GO

/*
Execute sp_pisf034u_02 ' '
*/

Create Procedure sp_pisf034u_02
    @ps_areacode    Char(1),    -- 지역코드
    @ps_divcode   Char(1),    -- 공장코드
    @ps_buybackno VarChar(11),  -- 반출증 발행번호
    @ps_buybackdept VarChar(5)  -- 반출부서

As
Begin

SELECT  AreaCode = D.AreaCode,
  DivisionCode = D.DivisionCode,
  BuyBackNo = D.BuyBackNo,
  BuyBackDept = D.BuyBackDept,
  BuyBackSupplier = D.BuyBackSupplier,
  BuyBackEmp = D.BuyBackEmp,
  BuyBackTime= D.BuyBackTime,
  BuyBackDate = D.BuyBackDate,
  ApprovalEmp = D.ApprovalEmp,
  ApprovalTime = D.ApprovalTime,
  CarNo = D.CarNo,
  TakingName = D.TakingName,
  OutEmp = D.OutEmp,
  OutTime = D.OutTime,
  StatusFlag = D.StatusFlag,
  BuyBackFlag = D.BuyBackFlag,
  Remark01 = D.Remark01,
  Remark02 = D.Remark02,
  LastEmp = D.LastEmp,
  LastDate = D.LastDate,
  Comp_Name = C.Comp_Name,
  Emp_Name = B.Emp_Name,
  Cc_Name = A.Cc_Name,
  BackCheck = D.BackCheck
FROM  CC_MASTER   A,
  EMP_MASTER    B,
  COMP_MASTER   C,
  PART_BUYBACK    D
WHERE  D.BuyBackDept   = A.Cc_Code     and
  D.BuyBackSupplier   = C.Comp_Code   and
  D.BuyBackEmp    *= B.Emp_Code     and
  D.AreaCode    = @ps_areacode  AND
  D.DivisionCode    = @ps_divcode     AND
  D.BuyBackNo     = @ps_buybackno   AND
  D.BuyBackDept   LIKE @ps_buybackdept

End   -- Procedure End
Go
