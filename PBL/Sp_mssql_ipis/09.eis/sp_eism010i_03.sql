SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism010i_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism010i_03]
GO



/****************************************************/
/*        기준년 월별 LPI계획 및 실적(전사)         */
/****************************************************/

CREATE PROCEDURE sp_eism010i_03 
	@ps_sYear	Char(4),			-- 기준년 
	@ps_area	Char(1)				-- 지역 
AS
BEGIN

 Declare @lastYear	Char(4) 

	CREATE TABLE #Temp_lpi -- 기준년월 년간목표, 당월목표, 당월실적, 누계목표, 누계실적 
	( 
		AreaCode	Char(1)		not null, 
		DivisionCode	Char(1)		not null, 
		sMonth		Char(2)		not null, 
		sPlan	Numeric(6,1)	null,
		Stock	Numeric(6,1)	null,
		Rate	Numeric(6,1)	null 
	)

 Set @lastYear = Cast ( Cast( @ps_sYear as Numeric(4) ) - 1 as Char(4) )

	-- 기준년 월별 목표, 실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, sMonth, sPlan, Stock ) 
	  SELECT A.AreaCode, 
	 	 A.DivisionCode,   
		 substring(A.tarMonth, 6, 2), 
	         round(A.tarLPI,1), 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
		      round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM TMHDIVVALUETARGET A,
	       ( SELECT C.AreaCode, 
			C.DivisionCode, 
			C.sMonth, 
		        sum( IsNull(D.stMH,0) * IsNull(C.pQty,0) ) LPI_bunja,
			sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		   FROM TMHMONTHPRODLINE_S C, 
		    	TMHSTANDARD D 
		  WHERE ( C.AreaCode = D.AreaCode ) and  
			( C.DivisionCode = D.DivisionCode ) and  
		        ( C.WorkCenter = D.WorkCenter ) and  
			( C.ItemCode = D.ItemCode ) and  
			( C.subLineCode = D.subLineCode ) And 
			( C.subLineNo = D.subLineNo ) And 
			( ( C.areaCode like @ps_area ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.AreaCode, C.DivisionCode, C.sMonth ) D
	   WHERE ( A.AreaCode *= D.AreaCode ) And 
		 ( A.DivisionCode *= D.DivisionCode ) And 
		 ( A.tarMonth *= D.sMonth ) And 
		 ( ( A.areaCode like @ps_area ) And 
		   ( substring(A.tarMonth, 1, 4) = @ps_sYear ) And 
		   ( substring(A.tarMonth, 6, 2) Between '01' And '12' ) ) 

	-- 기준년 공장별 누계 목표, 실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, sMonth, sPlan, Stock ) 
	  SELECT A.AreaCode, 
	 	 A.DivisionCode,   
		 '13', 
		 Case A.tarLPI_bunmo When 0 Then 0 Else 
		      Round( A.tarLPI_bunja / A.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM 
		( SELECT AreaCode, 
			 DivisionCode,   
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( substring(tarMonth, 1, 4) = @ps_sYear ) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) 
		Group By AreaCode, DivisionCode ) A, 
	       ( SELECT C.AreaCode, 
			C.DivisionCode, 
		        sum( IsNull(D.stMH,0) * IsNull(C.pQty,0) ) LPI_bunja,
			sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		   FROM TMHMONTHPRODLINE_S C, 
		    	TMHSTANDARD D 
		  WHERE ( C.AreaCode = D.AreaCode ) and  
			( C.DivisionCode = D.DivisionCode ) and  
		        ( C.WorkCenter = D.WorkCenter ) and  
			( C.ItemCode = D.ItemCode ) and  
			( C.subLineCode = D.subLineCode ) And 
			( C.subLineNo = D.subLineNo ) And 
			( ( C.areaCode like @ps_area ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.AreaCode, C.DivisionCode ) D
	   WHERE ( A.AreaCode *= D.AreaCode ) And 
		 ( A.DivisionCode *= D.DivisionCode )

	-- 각 지역별 월별 목표, 실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, sMonth, sPlan, Stock ) 
	  SELECT A.AreaCode, 
	 	 'X',   
		 substring(A.tarMonth, 6, 2), 
		 Case A.tarLPI_bunmo When 0 Then 0 Else 
		      Round( A.tarLPI_bunja / A.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM ( SELECT AreaCode, 
			  tarMonth, 
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( substring(tarMonth, 1, 4) = @ps_sYear ) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) 
		Group By AreaCode, tarMonth ) A, 
	       ( SELECT C.AreaCode, 
			C.sMonth, 
		        sum( IsNull(D.stMH,0) * IsNull(C.pQty,0) ) LPI_bunja,
			sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		   FROM TMHMONTHPRODLINE_S C, 
		    	TMHSTANDARD D 
		  WHERE ( C.AreaCode = D.AreaCode ) and  
			( C.DivisionCode = D.DivisionCode ) and  
		        ( C.WorkCenter = D.WorkCenter ) and  
			( C.ItemCode = D.ItemCode ) and  
			( C.subLineCode = D.subLineCode ) And 
			( C.subLineNo = D.subLineNo ) And 
			( ( C.areaCode like @ps_area ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.AreaCode, C.sMonth ) D
	   WHERE ( A.AreaCode *= D.AreaCode ) And 
		 ( A.tarMonth *= D.sMonth )

	-- 기준년 지역별 누계 목표, 실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, sMonth, sPlan, Stock ) 
	 SELECT A.AreaCode, 
	 	 'X',   
		 '13', 
		 Case A.tarLPI_bunmo When 0 Then 0 Else 
		      Round( A.tarLPI_bunja / A.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM ( SELECT AreaCode, 
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( substring(tarMonth, 1, 4) = @ps_sYear ) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) 
		Group By AreaCode ) A, 
		( SELECT C.AreaCode, 
		        sum( IsNull(D.stMH,0) * IsNull(C.pQty,0) ) LPI_bunja,
			sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		   FROM TMHMONTHPRODLINE_S C, 
		    	TMHSTANDARD D 
		  WHERE ( C.AreaCode = D.AreaCode ) and  
			( C.DivisionCode = D.DivisionCode ) and  
		        ( C.WorkCenter = D.WorkCenter ) and  
			( C.ItemCode = D.ItemCode ) and  
			( C.subLineCode = D.subLineCode ) And 
			( C.subLineNo = D.subLineNo ) And 
			( ( C.areaCode like @ps_area ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.AreaCode ) D
	   WHERE ( A.AreaCode *= D.AreaCode ) 

	-- 전사 월별 목표, 실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, sMonth, sPlan, Stock ) 
	  SELECT 'X', 
	 	 '',   
		 substring(A.tarMonth, 6, 2), 
		 Case A.tarLPI_bunmo When 0 Then 0 Else 
		      Round( A.tarLPI_bunja / A.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM ( SELECT tarMonth, 
         			 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( substring(tarMonth, 1, 4) = @ps_sYear ) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) 
		Group By tarMonth ) A, 
		( SELECT C.sMonth, 
		        	sum( IsNull(D.stMH,0) * IsNull(C.pQty,0) ) LPI_bunja,
			sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		   FROM TMHMONTHPRODLINE_S C, 
		    	TMHSTANDARD D 
		  WHERE ( C.AreaCode = D.AreaCode ) and  
			( C.DivisionCode = D.DivisionCode ) and  
	        	( C.WorkCenter = D.WorkCenter ) and  
			( C.ItemCode = D.ItemCode ) and  
			( C.subLineCode = D.subLineCode ) And 
			( C.subLineNo = D.subLineNo ) And 
			( ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
		Group By C.sMonth ) D
	   WHERE ( A.tarMonth *= D.sMonth )

	-- 전사 누계 목표, 실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, sMonth, sPlan, Stock ) 
	 SELECT 'X', 
	 	 '',   
		 '13', 
		 Case A.tarLPI_bunmo When 0 Then 0 Else 
		      Round( A.tarLPI_bunja / A.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM ( SELECT sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( substring(tarMonth, 1, 4) = @ps_sYear ) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) ) A, 
		( SELECT sum( IsNull(D.stMH,0) * IsNull(C.pQty,0) ) LPI_bunja,
			sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		   FROM TMHMONTHPRODLINE_S C, 
		    	TMHSTANDARD D 
		  WHERE ( C.AreaCode = D.AreaCode ) and  
			( C.DivisionCode = D.DivisionCode ) and  
		       	( C.WorkCenter = D.WorkCenter ) and  
			( C.ItemCode = D.ItemCode ) and  
			( C.subLineCode = D.subLineCode ) And 
			( C.subLineNo = D.subLineNo ) And 
			( ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) ) D

	 Update #Temp_lpi 
	    Set Rate  = Case IsNull(sPlan,0) When 0 Then 0 Else 
			         Round( Stock / sPlan * 100, 1 ) End 

	  Select A.AreaCode, 
		 Case A.AreaCode When 'X' Then '전사' Else B.AreaName End AreaName, 
		 A.DivisionCode,
		 Case A.DivisionCode When 'X' Then '소계' Else C.DivisionName End DivisionName, 
		 m01.sPlan,
		 m01.Stock, 
		 m01.Rate,
		 m02.sPlan,
		 m02.Stock, 
		 m02.Rate, 
		 m03.sPlan,
		 m03.Stock, 
		 m03.Rate, 
		 m04.sPlan,
		 m04.Stock, 
		 m04.Rate, 
		 m05.sPlan,
		 m05.Stock, 
		 m05.Rate, 
		 m06.sPlan,
		 m06.Stock, 
		 m06.Rate, 
		 m07.sPlan,
		 m07.Stock, 
		 m07.Rate, 
		 m08.sPlan,
		 m08.Stock, 
		 m08.Rate, 
		 m09.sPlan,
		 m09.Stock, 
		 m09.Rate, 
		 m10.sPlan,
		 m10.Stock, 
		 m10.Rate, 
		 m11.sPlan,
		 m11.Stock, 
		 m11.Rate, 
		 m12.sPlan,
		 m12.Stock, 
		 m12.Rate, 
		 m13.sPlan,
		 m13.Stock, 
		 m13.Rate 
  From 
	  ( Select Distinct AreaCode, 
		   DivisionCode
	      From #Temp_lpi ) A,
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '01' ) ) m01, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '02' ) ) m02, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '03' ) ) m03, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '04' ) ) m04, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '05' ) ) m05, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '06' ) ) m06, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '07' ) ) m07, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '08' ) ) m08, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '09' ) ) m09, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '10' ) ) m10, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '11' ) ) m11, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '12' ) ) m12, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   sPlan,	
		   Stock,
		   Rate 
	      From #Temp_lpi 
	     Where ( sMonth = '13' ) ) m13, 
		TMSTAREA B,
		TMSTDIVISION C 
	   Where ( A.AreaCode *= B.AreaCode ) And 
		 ( A.AreaCode *= C.AreaCode ) And 
		 ( A.DivisionCode *= C.DivisionCode ) And 
		 ( A.AreaCode *= m01.AreaCode ) And 
		 ( A.DivisionCode *= m01.DivisionCode ) And 
		 ( A.AreaCode *= m02.AreaCode ) And 
		 ( A.DivisionCode *= m02.DivisionCode ) And 
		 ( A.AreaCode *= m03.AreaCode ) And 
		 ( A.DivisionCode *= m03.DivisionCode ) And 
		 ( A.AreaCode *= m04.AreaCode ) And 
		 ( A.DivisionCode *= m04.DivisionCode ) And 
		 ( A.AreaCode *= m05.AreaCode ) And 
		 ( A.DivisionCode *= m05.DivisionCode ) And 
		 ( A.AreaCode *= m06.AreaCode ) And 
		 ( A.DivisionCode *= m06.DivisionCode ) And 
		 ( A.AreaCode *= m07.AreaCode ) And 
		 ( A.DivisionCode *= m07.DivisionCode ) And 
		 ( A.AreaCode *= m08.AreaCode ) And 
		 ( A.DivisionCode *= m08.DivisionCode ) And 
		 ( A.AreaCode *= m09.AreaCode ) And 
		 ( A.DivisionCode *= m09.DivisionCode ) And 
		 ( A.AreaCode *= m10.AreaCode ) And 
		 ( A.DivisionCode *= m10.DivisionCode ) And 
		 ( A.AreaCode *= m11.AreaCode ) And 
		 ( A.DivisionCode *= m11.DivisionCode ) And 
		 ( A.AreaCode *= m12.AreaCode ) And 
		 ( A.DivisionCode *= m12.DivisionCode ) And 
		 ( A.AreaCode *= m13.AreaCode ) And 
		 ( A.DivisionCode *= m13.DivisionCode ) 
Order By A.AreaCode, 
	 A.DivisionCode  

 Drop Table #Temp_lpi 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

