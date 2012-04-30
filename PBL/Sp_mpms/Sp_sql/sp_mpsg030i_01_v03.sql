/*
  File Name : sp_mpsg030i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg030i_01
  Description : WorkCenter별 공정작업순서
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_terminalcode varchar(5)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg030i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg030i_01]
GO

/*
Execute sp_mpsg030i_01 
  @ps_plandate		= '2006.04.20',
	@ps_workcenter		= 'MWG01',
	@ps_linecode		= 'TAM'
*/

Create Procedure sp_mpsg030i_01
  @ps_plandate		char(10),	  /* 계획일자	*/
	@ps_workcenter	char(5),		/* 작업그룹	*/
	@ps_linecode		char(3)		  /* 작업장	*/

As
Begin

/*########################################################################################

공정순서 - 전공정이 작업완료된 공정만 표시, 계획일자에 등록된 실적표시

########################################################################################*/

SELECT as_orderno = tmp_result.as_orderno,
  as_partno = tmp_result.as_partno,
  as_operno = tmp_result.as_operno,
  as_workdate = tmp_result.as_workdate,
  as_workemp = tmp_result.as_workemp,
  as_mchno = tmp_result.as_mchno,
  as_processratio = tmp_result.as_processratio,
  as_jobtime = tmp_result.as_jobtime,
  as_resultflag = tmp_result.as_resultflag,
  as_lastdate = tmp_result.as_lastdate,
  as_stype = tmp_result.as_stype,
  as_srno = tmp_result.as_srno
FROM (
SELECT	as_orderno = dd.orderno,
  as_partno = dd.partno,
  as_operno = dd.operno,
  as_workdate = convert(char(10),cast(dd.workdate as datetime),102),
  as_workemp = dd.workemp,
  as_mchno = dd.mchno,
  as_processratio = dd.processratio,
  as_jobtime = dd.jobtime,
  as_resultflag = dd.resultflag,
  as_lastdate = dd.lastdate,
  as_stype = dd.stype,
  as_srno = dd.srno
FROM tworkcenter bb inner join tworkjob dd
      on bb.wccode = dd.wccode
WHERE bb.wccode = @ps_linecode and bb.wgcode = @ps_workcenter and 
  dd.workdate = convert(char(8),cast(@ps_plandate as datetime),112)

UNION ALL

SELECT	as_orderno = tmp.orderno,
  as_partno = tmp.partno,
  as_operno = tmp.operno,
  as_workdate = tmp.workdate,
  as_workemp = '',
  as_mchno = '',
  as_processratio = isnull(tmp.processratio,0),
  as_jobtime = isnull(tmp.jobtime,0),
  as_resultflag = '',
  as_lastdate = cast('9999.12.31' as datetime),
  as_stype = 'WA',
  as_srno = ''
FROM ( select orderno = aa.orderno,
  partno = aa.partno,
  operno = aa.operno,
  workdate = convert(char(10),aa.workstart,102),
  preworkstatus = isnull(( select top 1 workstatus from trouting 
                where orderno = aa.orderno and partno = aa.partno and operno < aa.operno
                order by operno desc ),'C'),
  processratio = sum(isnull(cc.processratio,0)),
  jobtime = sum(isnull(cc.jobtime,0))
  from trouting aa inner join tworkcenter bb
    on aa.wccode = bb.wccode
    left outer join tworkjob cc
    on aa.orderno = cc.orderno and aa.partno = cc.partno and aa.operno = cc.operno and cc.stype = 'WC'
  where bb.wccode = @ps_linecode and bb.wgcode = @ps_workcenter and 
        aa.workstatus <> 'C'
  group by aa.orderno, aa.partno, aa.operno, convert(char(10),aa.workstart,102)
  ) tmp
WHERE tmp.preworkstatus = 'C'

UNION ALL

SELECT	as_orderno = tmp_bad.orderno,
  as_partno = tmp_bad.partno,
  as_operno = tmp_bad.operno,
  as_workdate = tmp_bad.workdate,
  as_workemp = '',
  as_mchno = '',
  as_processratio = isnull(tmp_bad.processratio,0),
  as_jobtime = isnull(tmp_bad.jobtime,0),
  as_resultflag = '',
  as_lastdate = cast('9999.12.31' as datetime),
  as_stype = 'WE',
  as_srno = ''
FROM ( select orderno = aa.orderno,
  partno = aa.partno,
  operno = aa.reoperno,
  workdate = convert(char(10),aa.lastdate,102),
  preworkstatus = isnull(( select top 1 workstatus from tbaddetail 
                where orderno = aa.orderno and partno = aa.partno and reoperno < aa.reoperno
                order by reoperno desc ),'C'),
  processratio = sum(isnull(cc.processratio,0)),
  jobtime = sum(isnull(cc.jobtime,0))
  from tbaddetail aa inner join tworkcenter bb
    on aa.wccode = bb.wccode
    left outer join tworkjob cc
    on aa.orderno = cc.orderno and aa.partno = cc.partno and aa.reoperno = cc.operno and cc.stype = 'WR'
  where bb.wccode = @ps_linecode and bb.wgcode = @ps_workcenter and 
        aa.workstatus <> 'C'
  group by aa.orderno, aa.partno, aa.reoperno, convert(char(10),aa.lastdate,102)
  ) tmp_bad
WHERE tmp_bad.preworkstatus = 'C'
) tmp_result
ORDER BY tmp_result.as_lastdate, tmp_result.as_processratio DESC

End   -- Procedure End
Go
