/*
  File Name : sp_mpm113u_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm113u_02
  Description : �μ��� ���� �ο���ȸ�� �߰�
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
  @ps_deptcode char(4)    /* �μ��ڵ� */


As
Begin

/*########################################################################################

�ش�μ��� ���� �ο��� �������� �ű��Ի��ڹ�����ڴ� �ڵ�������Ʈ�Ѵ�.

########################################################################################*/

-- �߰�
INSERT INTO TMOLDEMPNO(EmpNo, EmpName, DeptCode, WcCode, ApplyFrom, ApplyTo, LastEmp, LastDate)
SELECT aa.EmpNo, aa.EmpName, aa.DeptCode, null, aa.EmpEnterDate, 
'9999.12.31','SYSTEM',getdate()
FROM TMSTEMP aa
WHERE aa.DeptCode = @ps_deptcode AND aa.RetireGubun <> 'Y' AND
  NOT EXISTS ( SELECT bb.EmpNo FROM TMOLDEMPNO bb WHERE aa.EmpNo = bb.EmpNo AND aa.DeptCode = bb.DeptCode )

--���
UPDATE TMOLDEMPNO
SET ApplyTo = convert(char(10),getdate(),102)
FROM TMSTEMP aa INNER JOIN TMOLDEMPNO bb
  ON aa.EmpNo = bb.EmpNo AND aa.DeptCode = bb.DeptCode
WHERE aa.DeptCode = @ps_deptcode AND aa.RetireGubun = 'Y'

-- ��ȸ
SELECT EmpNo, EmpName, DeptCode, WcCode, ApplyFrom, ApplyTo, LastEmp, LastDate
FROM TMOLDEMPNO
WHERE DeptCode = @ps_deptcode

End   -- Procedure End
Go
