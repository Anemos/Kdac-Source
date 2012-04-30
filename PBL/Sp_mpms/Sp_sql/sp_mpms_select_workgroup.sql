/*
  File Name : sp_mpms_select_workgroup.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_select_workgroup
  Description : 작업그룹 가져오기
  Use DataBase  : MPMS
  Use Program :
  Use Table : tmoldempno
  Parameter :
  Initial   : 2006.11
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_select_workgroup]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_select_workgroup]
GO

/*
Execute sp_mpms_select_workgroup
*/

Create Procedure sp_mpms_select_workgroup

As
Begin

Select  WgCode  = A.WgCode,
  WgName  = A.WgName,
  DisplayName = A.WgName + '(' + A.WgCode + ')'
From  tworkgroup   A
Order By A.WgCode

Return

End   -- Procedure End

Go
