/*
  File Name : sp_mpms_select_workcenter.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_select_workcenter
  Description : workcenter 가져오기
  Use DataBase  : MPMS
  Use Program :
  Use Table : tworkcenter
  Parameter : 
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_select_workcenter]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_select_workcenter]
GO

/*
Execute sp_mpms_select_workcenter
*/

Create Procedure sp_mpms_select_workcenter

As
Begin

Select  WcCode  = A.WcCode,
  WcName  = A.WcName,
  DisplayName = A.WcName + '(' + A.WcCode + ')'
From  tworkcenter   A
Order By A.WcSerial

Return

End   -- Procedure End

Go
