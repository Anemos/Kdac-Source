/*
  File Name : sp_mpms_select_empno.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_select_empno
  Description : 작업자 가져오기
  Use DataBase  : MPMS
  Use Program :
  Use Table : tmoldempno
  Parameter :
  Initial   : 2006.05
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_select_empno]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_select_empno]
GO

/*
Execute sp_mpms_select_empno
*/

Create Procedure sp_mpms_select_empno

As
Begin

Select  EmpNo = '',
  EmpName = '',
  DisplayName = ''
  
Union All
  
Select  EmpNo  = A.EmpNo,
  EmpName  = A.EmpName,
  DisplayName = A.EmpName + '(' + A.EmpNo + ')'
From  tmoldempno   A
Where A.ApplyTo = '9999.12.31'
Order By A.EmpName

Return

End   -- Procedure End

Go
