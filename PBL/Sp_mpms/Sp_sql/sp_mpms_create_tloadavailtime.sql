/*
  File Name : sp_mpms_create_tloadavailtime.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_create_tloadavailtime
  Description :작업장 일별 가용시간 계산 및 생성
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
Execute sp_mpms_create_tloadavailtime '2010.06.01'
delete from tloadavailtime
select * from tloadavailtime
*/

Create Procedure sp_mpms_create_tloadavailtime
  @ps_applydate varchar(10)

As
Begin

declare @ls_wccode char(3), @ls_applymonth char(7)
declare @li_index int, @li_lifetime int

select @ls_applymonth = substring(@ps_applydate,1,7)
select @ls_wccode = '000'
select @li_index = 0


while @li_index = 0
  Begin
    SELECT TOP 1 @ls_wccode = WcCode
    FROM TWORKCENTER
    WHERE WcCode > @ls_wccode AND WcCode <> 'THT'
    ORDER BY wccode ASC

    if @@rowcount = 0
      Break

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

    if @@rowcount = 0
      Begin
        exec sp_mpms_create_calendar @ls_applymonth

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

    INSERT INTO TLOADAVAILTIME
    ( PlanDate,WcCode,LifeTime,ApplyTime,RemainTime,
      OkFlag,LastEmp,LastDate )
    VALUES(@ps_applydate,@ls_wccode,@li_lifetime,0,@li_lifetime,
      'N', null, getdate() )
  End

return

End   -- Procedure End

Go