SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism040i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism040i_01]
GO


/*************************************/ 
/*     월별 부하율, 잔업율 현황      */ 
/*************************************/ 

CREATE PROCEDURE sp_eism040i_01
	@ps_stYear	Char(4),		-- 기준년도
	@ps_area	Char(1)			-- 지역 
AS
BEGIN

 Create Table #Temp_Month_s 
	( AreaCode 	Char(1)		not null, 
	  DivisionCode	Char(1)		not null, 
	  sMonth	Char(2)		not null, 
	  totMH		Numeric(6,1)	null, 
	  jungsiMH	Numeric(6,1)	null, 
	  etcMH		Numeric(6,1)	null, 
	  excunpaidMH	Numeric(6,1)	null, 
	  excpaidMH	Numeric(6,1)	null, 
	  gunteMH	Numeric(6,1)	null, 
	  ilboMH	Numeric(6,1)	null, 
	  bugaMH	Numeric(6,1)	null,
	  S4MH		Numeric(6,1)	null,
	  F67MH		Numeric(6,1)	null,
	  tarqtyMH	Numeric(15,4)	null ) 


 Insert Into #Temp_Month_s ( AreaCode, DivisionCode, sMonth, totMH, jungsiMH, etcMH, excunpaidMH, 
			     excpaidMH, gunteMH, ilboMH, bugaMH ) 
   Select AreaCode, 
	  DivisionCode, 
	  substring(sMonth, 6, 2) sMonth, 
	  sum(IsNull(totMH,0)) totMH, 
          sum(IsNull(jungsiMH,0)) jungsiMH, 
	  sum(IsNull(etcMH,0)) etcMH, 
	  sum(IsNull(excunpaidMH,0)) excunpaidMH,
	  sum(IsNull(excpaidMH,0)) excpaidMH,
	  sum(IsNull(gunteMH,0)) gunteMH, 
 	  sum(IsNull(ilboMH,0)) ilboMH, 
 	  sum(IsNull(bugaMH,0)) bugaMH  
     From TMHMONTH_S 
    Where ( areaCode like @ps_area ) And 
	  ( substring(sMonth, 1, 4) = @ps_stYear ) 
 Group By AreaCode, 
	  DivisionCode, 
	  substring(sMonth, 6, 2) 
  Union
   Select AreaCode, 
	  'X', 
	  substring(sMonth, 6, 2) sMonth, 
	  sum(IsNull(totMH,0)) totMH, 
          sum(IsNull(jungsiMH,0)) jungsiMH, 
	  sum(IsNull(etcMH,0)) etcMH, 
	  sum(IsNull(excunpaidMH,0)) excunpaidMH,
	  sum(IsNull(excpaidMH,0)) excpaidMH,
	  sum(IsNull(gunteMH,0)) gunteMH, 
 	  sum(IsNull(ilboMH,0)) ilboMH, 
 	  sum(IsNull(bugaMH,0)) bugaMH  
     From TMHMONTH_S 
    Where ( areacode like @ps_area ) And 
	  ( substring(sMonth, 1, 4) = @ps_stYear ) 
 Group By AreaCode, 
	  substring(sMonth, 6, 2) 
  Union 
   Select 'X', 
	  '', 
	  substring(sMonth, 6, 2) sMonth, 
	  sum(IsNull(totMH,0)) totMH, 
          sum(IsNull(jungsiMH,0)) jungsiMH, 
	  sum(IsNull(etcMH,0)) etcMH, 
	  sum(IsNull(excunpaidMH,0)) excunpaidMH,
	  sum(IsNull(excpaidMH,0)) excpaidMH,
	  sum(IsNull(gunteMH,0)) gunteMH, 
 	  sum(IsNull(ilboMH,0)) ilboMH, 
 	  sum(IsNull(bugaMH,0)) bugaMH  
     From TMHMONTH_S 
    Where ( substring(sMonth, 1, 4) = @ps_stYear ) 
 Group By substring(sMonth, 6, 2) 


Update #Temp_Month_s 
   Set S4MH = B.S4MH 
  From #Temp_Month_s A, 
 ( Select A.AreaCode, 
	  A.DivisionCode, 
	  substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) S4MH 
     From TMHDAILYDETAIL A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'S' ) AND ( A.mhCode = 'S4' ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By A.AreaCode, 
	  A.DivisionCode, 
	  substring(A.WorkDay, 6, 2) 
   Union 
   Select A.AreaCode, 
	  'X', 
	  substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) S4MH 
     From TMHDAILYDETAIL A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'S' ) AND ( A.mhCode = 'S4' ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By A.AreaCode, 
	  substring(A.WorkDay, 6, 2) 
  Union
   Select 'X', 
	  '', 
	  substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) S4MH 
     From TMHDAILYDETAIL A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'S' ) AND ( A.mhCode = 'S4' ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By substring(A.WorkDay, 6, 2) ) B 
 Where ( A.areaCode = B.areaCode ) And 
       ( A.DivisionCode = B.DivisionCode ) And 
       ( A.sMonth = B.stMonth ) 

