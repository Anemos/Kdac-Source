/*
  File Name : sp_mpms_create_tloadavailtime.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_create_tloadavailtime
  Description :작업장 일별 가용시간 계산 및 생성
               check_calendar 'AA' => Workcalendar
                              'BB' => option
  Use DataBase  : MPMS
  Use Program :
  Use Table : tloadavailtime
  Parameter :
  Initial   : 2010.06.07
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_create_tloadavailtime]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_create_tloadavailtime]
GO

/*
Execute sp_mpms_create_tloadavailtime 'A','2010.07.26'
delete from tloadavailtime
select * from tloadavailtime where plandate in ('2010.07.23','2010.07.24','2010.07.26')
*/

Create Procedure sp_mpms_create_tloadavailtime
  @ps_versionno char(1),
  @ps_applydate varchar(10)

As
Begin

declare @ls_wccode char(3), @ls_applymonth char(7), @ls_check_calendar char(1)
declare @li_index int, @li_lifetime int, @li_applyratio int
declare @ls_overwork char(1), @ls_specialwork char(1), @ls_nightwork char(1)

select @ls_applymonth = substring(@ps_applydate,1,7)
select @ls_wccode = '000'
select @li_index = 0

select @li_applyratio = a.applyratio,
  @ls_overwork = a.overwork,
  @ls_specialwork = a.specialwork,
  @ls_nightwork = a.nightwork
from tloadoption a
where a.versionno = @ps_versionno and
  a.startdate <= cast(@ps_applydate as datetime) and
  a.enddate >= cast(@ps_applydate as datetime)

if @@rowcount < 1
  Begin
    select @ls_check_calendar = 'AA'
    select @li_applyratio = 100
    select @ls_specialwork = 'N'

    select top 1 @ls_overwork = a.overwork,
           @ls_nightwork = a.nightwork
    from tmpmcalendar a
    where a.applymonth = @ls_applymonth and a.applydate = @ps_applydate

    if @@rowcount < 1
      exec sp_mpms_create_calendar @ls_applymonth
  End
else
  Begin
    select @ls_check_calendar = 'BB'
  End

while @li_index = 0
  Begin
    SELECT TOP 1 @ls_wccode = WcCode
    FROM TWORKCENTER
    WHERE WcCode > @ls_wccode AND WcCode <> 'THT'
    ORDER BY wccode ASC

    if @@rowcount = 0
      Break

    if @ls_check_calendar = 'AA'
      Begin
        select @li_lifetime = ROUND(( CASE WHEN a.workgubun = 'W' THEN 8 * 60 ELSE 0 END +
         CASE WHEN a.overwork = 'S' THEN 2*60
              WHEN a.overwork = 'T' THEN 3*60
              ELSE 0 END +
         CASE WHEN a.dawnwork = 'Y' THEN 2.5*60 ELSE 0 END +
         CASE WHEN a.nightwork = 'Y' THEN 8 * 60 ELSE 0 END ) * b.manratio,1)
        from tmpmcalendar a inner join tworkcenter b
          on a.wccode = b.wccode
        where a.applymonth = @ls_applymonth and a.applydate = @ps_applydate and
              a.wccode = @ls_wccode
      End
    else
      Begin
        select @li_lifetime = ROUND(( CASE WHEN a.workgubun = 'W' or @ls_specialwork = 'Y' THEN 8 * 60 ELSE 0 END +
         CASE WHEN @ls_overwork = 'S' and a.workgubun = 'W' THEN 2*60
              WHEN @ls_overwork = 'T' and a.workgubun = 'W' THEN 3*60
              ELSE 0 END +
         CASE WHEN a.dawnwork = 'Y' THEN 2.5*60 ELSE 0 END +
         CASE WHEN @ls_nightwork = 'Y' and a.workgubun = 'W' THEN 8 * 60 ELSE 0 END ) * b.manratio * @li_applyratio / 100,1)
        from tmpmcalendar a inner join tworkcenter b
          on a.wccode = b.wccode
        where a.applymonth = @ls_applymonth and a.applydate = @ps_applydate and
              a.wccode = @ls_wccode
      End

    INSERT INTO TLOADAVAILTIME
    ( VersionNo,PlanDate,WcCode,LifeTime,ApplyTime,RemainTime,
      OkFlag,LastEmp,LastDate )
    VALUES(@ps_versionno,@ps_applydate,@ls_wccode,@li_lifetime,0,@li_lifetime,
      'N', null, getdate() )
  End

return

End   -- Procedure End

Go