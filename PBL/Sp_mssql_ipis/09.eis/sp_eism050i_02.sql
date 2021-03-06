SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism050i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism050i_02]
GO



/******************************/ 
/*     일별 공수투입 현황     */ 
/******************************/ 

CREATE PROCEDURE sp_eism050i_02
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		VarChar(5),		-- 조
	@ps_stMonth	Char(7),		-- 기준년월 
	@ps_retGubun	Char(1) 
AS
BEGIN


 Declare @lastYear 	Char(4) 

 Create Table #Temp_MHList 
	( sDay		Char(2)		not null,
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
	  dispRate_bunmo Numeric(8,1)	null ) 

 Set @lastYear = Cast ( Cast( substring(@ps_stMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )

	Insert Into #Temp_MHList ( sDay, jungsiMH, etcMH, totMH, excunpaidMH, excpaidMH, totInMH, gunteMH, ilboMH, 
				    bugaMH, ActInMH, ActMH, UnuseMH, effDownMH, basicMH, lpi, dispRate_bunmo ) 
	  Select sDay 		= substring(A.WorkDay,9,2), 
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
		 ActMH 		= IsNull(D.actMH,0),
		 UnuseMH 	= IsNull(D.unuseMH,0),
		 effDownMH 	= IsNull(F.effDownMH,0), 
		 basicMH 	= IsNull(D.basicMH,0), 
		 lpi 		= Case sum(IsNull(A.ActInMH,0)) When 0 Then 0 Else 
				       round( IsNull(D.lpi_bunja,0) / sum(IsNull(A.ActInMH,0)) * 100, 1) End, 
		 NULL 
	    FROM TMHDAILY A, 
		 TMHDAILYSTATUS B, 
		( Select B.WorkDay, 
			 sum(IsNull(B.ActMH,0)) actMH, 
			 sum(IsNull(B.UnuseMH,0)) unuseMH, 
			 round(sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) ) / 3600,1) basicMH,
			 sum(IsNull(C.stMH,0) * ( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) )) lpi_bunja 
	   	    From TMHDAILYSTATUS A, 
			 TMHREALPROD B, 
			( SELECT WorkCenter, 
				 ItemCode, 
				 subLineCode, 
				 subLineNo, 
				 IsNull(stMH,0) stMH 
			    FROM TMHSTANDARD 
			   WHERE ( AreaCode = @ps_area ) And 
				 ( DivisionCode = @ps_div ) And 
				 ( WorkCenter like @ps_wc ) And 
				 ( stYear = @lastYear ) ) C 
		  Where ( A.AreaCode = B.AreaCode ) And 
			( A.DivisionCode = B.DivisionCode ) And 
			( A.WorkCenter = B.WorkCenter ) And 
			( A.WorkDay = B.WorkDay ) And 
			( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( ( B.AreaCode = @ps_area ) And 
			  ( B.DivisionCode = @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( substring(B.WorkDay, 1, 7) = @ps_stMonth ) And 
			  ( A.DailyStatus = '1' ) )  
	        Group By B.WorkDay ) D, 
		( SELECT B.WorkDay,   
		         sum(IsNull(B.subMH,0)) effDownMH 
		    FROM TMHDAILYSTATUS A, TMHDAILYSUB B 
		   WHERE ( A.AreaCode = B.AreaCode ) And 
			 ( A.DivisionCode = B.DivisionCode ) And 
			 ( A.WorkCenter = B.WorkCenter ) And 
			 ( A.WorkDay = B.Workday ) And 
			 ( ( A.AreaCode = @ps_area ) AND  
		           ( A.DivisionCode = @ps_div ) AND  
		           ( A.WorkCenter like @ps_wc ) And 
			   ( B.mhGubun = 'Z' ) And
			   ( substring(B.WorkDay, 1, 7) = @ps_stMonth ) And
			   ( A.DailyStatus = '1' ) ) 
		Group By B.WorkDay ) F 
	   WHERE ( A.AreaCode = B.AreaCode ) And 
		 ( A.DivisionCode = B.DivisionCode ) And 
		 ( A.WorkCenter = B.WorkCenter ) And 
		 ( A.WorkDay = B.WorkDay ) And 
		 ( A.WorkDay = D.WorkDay ) And 
		 ( A.WorkDay *= F.WorkDay ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( substring(A.WorkDay, 1, 7) = @ps_stMonth ) And 
		   ( B.DailyStatus = '1' ) ) 
	Group By substring(A.WorkDay,9,2), D.actMH, D.unuseMH, F.effDownMH, D.basicMH, D.lpi_bunja
	Union
	  Select '99', 
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
		 ActMH 		= IsNull(D.actMH,0),
		 UnuseMH 	= IsNull(D.unuseMH,0),
		 effDownMH 	= IsNull(F.effDownMH,0), 
		 basicMH 	= IsNull(D.basicMH,0), 
		 lpi 		= Case sum(IsNull(A.ActInMH,0)) When 0 Then 0 Else 
				       round( IsNull(D.lpi_bunja,0) / sum(IsNull(A.ActInMH,0)) * 100, 1) End, 
		 NULL 
	    FROM TMHDAILY A, 
		 TMHDAILYSTATUS B, 
		( Select sum(IsNull(B.ActMH,0)) actMH, 
			 sum(IsNull(B.UnuseMH,0)) unuseMH, 
			 round(sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) ) / 3600,1) basicMH,
			 sum(IsNull(C.stMH,0) * ( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) )) lpi_bunja 
	   	    From TMHDAILYSTATUS A, 
			 TMHREALPROD B, 
			( SELECT WorkCenter, 
				 ItemCode, 
				 subLineCode, 
				 subLineNo, 
				 IsNull(stMH,0) stMH 
			    FROM TMHSTANDARD 
			   WHERE ( AreaCode = @ps_area ) And 
				 ( DivisionCode = @ps_div ) And 
				 ( WorkCenter like @ps_wc ) And 
				 ( stYear = @lastYear ) ) C 
		  Where ( A.AreaCode = B.AreaCode ) And 
			( A.DivisionCode = B.DivisionCode ) And 
			( A.WorkCenter = B.WorkCenter ) And 
			( A.WorkDay = B.WorkDay ) And 
			( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( ( B.AreaCode = @ps_area ) And 
			  ( B.DivisionCode = @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( substring(B.WorkDay, 1, 7) = @ps_stMonth ) And 
			  ( A.DailyStatus = '1' ) ) ) D,
		( SELECT sum(IsNull(B.subMH,0)) effDownMH 
		    FROM TMHDAILYSTATUS A, TMHDAILYSUB B 
		   WHERE ( A.AreaCode = B.AreaCode ) And 
			 ( A.DivisionCode = B.DivisionCode ) And 
			 ( A.WorkCenter = B.WorkCenter ) And 
			 ( A.WorkDay = B.Workday ) And 
			 ( ( A.AreaCode = @ps_area ) AND  
		           ( A.DivisionCode = @ps_div ) AND  
		           ( A.WorkCenter like @ps_wc ) And 
			   ( B.mhGubun = 'Z' ) And
			   ( substring(B.WorkDay, 1, 7) = @ps_stMonth ) And
			   ( A.DailyStatus = '1' ) ) ) F 
	   WHERE ( A.AreaCode = B.AreaCode ) And 
		 ( A.DivisionCode = B.DivisionCode ) And 
		 ( A.WorkCenter = B.WorkCenter ) And 
		 ( A.WorkDay = B.WorkDay ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( substring(A.WorkDay, 1, 7) = @ps_stMonth ) And 
		   ( B.DailyStatus = '1' ) ) 
	Group By D.actMH, D.unuseMH, F.effDownMH, D.basicMH, D.lpi_bunja

	Update #Temp_MHList 
	   Set dispRate_bunmo = IsNull(( Select totMH From #Temp_MHList A Where A.sDay = #Temp_MHList.sDay ), 0) 

	Begin
	

	Create Table #Temp_dispMHList 
	( sDay		Char(2) 	not null,
	  Seq1		Int		not null,
	  seq2		Int		null, 
	  dispLevel	Char(1)		not null,
	  dispName	VarChar(100)	null, 
	  dispMH	Numeric(6,1)	null,
	  dispRate 	Numeric(5,1)	null ) 

	If @ps_retGubun = '1' 
	Begin 

		Insert Into #Temp_dispMHList 
		  SELECT sDay, 
			 1 Seq1,  
			 0 Seq2, 
			'1' dispLevel, 
			'   정시공수 (B)' dispName,
			 jungsiMH dispMH,
			 Case dispRate_bunmo When 0 Then 0 Else 
			      round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate   
		    From #Temp_MHList 
		 Union 
		  SELECT sDay, 2, 0, '1', '   정시외공수 (C)', 		etcMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End 	From #Temp_MHList Union 
		  SELECT sDay, 3, 0, '0', '총보유공수 (A=B+C)', 	totMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
		  SELECT sDay, 5, 0, '1', '   무급공수 (E)', 		excunpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		-- 평가제외 유급공수 'S' 
		  SELECT sDay, 7, 0, '1', '   유급공수 (F)', 		excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 8, 0, '0', '평가제외공수 (D=E+F)', 	excunpaidMH + excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 9, 0, '0', '총투입공수 (G=A-D)', 	totInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		-- 유급근태사고공수 'B'
		  SELECT sDay, 11, 0, '1', '   유급근태사고공수 (H)',	gunteMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 일보사고공수 'G'
		  SELECT sDay, 13, 0, '1', '   일보사고공수 (I)',	ilboMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 부가작업공수 'F'
		  SELECT sDay, 15, 0, '1', '   부가작업공수 (J)',	bugaMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 유휴공수 'U'
		  SELECT sDay, 17, 0, '1', '   유휴공수 (K)',		UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sDay, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)',	gunteMH + ilboMH + bugaMH + UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sDay, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',	ActInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sDay, 20, 0, '0', '실동공수 (N=G-L)',		ActMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 능률저하 'Z' 
		  SELECT sDay, 22, 0, '1', '   능률저하공수',		effDownMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( effDownMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 23, 0, '0', '표준생산공수 (O)',		basicMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 24, 0, '0', '가동율 (P=N/G) (단위:%)',  Case totInMH When 0 Then 0 Else 
								     round( ActMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sDay, 25, 0, '0', '작업효율 (Q=O/N) (단위:%)',Case ActMH When 0 Then 0 Else 
								     round( basicMH / ActMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sDay, 26, 0, '0', '종합효율 (R=P*Q) (단위:%)',Case totInMH When 0 Then 0 Else 
								     round( basicMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sDay, 27, 0, '0', 'LPI',		lpi, NULL			From #Temp_MHList  
		Order By sDay, Seq1, Seq2  
	End 
	If @ps_retGubun = '2' 
	Begin 
		Insert Into #Temp_dispMHList 
		  SELECT sDay, 
			 1 Seq1,  
			 0 Seq2, 
			'1' dispLevel, 
			'   정시공수 (B)' dispName,
			 jungsiMH dispMH, 
			 Case dispRate_bunmo When 0 Then 0 Else 
			      round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate   
		    From #Temp_MHList 
		 Union 
		  SELECT sDay, 2, 0, '1', '   정시외공수 (C)', 		etcMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End 	From #Temp_MHList Union 
		  SELECT sDay, 3, 0, '0', '총보유공수 (A=B+C)', 		totMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
		Select D.sDay, 4, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				 ( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'K' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				 ( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'K' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'K' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 5, 0, '1', '   무급공수 (E)', 		excunpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		-- 평가제외 유급공수 'S' 
		Select D.sDay, 6, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'S' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'S' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'S' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 7, 0, '1', '   유급공수 (F)', 		excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 8, 0, '0', '평가제외공수 (D=E+F)', 	excunpaidMH + excpaidMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 9, 0, '0', '총투입공수 (G=A-D)', 	totInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		-- 유급근태사고공수 'B'
		Select D.sDay, 10, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'B' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'B' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'B' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 11, 0, '1', '   유급근태사고공수 (H)',	gunteMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 일보사고공수 'G'
		Select D.sDay, 12, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'G' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'G' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'G' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 13, 0, '1', '   일보사고공수 (I)',		ilboMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 부가작업공수 'F'
		Select D.sDay, 14, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'F' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) )  
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'F' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) )  
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'F' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 15, 0, '1', '   부가작업공수 (J)',		bugaMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 유휴공수 'U'
		Select D.sDay, 16, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'U' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union 
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'U' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'U' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 17, 0, '1', '   유휴공수 (K)',			UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)',	gunteMH + ilboMH + bugaMH + UnuseMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sDay, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',	ActInMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		  SELECT sDay, 20, 0, '0', '실동공수 (N=G-L)',		ActMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
		-- 능률저하 'Z' 
		Select D.sDay, 21, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)) ,
			 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
		  From #Temp_MHList D, 
		       TMHCODE B, 
		     ( Select substring(D.WorkDay, 9, 2) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'Z' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By substring(D.WorkDay, 9, 2), D.mhGubun, D.mhCode 
			Union
		       Select '99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
			 From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F 
			Where ( F.AreaCode = D.AreaCode ) And 
			      ( F.DivisionCode = D.DivisionCode ) And 
			      ( F.WorkCenter = D.WorkCenter ) And 
			      ( F.WorkDay = D.WorkDay ) And 
			      ( D.mhGubun = E.mhGubun ) And 
			      ( D.mhCode = E.mhCode ) And 
			      ( ( D.AreaCode = @ps_area ) And 
			        ( D.DivisionCode = @ps_div ) And 
				( D.WorkCenter like @ps_wc ) And 
				( substring(D.WorkDay, 1, 7) = @ps_stMonth ) And 
				( D.mhGubun = 'Z' ) And 
				( IsNull(E.UseFlag,'0') = '1' ) And 
				( F.DailyStatus = '1' ) ) 
		     Group By D.mhGubun, D.mhCode ) C 
		 Where ( D.sDay *= C.sDay ) And 
		       ( B.mhGubun *= C.mhGubun ) And 	
		       ( B.mhCode *= C.mhCode ) And 
		       ( B.mhGubun = 'Z' ) And
		       ( IsNull(B.useFlag,'0') = '1' ) 
	      Group By D.sDay, B.printSq, B.mhName, D.dispRate_bunmo
		Union 
		  SELECT sDay, 22, 0, '1', '   능률저하공수',	effDownMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( effDownMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 23, 0, '0', '표준생산공수 (O)',basicMH,
			 Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
		  SELECT sDay, 24, 0, '0', '가동율 (P=N/G) (단위:%)',	Case totInMH When 0 Then 0 Else 
								     round( ActMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sDay, 25, 0, '0', '작업효율 (Q=O/N) (단위:%)',Case ActMH When 0 Then 0 Else 
								     round( basicMH / ActMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sDay, 26, 0, '0', '종합효율 (R=P*Q) (단위:%)',Case totInMH When 0 Then 0 Else 
								     round( basicMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union 
		  SELECT sDay, 27, 0, '0', 'LPI',		lpi, NULL			From #Temp_MHList  
		Order By sDay, Seq1, Seq2  

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
	       mh13.dispRate, 
	       mh14.dispMH, 
	       mh14.dispRate, 
	       mh15.dispMH, 
	       mh15.dispRate, 
	       mh16.dispMH, 
	       mh16.dispRate, 
	       mh17.dispMH, 
	       mh17.dispRate, 
	       mh18.dispMH, 
	       mh18.dispRate, 
	       mh19.dispMH, 
	       mh19.dispRate, 
	       mh20.dispMH, 
	       mh20.dispRate, 
	       mh21.dispMH, 
	       mh21.dispRate, 
	       mh22.dispMH, 
	       mh22.dispRate, 
	       mh23.dispMH, 
	       mh23.dispRate, 
	       mh24.dispMH, 
	       mh24.dispRate, 
	       mh25.dispMH, 
	       mh25.dispRate, 
	       mh26.dispMH, 
	       mh26.dispRate, 
	       mh27.dispMH, 
	       mh27.dispRate, 
	       mh28.dispMH, 
	       mh28.dispRate, 
	       mh29.dispMH, 
	       mh29.dispRate, 
	       mh30.dispMH, 
	       mh30.dispRate, 
	       mh31.dispMH, 
	       mh31.dispRate, 
	       mh99.dispMH, 
	       mh99.dispRate 
 	  From ( Select Distinct Seq1, Seq2, dispLevel, dispName 
		   From #Temp_dispMHList ) A, 
	       ( Select Seq1, Seq2, dispMH, dispRate 
		   From #Temp_dispMHList 
	 	  Where ( sDay = '01' ) ) mh01, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '02' ) ) mh02, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '03' ) ) mh03, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '04' ) ) mh04, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '05' ) ) mh05, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '06' ) ) mh06, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '07' ) ) mh07, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '08' ) ) mh08, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '09' ) ) mh09, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '10' ) ) mh10, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '11' ) ) mh11, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '12' ) ) mh12, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '13' ) ) mh13, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '14') ) mh14,
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '15') ) mh15,
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '16') ) mh16, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '17' ) ) mh17, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '18' ) ) mh18, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '19' ) ) mh19, 
	       ( Select Seq1, Seq2, dispMH, dispRate 
		   From #Temp_dispMHList 
	 	  Where ( sDay = '20' ) ) mh20, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '21' ) ) mh21, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '22' ) ) mh22, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '23' ) ) mh23, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '24' ) ) mh24, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '25' ) ) mh25, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '26' ) ) mh26, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '27' ) ) mh27, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '28' ) ) mh28, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '29' ) ) mh29, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '30' ) ) mh30, 
	       ( Select Seq1, Seq2, dispMH, dispRate   
		   From #Temp_dispMHList 
	 	  Where ( sDay = '31' ) ) mh31, 
	       ( Select Seq1, Seq2, dispMH, dispRate  
		   From #Temp_dispMHList 
	 	  Where ( sDay = '99' ) ) mh99 
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
	      ( A.Seq2 *= mh13.Seq2 ) And 
	      ( A.Seq1 *= mh14.Seq1 ) And 
	      ( A.Seq2 *= mh14.Seq2 ) And 
	      ( A.Seq1 *= mh15.Seq1 ) And 
	      ( A.Seq2 *= mh15.Seq2 ) And 
	      ( A.Seq1 *= mh16.Seq1 ) And 
	      ( A.Seq2 *= mh16.Seq2 ) And 
	      ( A.Seq1 *= mh17.Seq1 ) And 
	      ( A.Seq2 *= mh17.Seq2 ) And 
	      ( A.Seq1 *= mh18.Seq1 ) And 
	      ( A.Seq2 *= mh18.Seq2 ) And 
	      ( A.Seq1 *= mh19.Seq1 ) And 
	      ( A.Seq2 *= mh19.Seq2 ) And 
	      ( A.Seq1 *= mh20.Seq1 ) And 
	      ( A.Seq2 *= mh20.Seq2 ) And 
	      ( A.Seq1 *= mh21.Seq1 ) And 
	      ( A.Seq2 *= mh21.Seq2 ) And 
	      ( A.Seq1 *= mh22.Seq1 ) And 
	      ( A.Seq2 *= mh22.Seq2 ) And 
	      ( A.Seq1 *= mh23.Seq1 ) And 
	      ( A.Seq2 *= mh23.Seq2 ) And 
	      ( A.Seq1 *= mh24.Seq1 ) And 
	      ( A.Seq2 *= mh24.Seq2 ) And 
	      ( A.Seq1 *= mh25.Seq1 ) And 
	      ( A.Seq2 *= mh25.Seq2 ) And 
	      ( A.Seq1 *= mh26.Seq1 ) And 
	      ( A.Seq2 *= mh26.Seq2 ) And 
	      ( A.Seq1 *= mh27.Seq1 ) And 
	      ( A.Seq2 *= mh27.Seq2 ) And 
	      ( A.Seq1 *= mh28.Seq1 ) And 
	      ( A.Seq2 *= mh28.Seq2 ) And 
	      ( A.Seq1 *= mh29.Seq1 ) And 
	      ( A.Seq2 *= mh29.Seq2 ) And 
	      ( A.Seq1 *= mh30.Seq1 ) And 
	      ( A.Seq2 *= mh30.Seq2 ) And 
	      ( A.Seq1 *= mh31.Seq1 ) And 
	      ( A.Seq2 *= mh31.Seq2 ) And 
	      ( A.Seq1 *= mh99.Seq1 ) And 
	      ( A.Seq2 *= mh99.Seq2 ) 

Drop Table #Temp_MHList  
Drop Table #Temp_dispMHList

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

