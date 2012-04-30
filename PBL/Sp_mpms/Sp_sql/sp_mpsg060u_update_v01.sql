/*
  File Name : sp_mpsg060u_update.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg060u_update
  Description : ������� �������μ���
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_stype  char(2),
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
      Where id = object_id(N'[dbo].[sp_mpsg060u_update]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg060u_update]
GO

/*
Execute sp_mpsg060u_update
  @ps_stype  char(2),
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

Create Procedure sp_mpsg060u_update
  @ps_stype         char(2),
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

Declare @ldt_systemtime   DateTime, -- ���� DATETIME
  @ls_applydate   char(10), -- ������ ������� ����
  @ls_stype       char(2),
  @li_heatcost    int,
  @li_finalqty    int,
  @ls_check       char(1),
  @li_maxno       int,
  @li_processratio  int,
  @ls_rtn         varchar(5),
  @ls_postoperno  char(3)

/*########################################################################################

  ERROR FLAG �ʱ�ȭ

########################################################################################*/

SELECT  @pi_err_code = 0

/*########################################################################################

  �ý��� �ð�

########################################################################################*/

SELECT  @ldt_systemtime   = GETDATE()

EXEC  sp_mpms_get_applydate
  @ldt_systemtime,
  @ls_applydate   output

/*########################################################################################

  �⺻����

########################################################################################*/

IF @ps_wccode = 'THT'
  BEGIN
    SELECT @li_heatcost = StdHeatCost
    FROM  TROUTING
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno
  END
ELSE
  Select @li_heatcost = 0

/*########################################################################################

  �۾��� üũ �� �۾����� Ȯ��

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

  �������� ��� �� �۾����� üũ

########################################################################################*/

IF @ps_stype = 'WR'
  BEGIN
    SELECT @li_finalqty = isnull(ScrapQty,0)
      FROM TBADHEAD
      WHERE Stype = @ps_badstype AND Srno = @ps_badsrno

    SELECT @li_processratio = sum(ProcessRatio)
    FROM TWORKJOB
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno AND
      BadStype = @ps_badstype AND BadSrno = @ps_badsrno AND Stype = 'WR'

    IF @ps_processratio = 100 AND @li_processratio <> 100
      BEGIN
        UPDATE TBADDETAIL
        SET WorkStatus = 'C'
        WHERE Stype = @ps_badstype AND Srno = @ps_badsrno AND
          ReOperNo = @ps_operno

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
    IF @ps_processratio <> 100 AND @li_processratio = 100
      BEGIN
        SELECT TOP 1 @ls_postoperno = ReOperNo 
        FROM TBADDETAIL
        WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND ReOperNo > @ps_operno
        ORDER BY ReOperNo
        
        If @@ROWCOUNT > 0
          BEGIN
            SELECT @li_maxno = COUNT(*)
            FROM TWORKJOB
            WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ls_postoperno AND
              BadStype = @ps_badstype AND BadSrno = @ps_badsrno AND Stype = 'WR'
              
            If @li_maxno > 0
              Select @pi_err_code = @pi_err_code - 1
            Else
              BEGIN
                UPDATE TBADDETAIL
                SET WorkStatus = 'P'
                WHERE Stype = @ps_badstype AND Srno = @ps_badsrno AND
                  ReOperNo = @ps_operno
                  
                Select @pi_err_code = @pi_err_code + @@ERROR
              END
          END
        Else
          BEGIN
            UPDATE TBADDETAIL
            SET WorkStatus = 'P'
            WHERE Stype = @ps_badstype AND Srno = @ps_badsrno AND
              ReOperNo = @ps_operno
                  
            Select @pi_err_code = @pi_err_code + @@ERROR
          END
      END
    
    SELECT @li_processratio = @ps_processratio + isnull(ProcessRatio,0) - isnull(@li_processratio,0)
    FROM TWORKJOB
    WHERE Stype = @ps_stype AND Srno = @ps_srno
  END
ELSE
  BEGIN
    SELECT @li_finalqty = (isnull(Qty1,0) + isnull(Qty2,0))
      FROM TPARTLIST
      WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno

    SELECT @li_processratio = sum(ProcessRatio)
    FROM TWORKJOB
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno AND
      Stype = 'WC'

    IF @ps_processratio = 100 AND @li_processratio <> 100
      BEGIN
        UPDATE TROUTING
        SET WorkStatus = 'C'
        WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND 
          OutFlag <> 'P' AND OperNo = @ps_operno

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
    IF @ps_processratio <> 100 AND @li_processratio = 100
      BEGIN
        SELECT TOP 1 @ls_postoperno = OperNo
        FROM TROUTING
        WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND 
          OutFlag <> 'P' and OperNo > @ps_operno
        ORDER BY Operno
        
        If @@ROWCOUNT > 0
          BEGIN
            SELECT @li_maxno = COUNT(*)
            FROM TWORKJOB
            WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND 
              OperNo = @ls_postoperno AND Stype = 'WC'
              
            If @li_maxno > 0
              Select @pi_err_code = @pi_err_code - 1
            Else
              BEGIN
                UPDATE TROUTING
                SET WorkStatus = 'P'
                WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno

                Select @pi_err_code = @pi_err_code + @@ERROR
              END
          END
        Else
          BEGIN
            UPDATE TROUTING
            SET WorkStatus = 'P'
            WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OperNo = @ps_operno

            Select @pi_err_code = @pi_err_code + @@ERROR
          END
      END
    SELECT @li_processratio = @ps_processratio + isnull(ProcessRatio,0) - isnull(@li_processratio,0)
    FROM TWORKJOB
    WHERE Stype = @ps_stype AND Srno = @ps_srno
  END

/*########################################################################################

  �����ǥ ó�� - �������� ��� �� WorkCenter üũ

########################################################################################*/



/*########################################################################################

  �۾��������

########################################################################################*/
UPDATE TWORKJOB
SET WorkDate = convert(char(8),cast(@ps_workdate as datetime),112),
    WorkEmp = @ps_workemp,
    MchNo = @ps_mchno,
    JobTime = @ps_jobtime,
    ProcessRatio = @li_processratio,
    LastDate = @ldt_systemtime
WHERE Stype = @ps_stype AND Srno = @ps_srno

Select @pi_err_code = @pi_err_code + @@ERROR

-- ERROR ����
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
