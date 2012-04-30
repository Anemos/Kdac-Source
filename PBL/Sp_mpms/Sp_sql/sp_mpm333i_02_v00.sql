/*
  File Name : sp_mpm333i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm333i_02
  Description : 예상대비실시간편차율 - W/C별
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(8), @ps_partno varchar(6)
  Use Table :
  Initial   : 2004.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm333i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm333i_02]
GO

/*
Execute sp_mpm333i_02 '20040000','049031'
*/

Create Procedure sp_mpm333i_02
  @ps_orderno varchar(8),
  @ps_partno varchar(6)
As
Begin

if @ps_partno = 'ALL'
  select @ps_partno = '%'
  
-- All WcCode
Select OrderNo = @ps_orderno,
  WcCode = 'ALL',
  Serialno = 0,
  StdTime = Sum(convert(decimal(6,1),isnull(bb.stdtime,0) / 60)),
  JobTime = Sum(isnull(tmp.jobtime,0))
From trouting bb
  left outer join ( select orderno = cc.orderno, 
    partno = cc.partno,
    operno = cc.operno,
    wccode = cc.wccode,
    jobtime = Sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60)) 
    from tworkjob cc
    where cc.orderno = @ps_orderno and cc.partno like @ps_partno
    group by cc.orderno, cc.partno, cc.operno, cc.wccode ) tmp
  on bb.orderno = tmp.orderno and bb.partno = tmp.partno and 
    bb.operno = tmp.operno and bb.wccode = tmp.wccode
Where bb.orderno = @ps_orderno and bb.partno like @ps_partno and bb.workstatus = 'C'

Union All
-- Each WcCode
Select OrderNo = @ps_orderno,
  WcCode = dd.wccode,
  Serialno = dd.WcSerial,
  StdTime = Sum(isnull(tmp_std.stdtime,0)),
  JobTime = Sum(isnull(tmp_job.jobtime,0))
From ( select orderno = bb.orderno,
    partno = bb.partno,
    operno = bb.operno,
    wccode = bb.wccode,
    stdtime = Sum(convert(decimal(6,1),isnull(bb.stdtime,0) / 60))
    from trouting bb
    where bb.orderno = @ps_orderno and bb.partno like @ps_partno and bb.workstatus = 'C'
    group by bb.orderno, bb.partno, bb.operno, bb.wccode ) tmp_std
  left outer join ( select orderno = cc.orderno,
    partno = cc.partno,
    operno = cc.operno,
    wccode = cc.wccode,
    jobtime = Sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60))
    from tworkjob cc
    where cc.orderno = @ps_orderno and cc.partno like @ps_partno
    group by cc.orderno, cc.partno, cc.operno, cc.wccode ) tmp_job
  on tmp_std.orderno = tmp_job.orderno and tmp_std.partno = tmp_job.partno and
    tmp_std.operno = tmp_job.operno and tmp_std.wccode = tmp_job.wccode
  right outer join tworkcenter dd
  on tmp_std.WcCode = dd.WcCode and dd.WcCode <> 'THT'
Group by dd.wccode, dd.wcserial

End   -- Procedure End
Go
