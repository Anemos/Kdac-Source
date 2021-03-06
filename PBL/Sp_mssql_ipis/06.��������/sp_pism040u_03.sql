SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism040u_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism040u_03]
GO







/*******************************************************************/
/*        전년도 기준월별 종합효율/가동율/작업효율 조회            */
/*******************************************************************/

CREATE PROCEDURE sp_pism040u_03
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		Varchar(5),		-- 조
	@ps_stYear	Char(4)			-- 기준년 
AS
BEGIN


	CREATE TABLE #Temp_allover -- 기준월 월별공수, 기준월평균, 기준년평균 조회용 
	(
		Gbn		Char(1)		not null, 
		WorkCenter	Varchar(5)	not null,
		stMonth		Char(2)		not null,
		rate		Numeric(6,1)	null 
	)

	
	Insert Into #Temp_allover 
	  SELECT '1', 
	          A.WorkCenter,   	
	          substring(A.sMonth, 6, 2),   
		  Case A.totInMH When 0 Then 0 Else 
		       round( ( A.BasicMH / A.totInMH ) * 100, 1 ) End alloverEff
	    FROM TMHMONTH_S A 
	   WHERE ( ( A.AreaCode = @ps_area ) AND  
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
	          substring(A.sMonth, 6, 2),   
		  Case A.totInMH When 0 Then 0 Else 
		       round( ( A.ActMH / A.totInMH ) * 100, 1 ) End workRate
	    FROM TMHMONTH_S A 
	   WHERE ( ( A.AreaCode = @ps_area ) AND  
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
	          substring(A.sMonth, 6, 2),   
		  Case A.ActMH When 0 Then 0 Else 
		       round( ( A.BasicMH / A.ActMH ) * 100, 1 ) End workEff 
	    FROM TMHMONTH_S A 
	   WHERE ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
	           ( A.WorkCenter like @ps_wc ) AND  
	           ( substring(A.sMonth, 1, 4) = @ps_stYear ) And
		   ( substring(A.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
						     Where ( AreaCode = A.AreaCode ) And 
							   ( DivisionCode = A.DivisionCode ) And 
							   ( stYear = @ps_stYear ) ) ) ) 


	CREATE TABLE #Temp_totallover -- 기준월 월별공수, 기준월평균, 기준년평균 조회용 
	(
		Gbn		Char(1)		not null, 
		WorkCenter	Varchar(5)	not null,
		alloverEff_YEAR	 Numeric(6,1)	null,
		alloverEff_MONTH Numeric(6,1)	null
	)

	-- 연간누계 
	Insert Into #Temp_totallover
	  SELECT '1', 
		 A.WorkCenter, 
		 Case Sum(A.totInMH) When 0 Then 0 Else 
		    ( Sum(A.BasicMH) / Sum(A.totInMH) ) * 100 End alloverEff_YEAR,
		 Case Sum(B.totInMH) When 0 Then 0 Else 
		    ( Sum(B.BasicMH) / Sum(B.totInMH) ) * 100 End alloverEff_MONTH  
	    FROM TMHMONTH_S A, TMHMONTH_S B 
	   WHERE ( A.AreaCode = B.AreaCode ) And
		 ( A.DivisionCode = B.DivisionCode ) And 
	 	 ( A.WorkCenter = B.WorkCenter ) And 
		 ( substring(A.sMonth, 1, 4) = substring(B.sMonth, 1, 4) ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
		   ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) AND  
		   ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
		   ( substring(B.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
						     Where ( AreaCode = A.AreaCode ) And 
						           ( DivisionCode = A.DivisionCode ) And 
							   ( stYear = @ps_stYear ) ) ) ) 
	Group By A.WorkCenter 

	Union

	  SELECT '2', 
		 A.WorkCenter, 
		 Case Sum(A.totInMH) When 0 Then 0 Else 
		    ( Sum(A.ActMH) / Sum(A.totInMH) ) * 100 End alloverEff_YEAR,
		 Case Sum(B.totInMH) When 0 Then 0 Else 
		    ( Sum(B.ActMH) / Sum(B.totInMH) ) * 100 End alloverEff_MONTH  
	    FROM TMHMONTH_S A, TMHMONTH_S B 
	   WHERE ( A.AreaCode = B.AreaCode ) And
		 ( A.DivisionCode = B.DivisionCode ) And 
	 	 ( A.WorkCenter = B.WorkCenter ) And 
		 ( substring(A.sMonth, 1, 4) = substring(B.sMonth, 1, 4) ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
		   ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) AND  
		   ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
		   ( substring(B.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
			 			     Where ( AreaCode = A.AreaCode ) And 
						           ( DivisionCode = A.DivisionCode ) And 
							   ( stYear = @ps_stYear ) ) ) ) 
	Group By A.WorkCenter 

	Union

	  SELECT '3', 
		 A.WorkCenter, 
		 Case Sum(A.ActMH) When 0 Then 0 Else 
		    ( Sum(A.BasicMH) / Sum(A.ActMH) ) * 100 End alloverEff_YEAR,
		 Case Sum(B.ActMH) When 0 Then 0 Else 
		    ( Sum(B.BasicMH) / Sum(B.ActMH) ) * 100 End alloverEff_MONTH  
	    FROM TMHMONTH_S A, TMHMONTH_S B 
	   WHERE ( A.AreaCode = B.AreaCode ) And
		 ( A.DivisionCode = B.DivisionCode ) And 
	 	 ( A.WorkCenter = B.WorkCenter ) And 
		 ( substring(A.sMonth, 1, 4) = substring(B.sMonth, 1, 4) ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
		   ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) AND  
		   ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
		   ( substring(B.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
						     Where ( AreaCode = A.AreaCode ) And 
						           ( DivisionCode = A.DivisionCode ) And 
						  	   ( stYear = @ps_stYear ) ) ) ) 
	Group By A.WorkCenter 

	Select @ps_area, 
	       @ps_div, 
	       @ps_stYear, 
	       A.WorkCenter, 
	       B.WorkCenterName, 
	       Case A.Gbn When '1' Then '종합효율' 
			  When '2' Then '실 동 율'
			  When '3' Then '작업효율' Else '' End rateGbn, 
	       A.alloverEff_YEAR, 
	       A.alloverEff_MONTH, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '01' ) rate_01, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '02' ) rate_02, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '03' ) rate_03, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '04' ) rate_04, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '05' ) rate_05, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '06' ) rate_06, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '07' ) rate_07, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '08' ) rate_08, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '09' ) rate_09, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '10' ) rate_10, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '11' ) rate_11, 
	     ( Select rate From #Temp_allover Where Gbn = A.Gbn And WorkCenter = A.WorkCenter And stMonth = '12' ) rate_12 
	  From #Temp_totallover A, TMSTWORKCENTER B 
	 Where ( A.WorkCenter = B.WorkCenter ) And 
	       ( ( B.AreaCode = @ps_area ) And
		 ( B.DivisionCode = @ps_div ) ) 
      Order By A.WorkCenter, A.Gbn 
		
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

