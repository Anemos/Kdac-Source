/*
  File Name : sp_mpsg080i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpsg080i_01
  Description : ����, �ο���, �۾����ں� �۾��Ϻ���ȸ
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_plandate  char(10),
              @ps_workgubun char(1),
              @ps_workemp   varchar(6)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpsg080i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpsg080i_01]
GO

/*
Execute sp_mpsg080i_01
  @ps_plandate    = '2006.04.20',
  @ps_workgubun   = 'A',
  @ps_workemp     = '866069'
*/

Create Procedure sp_mpsg080i_01
  @ps_plandate    char(10),     /* �۾����� */
  @ps_workgubun   char(1),      /* �۾��׷� */
  @ps_workemp     varchar(6)    /* �۾��� */

As
Begin

Declare @ls_workdate char(8)

Select @ls_workdate = convert(char(8),cast(isnull(@ps_plandate,'1900.01.01') as datetime),112)
/*########################################################################################

�۾����� ��ȸ - �۾�����(�ʼ�), �۾��׷�(�ʼ�), �۾���(����)

########################################################################################*/
SELECT Stype = aa.Stype,
  Srno = aa.Srno,
  OrderNo = aa.OrderNo,
  OperNo = aa.OperNo,
  PartName = bb.PartName,
  PartNo = aa.PartNo,
  FinalQty = aa.FinalQty,
  JobTime = aa.JobTime,
  PreRatio = ( SELECT SUM(ProcessRatio) FROM TWORKJOB
      WHERE OrderNo = aa.OrderNo AND PartNo = aa.PartNo AND
        OperNo = aa.OperNo AND WorkDate < @ls_workdate ),
  NowRatio = ( SELECT SUM(ProcessRatio) FROM TWORKJOB
      WHERE OrderNo = aa.OrderNo AND PartNo = aa.PartNo AND
        OperNo = aa.OperNo AND WorkDate <= @ls_workdate ),
  MchNo = aa.MchNo,
  WcCode = aa.WcCode,
  WorkEmp = aa.WorkEmp,
  EmpName = dd.EmpName,
  ResultFlag = aa.ResultFlag
FROM TWORKJOB aa INNER JOIN TPARTLIST bb
  ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo
  INNER JOIN TWORKCENTER cc
  ON aa.WcCode = cc.WcCode AND cc.WcGubun = @ps_workgubun
  INNER JOIN TMOLDEMPNO dd
  ON aa.WcCode = dd.WcCode AND aa.WorkEmp = dd.EmpNo
WHERE aa.WorkDate = @ls_workdate AND aa.WorkEmp LIKE @ps_workemp


End   -- Procedure End
Go
