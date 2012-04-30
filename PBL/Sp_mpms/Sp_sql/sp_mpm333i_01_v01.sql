/*
  File Name : sp_mpm333i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm333i_01
  Description : 예상대비실시간 편차 (예상작업시간, 실시간작업시간 )
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(8)
  Use Table :
  Initial   : 2004.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm333i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm333i_01]
GO

/*
Execute sp_mpm333i_01 '20040000'
*/

Create Procedure sp_mpm333i_01
  @ps_orderno varchar(8)
As
Begin

-- All Order
Select OrderNo = @ps_orderno,
  PartNo = 'ALL',
  SerialNo = 0,
  StdTime = Sum(convert(decimal(6,1),isnull(bb.StdTime * (isnull(dd.Qty1,0) + isnull(dd.Qty2,0)),0) / 60)),
  JobTime = Sum(isnull(tmp.jobtime,0))
From torder aa inner join tpartlist dd
  on aa.orderno = dd.orderno and aa.ingstatus <> 'C'
  inner join trouting bb
  on dd.orderno = bb.orderno and dd.partno = bb.partno and bb.workstatus = 'C'
  left outer join ( select orderno = cc.orderno, 
    partno = cc.partno,
    operno = cc.operno,
    jobtime = Sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60)) 
    from tworkjob cc
    where cc.orderno = @ps_orderno
    group by cc.orderno, cc.partno, cc.operno ) tmp
  on bb.orderno = tmp.orderno and bb.partno = tmp.partno and bb.operno = tmp.operno
Where bb.orderno = @ps_orderno
  
Union All
--Each Order, PartNo
Select OrderNo = bb.orderno,
  PartNo = bb.partno,
  Serialno = dd.serialno,
  StdTime = Sum(convert(decimal(6,1),isnull(bb.StdTime * (isnull(dd.Qty1,0) + isnull(dd.Qty2,0)),0) / 60)),
  JobTime = Sum(isnull(tmp.jobtime,0))
From torder aa inner join tpartlist dd
  on aa.orderno = dd.orderno and aa.ingstatus <> 'C'
  inner join trouting bb
  on dd.orderno = bb.orderno and dd.partno = bb.partno and bb.workstatus = 'C'
  left outer join ( select orderno = cc.orderno,
    partno = cc.partno,
    operno = cc.operno,
    jobtime = Sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60)) 
    from tworkjob cc
    where cc.orderno = @ps_orderno
    group by cc.orderno, cc.partno, cc.operno ) tmp
  on bb.orderno = tmp.orderno and bb.partno = tmp.partno and bb.operno = tmp.operno
Where bb.orderno = @ps_orderno
Group by bb.orderno, bb.partno, dd.serialno
Order by dd.serialno

End   -- Procedure End
Go
