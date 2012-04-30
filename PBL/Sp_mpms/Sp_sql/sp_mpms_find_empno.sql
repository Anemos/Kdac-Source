/*
  File Name : sp_mpms_find_empno.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpms_find_empno
  Description : 해당사번 가져오기
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_gubun char(1), @ps_query varchar(100)
  Use Table :
  Initial   : 2004.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_find_empno]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_find_empno]
GO

/*
Execute sp_mpms_find_empno
*/

Create Procedure sp_mpms_find_empno

As
Begin

select empno = aa.empno,
	empname = aa.empname,
 	deptcode = bb.deptcode,
	deptname = bb.deptname
from tmstemp aa left outer join tmstdept bb
  on aa.deptcode = bb.deptcode
where bb.deptname like '%엔지%' and aa.retiregubun <> 'Y'
order by bb.deptcode, aa.empname

End   -- Procedure End
Go
