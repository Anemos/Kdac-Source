SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism010i_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism010i_04]
GO



/******************************************************/
/*        기준년 월별 LPI계획 및 실적(공장별)         */
/******************************************************/

CREATE PROCEDURE sp_eism010i_04 
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장 
	@ps_sYear	Char(4)			-- 기준년 
AS
BEGIN

 Declare @lastYear	Char(4) 

	CREATE TABLE #Temp_lpi -- 기준년월 년간목표, 당월목표, 당월실적, 누계목표, 누계실적 
	( 
		WorkCenter	VarChar(5)	not null, 
		sMonth		Char(2)		not null, 
		sPlan	Numeric(6,1)	null,
		Stock	Numeric(6,1)	null,
		Rate	Numeric(6,1)	null 
	)

 Set @lastYear = Cast ( Cast( @ps_sYear as Numeric(4) ) - 1 as Char(4) )

	-- 기준년 월별 목표, 실적 
	Insert Into #Temp_lpi ( WorkCenter, sMonth, sPlan, Stock ) 
	  SELECT A.WorkCenter,   
		 substring(A.tarMonth, 6, 2), 
	         round(A.tarLPI,1), 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM TMHVALUETARGET A,
	       ( SELECT C.WorkCenter, 
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
			( ( C.AreaCode = @ps_area ) And 
			  ( C.DivisionCode = @ps_div ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.WorkCenter, C.sMonth ) D
	   WHERE ( A.WorkCenter *= D.WorkCenter ) And 
		 ( A.tarMonth *= D.sMonth ) And 
		 ( ( A.AreaCode = @ps_area ) And 
		   ( A.DivisionCode = @ps_div ) And 
		   ( substring(A.tarMonth, 1, 4) = @ps_sYear ) And 
		   ( substring(A.tarMonth, 6, 2) Between '01' And '12' ) ) 


	-- 기준년 공장별 누계 목표, 실적 
	Insert Into #Temp_lpi ( WorkCenter, sMonth, sPlan, Stock ) 
	  SELECT A.WorkCenter,   
		 '13', 
		 round(A.tarLPI,1), 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM 
		( SELECT WorkCenter,   
         		 IsNull(tarLPI,0) tarLPI 
		    FROM TMHVALUETARGET 
		   Where ( AreaCode = @ps_area ) And 
			 ( DivisionCode = @ps_div ) And 
			 ( substring(tarMonth, 1, 7) = @ps_sYear + '.13' ) ) A, 
		( SELECT C.WorkCenter, 
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
			( ( C.AreaCode = @ps_area ) And 
			  ( C.DivisionCode = @ps_div ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.WorkCenter ) D
	   WHERE ( A.WorkCenter *= D.WorkCenter )


	-- 각 공장별 월별 목표, 실적 
	Insert Into #Temp_lpi ( WorkCenter, sMonth, sPlan, Stock ) 
	  SELECT 'XXXXX',   
		 substring(A.tarMonth, 6, 2), 
		 round(A.tarLPI,1), 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM ( SELECT tarMonth, 
         		 IsNull(tarLPI,0) tarLPI 
		    FROM TMHDIVVALUETARGET 
		   Where ( AreaCode = @ps_area ) And 
			 ( DivisionCode = @ps_div ) And 
			 ( substring(tarMonth, 1, 4) = @ps_sYear ) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) ) A, 
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
			( ( C.Areacode = @ps_area ) And 
			  ( C.DivisionCode = @ps_div ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) 
	       Group By C.sMonth ) D
	   WHERE ( A.tarMonth *= D.sMonth )


	-- 기준년 지역별 누계 목표, 실적 
	Insert Into #Temp_lpi ( WorkCenter, sMonth, sPlan, Stock ) 
	 SELECT 'XXXXX',   
		 '13', 
		 round(A.tarLPI,1), 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End 
	    FROM ( SELECT IsNull(tarLPI,0) tarLPI 
		    FROM TMHDIVVALUETARGET 
		   Where ( AreaCode = @ps_area ) And 
			 ( DivisionCode = @ps_div ) And 
			 ( substring(tarMonth, 1, 7) = @ps_sYear + '.13' ) ) A, 
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
			( ( C.Areacode = @ps_area ) And 
			  ( C.DivisionCode = @ps_div ) And 
			  ( D.stYear = @lastYear ) And 
			  ( substring(C.sMonth, 1, 4) = @ps_sYear ) ) ) D 

	 Update #Temp_lpi 
	    Set Rate  = Case IsNull(sPlan,0) When 0 Then 0 Else 
			         Round( Stock / sPlan * 100, 1 ) End 

	  Select A.WorkCenter, 
		 Case A.WorkCenter When 'XXXXX' Then '소계' Else B.WorkCenterName End WorkCenterName, 
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
	  ( Select Distinct WorkCenter 
			From #Temp_lpi ) A,
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '01' ) ) m01, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '02' ) ) m02, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '03' ) ) m03, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '04' ) ) m04, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '05' ) ) m05, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '06' ) ) m06, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '07' ) ) m07, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '08' ) ) m08, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '09' ) ) m09, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '10' ) ) m10, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '11' ) ) m11, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '12' ) ) m12, 
	  ( Select WorkCenter, 
				  sPlan,	
				  Stock,
				  Rate 
		   From #Temp_lpi 
		  Where ( sMonth = '13' ) ) m13,
		TMSTWORKCENTER B 
	   Where ( A.WorkCenter *= B.WorkCenter ) And 
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
		 ( A.WorkCenter *= m13.WorkCenter ) And 
		 ( ( B.AreaCode = @ps_area ) And 
		   ( B.DivisionCode = @ps_div ) ) 
	Order By A.WorkCenter 
 Drop Table #Temp_lpi 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

