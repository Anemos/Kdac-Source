/*
	File Name	: sp_mpm310u_01.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm310u_01
	Description	: 공정순서 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_partno char(6) 
	Use Table	: trouting
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm310u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm310u_01]
GO

/*
Execute sp_mpm310u_01 '@ps_orderno','@ps_partno'
*/

Create Procedure sp_mpm310u_01
  @ps_orderno char(8),
  @ps_partno  char(6)

As
Begin

Select OperNo = A.OperNo,
    WcCode = A.WcCode,
    StdTime = A.StdTime,
    WorkMatter = A.WorkMatter,
    WorkStatus = A.WorkStatus,
    OrderNo = A.OrderNo,
    PartNo = A.PartNo,
    LastEmp = A.LastEmp,
    LastDate = A.LastDate,
    OutFlag = A.OutFlag
From	trouting  A
Where	A.Orderno = @ps_orderno and A.PartNo = @ps_partno
Order by A.OperNo

Return

End		-- Procedure End

Go
