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
  @ps_plandate		= '2006.04.07',
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


SELECT	as_orderno = tmp.orderno,
  as_partno = tmp.partno,
  as_operno = tmp.operno,
  as_workdate = tmp.workdate,
  as_workemp = tmp.workemp,
  as_mchno = tmp.mchno,
  as_processratio = '',
  as_jobtime = tmp.jobtime,
  as_resultflag = isnull(tmp.resultflag,' ')
FROM ( select orderno = aa.orderno,
  partno = aa.partno,
  operno = aa.operno,
  workdate = isnull(convert(varchar(10),cast(dd.workdate as datetime),102),convert(varchar(10),aa.workstart,102)),
  workemp = dd.workemp,
  mchno = dd.mchno,
  processratio = dd.processratio,
  jobtime = dd.jobtime,
  resultflag = isnull(dd.resultflag,' '),
  preworkstatus = isnull(( select top 1 workstatus from trouting 
                where orderno = aa.orderno and partno = aa.partno and operno < aa.operno
                order by operno desc ),'C')
  from trouting aa inner join tworkcenter bb
    on aa.wccode = bb.wccode
    left outer join tworkjob dd
      on aa.orderno = dd.orderno and aa.partno = dd.partno and
      aa.operno = dd.operno
  where bb.wccode = @ps_linecode and bb.wgcode = @ps_workcenter and 
    ( ( aa.workstatus <> 'C' and convert(varchar(10),aa.workstart,102) <= @ps_plandate ) or
      ( dd.workdate = convert(char(8),cast(@ps_plandate as datetime),112) ) ) ) tmp
where tmp.preworkstatus = 'C'
order by tmp.workdate desc, tmp.orderno desc, tmp.partno, tmp.operno

End   -- Procedure End
Go
