/*
  File Name : sp_mpm340u_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm340u_01
  Description : 작업일지 Master 데이타 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_workgubun char(1), @ps_workdate char(10)
  Use Table :
  Initial   : 2006.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm340u_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm340u_01]
GO

/*
Execute sp_mpm340u_01
  @ps_workgubun   = 'A',
  @ps_workdate   = '2006.05.10'
*/

Create Procedure sp_mpm340u_01
  @ps_workgubun char(4),    /* 조구분 */
  @ps_workdate char(10)    /* 적용일 */


As
Begin

Declare @li_chkcnt  int,
  @li_totcnt int,
  @li_cnt int,
  @ls_empno char(6)

/*########################################################################################
tworkreport에 데이타가 없는 경우에 먼저 생성한다.
생성기준 : 조구분에 해당하는 사람만 적용한다.
########################################################################################*/

Select @li_chkcnt = count(*)
From TWORKREPORT
Where WorkDate = @ps_workdate And WorkGubun = @ps_workgubun

If @li_chkcnt < 1
  Begin
    INSERT INTO TWORKREPORT(WorkDate, WorkGubun, ConfirmFlag, SanctionFlag, LastEmp)
    VALUES( @ps_workdate, @ps_workgubun, 'N', 'N', 'SYSTEM' )

    SELECT EmpNo = EmpNo,
      IDENTITY(int, 1,1) as id_num
    INTO #tmp_empno
    FROM TMOLDEMPNO aa INNER JOIN TWORKCENTER bb
      ON aa.WcCode = bb.WcCode
    WHERE aa.ApplyTo = '9999.12.31' AND bb.WcGubun = @ps_workgubun

    select @li_totcnt = @@rowcount
    select @li_cnt = 0

    while @li_cnt <= (@li_totcnt - 1)
      Begin
        select top 1 @ls_empno = EmpNo
        from #tmp_empno
        where id_num > @li_cnt
        order by id_num
        
        select @li_cnt = @li_cnt + 1
        
        If @li_cnt = 1
          UPDATE TWORKREPORT
            SET EmpNo1 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 2
          UPDATE TWORKREPORT
            SET EmpNo2 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 3
          UPDATE TWORKREPORT
            SET EmpNo3 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 4
          UPDATE TWORKREPORT
            SET EmpNo4 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 5
          UPDATE TWORKREPORT
            SET EmpNo5 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 6
          UPDATE TWORKREPORT
            SET EmpNo6 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 7
          UPDATE TWORKREPORT
            SET EmpNo7 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 8
          UPDATE TWORKREPORT
            SET EmpNo8 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 9
          UPDATE TWORKREPORT
            SET EmpNo9 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 10
          UPDATE TWORKREPORT
            SET EmpNo10 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 11
          UPDATE TWORKREPORT
            SET EmpNo11 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
        If @li_cnt = 12
          UPDATE TWORKREPORT
            SET EmpNo12 = @ls_empno
            WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun
      End
  End

-- 조회
SELECT WorkDate, WorkGubun, OverTime2, OverTime3, EarlyTime, SpecialTime,
  DayMan, DayInputTime, NightMan, NightInputTime, EventMan, EventInputTime, EventMemo,
  SpecialMemo, ConfirmFlag, ConfirmEmp, SanctionFlag, SanctionEmp, EmpNo1, JobTime1,
  EmpNo2, JobTime2, EmpNo3, JobTime3, EmpNo4, JobTime4, EmpNo5, JobTime5,
  EmpNo6, JobTime6, EmpNo7, JobTime7, EmpNo8, JobTime8, EmpNo9, JobTime9,
  EmpNo10, JobTime10, EmpNo11, JobTime11, EmpNo12, JobTime12, LastEmp, LastDate
FROM TWORKREPORT
WHERE WorkDate = @ps_workdate AND WorkGubun = @ps_workgubun

End   -- Procedure End
Go
