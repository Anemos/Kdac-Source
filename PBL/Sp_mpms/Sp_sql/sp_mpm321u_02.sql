/*
	File Name	: sp_mpm321u_02.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm321u_02
	Description	: 불량내역에 대한 재작업공정 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_stype char(2), @ps_srno char(10)
	Use Table	: tbaddetail
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm321u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm321u_02]
GO

/*
Execute sp_mpm321u_02 '@ps_stype','@ps_srno'
*/

Create Procedure sp_mpm321u_02
  @ps_stype char(2),
  @ps_srno  char(10)

As
Begin

Select Stype = B.Stype,
    Srno = B.Srno,
    OrderNo = B.OrderNo,
    PartNo = B.PartNo,
    BadOperNo = B.BadOperNo,
    BadDate = B.BadDate,
    ReOperNo = B.ReOperNo,
    WcCode = A.WcCode,
    ReworkQty = C.ScrapQty,
    ReworkFlag = B.ReworkFlag
From	trouting  A 
      inner join tbaddetail B
      on A.OrderNo = B.OrderNo and A.PartNo = B.PartNo and 
        A.OperNo = B.BadOperNo
      inner join tbadhead C
      on B.OrderNo = C.OrderNo and B.PartNo = C.PartNo and
        B.BadOperNo = C.BadOperNo and B.BadDate = C.BadDate 
Where	B.Stype = @ps_stype and B.Srno = @ps_srno
Order by B.ReOperNo

Return

End		-- Procedure End

Go
