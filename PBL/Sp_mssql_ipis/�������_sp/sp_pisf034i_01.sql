/*
  File Name : sp_pisf034i_01.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf034i_01
  Description : ���ǰ������Ȳ��ȸ( ��������� )
  Use DataBase  : CMMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf034i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf034i_01]
GO

/*
Execute sp_pisf034i_01
*/

Create Procedure sp_pisf034i_01
  @ps_areacode 		Char(1),   	-- ���� �ڵ�
 	@ps_divcode 		Char(1),   	-- ���� �ڵ�
 	@ps_deptcode 		VarChar(4),   	-- �μ��ڵ�
 	@ps_suppcode 		VarChar(5),   	-- ��ü����ȭ��ȣ
 	@ps_applyfrom 		Char(10),   	-- ��������
 	@ps_applyto 		Char(10)   	-- ��������

As
Begin
-- StatusFlag	'1'���ο�û, 'C'����
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
FROM PART_BUYBACK	A,
COMP_MASTER	B
WHERE A.AreaCode 		= @ps_areacode		AND
  A.DivisionCode 	like @ps_divcode	AND
  A.BuyBackDept 		like @ps_deptcode 	AND
  A.BuyBackSupplier 	like @ps_suppcode 	AND
  Convert( Char(10), A.BuyBackTime, 102) >= @ps_applyfrom	And
  Convert( Char(10), A.BuyBackTime, 102) <= @ps_applyto		And
  A.BuyBackSupplier	= B.Comp_Code

End   -- Procedure End
Go
