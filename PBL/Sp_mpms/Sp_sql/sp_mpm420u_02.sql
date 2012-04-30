/*
  File Name : sp_mpm420u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm420u_02
  Description : Work Calendar
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tmpmcalendar
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm420u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm420u_02]
GO

/*
Execute sp_mpm420u_02 '2006.06','TAM'
*/

Create Procedure sp_mpm420u_02
  @ps_applymonth  char(7),   -- °èÈ¹¿ù ('YYYY.MM')
  @ps_wccode char(3)

As
Begin       -- Procedure Start

Select  ApplyDate = A.ApplyDate,
  DayNo   = A.DayNo,
  WorkGubun = A.WorkGubun,
  OverWork = ( select count(*) from tmpmcalendar B 
      where B.ApplyMonth  = @ps_applymonth and B.ApplyDate = A.ApplyDate and
          B.OverWork <> 'N' ),
  DawnWork = ( select count(*) from tmpmcalendar B 
      where B.ApplyMonth  = @ps_applymonth and B.ApplyDate = A.ApplyDate and
          B.DawnWork <> 'N' ),
  NightWork =( select count(*) from tmpmcalendar B 
      where B.ApplyMonth  = @ps_applymonth and B.ApplyDate = A.ApplyDate and
          B.NightWork <> 'N' )
From  tmpmcalendar  A
Where A.ApplyMonth  = @ps_applymonth and A.WcCode = @ps_wccode
Order by A.ApplyDate, A.DayNo

Return

End   -- Procedure End
Go

