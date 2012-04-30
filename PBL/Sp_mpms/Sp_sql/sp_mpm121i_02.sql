/*
  File Name : sp_mpm121i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm121i_02
  Description : 완료상태가 아닌 금형 진행정보
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno char(8)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm121i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm121i_02]
GO

/*
Execute sp_mpm121i_02 '20040001'
*/

Create Procedure sp_mpm121i_02
  @ps_orderno char(8)

As
Begin

select aa.orderno, aa.toolname, aa.ingstatus, aa.duedate, bb.partno, 
  bb.partname, cc.operno, cc.wccode, cc.workstatus, dd.workdate, dd.workemp, 
  dd.mchno, dd.jobtime
from torder aa left outer join tpartlist bb
    on aa.orderno = bb.orderno
    left outer join trouting cc
    on bb.orderno = cc.orderno and bb.partno = cc.partno
    left outer join tworkjob dd
    on cc.orderno = dd.orderno and cc.partno = dd.partno and
      cc.operno = dd.operno
where aa.OrderNo = @ps_orderno
order by aa.orderno, bb.partno, cc.operno

End   -- Procedure End
Go
