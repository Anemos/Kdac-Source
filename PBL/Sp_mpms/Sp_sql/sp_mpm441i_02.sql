/*
  File Name : sp_mpm441i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm441i_02
  Description : 작업일자별 납기정보조회
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_yyyymm char(6)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm441i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm441i_02]
GO

/*
Execute sp_mpm441i_02 'A'
*/

Create Procedure sp_mpm441i_02
 @ps_versionno char(1)

As
Begin

select plandate = b.plandate,
  wccode = a.wccode,
  lifetime = d.lifetime,
  orderno = a.orderno,
  toolname = c.toolname,
  partno = a.partno,
  operno = a.operno,
  stdtimesum = a.stdtimesum,
  inworkdate = a.inworkdate,
  outworkdate = a.outworkdate,
  outflag = a.outflag,
  allottime = b.allottime
from tloadpriority a left outer join tloadsimulation b
  on a.versionno = b.versionno and a.serialno = b.serialno
  inner join torder c
  on a.orderno = c.orderno
  inner join tloadavailtime d
  on b.versionno = d.versionno and b.plandate = d.plandate and b.wccode = d.wccode
where a.versionno = @ps_versionno
order by b.plandate, a.wccode, a.serialno, b.lastdate

Return

End   -- Procedure End
Go
