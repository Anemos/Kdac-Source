SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism020i_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism020i_03]
GO



/**************************************/
/*     공장내 월별 종합효율 실적      */
/**************************************/

CREATE PROCEDURE sp_eism020i_03
	@ps_stYear	Char(4),			-- 기준년
	@ps_area	Char(1)				-- 지역 
AS
BEGIN

CREATE TABLE #Temp_alloverRate -- 당월 공장별 총투입공수, 실동공수, 표준생산공수 
( 
	AreaCode	Char(1)		not null, 
	DivisionCode	Char(1)		not null, 
	sMonth		Char(2)		not null, 
	totinMH		Numeric(6,1)	null, 
	basicMH		Numeric(6,1)	null,
	tar_totInMH	Numeric(6,1) 	null,
	tar_basicMH	Numeric(6,1)	null, 
	tar_alloverEff  Numeric(6,1)	null, 
	alloverEff	Numeric(6,1)	null,
	alloverEffRate	Numeric(6,1)	null 
)

Insert Into #Temp_alloverRate ( AreaCode, DivisionCode, sMonth, totInMH, basicMH, tar_totInMH, tar_basicMH ) 
  SELECT A.AreaCode,   
         A.DivisionCode,   
	 substring(A.sMonth, 6, 2) sMonth, 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH,  
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	    ( substring(B.tarMonth, 6, 2) Between '01' And '12') ) 
 Group By A.AreaCode,   
          A.DivisionCode,   
	  substring(A.sMonth, 6, 2) 
Union
  SELECT A.AreaCode,   
         'X',   
	 substring(A.sMonth, 6, 2), 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH, 
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	    ( substring(B.tarMonth, 6, 2) Between '01' And '12') ) 
 Group By A.AreaCode, 
	  substring(A.sMonth, 6, 2) 
Union
  SELECT 'X',   
         '',   
	 substring(A.sMonth, 6, 2), 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH, 
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	    ( substring(B.tarMonth, 6, 2) Between '01' And '12') ) 
 Group By substring(A.sMonth, 6, 2) 
Union
  SELECT A.AreaCode,   
         A.DivisionCode,   
	 '13', 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH,  
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	    ( substring(B.tarMonth, 6, 2) Between '01' And '12') ) 
 Group By A.AreaCode,   
          A.DivisionCode 
Union
  SELECT A.AreaCode,   
         'X',   
	 '13', 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH, 
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( A.areacode like @ps_area ) And 
	    ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	    ( substring(B.tarMonth, 6, 2) Between '01' And '12') ) 
 Group By A.AreaCode 
Union 
  SELECT 'X',   
         '',   
	 '13', 
	 sum(IsNull(A.totInMH,0)) totInMH, 
	 sum(IsNull(A.BasicMH,0)) BasicMH, 
	 sum(IsNull(B.totInMH,0)) tar_totInMH,  
	 sum(IsNull(B.BasicMH,0)) tar_BasicMH 
    FROM TMHMONTH_S A,   
         TMHVALUETARGET B 
    WHERE ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
          ( A.WorkCenter = B.WorkCenter ) and  
          ( A.sMonth = B.tarMonth ) and  
	  ( ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	    ( substring(B.tarMonth, 6, 2) Between '01' And '12') )  

  Update #Temp_alloverRate 
     Set tar_alloverEff = Case tar_totInMH When 0 Then 0 Else 
			       round( tar_BasicMH / tar_totInMH * 100, 1 ) End, 
	 alloverEff     = Case totInMH When 0 Then 0 Else 
			       round( BasicMH / totInMH * 100, 1 ) End, 
	 alloverEffRate = Case ( Case tar_totInMH When 0 Then 0 Else 
		       	              round( tar_BasicMH / tar_totInMH * 100, 1 ) End ) When 0 Then 0 Else 
			       		round( ( Case totInMH When 0 Then 0 Else 
						      round( BasicMH / totInMH * 100, 1 ) End ) /
					       ( Case tar_totInMH When 0 Then 0 Else 
				       	              round( tar_BasicMH / tar_totInMH * 100, 1 ) End ) * 100, 1 ) End 


	  Select A.AreaCode, 
		 Case A.AreaCode When 'X' Then '전사' Else B.AreaName End AreaName, 
		 A.DivisionCode,
		 Case A.DivisionCode When 'X' Then '소계' Else C.DivisionName End DivisionName, 
		 m01.tar_alloverEff,
		 m01.alloverEff, 
		 m01.alloverEffRate ,
		 m02.tar_alloverEff,
		 m02.alloverEff, 
		 m02.alloverEffRate ,
		 m03.tar_alloverEff,
		 m03.alloverEff, 
		 m03.alloverEffRate ,
		 m04.tar_alloverEff,
		 m04.alloverEff, 
		 m04.alloverEffRate ,
		 m05.tar_alloverEff,
		 m05.alloverEff, 
		 m05.alloverEffRate ,
		 m06.tar_alloverEff,
		 m06.alloverEff, 
		 m06.alloverEffRate ,
		 m07.tar_alloverEff,
		 m07.alloverEff, 
		 m07.alloverEffRate ,
		 m08.tar_alloverEff,
		 m08.alloverEff, 
		 m08.alloverEffRate ,
		 m09.tar_alloverEff,
		 m09.alloverEff, 
		 m09.alloverEffRate ,
		 m10.tar_alloverEff,
		 m10.alloverEff, 
		 m10.alloverEffRate ,
		 m11.tar_alloverEff,
		 m11.alloverEff, 
		 m11.alloverEffRate ,
		 m12.tar_alloverEff,
		 m12.alloverEff, 
		 m12.alloverEffRate ,
		 m13.tar_alloverEff,
		 m13.alloverEff, 
		 m13.alloverEffRate 
  From   
	  ( Select Distinct AreaCode, 
		   DivisionCode 
	      From #Temp_alloverRate ) A, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '01' ) ) m01, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '02' ) ) m02, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '03' ) ) m03, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '04' ) ) m04, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '05' ) ) m05, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '06' ) ) m06, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '07' ) ) m07, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '08' ) ) m08, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '09' ) ) m09, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '10' ) ) m10, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '11' ) ) m11, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
	     Where ( sMonth = '12' ) ) m12, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   tar_alloverEff,	
		   alloverEff,
		   alloverEffRate  
	      From #Temp_alloverRate 
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

  Drop Table #Temp_alloverRate 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

