SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism080i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism080i_01]
GO








/**************************************/
/*     라인별 LPI 및 작업효율 조회    */
/**************************************/

CREATE PROCEDURE [dbo].[sp_pism080i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stMonth	Char(7)			-- 기준년월
AS
BEGIN

Declare @lastYear	Char(4)

Set @lastYear = Cast ( Cast( substring(@ps_stMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )

  SELECT A.sMonth, 
	 A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         E.WorkCenterName,   
	 A.subLineCode, 
	 A.subLineNo, 
	 sum(IsNull(A.pQty,0)) pQty, 
	 sum(IsNull(A.unuseMH,0)) unuseMH, 
	 sum(IsNull(A.ActMH,0)) actMH, 
	 sum(IsNull(A.ActInMH,0)) actInMH, 
	 sum(IsNull(A.BasicMH,0)) basicMH,
	 I.tarLPI,
	 I.divtarLPI 
    FROM TMHMONTHPRODLINE_S A, 
         TMSTWORKCENTER E, 
	 TMHVALUETARGET I 
   WHERE ( A.AreaCode = E.AreaCode ) and  
         ( A.DivisionCode = E.DivisionCode ) and  
         ( A.WorkCenter = E.WorkCenter ) and  
	 ( A.AreaCode *= I.AreaCode ) and  
         ( A.DivisionCode *= I.DivisionCode ) and  
         ( A.WorkCenter *= I.WorkCenter ) And 
	 ( A.sMonth *= I.tarMonth ) And 
         ( ( A.AreaCode = @ps_area ) And 
	   ( A.DivisionCode = @ps_div ) And 
	   ( A.WorkCenter like @ps_wc ) And 
	   ( A.sMonth = @ps_stMonth ) ) 
Group By A.sMonth, 
	 A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         E.WorkCenterName,   
	 A.subLineCode, 
	 A.subLineNo, 
	 I.tarLPI,
	 I.divtarLPI 

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

