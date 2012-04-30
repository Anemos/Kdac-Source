/*
  File Name : sp_mpsg090i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg090i_01
  Description : WorkCenter�� �۾����� ��ȸ
  Use DataBase  : MPMS
  Use Program :
  Parameter : 
  Use Table :
  Initial   : 2004.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg090i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg090i_01]
GO

/*
Execute sp_mpsg090i_01 
  @ps_plandate		= '2006.04.20',
	@ps_workcenter		= 'MWG01',
	@ps_linecode		= 'TAM'
*/

Create Procedure sp_mpsg090i_01
  @ps_plandate		char(10),	  /* ��ȸ����	*/
	@ps_workcenter	char(5),		/* �۾��׷�	*/
	@ps_linecode		char(3)		  /* �۾���	*/

As
Begin

/*########################################################################################

�������� - ��ȸ���ڿ� ��ϵ� ����ǥ��

########################################################################################*/


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
ORDER BY dd.lastdate

End   -- Procedure End
Go
