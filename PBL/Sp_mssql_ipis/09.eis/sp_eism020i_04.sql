SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism020i_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism020i_04]
GO



/**********************************************/
/*     조내 월별 가동율/작업효율/종합효율     */
/**********************************************/

CREATE PROCEDURE sp_eism020i_04 
	@ps_area	Char(1),		-- 지역 
	@ps_div		Char(1),		-- 공장 
	@ps_stYear	Char(4)			-- 기준년
AS
BEGIN

CREATE TABLE #Temp_alloverRate 
( 
	WorkCenter	VarChar(5)	not null, 
	sMonth		Char(2)		not null, 
	totinMH		Numeric(6,1)	null, 
	basicMH		Numeric(6,1)	null,
	actMH		Numeric(6,1)	null,
	workRate	Numeric(6,1)	null, 
	workEffRate	Numeric(6,1)	null,  	
	alloverEffRate	Numeric(6,1)	null 
)

Insert Into #Temp_alloverRate ( WorkCenter, sMonth, totInMH, basicMH, actMH ) 
  SELECT A.WorkCenter, 
	 substring(A.sMonth, 6, 2) sMonth, 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(A.actMH,0)) actMH 
    FROM TMHMONTH_S A 
    WHERE ( A.AreaCode = @ps_area ) And 
	  ( A.DivisionCode = @ps_div ) And 
	  ( substring(A.sMonth, 1, 4) = @ps_stYear ) 
 Group By A.WorkCenter, 
	  substring(A.sMonth, 6, 2) 
Union
  SELECT 'XXXXX',   
	 substring(A.sMonth, 6, 2), 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(A.actMH,0)) actMH 
    FROM TMHMONTH_S A 
    WHERE ( A.AreaCode = @ps_area ) And 
	  ( A.DivisionCode = @ps_div ) And 
	  ( substring(A.sMonth, 1, 4) = @ps_stYear ) 
 Group By substring(A.sMonth, 6, 2) 
Union
  SELECT A.WorkCenter, 
	 '13', 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(A.actMH,0)) actMH 
    FROM TMHMONTH_S A 
    WHERE ( A.AreaCode = @ps_area ) And 
	  ( A.DivisionCode = @ps_div ) And 
	  ( substring(A.sMonth, 1, 4) = @ps_stYear ) 
 Group By A.WorkCenter  
Union
  SELECT 'XXXXX',   
	 '13', 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(A.actMH,0)) actMH 
    FROM TMHMONTH_S A 
    WHERE ( A.AreaCode = @ps_area ) And 
	  ( A.DivisionCode = @ps_div ) And 
	  ( substring(A.sMonth, 1, 4) = @ps_stYear ) 


  Update #Temp_alloverRate 
     Set workRate 	= Case totInMH When 0 Then 0 Else 
			       round( actMH / totInMH * 100, 1 ) End, 
	 workEffRate    = Case actMH When 0 Then 0 Else 
			       round( BasicMH / actMH * 100, 1 ) End, 
	 alloverEffRate = Case totInMH When 0 Then 0 Else 
			       round( BasicMH / totInMH * 100, 1 ) End

	  Select A.WorkCenter, 
		 Case A.WorkCenter When 'XXXXX' Then '소계' Else B.WorkCenterName End WorkCenterName, 
		 m01.workRate,
		 m01.workEffRate, 
		 m01.alloverEffRate,
		 m02.workRate,
		 m02.workEffRate, 
		 m02.alloverEffRate,
		 m03.workRate,
		 m03.workEffRate, 
		 m03.alloverEffRate,
		 m04.workRate,
		 m04.workEffRate, 
		 m04.alloverEffRate,
		 m05.workRate,
		 m05.workEffRate, 
		 m05.alloverEffRate,
		 m06.workRate,
		 m06.workEffRate, 
		 m06.alloverEffRate,
		 m07.workRate,
		 m07.workEffRate, 
		 m07.alloverEffRate,
		 m08.workRate,
		 m08.workEffRate, 
		 m08.alloverEffRate,
		 m09.workRate,
		 m09.workEffRate, 
		 m09.alloverEffRate,
		 m10.workRate,
		 m10.workEffRate, 
		 m10.alloverEffRate,
		 m11.workRate,
		 m11.workEffRate, 
		 m11.alloverEffRate,
		 m12.workRate,
		 m12.workEffRate, 
		 m12.alloverEffRate,
		 m13.workRate,
		 m13.workEffRate, 
		 m13.alloverEffRate 
	  From   
	  ( Select Distinct WorkCenter 
	      From #Temp_alloverRate ) A, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '01' ) ) m01, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '02' ) ) m02, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '03' ) ) m03, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '04' ) ) m04, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '05' ) ) m05, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '06' ) ) m06, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '07' ) ) m07, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '08' ) ) m08, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '09' ) ) m09, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '10' ) ) m10, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '11' ) ) m11, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '12' ) ) m12, 
	  ( Select WorkCenter, 
		   workRate,	
		   workEffRate,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '13' ) ) m13, 
	TMSTWORKCENTER B 
   Where ( A.Workcenter *= B.WorkCenter ) And 
	 ( A.WorkCenter *= m01.WorkCenter ) And 
	 ( A.WorkCenter *= m02.WorkCenter ) And 
	 ( A.WorkCenter *= m03.WorkCenter ) And 
	 ( A.WorkCenter *= m04.WorkCenter ) And 
	 ( A.WorkCenter *= m05.WorkCenter ) And 
	 ( A.WorkCenter *= m06.WorkCenter ) And 
	 ( A.WorkCenter *= m07.WorkCenter ) And 
	 ( A.WorkCenter *= m08.WorkCenter ) And 
	 ( A.WorkCenter *= m09.WorkCenter ) And 
	 ( A.WorkCenter *= m10.WorkCenter ) And 
	 ( A.WorkCenter *= m11.WorkCenter ) And 
	 ( A.WorkCenter *= m12.WorkCenter ) And 
	 ( A.WorkCenter *= m13.WorkCenter ) 
Order By A.WorkCenter 

  Drop Table #Temp_alloverRate 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

