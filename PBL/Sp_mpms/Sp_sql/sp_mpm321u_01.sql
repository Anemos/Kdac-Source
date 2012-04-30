/*
	File Name	: sp_mpm321u_01.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm321u_01
	Description	: 불량내역 가져오기
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno varchar(8) 
	Use Table	: tbadhead
	Initial		: 2004.03.31
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm321u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm321u_01]
GO

/*
Execute sp_mpm321u_01 '@ps_orderno'
*/

Create Procedure sp_mpm321u_01
  @ps_orderno varchar(8)

As
Begin

Select Stype = A.Stype,
    Srno = A.Srno,
    OrderNo = A.OrderNo,
    PartNo = A.PartNo,
    PartName = C.PartName,
    Material = C.Material,
    WcCode = B.WcCode,
    BadOperNo = A.BadOperNo,
    BadDate = A.BadDate,
    WorkMan = A.WorkMan,
    WorkManName = ( Select empname From tmstemp
                    Where empno = A.workman ),
    FindMan = A.FindMan,
    FindManName = ( Select empname From tmstemp
                    Where empno = A.findman ),
    PlanQty = A.PlanQty,
    ScrapQty = A.ScrapQty,
    BadReason = A.BadReason,
    ResultFlag = A.ResultFlag,
    LastEmp = A.LastEmp,
    LastDate = A.LastDate
From	tbadhead  A 
      inner join trouting B
      on A.OrderNo = B.OrderNo and A.PartNo = B.PartNo and A.BadOperNo = B.OperNo
      inner join tpartlist C 
      on A.OrderNo = C.OrderNo and A.PartNo = C.PartNo
      inner join torder D
      on A.OrderNo = D.OrderNo and D.IngStatus <> 'C'
Where	A.Orderno like @ps_orderno

Return

End		-- Procedure End

Go
