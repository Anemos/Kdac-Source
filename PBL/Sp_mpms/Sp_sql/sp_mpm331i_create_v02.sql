/*
  File Name : sp_mpm331i_create.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm331i_create
  Description : 예상부하현황 데이타 생성
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tmpmcalendar
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm331i_create]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm331i_create]
GO

/*
Execute sp_mpm331i_create
*/

Create Procedure sp_mpm331i_create

As
Begin       -- Procedure Start

Declare @ldt_systemtime   DateTime, -- 현재 DATETIME
  @ls_refapplydate   char(10), -- 마감을 적용안한 날자
  @ls_applydate   char(10),
  @li_availtime   numeric(10,0),
  @li_totaltime   numeric(10,0),
  @li_unittime    numeric(10,0),
  @li_stdtime     numeric(10,0),
  @li_adjtime     numeric(10,0),
  @li_applyqty    numeric(5,0),
  @ls_preoperno   char(3),
  @li_totcnt      int,
  @li_cnt         int,
  @ls_orderno     char(8),
  @ls_partno      char(6),
  @ls_operno      char(3),
  @ls_wccode      char(3),
  @li_index       int,
  @ls_outflag     char(1)

/*########################################################################################

  시스템 시간

########################################################################################*/

truncate table tloadplan

SELECT  @li_index = 0
SELECT  @ldt_systemtime   = GETDATE()

EXEC  sp_mpms_get_applydate
  @ldt_systemtime,
  @ls_refapplydate   output

/*########################################################################################

  초기데이타 처리

########################################################################################*/
SELECT orderno = tmp.orderno,
  partno = tmp.partno,
  operno = tmp.operno,
  wccode = tmp.wccode,
  outflag = tmp.outflag,
  workdate = tmp.workdate,
  duedate = tmp.duedate,
  stdtime = tmp.stdtime,
  applyqty = tmp.applyqty,
  IDENTITY(int, 1,1) as id_num
into #tmp_routing
FROM ( select orderno = cc.orderno,
  partno = cc.partno,
  operno = cc.operno,
  wccode = cc.wccode,
  outflag = cc.outflag,
  stdtime = isnull(cc.stdtime,0),
  workdate = convert(char(10),cc.workstart,102),
  duedate = convert(char(10),aa.duedate,102),
  applyqty = isnull(bb.qty1,0) + isnull(bb.qty2,0),
  preworkstatus = isnull(( select top 1 workstatus from trouting
                where orderno = cc.orderno and partno = cc.partno and operno < cc.operno
                order by operno desc ),'C')
  from torder aa inner join tpartlist bb
    on aa.orderno = bb.orderno and aa.ingstatus <> 'C'
  inner join trouting cc
    on bb.orderno = cc.orderno and bb.partno = cc.partno and cc.workstatus <> 'C'
  ) tmp
WHERE tmp.preworkstatus = 'C'
ORDER BY tmp.stdtime

select @li_totcnt = @@rowcount
select @li_cnt = 0

while @li_cnt <= (@li_totcnt - 1)
  BEGIN
    select top 1 @ls_orderno = orderno,
      @ls_partno = partno,
      @ls_operno = operno,
      @ls_wccode = wccode,
      @ls_outflag = outflag,
      @li_unittime = stdtime,
      @li_applyqty = applyqty
    from #tmp_routing
    where id_num > @li_cnt
    order by id_num

    select @ls_applydate = @ls_refapplydate
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
    select @li_cnt = @li_cnt + 1
  END

DROP TABLE #tmp_routing

--- 03 : 작업예정일별로 공순 순차적으로 배치
/*
    --- 02 : 하위공순 배정 프로세스
    while @li_index = 0
      BEGIN
        SELECT top 1 @ls_applydate = workdate,
          @ls_preoperno = operno
        FROM TLOADPLAN
        WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno
        ORDER BY OperNo desc, WorkDate desc
        
        If @@rowcount = 0 or @ls_applydate <> @ls_refapplydate
          BREAK
        
        SELECT top 1 @ls_operno = bb.operno,
          @ls_wccode = bb.wccode,
          @li_unittime = isnull(bb.stdtime,0),
          @li_applyqty = ( isnull(aa.qty1,0) + isnull(aa.qty2,0))
        FROM TPARTLIST aa INNER JOIN TROUTING bb
          ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo
        WHERE bb.OrderNo = @ls_orderno AND bb.PartNo = @ls_partno AND bb.OperNo > @ls_preoperno
        ORDER BY bb.OperNo

        If @@rowcount = 0
          BREAK
        
        select @li_stdtime = @li_unittime * @li_applyqty
        select @li_adjtime = @li_stdtime
        --- 02-01 : 예정작업시간 배정 프로세스
        while @li_index = 0
          BEGIN
          --- 해당일자에 활용가능시간 체크
            select @li_availtime = isnull(sum( stdtime ),0)
            from tloadplan
            where workdate = @ls_applydate and wccode = @ls_wccode

            if @li_availtime >= 480 or @li_adjtime > @li_availtime
              BEGIN
                select @li_index = -1
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
        --- 02-01 END
        If @li_index = -1
          BEGIN
            select @li_index = 0
            BREAK
          END
        select @ls_preoperno = @ls_operno
      END
    --- 02 END
    */


Return

End   -- Procedure End
Go

