/*
	File Name	: sp_mpm310u_04.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm310u_04
	Description	: 공정별 재작업실적 정보
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_partno char(6), @ps_operno char(3) 
	Use Table	: tworkjob
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm310u_04]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm310u_04]
GO

/*
Execute sp_mpm310u_04 '@ps_orderno','@ps_partno','@ps_operno'
*/

Create Procedure sp_mpm310u_04
  @ps_orderno char(8),
  @ps_partno  char(6),
  @ps_operno  char(3)

As
Begin

Select Stype = aa.Stype,
    Srno = aa.Srno,
    OrderNo = aa.OrderNo,
    PartNo = aa.PartNo,
    OperNo = aa.OperNo,
    WorkDate = aa.WorkDate,
    WorkEmp = aa.WorkEmp,
    EmpName = ( Select bb.EmpName From [ipis_daegu].ipis.dbo.tmstemp bb
                Where aa.WorkEmp = bb.EmpNo ),
    MchNo = aa.MchNo,
    ScrapQty = aa.ScrapQty,
    FinalQty = aa.FinalQty,
    JobTime = aa.JobTime,
    MchTime1 = aa.MchTime1,
    MchTime2 = aa.MchTime2,
    MchTime3 = aa.MchTime3,
    ResultFlag = aa.ResultFlag,
    BadStype = aa.BadStype,
    BadSrno = aa.BadSrno,
    BadOperNo = bb.BadOperNo,
    BadDate = bb.BadDate,
    LastEmp = aa.LastEmp,
    LastDate = aa.LastDate
From tworkjob aa inner join tbadhead bb
  on aa.badstype = bb.stype and aa.badsrno = bb.srno
Where aa.OrderNo = @ps_orderno and aa.PartNo = @ps_partno and
      aa.OperNo  = @ps_operno and aa.Stype = 'WR'

Return

End		-- Procedure End

Go
