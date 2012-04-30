/*
  File Name : sp_pisr135b_02.sql
  SYSTEM    : 외주간판 System
  Procedure Name  : sp_pisr135b_02
  Description : 사급품반출증작성  ( New : 2003.07.15 )
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr135b_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr135b_02]
GO

/*
Execute sp_pisr135b_02 '','','',''
*/

Create Procedure sp_pisr135b_02
 	@ps_areacode		Char(1),		-- 지역코드
 	@ps_divcode		Char(1),		-- 공장코드
 	@ps_buybackno	VarChar(11),	-- 반출증 발행번호
 	@ps_buybackdept	VarChar(5)	-- 반출부서

AS

BEGIN
  SELECT 	AreaCode = D.AreaCode,
    DivisionCode = D.DivisionCode,
    BuyBackNo = D.BuyBackNo,
    BuyBackDept = D.BuyBackDept,
    BuyBackSupplier = D.BuyBackSupplier,
    BuyBackEmp = D.BuyBackEmp,
    BuyBackTime = D.BuyBackTime,
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
    SupplierNo = C.SupplierNo,
    SupplierKorName = C.SupplierKorName,
    EmpName = B.EmpName,
    DeptName = A.DeptName,
    BackCheck = D.BackCheck
  FROM 	TMSTDEPT		A,
      TMSTEMP		B,
      TMSTSUPPLIER	C,
      TPARTBUYBACK	D
  WHERE D.BuyBackDept 	= A.DeptCode 		and
    D.BuyBackSupplier 	= C.SupplierCode 	and
    D.BuyBackEmp 		*= B.EmpNo 		and
    D.AreaCode 		= @ps_areacode 	AND
    D.DivisionCode 		= @ps_divcode 		AND
    D.BuyBackNo 		= @ps_buybackno 	AND
    D.BuyBackDept 	LIKE @ps_buybackdept

END
