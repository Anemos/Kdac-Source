/*
	File Name	: sp_mpm320u_02.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm320u_02
	Description	: 불량공정에 대한 재작업공정정보
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_stype char(2), @ps_srno char(10),
	  @ps_orderno char(8), @ps_partno char(6), @ps_badoperno char(3),
	  @ps_baddate char(8)
	Use Table	: trouting, tworkjob
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm320u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm320u_02]
GO

/*
Execute sp_mpm320u_02 '@ps_stype','@ps_srno','@ps_orderno','@ps_parno','@ps_badoperno','@ps_baddate'
*/

Create Procedure sp_mpm320u_02
  @ps_stype char(2),
  @ps_srno  char(10),
  @ps_orderno char(8),
  @ps_partno char(6),
  @ps_badoperno char(3),
  @ps_baddate char(8)

As
Begin

Select Stype = isnull(B.Stype,@ps_stype),
    Srno = isnull(B.Srno,@ps_srno),
    OrderNo = A.OrderNo,
    PartNo = A.PartNo,
    BadOperNo = isnull(B.BadOperNo,@ps_badoperno),
    BadDate = isnull(B.BadDate,@ps_baddate),
    ReOperNo  = A.OperNo,
    WcCode = A.WcCode,
    MchNo = B.MchNo,
    BadTime = B.BadTime,
    ReworkFlag = case A.OperNo
                  when @ps_badoperno then 'Y'
                  else isnull(B.ReworkFlag,'N') end,
    ReworkChk = case A.OperNo
                when @ps_badoperno then 1
                else ( case B.ReworkFlag
                      when 'Y' then 1
                      else 0 end ) end,
    LastEmp = B.LastEmp,
    LastDate = B.LastDate
From	trouting  A 
      left outer join tbaddetail B
      on A.OrderNo = B.OrderNo and A.PartNo = B.PartNo and
        A.OperNo = B.ReOperNo and B.Stype = @ps_stype and
        B.Srno = @ps_srno
Where	A.Orderno = @ps_orderno and A.PartNo = @ps_partno and
      A.OperNo <= @ps_badoperno 
Order By A.OperNo

Return

End		-- Procedure End

Go
