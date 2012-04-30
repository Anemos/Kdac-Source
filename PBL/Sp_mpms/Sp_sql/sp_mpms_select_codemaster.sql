/*
  File Name : sp_mpms_select_codemaster.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_select_codemaster
  Description : code 가져오기
  Use DataBase  : MPMS
  Use Program :
  Use Table : tcodemaster
  Parameter : @ps_codegubun char(6)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_select_codemaster]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_select_codemaster]
GO

/*
Execute sp_mpms_select_codemaster
*/

Create Procedure sp_mpms_select_codemaster
  @ps_codegubun char(6)

As
Begin

Select  CoCode  = A.CoCode,
  CodeName  = A.CodeName,
  DisplayName = A.CodeName + '(' + A.CoCode + ')'
From  tcodemaster   A
Where A.CodeGubun = @ps_codegubun

Return

End   -- Procedure End

Go
