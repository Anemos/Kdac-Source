/*
  File Name : sp_mpsg050u_save.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg050u_save
  Description : 실적등록 프로세스
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_codetype char(1),
              @ps_srno  char(10),
              @ps_orderno  char(8),
              @ps_partno char(6),
              @ps_operno char(3),
              @ps_wccode char(3),
              @ps_workdate char(10),
              @ps_workemp char(6),
              @ps_mchno char(5),
              @ps_jobtime int,
              @ps_processratio int,
              @ps_resultflag char(1),
              @ps_badstype  char(2),
              @ps_badsrno   char(10),
              @pi_err_code INT OUTPUT
  Use Table : tworkjob
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg050u_save]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg050u_save]
GO

/*
Execute sp_mpsg050u_save
  @ps_codetype char(1),
  @ps_srno  char(10),
  @ps_orderno  char(8),
  @ps_partno char(6),
  @ps_operno char(3),
  @ps_wccode char(3),
  @ps_workdate char(10),
  @ps_workemp char(6),
  @ps_mchno char(5),
  @ps_jobtime int,
  @ps_processratio int,
  @ps_resultflag char(1),
  @ps_badstype  char(2),
  @ps_badsrno   char(10),
  @pi_err_code = 0
*/

Create Procedure sp_mpsg050u_save
  @ps_codetype      char(1),
  @ps_srno          char(10),
  @ps_orderno       char(8),
  @ps_partno        char(6),
  @ps_operno        char(3),
  @ps_wccode        char(3),
  @ps_workdate      char(10),
  @ps_workemp       char(6),
  @ps_mchno         char(5),
  @ps_jobtime       int,
  @ps_processratio  int,
  @ps_resultflag    char(1),
  @ps_badstype      char(2),
  @ps_badsrno       char(10),
  @pi_err_code      INT OUTPUT

As
Begin       -- Procedure Start

Begin TRAN

Declare @ldt_systemtime   DateTime, -- 현재 DATETIME
  @ls_applydate   char(10), -- 마감을 적용안한 날자
  @ls_stype       char(2),
  @li_heatcost    int,
  @li_finalqty    int,
  @ls_check       char(1),
  @li_maxno       int,
  @li_processratio  int,
  @ls_rtn         varchar(5)

/*########################################################################################

  ERROR FLAG 초기화

########################################################################################*/

SELECT  @pi_err_code = 0

/*########################################################################################

  시스템 시간

########################################################################################*/

SELECT  @ldt_systemtime   = GETDATE()

EXEC  sp_mpms_get_applydate
  @ldt_systemtime,
  @ls_applydate   output

/*########################################################################################

  긴급전표 처리 - 공정순서 등록 및 WorkCenter 체크

########################################################################################*/

If @ps_codetype = 'C'
  BEGIN
    SELECT @li_maxno = cast(isnull(Max(Operno),'0') as integer)
    FROM TROUTING
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno

    SELECT @ps_operno = cast((@li_maxno + 10) as char(3))

    If Len(@ps_operno) = 2
      SELECT @ps_operno = '0' + @ps_operno

    -- 공정설계 데이타 등록
    If @ps_operno = '010' or @ps_processratio = 100
      BEGIN
        INSERT INTO TROUTING(OperNo, OrderNo, PartNo, WcCode,
          WorkStatus, OutFlag, WorkStart, StdTime, StdHeatCost, StdOutCost,
          WorkMatter, ResultFlag, LastEmp, LastDate)
        VALUES(@ps_operno, @ps_orderno, @ps_partno, @ps_wccode,
          case @ps_processratio when 100 then 'C' else 'P' end, case @ps_wccode when 'THT' then 'H' else 'N' end,
          @ldt_systemtime, 0,
          0, 0, '긴급전표', 'N', 'SYSTEM', @ldt_systemtime)

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
  END

/*########################################################################################

  기본정보

########################################################################################*/
IF @ps_codetype = 'B'
  BEGIN
    Select @ls_stype = 'WR'
    SELECT @li_finalqty = isnull(ScrapQty,0)
      FROM TBADHEAD
      WHERE Stype = @ps_badstype AND Srno = @ps_badsrno

    SELECT @li_processratio = sum(ProcessRatio)
    FROM TWORKJOB
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno AND
      BadStype = @ps_badstype AND BadSrno = @ps_badsrno AND Stype = 'WR'

    Select @li_processratio = @ps_processratio - isnull(@li_processratio,0)

    If @ps_processratio = 100
      BEGIN
        UPDATE TBADDETAIL
        SET WorkStatus = 'C'
        WHERE Stype = @ps_badstype AND Srno = @ps_badsrno AND
          ReOperNo = @ps_operno

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
  END
