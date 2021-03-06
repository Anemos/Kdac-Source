SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism170i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism170i_01]
GO







/*********************************/ 
/*     작업일보 특기사항 조회    */ 
/*********************************/ 

CREATE PROCEDURE sp_pism170i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stFromDate	Char(10),		-- 기준일 From
	@ps_stToDate	Char(10)		-- 기준일 To 
AS
BEGIN

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         A.WorkDay,   
	 B.WorkCenterName, 
         A.Remark,   
         A.LastEmp,   
         A.LastDate  
    FROM TMHDAILYSTATUS A,
	 TMSTWORKCENTER B 
   WHERE ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.WorkCenter = B.WorkCenter ) And 
	 ( ( A.AreaCode = @ps_area ) AND  
          ( A.DivisionCode = @ps_div ) AND  
          ( A.WorkCenter like @ps_wc ) AND  
          ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) And 
	  ( IsNull(A.Remark,'') <> '' ) And 
	  ( A.DailyStatus = '1' ) ) 
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

