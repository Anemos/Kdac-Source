SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism010i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism010i_01]
GO




/****************************************************/
/*        기준년월 LPI계획 및 실적(전사)            */
/****************************************************/

CREATE PROCEDURE sp_eism010i_01
	@ps_fromMonth	Char(7),			-- 기준년월 From 
	@ps_toMonth	Char(7),			-- 기준년월 To 
	@ps_area	Char(1)				-- 지역 
AS
BEGIN

 Declare @lastYear	Char(4) 

 Set @lastYear = Cast ( Cast( substring(@ps_toMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )

	CREATE TABLE #Temp_lpi -- 기준년월 년간목표, 당월목표, 당월실적, 누계목표, 누계실적 
	( 
		AreaCode	Char(1)		not null, 
		DivisionCode	Char(1)		not null, 
		year_Plan	Numeric(6,1)	null,
		mth_Plan	Numeric(6,1)	null,
		mth_Stock	Numeric(6,1)	null,
		mth_Rate	Numeric(6,1)	null, 
		over_Plan	Numeric(6,1)	null,
		over_Stock	Numeric(6,1)	null,
		over_Rate	Numeric(6,1)	null 
	)

	-- 각 공장별 년간목표, 당월목표, 누계목표치, 당월실적, 누계실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, year_Plan, mth_Plan, over_Plan, mth_Stock, over_Stock ) 
	  SELECT A.AreaCode, 
	 	 A.DivisionCode,   
		 Case B.tarLPI_bunmo When 0 Then 0 Else 
		      Round( B.tarLPI_bunja / B.tarLPI_bunmo * 100 , 1 ) End, 
	         round(A.tarLPI,1), 
		 Case C.tarLPI_bunmo When 0 Then 0 Else 
		      Round( C.tarLPI_bunja / C.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
			  	round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End, 
	    Case IsNull(E.LPI_bunmo,0) When 0 Then 0 Else
			   round( IsNull(E.LPI_bunja,0) / IsNull(E.LPI_bunmo,0) * 100, 1 ) End  
	    FROM TMHDIVVALUETARGET A,
		( SELECT AreaCode, 
			 DivisionCode,   
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( substring(tarMonth, 1, 4) = substring(@ps_toMonth, 1, 4) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) ) 	-- 년간목표 
		Group By AreaCode, DivisionCode ) B, 
		( SELECT AreaCode, 
			 DivisionCode,   
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( tarMonth Between @ps_fromMonth And @ps_toMonth ) 
		Group By AreaCode, DivisionCode ) C,
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
			   ( C.sMonth = @ps_toMonth ) ) 
	       Group By C.AreaCode, C.DivisionCode ) D, 
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
			  ( C.sMonth Between @ps_fromMonth And @ps_toMonth ) ) 
		Group By C.AreaCode, C.DivisionCode ) E 
	   WHERE ( A.AreaCode = B.AreaCode ) And 
		 ( A.DivisionCode = B.DivisionCode ) And 
		 ( A.AreaCode = C.AreaCode ) And 
		 ( A.DivisionCode = C.DivisionCode ) And 
		 ( A.AreaCode *= D.AreaCode ) And 
		 ( A.DivisionCode *= D.DivisionCode ) And 
		 ( A.AreaCode *= E.AreaCode ) And 
		 ( A.DivisionCode *= E.DivisionCode ) And 
		 ( ( A.areaCode like @ps_area ) And 
		   ( A.tarMonth = @ps_toMonth ) ) 


	-- 각 지역별 년간목표, 당월목표, 누계목표치, 당월실적, 누계실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, year_Plan, mth_Plan, over_Plan, mth_Stock, over_Stock ) 
	  SELECT A.AreaCode, 
	 	 'X',   
		 Case B.tarLPI_bunmo When 0 Then 0 Else 
		      Round( B.tarLPI_bunja / B.tarLPI_bunmo * 100 , 1 ) End, 
	         round(A.tarLPI,1), 
		 Case C.tarLPI_bunmo When 0 Then 0 Else 
		      Round( C.tarLPI_bunja / C.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
		      round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End, 
		 Case IsNull(E.LPI_bunmo,0) When 0 Then 0 Else
		      round( IsNull(E.LPI_bunja,0) / IsNull(E.LPI_bunmo,0) * 100, 1 ) End  
	    FROM 
		( Select Areacode, 
			 Case sum(IsNull(tarLPI_bunmo,0)) When 0 Then 0 Else 
			      Round( sum(IsNull(tarLPI_bunja,0)) / sum(IsNull(tarLPI_bunmo,0)) * 100, 1 ) End tarLPI 
			 From TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( tarMonth = @ps_toMonth ) 
		Group By AreaCode ) A, 
		( SELECT AreaCode, 
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( substring(tarMonth, 1, 4) = substring(@ps_toMonth, 1, 4) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) ) -- 공장전체 년간목표 
		Group By AreaCode ) B, 
		( SELECT AreaCode, 
         		 sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( areaCode like @ps_area ) And 
			 ( tarMonth Between @ps_fromMonth And @ps_toMonth ) 
		Group By AreaCode ) C,
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
			  ( C.sMonth = @ps_toMonth ) ) 
	       Group By C.AreaCode ) D, 
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
			  ( C.sMonth Between @ps_fromMonth And @ps_toMonth ) ) 
		Group By C.AreaCode ) E 
	   WHERE ( A.AreaCode = B.AreaCode ) And 
		 ( A.AreaCode = C.AreaCode ) And 
		 ( A.AreaCode *= D.AreaCode ) And 
		 ( A.AreaCode *= E.AreaCode )


	-- 전사 년간목표, 당월목표, 누계목표치, 당월실적, 누계실적 
	Insert Into #Temp_lpi ( AreaCode, DivisionCode, year_Plan, mth_Plan, over_Plan, mth_Stock, over_Stock ) 
	  SELECT 'X', 
	 	 '', 
		 Case B.tarLPI_bunmo When 0 Then 0 Else 
		      Round( B.tarLPI_bunja / B.tarLPI_bunmo * 100 , 1 ) End, 
	         round(A.tarLPI,1), 
		 Case C.tarLPI_bunmo When 0 Then 0 Else 
		      Round( C.tarLPI_bunja / C.tarLPI_bunmo * 100 , 1 ) End, 
		 Case IsNull(D.LPI_bunmo,0) When 0 Then 0 Else
		      round( IsNull(D.LPI_bunja,0) / IsNull(D.LPI_bunmo,0) * 100, 1 ) End, 
		 Case IsNull(E.LPI_bunmo,0) When 0 Then 0 Else
		      round( IsNull(E.LPI_bunja,0) / IsNull(E.LPI_bunmo,0) * 100, 1 ) End  
	    FROM 
		( Select Case sum(IsNull(tarLPI_bunmo,0)) When 0 Then 0 Else 
			        Round( sum(IsNull(tarLPI_bunja,0)) / sum(IsNull(tarLPI_bunmo,0)) * 100, 1 ) End tarLPI 
		    From TMHDIVVALUETARGET 
		   Where ( tarMonth = @ps_toMonth ) ) A, 
		( SELECT sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( substring(tarMonth, 1, 4) = substring(@ps_toMonth, 1, 4) And 
			 ( substring(tarMonth, 6, 2) Between '01' And '12' ) ) 
		 ) B, 
		( SELECT sum(IsNull(tarLPI_bunja,0)) tarLPI_bunja, 
			 sum(IsNull(tarLPI_bunmo,0)) tarLPI_bunmo 
		    FROM TMHDIVVALUETARGET 
		   Where ( tarMonth Between @ps_fromMonth And @ps_toMonth ) ) C, 
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
			  ( C.sMonth = @ps_toMonth ) ) ) D, 
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
			  ( C.sMonth Between @ps_fromMonth And @ps_toMonth ) ) ) E 

	 Update #Temp_lpi 
	    Set mth_Rate  = Case IsNull(mth_Plan,0) When 0 Then 0 Else 
			         Round( mth_Stock / mth_Plan * 100, 1 ) End, 
	        over_Rate = Case IsNull(over_Plan,0) When 0 Then 0 Else 
				 Round( over_Stock / over_Plan * 100, 1 ) End 

  SELECT A.AreaCode,   
         Case A.AreaCode When 'X' Then '전사' Else B.AreaName End AreaName,   
         A.DivisionCode,   
         Case A.DivisionCode When 'X' Then '소계' Else C.DivisionName End DivisionName,   
         A.year_Plan,   
         A.mth_Plan,   
         A.mth_Stock,   
         A.mth_Rate,   
         A.over_Plan,   
         A.over_Stock,   
         A.over_Rate  
    FROM #Temp_lpi A,   
         TMSTAREA B,   
         TMSTDIVISION C
   WHERE ( A.AreaCode *= B.AreaCode ) and  
         ( A.AreaCode *= C.AreaCode ) and  
         ( A.DivisionCode *= C.DivisionCode) 
Order By A.AreaCode, 
	 A.DivisionCode  

 Drop Table #Temp_lpi

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

