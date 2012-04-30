/*
  File Name : sp_mpm116u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm116u_02
  Description : Work Calendar
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tmpmcalendar
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm116u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm116u_02]
GO

/*
Execute sp_mpm116u_02 '2006.06','TAM'
*/

Create Procedure sp_mpm116u_02
  @ps_applymonth  char(7),   -- °èÈ¹¿ù ('YYYY.MM')
  @ps_wccode char(3)

As
Begin       -- Procedure Start

Select  ApplyDate = A.ApplyDate,
  DayNo   = A.DayNo,
  WorkGubun = A.WorkGubun,
  OverWork = A.OverWork,
  DawnWork = A.DawnWork,
  NightWork = A.NightWork
From  tmpmcalendar  A
Where A.ApplyMonth  = @ps_applymonth and A.WcCode = @ps_wccode
Group By A.ApplyDate, A.DayNo, A.WorkGubun,
  A.OverWork, A.DawnWork, A.NightWork


Return

End   -- Procedure End
Go

