/*
  File Name : sp_mpms_find_dept.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpms_find_dept
  Description : 사내부서, 사외업체 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_gubun char(1), @ps_query varchar(100)
  Use Table :
  Initial   : 2004.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_find_dept]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_find_dept]
GO

/*
Execute sp_mpms_find_dept @ps_gubun, @ps_query
*/

Create Procedure sp_mpms_find_dept
  @ps_gubun char(1),
  @ps_query varchar(100)
As
Begin

if @ps_gubun = '1'

select findcode = cast(aa.deptcode as varchar(5)), 
    findname = cast(aa.deptname as varchar(50))
from tmstdept aa
where aa.deptname like @ps_query

else

select findcode = cast(aa.custcode as varchar(5)), 
    findname = cast(aa.custname as varchar(50))
from tcustomer aa
where aa.custname like @ps_query

End   -- Procedure End
Go
