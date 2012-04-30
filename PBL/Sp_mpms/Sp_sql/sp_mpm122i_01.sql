/*
  File Name : sp_mpm122i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm122i_01
  Description : 금형완료정보 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_firstdt datetime
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm122i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm122i_01]
GO

/*
Execute sp_mpm122i_01
*/

Create Procedure sp_mpm122i_01
  @ps_firstdt datetime

As
Begin

declare @ls_lastdt datetime
select @ls_lastdt = dateadd(dd,-1,dateadd(mm,1,@ps_firstdt))
select orderno = aa.orderno, 
  toolname = aa.toolname, 
  drawingno = aa.drawingno, 
  productname = aa.productname, 
  orderdept = aa.orderdept,
  deptname = bb.deptname, 
  desingname = aa.designman, 
  empname = cc.empname, 
  duedate = aa.duedate, 
  foredate = aa.foredate,
  enddate = aa.enddate
from  torder aa left outer join tmstdept bb
      on aa.orderdept = bb.deptcode
      left outer join tmstemp cc
      on aa.designman = cc.empno
where aa.ingstatus = 'C' and aa.deptgubun = '1' and
  aa.enddate >= @ps_firstdt and aa.enddate <= @ls_lastdt

union all

select orderno = aa.orderno, 
  toolname = aa.toolname, 
  drawingno = aa.drawingno, 
  productname = aa.productname, 
  orderdept = aa.orderdept,
  custname = bb.custname, 
  designman = aa.designman, 
  empname = cc.empname, 
  duedate = aa.duedate, 
  foredate = aa.foredate,
  enddate = aa.enddate
from  torder aa left outer join tcustomer bb
      on aa.orderdept = bb.custcode
      left outer join tmstemp cc
      on aa.designman = cc.empno
where aa.ingstatus = 'C' and aa.deptgubun = '2' and
  aa.enddate >= @ps_firstdt and aa.enddate <= @ls_lastdt

End   -- Procedure End
Go
