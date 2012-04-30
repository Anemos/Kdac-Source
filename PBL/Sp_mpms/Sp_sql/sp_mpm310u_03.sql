/*
	File Name	: sp_mpm310u_03.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm310u_03
	Description	: 공정별 작업실적 정보
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_partno char(6), @ps_operno char(3) 
	Use Table	: tworkjob
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm310u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm310u_03]
GO

/*
Execute sp_mpm310u_03 '@ps_orderno','@ps_partno','@ps_operno'
*/

Create Procedure sp_mpm310u_03
  @ps_orderno char(8),
  @ps_partno  char(6),
  @ps_operno  char(3)

As
Begin

declare @ls_close char(6)

Select @ls_close = Convert( char(8), DateAdd( Month, 1, Convert(Datetime,( isnull(Max(YearMm),'190001') + '01'))), 112)
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
          Else 1 End,
    ProcessRatio = aa.ProcessRatio
From tworkjob aa
Where aa.OrderNo = @ps_orderno and aa.PartNo = @ps_partno and
      aa.OperNo  = @ps_operno and aa.Stype = 'WC'

Return

End		-- Procedure End

Go
