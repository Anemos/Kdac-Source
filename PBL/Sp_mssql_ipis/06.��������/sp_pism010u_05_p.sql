SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_05_p]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_05_p]
GO







/********************************************/
/*      작업일보 시간단위 지원공수 Report   */
/********************************************/

CREATE PROCEDURE sp_pism010u_05_p 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

  SELECT '+' supGbn,
	 A.DivisionCode,
         A.AreaCode,
         A.WorkDay,
	 A.EmpNo, 
	 B.empName, 
	 A.supGubun, 
	 A.FromTime, 
	 A.ToTime, 
         IsNull(A.supMH,0) + IsNull(A.etcsupMH,0) supMH, 
	 A.WorkCenter, 
	 C.WorkCenterName 
    FROM TMHSUPPORT A, TMSTEMP B, TMSTWORKCENTER C 
   WHERE ( A.AreaCode *= C.AreaCode ) And 
	 ( A.DivisionCode *= C.DivisionCode ) And 
	 ( A.Workcenter *= C.WorkCenter ) And 
	 ( A.empNo *= B.empNo ) And 
	 ( A.AreaCode = @ps_area ) AND  
         ( A.DivisionCode = @ps_div ) AND  
         ( A.SupWorkcenter = @ps_wc ) AND  
         ( A.WorkDay = @ps_wday ) 
Union 
  SELECT '-',
	 A.DivisionCode,
         A.AreaCode,
         A.WorkDay,
	 A.EmpNo, 
	 B.empName, 
	 A.supGubun, 
	 A.FromTime, 
	 A.ToTime, 
         IsNull(A.supMH,0) + IsNull(A.etcsupMH,0) supMH, 
	 A.WorkCenter, 
	 C.WorkCenterName 
    FROM TMHSUPPORT A, TMSTEMP B, TMSTWORKCENTER C 
   WHERE ( A.AreaCode *= C.AreaCode ) And 
	 ( A.DivisionCode *= C.DivisionCode ) And 
	 ( A.SupWorkcenter *= C.Workcenter ) And 
	 ( A.empNo *= B.empNo ) And 
	 ( A.AreaCode = @ps_area ) AND  
         ( A.DivisionCode = @ps_div ) AND  
         ( A.WorkCenter = @ps_wc ) AND  
         ( A.WorkDay = @ps_wday ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