ELSE
  BEGIN
    Select @ls_stype = 'WC'
    SELECT @li_finalqty = (isnull(Qty1,0) + isnull(Qty2,0))
      FROM TPARTLIST
      WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno

    SELECT @li_processratio = sum(ProcessRatio)
    FROM TWORKJOB
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno AND
      Stype = 'WC'

    Select @li_processratio = @ps_processratio - isnull(@li_processratio,0)

    If @ps_processratio = 100 AND @ps_resultflag <> 'E'
      BEGIN
        UPDATE TROUTING
        SET WorkStatus = 'C'
        WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
  END

IF @ps_wccode = 'THT'
  BEGIN
    SELECT @li_heatcost = StdHeatCost
    FROM  TROUTING
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno
  END
ELSE
  Select @li_heatcost = 0

/*########################################################################################

  작업일 체크 및 작업일지 확인

########################################################################################*/

SELECT @ls_check = isnull(ResultFlag,'C')
FROM TMONTHJOB
WHERE Yearmm = convert(char(6),cast(@ps_workdate as datetime),112)

If @ls_check = 'C'
  Select @pi_err_code = @pi_err_code - 1

SELECT @ls_check = ConfirmFlag
FROM TWORKREPORT aa INNER JOIN TWORKCENTER bb
  ON aa.WorkGubun = bb.WcGubun AND bb.WcCode = @ps_wccode
WHERE WorkDate = @ps_workdate

If @ls_check = 'Y'
  Select @pi_err_code = @pi_err_code - 1

/*########################################################################################

  불량에 의한 재작업 처리 - 공정순서 등록 및 WorkCenter 체크

########################################################################################*/

If @ps_codetype <> 'B'
  BEGIN
    SELECT @li_maxno = COUNT(*)
      FROM TWORKJOB
      WHERE  OrderNo = @ps_orderno AND PartNo = @ps_partno AND
          OperNo = @ps_operno AND ResultFlag = 'E'

    If @li_maxno > 0
      BEGIN
        Execute sp_mpms_workstatus_chk
          @ps_orderno,
          @ps_partno,
          @ps_operno,
          @ls_rtn output

        If @ls_rtn <> 'OK'
          Select @pi_err_code = @pi_err_code - 1
      END
  END

/*########################################################################################

  작업실적등록

########################################################################################*/
INSERT INTO TWORKJOB(Stype, Srno, OrderNo, PartNo, OperNo,
  WcCode, WorkDate, WorkEmp, MchNo, HeatCost,
  OutCost, ScrapQty, FinalQty, JobTime, MchTime1, MchTime2, MchTime3,
  ResultFlag, JobMemo, BadStype, BadSrno, ProcessRatio, LastEmp, LastDate)
VALUES(@ls_stype, @ps_srno, @ps_orderno, @ps_partno, @ps_operno,
  @ps_wccode, convert(char(8),cast(@ps_workdate as datetime),112), @ps_workemp, @ps_mchno, @li_heatcost,
  0, 0, @li_finalqty, @ps_jobtime, 0, 0, 0,
  @ps_resultflag, '', @ps_badstype, @ps_badsrno, @li_processratio, 'SYSTEM', @ldt_systemtime)

Select @pi_err_code = @pi_err_code + @@ERROR

If @ps_resultflag = 'E'
  BEGIN
    INSERT INTO TBADHEAD(Stype, Srno, OrderNo, PartNo, BadOperNo,
      BadDate, WcCode, WorkMan, FindMan, PlanQty, ScrapQty, BadReason,
      ResultFlag, LastEmp)
    VALUES(@ls_stype, @ps_srno, @ps_orderno, @ps_partno, @ps_operno,
      convert(char(8),cast(@ps_workdate as datetime),112), @ps_wccode, @ps_workemp, @ps_workemp,
      @li_finalqty, 0, '', 'N', 'SYSTEM')

    Select @pi_err_code = @pi_err_code + @@ERROR
  END
-- ERROR 결정
IF @pi_err_code = 0
BEGIN
  COMMIT    TRAN
END
ELSE
BEGIN
  ROLLBACK  TRAN
END

RETURN  @pi_err_code

End   -- Procedure End
Go
