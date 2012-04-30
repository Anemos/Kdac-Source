/*
  File Name : sp_mpsg050u_03.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg050u_03
  Description : �۾��� ��������
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_wccode  varchar(3)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg050u_03]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg050u_03]
GO

/*
Execute sp_mpsg050u_03 
	@ps_wccode    = 'TWC'
*/

Create Procedure sp_mpsg050u_03
  @ps_wccode varchar(3)

As
Begin

/*########################################################################################

�۾�������
��ϵȺμ��ڵ忡 �ش��ϴ� ����� �ش���.
########################################################################################*/

Select EmpNo = bb.EmpNo,
    EmpName = bb.EmpName,
    DeptCode = aa.DeptCode,
    DeptName = aa.DeptName
From tmolddept aa inner join tmoldempno bb
  on aa.deptcode = bb.deptcode
Where bb.wccode like @ps_wccode
Order by bb.empno

End   -- Procedure End
Go