Update #Temp_Month_s 
   Set F67MH = B.F67MH 
  From #Temp_Month_s A, 
 ( Select A.AreaCode, 
	  A.DivisionCode, 
	  substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) F67MH 
     From TMHDAILYSUB A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'F' ) AND ( A.mhCode in ( 'F6', 'F7' ) ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By A.AreaCode, 
	  A.DivisionCode, 
	  substring(A.WorkDay, 6, 2) 
  Union 
   Select A.AreaCode, 
	  'X', 
	  substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) F67MH 
     From TMHDAILYSUB A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( A.areaCode like @ps_area ) And 
	    ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'F' ) AND ( A.mhCode in ( 'F6', 'F7' ) ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By A.AreaCode, 
	  substring(A.WorkDay, 6, 2) 
  Union
   Select 'X', 
	  '', 
	  substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) F67MH 
     From TMHDAILYSUB A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'F' ) AND ( A.mhCode in ( 'F6', 'F7' ) ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By substring(A.WorkDay, 6, 2) ) B 
 Where ( A.areaCode = B.areaCode ) And 
       ( A.DivisionCode = B.DivisionCode ) And 
       ( A.sMonth = B.stMonth ) 

Update #Temp_Month_s 
   Set tarqtyMH = B.tarqtyMH 
  From #Temp_Month_s A, 
 ( SELECT G.AreaCode, 
	  G.DivisionCode, 
	  substring(G.sMonth, 6, 2) sMonth, 
	  sum( IsNull(G.pQty,0) * IsNull(H.tarMH,0) ) tarqtyMH 
     FROM TMHMONTHPRODLINE_S G,   
	  TMHMONTHTARGET H  
    WHERE ( G.AreaCode = H.AreaCode ) and  
	  ( G.DivisionCode = H.DivisionCode ) and  
	  ( G.WorkCenter = H.WorkCenter ) and  
	  ( G.ItemCode = H.ItemCode ) and  
	  ( G.subLineCode = H.subLineCode ) And 
	  ( G.subLineNo = H.subLineNo ) And 
	  ( G.sMonth = H.tarMonth ) and  
	  ( ( G.areaCode like @ps_area ) And 
	    ( substring(G.sMonth, 1, 4) = @ps_stYear ) ) 
 Group By G.AreaCode, 
	  G.DivisionCode, 
	  substring(G.sMonth, 6, 2) 
  Union
   SELECT G.AreaCode, 
	  'X', 
	  substring(G.sMonth, 6, 2) sMonth, 
	  sum( IsNull(G.pQty,0) * IsNull(H.tarMH,0) ) tarqtyMH 
     FROM TMHMONTHPRODLINE_S G,   
	  TMHMONTHTARGET H  
    WHERE ( G.AreaCode = H.AreaCode ) and  
	  ( G.DivisionCode = H.DivisionCode ) and  
	  ( G.WorkCenter = H.WorkCenter ) and  
	  ( G.ItemCode = H.ItemCode ) and  
	  ( G.subLineCode = H.subLineCode ) And 
	  ( G.subLineNo = H.subLineNo ) And 
	  ( G.sMonth = H.tarMonth ) and  
	  ( ( G.areaCode like @ps_area ) And 
	    ( substring(G.sMonth, 1, 4) = @ps_stYear ) ) 
 Group By G.AreaCode, 
	  substring(G.sMonth, 6, 2) 
  Union
   SELECT 'X', 
	  '', 
	  substring(G.sMonth, 6, 2) sMonth, 
	  sum( IsNull(G.pQty,0) * IsNull(H.tarMH,0) ) tarqtyMH 
     FROM TMHMONTHPRODLINE_S G,   
	  TMHMONTHTARGET H  
    WHERE ( G.AreaCode = H.AreaCode ) and  
	  ( G.DivisionCode = H.DivisionCode ) and  
	  ( G.WorkCenter = H.WorkCenter ) and  
	  ( G.ItemCode = H.ItemCode ) and  
	  ( G.subLineCode = H.subLineCode ) And 
	  ( G.subLineNo = H.subLineNo ) And 
	  ( G.sMonth = H.tarMonth ) and  
	  ( ( substring(G.sMonth, 1, 4) = @ps_stYear ) ) 
 Group By substring(G.sMonth, 6, 2) ) B 
 Where ( A.areaCode = B.areaCode ) And 
       ( A.DivisionCode = B.DivisionCode ) And 
       ( A.sMonth = B.sMonth ) 

