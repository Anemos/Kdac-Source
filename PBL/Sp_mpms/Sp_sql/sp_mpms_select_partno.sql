/*
  File Name : sp_mpms_select_partno.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_select_partno
  Description : Order No 가져오기
  Use DataBase  : MPMS
  Use Program :
  Use Table : tpartlist
  Parameter : @ps_orderno char(8)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_select_partno]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_select_partno]
GO

/*
Execute sp_mpms_select_partno
*/

Create Procedure sp_mpms_select_partno
  @ps_orderno char(8)

As
Begin

Select  PartNo  = A.PartNo,
  PartName  = A.PartName,
  DisplayName = A.PartName + '(' + A.PartNo + ')'
From  tpartlist   A
Where A.OrderNo = @ps_orderno
Order By A.SerialNo

Return

End   -- Procedure End

Go
