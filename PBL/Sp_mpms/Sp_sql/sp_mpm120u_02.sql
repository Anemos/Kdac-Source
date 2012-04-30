/*
  File Name : sp_mpm120u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm120u_02
  Description : 긴급전표 처리
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno  char(8),
              @pi_err_code INT OUTPUT
  Use Table : tworkjob
  Initial   : 2004.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm120u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm120u_02]
GO

/*
Execute sp_mpm120u_02
  @ps_orderno  char(8),
  @pi_err_code = 0
*/

Create Procedure sp_mpm120u_02
  @ps_orderno         char(8),
  @pi_err_code      INT OUTPUT

As
Begin       -- Procedure Start

Begin TRAN

Declare @ldt_systemtime   DateTime, -- 현재 DATETIME
  @ls_applydate   char(10), -- 마감을 적용안한 날자
  @ls_moldgubun       char(1),  -- 금형구분
  @ls_partno  char(6),
  @li_chkcnt  int

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

SELECT @ls_moldgubun = MoldGubun
FROM TORDER
WHERE OrderNo = @ps_orderno

If @@rowcount = 0
  Select @pi_err_code = @pi_err_code - 1

If @ls_moldgubun = 'P'
  Select @pi_err_code = @pi_err_code - 1

/*########################################################################################

  품목설계생성 및 체크

########################################################################################*/

SELECT @li_chkcnt = count(*)
FROM TPARTLIST
WHERE OrderNo = @ps_orderno

If @li_chkcnt > 1
  Select @pi_err_code = @pi_err_code - 1

If @li_chkcnt = 0 and @pi_err_code = 0
  Begin
    -- Create PartList
    INSERT INTO TPARTLIST(DetailNo, OrderNo, RevNo, PartName, PartNo, 
      SheetNo, Spec, Material, Qty1, Qty2, Weight, PartCost, Remark, SerialNo, LastEmp)
    SELECT 1, OrderNo, '00', ToolName, '001000',
      0, '', '999', OrderQty, 0, 0, 0, '', 1, 'SYSTEM'
    FROM TORDER
    WHERE OrderNo = @ps_orderno
    
    Select @pi_err_code = @pi_err_code + @@ERROR
    
    INSERT INTO TPARTLISTHIST  
		 ( DetailNo, OrderNo, RevNo, RevEmp, RevDate, PartName, PartNo, SheetNo,   
			Spec, Material, Qty1, Qty2, Weight, PartCost, Remark, SerialNo, LastEmp)  
		SELECT DetailNo, OrderNo, RevNo, 'SYSTEM', Convert(char(8),getdate(),112), PartName, PartNo, SheetNo,
		  Spec, Material, Qty1, Qty2, Weight, PartCost, Remark, SerialNo, LastEmp
		FROM TPARTLIST
		WHERE OrderNo = @ps_orderno AND PartNo = '001000'
		
		Select @pi_err_code = @pi_err_code + @@ERROR
		
  End

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

