/*
  File Name : sp_mpm331i_create_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm331i_create_01
  Description : 일자별 예상부하현황 데이타 생성
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tmpmcalendar
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm331i_create_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm331i_create_01]
GO

/*
Declare @pi_rtn int
select @pi_rtn = 0

Execute sp_mpm331i_create_01
  @ps_applydate = '2006.06.08',
  @ps_wccode = 'TSG',
  @pi_err_code = @pi_rtn OUTPUT
  
select @pi_rtn
*/

Create Procedure sp_mpm331i_create_01
  @ps_applydate     char(10),
  @ps_wccode        char(3),
  @pi_err_code      INT OUTPUT
  
As
Begin       -- Procedure Start

Declare @ls_applydate   char(10),
  @li_availtime   numeric(10,0),
  @li_totaltime   numeric(10,0),
  @li_unittime    numeric(10,0),
  @li_stdtime     numeric(10,0),
  @li_adjtime     numeric(10,0),
  @li_applyqty    numeric(5,0),
  @li_totcnt1     int,
  @li_totcnt2     int,
  @ls_orderno     char(8),
  @ls_partno      char(6),
  @ls_operno      char(3),
  @ls_postoperno  char(3),
  @ls_preoperno   char(3),
  @ls_wccode      char(3),
  @li_index       int,
  @li_cnt         int,
  @ls_outflag     char(1),
  @ls_preworkdate  char(10)

/*########################################################################################

  초기데이타 처리

########################################################################################*/
create table #tmp_load
( orderno char(8) null,
  partno  char(6) null,
  operno  char(3) null,
  operno1 char(3) null,
  operno2 char(3) null,
  wccode  char(3) null,
  outflag char(1) null,
  unittime numeric(10,0) null,
  applyqty  numeric(5,0) null )

select @li_index = 0
while @li_index = 0
  BEGIN
    select @li_availtime = isnull(sum( stdtime ),0)
    from tloadplan
    where workdate = @ps_applydate and wccode = @ls_wccode

    if @li_availtime >= 480
      BEGIN
        select @pi_err_code = 0
        BREAK
      END
    
    -- 작업예상 다음공순 찾기
    SELECT @ls_orderno = cc.orderno,
      @ls_partno = cc.partno,
      @ls_operno = cc.operno,
      @ls_preoperno = dd.operno,
      @ls_preworkdate = dd.workdate,
      @ls_wccode = cc.wccode,
      @ls_outflag = cc.outflag,
      @li_unittime = isnull(cc.stdtime,0),
      @li_applyqty = isnull(bb.qty1,0) + isnull(bb.qty2,0)
    INTO #load_tmp
    FROM tpartlist bb inner join trouting cc
      on bb.orderno = cc.orderno and bb.partno = cc.partno
      inner join v_tloadplan01 dd
      on cc.orderno = dd.orderno and cc.partno = dd.partno and cc.operno = dd.postoperno
    WHERE cc.wccode = @ps_wccode
    
    select @li_totcnt1 = @@rowcount
    select @li_cnt = 0
    while @li_cnt < (@li_totcnt1 - 1)
      BEGIN
        --- 작업일에 대한 W/C가용시간체크
        select @li_availtime = isnull(sum( stdtime ),0)
        from tloadplan
        where workdate = @ps_applydate and wccode = @ls_wccode

        if @li_availtime >= 480
          BEGIN
            select @pi_err_code = 0
            return
          END
        --- 전공정 작업일 체크
        select @ls_preworkdate = max(workdate)
        from tloadplan
        where orderno = @ls_orderno and partno = @ls_partno and operno = @ls_postoperno
        
        if @ps_applydate > @ls_preworkdate
          BEGIN
            select @pi_err_code = 0
            return
          END
        --- 후공정 W/C의 가용시간 존재 여부
        select top 1 @ls_postoperno = operno from trouting
        where orderno = @ls_orderno and partno = @ls_partno and operno > bb.operno
        order by operno
        
        --- 데이타 생성 ( 작업한 시간, 작업하기 위한 시간 계산 )
      END
    
    if @li_totcnt1 = 0
      BEGIN
        -- 현재 라우팅에서 작업예상 공순
        SELECT TOP 1 @ls_orderno = tmp.orderno,
          @ls_partno = tmp.partno,
          @ls_operno = tmp.operno,
          @ls_wccode = tmp.wccode,
          @ls_outflag = tmp.outflag,
          @li_unittime = tmp.stdtime,
          @li_applyqty = tmp.applyqty
        FROM ( select orderno = cc.orderno,
          partno = cc.partno,
          operno = cc.operno,
          wccode = cc.wccode,
          outflag = cc.outflag,
          stdtime = isnull(cc.stdtime,0),
          workdate = convert(char(10),cc.workstart,102),
          applyqty = isnull(bb.qty1,0) + isnull(bb.qty2,0),
          preworkstatus = isnull(( select top 1 workstatus from trouting
                where orderno = cc.orderno and partno = cc.partno and operno < cc.operno
                order by operno desc ),'C')
          from torder aa inner join tpartlist bb
            on aa.orderno = bb.orderno and aa.ingstatus <> 'C'
            inner join trouting cc
            on bb.orderno = cc.orderno and bb.partno = cc.partno and cc.workstatus <> 'C'
          where not exists( select dd.orderno from tloadplan dd
            where cc.orderno = dd.orderno and cc.partno = dd.partno )
          ) tmp
        WHERE tmp.preworkstatus = 'C' and tmp.wccode = @ps_wccode
        
        select @li_totcnt2 = @@rowcount
      END
    if @li_totcnt1 = 0 and @li_totcnt2 = 0
      BEGIN
        select @pi_err_code = -1
        BREAK
      END
    
    select @ls_applydate = @ps_applydate
    select @li_stdtime = @li_unittime * @li_applyqty
    select @li_adjtime = @li_stdtime
    --- 01 : 단위수량당 예정작업시간 배정 프로세스
    while @li_index = 0
      BEGIN
        --- 해당일자에 활용가능시간 체크
        while @li_index = 0
          BEGIN
            select @li_availtime = isnull(sum( stdtime ),0)
            from tloadplan
            where workdate = @ls_applydate and wccode = @ls_wccode

            if @li_availtime >= 480
              BEGIN
                select top 1 @ls_applydate = applydate from tmpmcalendar
                where applydate > @ls_applydate and workgubun = 'W'
                order by applydate

                if @@rowcount = 0
                  RETURN
              END
            else
              BREAK
          END

        select @li_totaltime = @li_adjtime - (480 - @li_availtime)
        --- 작업시간 당일 여유시간보다 큰 경우
        If @li_totaltime > 0
          BEGIN
            INSERT INTO TLOADPLAN(WorkDate, OrderNo, PartNo, OperNo, TotalQty, WcCode, StdSumTime, StdTime)
              VALUES(@ls_applydate, @ls_orderno, @ls_partno, @ls_operno, @li_applyqty, @ls_wccode, @li_stdtime, (480 - @li_availtime))

            select @li_adjtime = @li_totaltime
          END
        Else
          BEGIN
            INSERT INTO TLOADPLAN(WorkDate, OrderNo, PartNo, OperNo, TotalQty, WcCode, StdSumTime, StdTime)
              VALUES(@ls_applydate, @ls_orderno, @ls_partno, @ls_operno, @li_applyqty, @ls_wccode, @li_stdtime, @li_adjtime)
            BREAK
          END
      END
    --- 01 END
  END

Return

End   -- Procedure End
Go

