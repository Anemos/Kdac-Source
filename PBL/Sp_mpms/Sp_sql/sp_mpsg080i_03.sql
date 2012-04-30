/*
  File Name : sp_mpsg080i_03.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg080i_03
  Description : 작업자 가져오기
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_wcgubun  varchar(3)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg080i_03]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg080i_03]
GO

/*
Execute sp_mpsg080i_03
  @ps_wcgubun    = 'A'
*/

Create Procedure sp_mpsg080i_03
  @ps_wcgubun char(1)

As
Begin

/*########################################################################################

작업자정보
등록된부서코드에 해당하는 사원만 해당함.
########################################################################################*/

Select EmpNo = 'ALL',
    EmpName = '전체',
    DeptCode = '',
    DeptName = ''

Union All

Select EmpNo = bb.EmpNo,
    EmpName = bb.EmpName,
    DeptCode = aa.DeptCode,
    DeptName = aa.DeptName
From tmolddept aa inner join tmoldempno bb
  on aa.deptcode = bb.deptcode
  inner join tworkcenter cc
  on bb.wccode = cc.wccode
Where cc.wcgubun like @ps_wcgubun
Order by bb.empno

End   -- Procedure End
Go
