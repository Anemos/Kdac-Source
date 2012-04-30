/*
	File Name	: sp_mpm321u_03.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm321u_03
	Description	: 공정별 재작업실적 정보
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_stype char(2), @ps_srno char(10), 
	      @ps_reoperno char(3)
	Use Table	: tworkjob
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm321u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm321u_03]
GO

/*
Execute sp_mpm321u_03 '@ps_stype','@ps_srno','@ps_reoperno'
*/

Create Procedure sp_mpm321u_03
  @ps_stype char(2),
  @ps_srno  char(10),
  @ps_reoperno char(3)

As
Begin

declare @ls_close char(6)

Select @ls_close = Convert( char(8), DateAdd( Month, 1, Convert(Datetime,(Max(YearMm) + '01'))), 112)
From tmonthjob
where resultflag = 'C'

Select Stype = aa.Stype,
    Srno = aa.Srno,
    OrderNo = aa.OrderNo,
    PartNo = aa.PartNo,
    OperNo = aa.OperNo,
    WcCode = aa.WcCode,
    WorkDate = aa.WorkDate,
    WorkEmp = aa.WorkEmp,
    EmpName = ( Select bb.EmpName From tmstemp bb
                Where aa.WorkEmp = bb.EmpNo ),
    MchNo = aa.MchNo,
    HeatCost = aa.HeatCost,
    OutCost = aa.OutCost,
    ScrapQty = aa.ScrapQty,
    FinalQty = aa.FinalQty,
    JobTime = aa.JobTime,
    MchTime1 = aa.MchTime1,
    MchTime2 = aa.MchTime2,
    MchTime3 = aa.MchTime3,
    ResultFlag = aa.ResultFlag,
    BadStype = aa.BadStype,
    BadSrno = aa.BadSrno,
    LastEmp = aa.LastEmp,
    LastDate = aa.LastDate,
    Chk = Case when aa.workdate >= @ls_close then 0
          Else 1 End
From tworkjob aa
Where aa.BadStype = @ps_stype and aa.BadSrno = @ps_srno and
      aa.OperNo = @ps_reoperno and aa.Stype = 'WR'

Return

End		-- Procedure End

Go
