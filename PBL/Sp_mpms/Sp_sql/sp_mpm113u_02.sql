/*
  File Name : sp_mpm113u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm113u_02
  Description : 부서에 대한 인원조회및 추가
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_deptcode char(4)
  Use Table :
  Initial   : 2006.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm113u_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm113u_02]
GO

/*
Execute sp_mpm113u_02 
  @ps_deptcode 	= '8143',
*/

Create Procedure sp_mpm113u_02
  @ps_deptcode char(4)    /* 부서코드 */


As
Begin

/*########################################################################################

해당부서에 대한 인원을 가져오고 신규입사자및퇴사자는 자동업데이트한다.

########################################################################################*/

-- 추가
INSERT INTO TMOLDEMPNO(EmpNo, EmpName, DeptCode, WcCode, ApplyFrom, ApplyTo, LastEmp, LastDate)
SELECT aa.EmpNo, aa.EmpName, aa.DeptCode, null, aa.EmpEnterDate, 
'9999.12.31','SYSTEM',getdate()
FROM TMSTEMP aa
WHERE aa.DeptCode = @ps_deptcode AND aa.RetireGubun <> 'Y' AND
  NOT EXISTS ( SELECT bb.EmpNo FROM TMOLDEMPNO bb WHERE aa.EmpNo = bb.EmpNo AND aa.DeptCode = bb.DeptCode )

--퇴사
UPDATE TMOLDEMPNO
SET ApplyTo = convert(char(10),getdate(),102)
FROM TMSTEMP aa INNER JOIN TMOLDEMPNO bb
  ON aa.EmpNo = bb.EmpNo AND aa.DeptCode = bb.DeptCode
WHERE aa.DeptCode = @ps_deptcode AND aa.RetireGubun = 'Y'

-- 조회
SELECT EmpNo, EmpName, DeptCode, WcCode, ApplyFrom, ApplyTo, LastEmp, LastDate
FROM TMOLDEMPNO
WHERE DeptCode = @ps_deptcode

End   -- Procedure End
Go
