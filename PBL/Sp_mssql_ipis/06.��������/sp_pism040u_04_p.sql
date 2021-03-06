USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism040u_04_p]    Script Date: 05/04/2012 10:34:59 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*******************************************************************/
/*        전년도 기준월별 종합효율/가동율/작업효율 조회            */
/*******************************************************************/
ALTER PROCEDURE [dbo].[sp_pism040u_04_p]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		Varchar(5),		-- 조
	@ps_stYear	Char(4)			-- 기준년 
AS
BEGIN
 Declare @Month 	int,
	 @cvtMonth	char(2) 
 Create Table #Temp_allover 
	( Gbn			Char(1)		not null,
	  WorkCenter		VarChar(5)	not null,
	  WorkCenterName 	VarChar(30)	null,
	  stMonth 		Char(2)		not null, 
	  calcValue		Numeric(5,1) 	null   ) 
 Create Table #Temp_Month ( sMonth	char(2) ) 
 Set @Month = 1 
 While @Month <= 12 
 Begin
	Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth	Output 
	Insert Into #Temp_Month Values ( @cvtMonth ) 
	Set @Month = @Month + 1 
 End 
	Insert Into #Temp_allover 
	  SELECT '1', 
		  A.WorkCenter,   	
	   	  B.WorkCenterName, 
	          substring(A.sMonth, 6, 2) + '월',   
		  round(( A.BasicMH / A.totInMH ) * 100, 1) alloverEff
	    FROM TMHMONTH_S A, TMSTWORKCENTER B  
	   WHERE ( A.AreaCode = B.AreaCode ) And
		 ( A.DivisionCode = B.DivisionCode ) And 
	 	 ( A.WorkCenter = B.WorkCenter ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
	           ( A.WorkCenter like @ps_wc ) AND  
	           ( substring(A.sMonth, 1, 4) = @ps_stYear ) And
		   ( substring(A.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
						     Where ( AreaCode = A.AreaCode ) And 
							   ( DivisionCode = A.DivisionCode ) And 
							   ( stYear = @ps_stYear ) ) ) ) 
	Union
	  SELECT '2', 
		  A.WorkCenter,   	
	   	  B.WorkCenterName, 
	          substring(A.sMonth, 6, 2) + '월',   
		  round(( A.ActMH / A.totInMH ) * 100, 1) workRate
	    FROM TMHMONTH_S A, TMSTWORKCENTER B  
	   WHERE ( A.AreaCode = B.AreaCode ) And
		 ( A.DivisionCode = B.DivisionCode ) And 
	 	 ( A.WorkCenter = B.WorkCenter ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
	           ( A.WorkCenter like @ps_wc ) AND  
	           ( substring(A.sMonth, 1, 4) = @ps_stYear ) And
		   ( substring(A.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
			   			     Where ( AreaCode = A.AreaCode ) And 
							   ( DivisionCode = A.DivisionCode ) And 
						  	   ( stYear = @ps_stYear ) ) ) ) 
	Union
	  SELECT '3', 
		  A.WorkCenter,   	
	   	  B.WorkCenterName, 
	          substring(A.sMonth, 6, 2) + '월',   
		  round(( A.BasicMH / A.ActMH ) * 100,1) workEff 
	    FROM TMHMONTH_S A, TMSTWORKCENTER B  
	   WHERE ( A.AreaCode = B.AreaCode ) And
		 ( A.DivisionCode = B.DivisionCode ) And 
	 	 ( A.WorkCenter = B.WorkCenter ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
	           ( A.WorkCenter like @ps_wc ) AND  
	           ( substring(A.sMonth, 1, 4) = @ps_stYear ) And
		   ( substring(A.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
						     Where ( AreaCode = A.AreaCode ) And 
							   ( DivisionCode = A.DivisionCode ) And 
							   ( stYear = @ps_stYear ) ) ) ) 
 Select * From #Temp_allover 
 Drop Table #Temp_allover 
END
