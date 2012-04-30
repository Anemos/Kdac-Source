/*
  file name : sp_pisf034i_01.sql
  system    : cmms system
  procedure name  : sp_pisf034i_01
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf034i_01]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf034i_01]
go

/*
Execute sp_pisf034i_01
*/

create Procedure [dbo].[sp_pisf034i_01]
  @ps_areacode    Char(1),    -- 지역 코드
  @ps_divcode     Char(1),    -- 공장 코드
  @ps_deptcode    VarChar(4),     -- 부서코드
  @ps_suppcode    VarChar(5),     -- 업체전산화번호
  @ps_applyfrom     Char(10),     -- 기준일자
  @ps_applyto     Char(10)    -- 기준일자

As
Begin
-- StatusFlag '1'승인요청, 'C'승인
SELECT AreaCode = A.AreaCode,
  DivisionCode = A.DivisionCode,
  BuyBackNo = A.BuyBackNo,
  BuyBackDept = A.BuyBackDept,
  BuyBackSupplier = A.BuyBackSupplier,
  BuyBackEmp = A.BuyBackEmp,
  BuyBackTime = A.BuyBackTime,
  BuyBackDate = A.BuyBackDate,
  ApprovalEmp = A.ApprovalEmp,
  ApprovalTime = A.ApprovalTime,
  CarNo = A.CarNo,
  TakingName = A.TakingName,
  OutEmp = A.OutEmp,
  OutTime = A.OutTime,
  StatusFlag = A.StatusFlag,
  Remark01 = A.Remark01,
  Remark02 = A.Remark02,
  LastEmp = A.LastEmp,
  LastDate = A.LastDate,
  Comp_Name = B.Comp_Name,
  BackCheck = A.BackCheck
FROM PART_BUYBACK A,
COMP_MASTER B
WHERE A.AreaCode    = @ps_areacode    AND
  A.DivisionCode  like @ps_divcode  AND
  A.BuyBackDept     like @ps_deptcode   AND
  A.BuyBackSupplier   like @ps_suppcode   AND
  Convert( Char(10), A.BuyBackTime, 102) >= @ps_applyfrom And
  Convert( Char(10), A.BuyBackTime, 102) <= @ps_applyto   And
  A.BuyBackSupplier = B.Comp_Code

End   -- Procedure End