/*
  File Name : sp_mpm332i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm332i_01
  Description : ���������� (�����۾��ð��� �������� �� )
  �������� Order�� ���� �Ѱ����ð�,�Ϸ����,�ܿ�����,�������� �����´�.
  Use DataBase  : MPMS
  Use Program :
  Parameter : 
  Use Table :
  Initial   : 2004.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm332i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm332i_01]
GO

/*
Execute sp_mpm332i_01
*/

Create Procedure sp_mpm332i_01
  
As
Begin

-- All Order
Select OrderNo = '00000000',
  TotalTime = Sum(convert(decimal(6,1),isnull(bb.StdTime,0) / 60)),
  EndTime =  Sum( Case When bb.workstatus = 'C' Then convert(decimal(6,1),isnull(bb.StdTime,0) / 60) Else 0 End ),
  IngTime =  Sum( Case When bb.workstatus <> 'C' Then convert(decimal(6,1),isnull(bb.StdTime,0) / 60) Else 0 End )
From torder aa inner join trouting bb
  on aa.orderno = bb.orderno and aa.ingstatus <> 'C'
  
Union All
--Each Order
Select OrderNo = bb.orderno,
  TotalTime = Sum(convert(decimal(6,1),isnull(bb.StdTime,0) / 60)),
  EndTime =  Sum( Case When bb.workstatus = 'C' Then convert(decimal(6,1),isnull(bb.StdTime,0) / 60) Else 0 End ),
  IngTime =  Sum( Case When bb.workstatus <> 'C' Then convert(decimal(6,1),isnull(bb.StdTime,0) / 60) Else 0 End )
From torder aa inner join trouting bb
  on aa.orderno = bb.orderno and aa.ingstatus <> 'C'
Group by bb.orderno
Order by bb.orderno

End   -- Procedure End
Go
