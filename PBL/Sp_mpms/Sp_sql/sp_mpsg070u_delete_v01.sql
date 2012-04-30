/*
  File Name : sp_mpsg070u_delete.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg070u_delete
  Description : 실적등록 삭제프로세스
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_stype  char(2),
              @ps_srno  char(10),
              @pi_err_code INT OUTPUT
  Use Table : tworkjob
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg070u_delete]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg070u_delete]
GO

/*
Execute sp_mpsg070u_delete
  @ps_stype  char(2),
  @ps_srno  char(10),
  @pi_err_code = 0
*/

Create Procedure sp_mpsg070u_delete
  @ps_stype         char(2),
  @ps_srno          char(10),
  @pi_err_code      INT OUTPUT

As
Begin       -- Procedure Start

Begin TRAN

Declare @ldt_systemtime   DateTime, -- 현재 DATETIME
  @ls_applydate   char(10), -- 마감을 적용안한 날자
  @ls_stype       char(2),
  @ls_check       char(1),
  @li_maxno       int,
  @li_processratio  int,
  @ls_rtn         varchar(5),
  @ls_orderno     char(8),
  @ls_partno      char(6),
  @ls_operno      char(3),
  @ls_postoperno  char(3),
  @ls_badstype    char(2),
  @ls_badsrno     char(10),
  @ls_workdate    char(8),
  @ls_resultflag  char(1),
  @ls_wccode      char(3)

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

  기본정보

########################################################################################*/

SELECT @ls_orderno = OrderNo,
  @ls_partno = PartNo,
  @ls_operno = OperNo,
  @ls_badstype = BadStype,
  @ls_badsrno = BadSrno,
  @ls_workdate = WorkDate,
  @ls_resultflag = ResultFlag,
  @ls_wccode = WcCode
FROM TWORKJOB
WHERE Stype = @ps_stype AND Srno = @ps_srno

If @@rowcount = 0
  Select @pi_err_code = @pi_err_code - 1

/*########################################################################################

  작업일 체크 및 작업일지 확인

########################################################################################*/

SELECT @ls_check = isnull(ResultFlag,'C')
FROM TMONTHJOB
WHERE Yearmm = Substring(@ls_workdate,1,6)

If @ls_check = 'C'
  Select @pi_err_code = @pi_err_code - 1

SELECT @ls_check = ConfirmFlag
FROM TWORKREPORT aa INNER JOIN TWORKCENTER bb
  ON aa.WorkGubun = bb.WcGubun AND bb.WcCode = @ls_wccode
WHERE WorkDate = convert(char(10),cast(@ls_workdate as datetime),102)

If @ls_check = 'Y'
  Select @pi_err_code = @pi_err_code - 1

/*########################################################################################

  공정순서 등록 및 작업상태 체크 - 후공정작업 존재여부

########################################################################################*/

IF @ps_stype = 'WR'
  BEGIN
    SELECT @li_processratio = sum(ProcessRatio)
    FROM TWORKJOB
    WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND OperNo = @ls_operno AND
      BadStype = @ls_badstype AND BadSrno = @ls_badsrno AND Stype = 'WR'

    SELECT TOP 1 @ls_postoperno = ReOperNo
    FROM TBADDETAIL
    WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND ReOperNo > @ls_operno
    ORDER BY ReOperNo

    If @@ROWCOUNT > 0
      BEGIN
        SELECT @li_maxno = COUNT(*)
        FROM TWORKJOB
        WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND OperNo = @ls_postoperno AND
          BadStype = @ls_badstype AND BadSrno = @ls_badsrno AND Stype = 'WR'

        If @li_maxno > 0
          Select @pi_err_code = @pi_err_code - 1
      END

    If @li_processratio = 100
      BEGIN
        UPDATE TBADDETAIL
        SET WorkStatus = 'P'
        WHERE Stype = @ls_badstype AND Srno = @ls_badsrno AND
          ReOperNo = @ls_operno

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
  END
ELSE
  BEGIN
    SELECT @li_processratio = sum(ProcessRatio)
    FROM TWORKJOB
    WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND OperNo = @ls_operno AND
      Stype = 'WC'

    SELECT TOP 1 @ls_postoperno = OperNo
    FROM TROUTING
    WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND 
      OutFlag <> 'P' AND OperNo > @ls_operno
    ORDER BY Operno

    If @@ROWCOUNT > 0
      BEGIN
        SELECT @li_maxno = COUNT(*)
        FROM TWORKJOB
        WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND
          OperNo = @ls_postoperno AND Stype = 'WC'

        If @li_maxno > 0
          Select @pi_err_code = @pi_err_code - 1
      END

    IF @li_processratio = 100
      BEGIN
        UPDATE TROUTING
        SET WorkStatus = 'P'
        WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND OperNo = @ls_operno

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
    IF @ls_resultflag = 'E'
      BEGIN
        SELECT @li_maxno = COUNT(*)
        FROM TBADHEAD aa INNER JOIN TBADDETAIL bb
          ON aa.Stype = bb.Stype AND aa.Srno = bb.Srno
        WHERE aa.Stype = @ps_stype AND aa.Srno = @ps_srno

        If @li_maxno > 0
          Select @pi_err_code = @pi_err_code - 1
        Else
          BEGIN
            DELETE FROM TBADHEAD
            WHERE Stype = @ps_stype AND Srno = @ps_srno

            Select @pi_err_code = @pi_err_code + @@ERROR
          END
      END
  END

/*########################################################################################

  긴급전표 처리 - 공정순서 등록 및 WorkCenter 체크

########################################################################################*/
If @ls_partno = '001000'
  Begin
    SELECT @li_maxno = COUNT(*)
    FROM TPARTLIST
    WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno
    
    If @li_maxno = 1
      Begin
        SELECT @li_maxno = COUNT(*)
        FROM TWORKJOB
        WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND OperNo = @ls_operno
        
        If @li_maxno = 0 
          Begin
            DELETE FROM TROUTING
            WHERE OrderNo = @ls_orderno AND PartNo = @ls_partno AND OperNo = @ls_operno
            
            Select @pi_err_code = @pi_err_code + @@ERROR
          End
      End
  End

/*########################################################################################

  작업실적등록

########################################################################################*/
DELETE TWORKJOB
WHERE Stype = @ps_stype AND Srno = @ps_srno

Select @pi_err_code = @pi_err_code + @@ERROR

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

