SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism050i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism050i_01]
GO



/******************************/ 
/*     월별 공수투입 현황     */ 
/******************************/ 

CREATE PROCEDURE sp_eism050i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		VarChar(5),		-- 조
	@ps_stYear	Char(4),		-- 기준년 
	@ps_retGubun	Char(1) 
AS
BEGIN


 Declare @lastYear 	Char(4) 

 Create Table #Temp_MHList 
	( sMonth	Char(2)		not null,
	  jungsiMH	Numeric(8,1)	null,
	  etcMH		Numeric(8,1)	null,
	  totMH		Numeric(8,1)	null, 
	  excunpaidMH	Numeric(8,1)	null, 
	  excpaidMH	Numeric(8,1)	null, 
	  totInMH	Numeric(8,1)	null, 
	  gunteMH	Numeric(8,1)	null, 
	  ilboMH	Numeric(8,1)	null, 
	  bugaMH	Numeric(8,1)	null, 
	  ActInMH	Numeric(8,1)	null, 
	  ActMH		Numeric(8,1)	null, 
	  UnuseMH	Numeric(8,1)	null, 
	  effDownMH	Numeric(8,1)	null, 
	  basicMH	Numeric(8,1)	null, 
	  lpi		Numeric(8,1)	null,
	  dispRate_bunmo Numeric(8,1)	null	 ) 

 Set @lastYear = Cast ( Cast( @ps_stYear as Numeric(4) ) - 1 as Char(4) )

	Insert Into #Temp_MHList ( sMonth, jungsiMH, etcMH, totMH, excunpaidMH, excpaidMH, totInMH, gunteMH, ilboMH, 
				   bugaMH, ActInMH, ActMH, UnuseMH, effDownMH, basicMH, lpi, dispRate_bunmo ) 
	  Select sMonth 	= substring(A.sMonth, 6, 2), 
		 jungsiMH	= sum(IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) ), 
	         etcMH 		= sum(IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) ), 
	         totMH 		= sum(IsNull(A.totMH,0)),
	         excunpaidMH 	= sum(IsNull(A.excunpaidMH,0)), 
	         excpaidMH 	= sum(IsNull(A.excpaidMH,0)), 
	         totInMH 	= sum(IsNull(A.totInMH,0)), 
	         gunteMH 	= sum(IsNull(A.gunteMH,0)), 
	         ilboMH 	= sum(IsNull(A.ilboMH,0)), 
	         bugaMH 	= sum(IsNull(A.bugaMH,0)), 
	         ActInMH 	= sum(IsNull(A.ActInMH,0)),
		 ActMH 		= sum(IsNull(A.ActMH,0)),
		 UnuseMH 	= sum(IsNull(A.UnuseMH,0)),
		 effDownMH 	= sum(IsNull(A.effDownMH,0)), 
		 basicMH 	= IsNull(D.basicMH,0),
		 lpi 		= Case IsNull(D.lpi_bunmo,0) When 0 Then 0 Else 
				       round( IsNull(D.lpi_bunja,0) / IsNull(D.lpi_bunmo,0) * 100, 1) End, 
		 NULL 
	    FROM TMHMONTH_S A, 
		( Select B.sMonth, 
			 sum(IsNull(B.basicMH,0)) basicMH,
			 sum(IsNull(C.stMH,0) * IsNull(B.pQty,0)) lpi_bunja, 
			 sum(IsNull(B.actInMH,0)) lpi_bunmo 
		    From TMHMONTHPRODLINE_S B, 
			( SELECT WorkCenter, 
				 ItemCode, 
				 subLineCode, 
				 subLineNo, 
				 IsNull(stMH,0) stMH 
			    FROM TMHSTANDARD 
			   WHERE ( AreaCode like @ps_area ) And 
				 ( DivisionCode like @ps_div ) And 
				 ( WorkCenter like @ps_wc ) And 
				 ( stYear = @lastYear ) ) C 
		  Where ( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( ( B.AreaCode like @ps_area ) And 
			  ( B.DivisionCode like @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( substring(B.sMonth, 1, 4) = @ps_stYear ) ) 
	       Group By B.sMonth ) D 
	   WHERE ( A.sMonth *= D.sMonth ) And 
		 ( ( A.AreaCode like @ps_area ) AND  
	           ( A.DivisionCode like @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( substring(A.sMonth, 1, 4) = @ps_stYear ) ) 
	Group By A.sMonth, D.basicMH, D.lpi_bunja, D.lpi_bunmo 
	Union
	  Select sMonth 	= '13',  
		 jungsiMH	= sum(IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) ), 
	         etcMH 		= sum(IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) ), 
	         totMH 		= sum(IsNull(A.totMH,0)),
	         excunpaidMH 	= sum(IsNull(A.excunpaidMH,0)), 
	         excpaidMH 	= sum(IsNull(A.excpaidMH,0)), 
	         totInMH 	= sum(IsNull(A.totInMH,0)), 
	         gunteMH 	= sum(IsNull(A.gunteMH,0)), 
	         ilboMH 	= sum(IsNull(A.ilboMH,0)), 
	         bugaMH 	= sum(IsNull(A.bugaMH,0)), 
	         ActInMH 	= sum(IsNull(A.ActInMH,0)),
		 ActMH 		= sum(IsNull(A.ActMH,0)),
		 UnuseMH 	= sum(IsNull(A.UnuseMH,0)),
		 effDownMH 	= sum(IsNull(A.effDownMH,0)), 
		 basicMH 	= IsNull(D.basicMH,0),
		 lpi 		= Case IsNull(D.lpi_bunmo,0) When 0 Then 0 Else 
				       round( IsNull(D.lpi_bunja,0) / IsNull(D.lpi_bunmo,0) * 100, 1) End, 
		 NULL  
	    FROM TMHMONTH_S A, 
		( Select substring(B.sMonth, 1, 4) sMonth, 
			 sum(IsNull(B.basicMH,0)) basicMH,
			 sum(IsNull(C.stMH,0) * IsNull(B.pQty,0)) lpi_bunja, 
			 sum(IsNull(B.actInMH,0)) lpi_bunmo 
		    From TMHMONTHPRODLINE_S B, 
			( SELECT WorkCenter, 
				 ItemCode, 
				 subLineCode, 
				 subLineNo, 
				 IsNull(stMH,0) stMH 
			    FROM TMHSTANDARD 
			   WHERE ( AreaCode like @ps_area ) And 
				 ( DivisionCode like @ps_div ) And 
				 ( WorkCenter like @ps_wc ) And 
				 ( stYear = @lastYear ) ) C 
		  Where ( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( ( B.AreaCode like @ps_area ) And 
			  ( B.DivisionCode like @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( substring(B.sMonth, 1, 4) = @ps_stYear ) ) 
	       Group By substring(B.sMonth, 1, 4) ) D 
	   WHERE ( substring(A.sMonth, 1, 4) *= D.sMonth ) And 
		 ( ( A.AreaCode like @ps_area ) AND  
	           ( A.DivisionCode like @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( substring(A.sMonth, 1, 4) = @ps_stYear ) ) 
	Group By D.basicMH, D.lpi_bunja, D.lpi_bunmo 

	Update #Temp_MHList 
	   Set dispRate_bunmo = IsNull(( Select totMH From #Temp_MHList A Where A.sMonth = #Temp_MHList.sMonth ), 0) 

	Begin	

	Create Table #Temp_dispMHList 
	( sMonth	Char(2) 	not null,
	  Seq1		Int		not null,
	  seq2		Int		null, 
	  dispLevel	Char(1)		not null,
	  dispName	VarChar(100)	null, 
	  dispMH	Numeric(6,1)	null,
	  dispRate	Numeric(5,1)	null ) 

	If @ps_retGubun = '1' 
	Begin 

		Insert Into #Temp_dispMHList 
		  SELECT sMonth, 
			 1 Seq1,  
			 0 Seq2, 
			'1' dispLevel, 
			'   정시공수 (B)' dispName,
			 jungsiMH dispMH,
			 Case dispRate_bunmo When 0 Then 0 Else 
			      round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate  
		    From #Temp_MHList 
		 Union 
		  SELECT sMonth, 2, 0, '1', '   정시외공수 (C)', 		etcMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 3, 0, '0', '총보유공수 (A=B+C)', 		totMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
		  SELECT sMonth, 5, 0, '1', '   무급공수 (E)', 		excunpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		-- 평가제외 유급공수 'S' 
		  SELECT sMonth, 7, 0, '1', '   유급공수 (F)', 		excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sMonth, 8, 0, '0', '평가제외공수 (D=E+F)', 	excunpaidMH + excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sMonth, 9, 0, '0', '총투입공수 (G=A-D)', 	totInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 유급근태사고공수 'B'
		  SELECT sMonth, 11, 0, '1', '   유급근태사고공수 (H)',	gunteMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 일보사고공수 'G'
		  SELECT sMonth, 13, 0, '1', '   일보사고공수 (I)',		ilboMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 부가작업공수 'F'
		  SELECT sMonth, 15, 0, '1', '   부가작업공수 (J)',		bugaMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 유휴공수 'U'
		  SELECT sMonth, 17, 0, '1', '   유휴공수 (K)',			UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
		  SELECT sMonth, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)',	gunteMH + ilboMH + bugaMH + UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',	ActInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 20, 0, '0', '실동공수 (N=G-L)',		ActMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 능률저하 'Z' 
--		  SELECT sMonth, 22, 0, '1', '   능률저하공수',	effDownMH		From #Temp_MHList Union 
		  SELECT sMonth, 23, 0, '0', '표준생산공수 (O)',basicMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 24, 0, '0', '가동율 (P=N/G) (단위:%)',	Case totInMH When 0 Then 0 Else 
								     round( ActMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sMonth, 25, 0, '0', '작업효율 (Q=O/N) (단위:%)',Case ActMH When 0 Then 0 Else 
								     round( basicMH / ActMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sMonth, 26, 0, '0', '종합효율 (R=P*Q) (단위:%)',Case totInMH When 0 Then 0 Else 
								     round( basicMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sMonth, 27, 0, '0', 'LPI',		lpi, NULL				From #Temp_MHList  
		Order By sMonth, Seq1, Seq2  
	End 
	If @ps_retGubun = '2' 
	Begin 
		Insert Into #Temp_dispMHList 
		  SELECT sMonth, 
			 1 Seq1,  
			 0 Seq2, 
			'1' dispLevel, 
			'   정시공수 (B)' dispName,
			 jungsiMH dispMH,
			 Case dispRate_bunmo When 0 Then 0 Else 
			      round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate  
		    From #Temp_MHList 
		 Union 
		  SELECT sMonth, 2, 0, '1', '   정시외공수 (C)', 		etcMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 3, 0, '0', '총보유공수 (A=B+C)', 		totMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
		Select D.sMonth, 4, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'K' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode 
			Union 
		      Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'K' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'K' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 5, 0, '1', '   무급공수 (E)', 		excunpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 평가제외 유급공수 'S' 
		Select D.sMonth, 6, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'S' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode
 			Union
		       Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'S' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'S' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 7, 0, '1', '   유급공수 (F)', 		excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 8, 0, '0', '평가제외공수 (D=E+F)', 	excunpaidMH + excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sMonth, 9, 0, '0', '총투입공수 (G=A-D)', 	totInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
		-- 유급근태사고공수 'B'
		Select D.sMonth, 10, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'B' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode 
			Union 
		       Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'B' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'B' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 11, 0, '1', '   유급근태사고공수 (H)',	gunteMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
		-- 일보사고공수 'G'
		Select D.sMonth, 12, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'G' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode 
			Union
		       Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'G' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'G' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 13, 0, '1', '   일보사고공수 (I)',		ilboMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
		-- 부가작업공수 'F'
		Select D.sMonth, 14, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'F' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) )  
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode 
			Union
		       Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'F' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) )  
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'F' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 15, 0, '1', '   부가작업공수 (J)',		bugaMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
		-- 유휴공수 'U'
		Select D.sMonth, 16, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'U' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode 
			Union 
		       Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'U' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'U' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 17, 0, '1', '   유휴공수 (K)',			UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)',	gunteMH + ilboMH + bugaMH + UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',	ActInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 20, 0, '0', '실동공수 (N=G-L)',		ActMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 능률저하 'Z' 
		Select D.sMonth, 21, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 6, 2) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'Z' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 6, 2), D.mhGubun, D.mhCode 
			Union
		       Select '13', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode like @ps_area ) And 
			        ( D.DivisionCode like @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 4) = @ps_stYear ) And 
				( D.mhGubun = 'Z' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sMonth *= C.sMonth ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'Z' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sMonth, B.printSq, B.mhName, D.dispRate_bunmo 
		Union 
		  SELECT sMonth, 22, 0, '1', '   능률저하공수',	effDownMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( effDownMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sMonth, 23, 0, '0', '표준생산공수 (O)',basicMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
		  SELECT sMonth, 24, 0, '0', '가동율 (P=N/G) (단위:%)',	Case totInMH When 0 Then 0 Else 
								     round( ActMH / totInMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
		  SELECT sMonth, 25, 0, '0', '작업효율 (Q=O/N) (단위:%)',Case ActMH When 0 Then 0 Else 
								     round( basicMH / ActMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
		  SELECT sMonth, 26, 0, '0', '종합효율 (R=P*Q) (단위:%)',Case totInMH When 0 Then 0 Else 
								     round( basicMH / totInMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
		  SELECT sMonth, 27, 0, '0', 'LPI',		lpi, NULL						From #Temp_MHList  
		Order By sMonth, Seq1, Seq2  

		End 
	End 

	Select A.Seq1, A.Seq2, A.dispLevel, A.dispName, 
	       mh01.dispMH, 
	       mh01.dispRate, 
	       mh02.dispMH, 
	       mh02.dispRate, 
	       mh03.dispMH, 
       	       mh03.dispRate, 
	       mh04.dispMH, 
	       mh04.dispRate, 
	       mh05.dispMH, 
	       mh05.dispRate, 
	       mh06.dispMH, 
	       mh06.dispRate, 
	       mh07.dispMH, 
	       mh07.dispRate, 
	       mh08.dispMH, 
	       mh08.dispRate, 
	       mh09.dispMH, 
	       mh09.dispRate, 
	       mh10.dispMH, 
	       mh10.dispRate, 
	       mh11.dispMH, 
	       mh11.dispRate, 
	       mh12.dispMH, 
	       mh12.dispRate, 
	       mh13.dispMH, 
	       mh13.dispRate 
 	  From ( Select Distinct Seq1, Seq2, dispLevel, dispName 
		   From #Temp_dispMHList ) A, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '01' ) ) mh01, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '02' ) ) mh02, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '03' ) ) mh03, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '04' ) ) mh04, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '05' ) ) mh05, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '06' ) ) mh06, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '07' ) ) mh07, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '08' ) ) mh08, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '09' ) ) mh09, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '10' ) ) mh10, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '11' ) ) mh11, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '12' ) ) mh12, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sMonth = '13' ) ) mh13 
 	Where ( A.Seq1 *= mh01.Seq1 ) And 
	      ( A.Seq2 *= mh01.Seq2 ) And 
	      ( A.Seq1 *= mh02.Seq1 ) And 
	      ( A.Seq2 *= mh02.Seq2 ) And 
	      ( A.Seq1 *= mh03.Seq1 ) And 
	      ( A.Seq2 *= mh03.Seq2 ) And 
	      ( A.Seq1 *= mh04.Seq1 ) And 
	      ( A.Seq2 *= mh04.Seq2 ) And 
	      ( A.Seq1 *= mh05.Seq1 ) And 
	      ( A.Seq2 *= mh05.Seq2 ) And 
	      ( A.Seq1 *= mh06.Seq1 ) And 
	      ( A.Seq2 *= mh06.Seq2 ) And 
	      ( A.Seq1 *= mh07.Seq1 ) And 
	      ( A.Seq2 *= mh07.Seq2 ) And 
	      ( A.Seq1 *= mh08.Seq1 ) And 
	      ( A.Seq2 *= mh08.Seq2 ) And 
	      ( A.Seq1 *= mh09.Seq1 ) And 
	      ( A.Seq2 *= mh09.Seq2 ) And 
	      ( A.Seq1 *= mh10.Seq1 ) And 
	      ( A.Seq2 *= mh10.Seq2 ) And 
	      ( A.Seq1 *= mh11.Seq1 ) And 
	      ( A.Seq2 *= mh11.Seq2 ) And 
	      ( A.Seq1 *= mh12.Seq1 ) And 
	      ( A.Seq2 *= mh12.Seq2 ) And 
	      ( A.Seq1 *= mh13.Seq1 ) And 
	      ( A.Seq2 *= mh13.Seq2 ) 		

Drop Table #Temp_MHList  
Drop Table #Temp_dispMHList

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

