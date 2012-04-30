/*
  File Name : sp_mpms_select_mchno.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_select_mchno
  Description : Machine No 가져오기
  Use DataBase  : MPMS
  Use Program :
  Use Table : tmachine
  Parameter : @ps_wccode char(3)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_select_mchno]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_select_mchno]
GO

/*
Execute sp_mpms_select_mchno '@ps_wccode'
*/

Create Procedure sp_mpms_select_mchno
  @ps_wccode char(3)

As
Begin

Select  MchNo  = A.MchNo,
  MchName  = A.MchName,
  DisplayName = A.MchName + '(' + A.MchNo + ')'
From  tmachine   A
Where A.WcCode = @ps_wccode
Order By A.MchNo

Return

End   -- Procedure End

Go