/*************************************************************************************/
/* 부하율(실적) = ( 목표대비소요MH + 총부가작업(물류,개선MH제외) ) / 		     */
/*		  ( 정시MH - 평가제외MH + 전사교육(S4) - 유급근태사고MH ) 	     */
/*										     */ 
/* 잔업율(실적) = 정시외MH / ( 정시MH - 평가제외MH + 전사교육(S4) - 유급근태사고MH ) */
/*************************************************************************************/

 SELECT A.AreaCode, 
	A.DivisionCode, 
	A.sMonth, 
	IsNull(A.tarqtyMH,0) + ( IsNull(A.bugaMH,0) - IsNull(A.F67MH,0) ) buha_bunja, 
	IsNull(A.jungsiMH,0) - ( IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) ) + IsNull(A.S4MH,0) - IsNull(A.gunteMH,0) buha_bunmo,
	Case IsNull(A.jungsiMH,0) - ( IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) ) + IsNull(A.S4MH,0) - IsNull(A.gunteMH,0) When 0 Then 0 Else 
	     round( ( IsNull(A.tarqtyMH,0) + ( IsNull(A.bugaMH,0) - IsNull(A.F67MH,0) ) ) / 
	    	    ( IsNull(A.jungsiMH,0) - ( IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) ) + IsNull(A.S4MH,0) - IsNull(A.gunteMH,0) ) * 100, 1 ) End buha_rate, 
	IsNull(A.etcMH,0) janup_bunja, 
	IsNull(A.jungsiMH,0) - ( IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) ) + IsNull(A.S4MH,0) - IsNull(A.gunteMH,0) janup_bunmo,
	Case IsNull(A.jungsiMH,0) - ( IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) ) + IsNull(A.S4MH,0) - IsNull(A.gunteMH,0) When 0 Then 0 Else 
	     round( IsNull(A.etcMH,0) / 
	            ( IsNull(A.jungsiMH,0) - ( IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) ) + IsNull(A.S4MH,0) - IsNull(A.gunteMH,0) ) * 100, 1 ) End janup_rate  
   Into #Temp_buhaRate 
   FROM #Temp_Month_s A 
Order By A.AreaCode, A.DivisionCode, A.sMonth 


	  Select A.AreaCode, 
		 Case A.AreaCode When 'X' Then '전사' Else B.AreaName End AreaName, 
		 A.DivisionCode, 
		 Case A.DivisionCode When 'X' Then '소계' Else C.DivisionName End DivisionName, 
		 m01.buha_rate,
		 m01.janup_rate, 
		 m02.buha_rate,
		 m02.janup_rate, 
		 m03.buha_rate,
		 m03.janup_rate, 
		 m04.buha_rate,
		 m04.janup_rate, 
		 m05.buha_rate,
		 m05.janup_rate, 
		 m06.buha_rate,
		 m06.janup_rate, 
		 m07.buha_rate,
		 m07.janup_rate, 
		 m08.buha_rate,
		 m08.janup_rate, 
		 m09.buha_rate,
		 m09.janup_rate, 
		 m10.buha_rate,
		 m10.janup_rate, 
		 m11.buha_rate, 
		 m11.janup_rate, 
		 m12.buha_rate, 
		 m12.janup_rate 
  From   
	  ( Select Distinct AreaCode, DivisionCode  
	      From #Temp_buhaRate ) A, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '01' ) ) m01, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '02' ) ) m02, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '03' ) ) m03, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '04' ) ) m04, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '05' ) ) m05, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '06' ) ) m06, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '07' ) ) m07, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '08' ) ) m08, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '09' ) ) m09, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '10' ) ) m10, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '11' ) ) m11, 
	  ( Select AreaCode, 
		   DivisionCode, 
		   buha_rate,	
		   janup_rate 
	      From #Temp_buhaRate 
	     Where ( sMonth = '12' ) ) m12, 
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
	 ( A.DivisionCode *= m12.DivisionCode ) 
Order By A.AreaCode, 
	 A.DivisionCode 
 
Drop Table #Temp_Month_s
Drop Table #Temp_buhaRate 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

