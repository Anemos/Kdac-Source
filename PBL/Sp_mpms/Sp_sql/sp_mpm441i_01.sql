/*
  File Name : sp_mpm441i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm441i_01
  Description : OrderNo별 납기정보조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_yyyymm char(6)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm441i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm441i_01]
GO

/*
Execute sp_mpm441i_01 'A'
*/

Create Procedure sp_mpm441i_01
 @ps_versionno char(1)

As
Begin

select orderno = a.orderno,
  orderstart = (select min(inworkdate) from tloadpriority where orderno = a.orderno and versionno = @ps_versionno),
  orderend = (select max(outworkdate) from tloadpriority where orderno = a.orderno and versionno = @ps_versionno),
  toolname = c.toolname,
  partno = a.partno,
  operno = a.operno,
  wccode = a.wccode,
  stdtimesum = a.stdtimesum,
  inworkdate = a.inworkdate,
  outworkdate = a.outworkdate,
  outflag = a.outflag,
  plandate = b.plandate,
  allottime = b.allottime
from tloadpriority a left outer join tloadsimulation b
  on a.versionno = b.versionno and a.serialno = b.serialno
  inner join torder c
  on a.orderno = c.orderno
where a.versionno = @ps_versionno
order by a.serialno, b.plandate, b.lastdate

Return

End   -- Procedure End
Go
