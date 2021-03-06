SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism020i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism020i_02]
GO



/***************************************/
/*     조별 종합효율 계획 및 실적      */
/***************************************/

CREATE PROCEDURE sp_eism020i_02
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장 
	@ps_stMonth	Char(7)			-- 기준년월
AS
BEGIN

CREATE TABLE #Temp_totinMH -- 당월 공장별 총투입공수, 실동공수, 표준생산공수 
( 
	AreaCode	Char(1)		not null, 
	DivisionCode	Char(1)		not null, 
	WorkCenter	VarChar(5)	not null, 
	totinMH		Numeric(6,1)	null, 
	actMH		Numeric(6,1)	null, 
	basicMH		Numeric(6,1)	null,
	tar_totinMH	Numeric(6,1)	null,
	tar_actMH	Numeric(6,1)	null,
	tar_basicMH	Numeric(6,1)	null 
)

Insert Into #Temp_totinMH 
  SELECT A.AreaCode,   
         A.DivisionCode,   
	 A.WorkCenter, 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.ActMH,0)) ActMH,
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH, 
	 sum(IsNull(B.ActMH,0)) tar_ActMH,
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( A.AreaCode = @ps_area ) And 
	    ( A.DivisionCode = @ps_div ) And 
	    ( A.sMonth = @ps_stMonth ) ) 
 Group By A.AreaCode,   
          A.DivisionCode,
	  A.WorkCenter 
Union
  SELECT A.AreaCode,   
	 A.DivisionCode, 
         'XXXXX',   
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.ActMH,0)) ActMH,
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH, 
	 sum(IsNull(B.ActMH,0)) tar_ActMH,
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( A.AreaCode = @ps_area ) And 
	    ( A.DivisionCode = @ps_div ) And 
	    ( A.sMonth = @ps_stMonth ) ) 
 Group By A.AreaCode, 
	  A.DivisionCode 


   SELECT A.AreaCode, 
   	  A.DivisionCode, 
	  A.WorkCenter, 
	  tar_workRate      = Case tar_totInMH When 0 Then 0 Else 
			           round( tar_ActMH / tar_totInMH * 100, 1 ) End, 
	  stock_workRate    = Case totInMH When 0 Then 0 Else 	
				   round( ActMH / totInMH * 100, 1 ) End, 
	  tar_workEffRate   = Case tar_ActMH When 0 Then 0 Else 
				   round( tar_BasicMH / tar_ActMH * 100, 1 ) End, 
	  stock_workEffRate = Case ActMH When 0 Then 0 Else  
				   round( BasicMH / ActMH * 100, 1 ) End, 
	  tar_alloverRate   = Case tar_totInMH When 0 Then 0 Else 
				   round( tar_BasicMH / tar_totInMH * 100, 1 ) End, 
	  stock_alloverRate = Case totInMH When 0 Then 0 Else 
				   round( BasicMH / totInMH * 100, 1 ) End 
     Into #Temp_alloverRate 
     FROM #Temp_totinMH A 

   SELECT A.AreaCode, 
   	  A.DivisionCode, 
	  A.WorkCenter, 
	  Case A.WorkCenter When 'XXXXX' Then '소계' Else B.WorkCenterName End WorkCenterName, 	  
	  tar_workRate, 
	  stock_workRate, 
	  Case tar_workRate When 0 Then 0 Else 
	       round( stock_workRate / tar_workRate * 100, 1 ) End workRate, 
	  tar_workEffRate, 
	  stock_workEffRate, 
	  Case tar_workEffRate When 0 Then 0 Else 
	       round( stock_workEffRate / tar_workEffRate * 100, 1 ) End workEffRate, 
	  tar_alloverRate, 
	  stock_alloverRate, 
	  Case tar_alloverRate When 0 Then 0 Else 
	       round( stock_alloverRate / tar_alloverRate * 100, 1 ) End alloverRate 
     FROM #Temp_alloverRate A,
	  TMSTWORKCENTER B 
    WHERE ( A.AreaCode *= B.AreaCode ) And 
	  ( A.DivisionCode *= B.DivisionCode ) And 
	  ( A.WorkCenter *= B.WorkCenter ) 
Order By A.AreaCode, 
	 A.DivisionCode  

 Drop Table #Temp_totinMH 
 Drop Table #Temp_alloverRate 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

