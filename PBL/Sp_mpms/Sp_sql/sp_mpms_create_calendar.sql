/*
  File Name : sp_mpms_create_calendar.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_create_calendar
  Description : 작업일정테이블을 생성함.
  Use DataBase  : MPMS
  Use Program :
  Use Table : torder
  Parameter : @ps_yyyymm char(7)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_create_calendar]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_create_calendar]
GO

/*
Execute sp_mpms_create_calendar '2010.07'
select * from tmpmcalendar where applymonth = '2010.07'
*/

Create Procedure sp_mpms_create_calendar
  @ps_yyyymm varchar(7)

As
Begin

declare @ls_wccode char(3), @ls_date char(10), @ls_check char(7)
declare @ls_workgubun char(1)
declare @li_cnt int, @li_dayno int, @li_datediff int

select @ls_wccode = '000'

SELECT TOP 1 @ls_check = ApplyMonth
FROM TMPMCALENDAR
WHERE ApplyMonth = @ps_yyyymm

if isnull(@ls_check,'') = @ps_yyyymm
  return
else
  select @ls_check = @ps_yyyymm

while (@ls_check = @ps_yyyymm)
Begin
  SELECT TOP 1 @ls_wccode = WcCode
  FROM TWORKCENTER
  WHERE WcCode > @ls_wccode AND WcCode <> 'THT'
  ORDER BY wccode ASC

  if @@rowcount = 0
    Break

  select @li_cnt = 1
  while ( @li_cnt <= 31 )
  Begin
    if @li_cnt = 1
      select @ls_date = @ps_yyyymm + '.01'
    else
      Begin
        select @ls_date = convert(varchar(10),DATEADD(day,@li_cnt - 1,cast(@ps_yyyymm + '.01' as datetime)),102)
        select @li_dayno = DATEPART(WEEKDAY,(DATEADD(day,@li_cnt -1,cast(@ps_yyyymm + '.01' as datetime))))
      End
    
    if substring(@ls_date,1,7) <> @ps_yyyymm
      Begin
        Break
      End
    
    if @li_dayno = 1 or @li_dayno = 7
      select @ls_workgubun = 'H'
    else
      select @ls_workgubun = 'W'
    
    select @li_datediff = DATEDIFF(day,cast(substring(@ps_yyyymm,1,5) + '01.01' as datetime),
        cast(@ls_date as datetime)) + 1

    INSERT INTO TMPMCALENDAR
    ( ApplyMonth, ApplyDate, WcCode, DayNo, WorkGubun,
      OverWork, DawnWork, NightWork, Remark, LastEmp, LastDate )
    VALUES (@ps_yyyymm, @ls_date,@ls_wccode,@li_datediff,@ls_workgubun,
      'N','N','N',Null,'SP',GetDate() )

    if @@error = 0
      select @li_cnt = @li_cnt + 1
  End
End

return

End   -- Procedure End

Go