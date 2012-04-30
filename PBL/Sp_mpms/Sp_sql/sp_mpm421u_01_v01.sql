/*
  File Name : sp_mpm421u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm421u_01
  Description : Work Calendar(�Ϻ�)
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tmpmcalendar
  Initial   : 2010.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm421u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm421u_01]
GO

/*
Execute sp_mpm421u_01 '2006.06','TAM'
*/

Create Procedure sp_mpm421u_01
  @ps_applymonth  char(7),   -- ��ȹ�� ('YYYY.MM')
  @ps_wccode varchar(3)

As
Begin       -- Procedure Start

Select  WcCode = A.WcCode,
  ApplyMonth = A.ApplyMonth,
  ApplyDate = A.ApplyDate,
  WeekDayName = Case DatePart(dw,cast(A.ApplyDate as datetime))
              When 1 then '��'
              When 2 then '��'
              When 3 then 'ȭ'
              When 4 then '��'
              When 5 then '��'
              When 6 then '��'
              When 7 then '��' else '' End,
  DayNo   = A.DayNo,
  WorkGubun = A.WorkGubun,
  OverWork = A.OverWork,
  DawnWork = A.DawnWork,
  NightWork = A.NightWork
From  tmpmcalendar  A
Where A.ApplyMonth  = @ps_applymonth and A.WcCode like @ps_wccode
Order By A.ApplyDate, A.WcCode


Return

End   -- Procedure End
Go

