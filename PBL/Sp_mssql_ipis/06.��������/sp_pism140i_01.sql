SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism140i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism140i_01]
GO

/*
Execute sp_pism140i_01
	@ps_area	= 'D',
	@ps_div		= 'H',
	@ps_wc		= '522H',
	@ps_FromMonth	= '2008.02',
	@ps_ToMonth	= '2008.03'


Execute sp_pism140i_01_test 
	@ps_area	= 'D',
	@ps_div		= 'H',
	@ps_wc		= '522H',
	@ps_FromMonth	= '2008.02',
	@ps_ToMonth	= '2008.03'
*/

/*********************************/ 
/*     월별 공수투입 상세현황    */ 
/*********************************/ 

CREATE PROCEDURE [dbo].[sp_pism140i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		VarChar(5),	-- 조 	
	@ps_FromMonth	Char(7), 		-- From 월
	@ps_ToMonth	Char(7)		-- To 월 
AS
BEGIN

Declare @lastYear_from	Char(4),
	@lastYear_to	Char(4),
	@cvtMonth	Char(2),
	@Month		int 
/*
 Create Table #Temp_Month ( sMonth	char(2) null ) 

 Set @Month = 1 
 While @Month <= 12 
 Begin
	Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth	Output 
	Insert Into #Temp_Month Values ( @cvtMonth ) 
	Set @Month = @Month + 1 
 End 
*/
Set 	@lastYear_From 	=	Cast ( Cast( substring(@ps_FromMonth,1,4) as Numeric(4) ) - 1 as Char(4) )
Set 	@lastYear_To	= 	Cast ( Cast( substring(@ps_ToMonth,1,4) as Numeric(4) ) - 1 as Char(4) )

Create 	Table #Temp_MHList 
            ( sMonth			Char(7)		not null, 
	sMonthName		VarChar(12)	null, 
	jungsiMH		Numeric(8,1)	null,
	etcMH			Numeric(8,1)	null,
	totMH			Numeric(8,1)	null, 
	excunpaidMH		Numeric(8,1)	null, 
	excpaidMH		Numeric(8,1)	null, 
	totInMH			Numeric(8,1)	null, 
	gunteMH			Numeric(8,1)	null, 
	ilboMH			Numeric(8,1)	null, 
	bugaMH			Numeric(8,1)	null, 
	ActInMH			Numeric(8,1)	null, 
	ActMH			Numeric(8,1)	null, 
	UnuseMH		Numeric(8,1)	null, 
	effDownMH		Numeric(8,1)	null, 
	basicMH			Numeric(8,1)	null, 
	lpi			Numeric(8,1)	null,
	dispRate_bunmo		Numeric(8,1)	null ) 

Insert Into #Temp_MHList 
Select 	sMonth 		= substring(A.sMonth, 1, 7), 
	substring(A.sMonth, 1, 4) + '년 ' + substring(A.sMonth, 6, 2) + '월', 
	jungsiMH	= sum(IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) ), 
	etcMH 		= sum(IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) ), 
	totMH 		= sum(IsNull(A.totMH,0)),
	excunpaidMH 	= sum(IsNull(A.excunpaidMH,0)), 
	excpaidMH 	= sum(IsNull(A.excpaidMH,0)), 
	totInMH 		= sum(IsNull(A.totInMH,0)), 
	gunteMH 	= sum(IsNull(A.gunteMH,0)), 
	ilboMH 		= sum(IsNull(A.ilboMH,0)), 
	bugaMH 	= sum(IsNull(A.bugaMH,0)), 
	ActInMH 		= sum(IsNull(A.ActInMH,0)),
	ActMH 		= sum(IsNull(A.ActMH,0)),
	UnuseMH 	= sum(IsNull(A.UnuseMH,0)),
	effDownMH 	= sum(IsNull(A.effDownMH,0)), 
	basicMH 	= IsNull(D.basicMH,0),
	lpi 		= Case IsNull(D.lpi_bunmo,0) When 0 Then 0 Else 
			       round( IsNull(D.lpi_bunja,0) / IsNull(D.lpi_bunmo,0) * 100, 1) End, 
	NULL 
FROM 	TMHMONTH_S A, 

 	(select	B.sMonth,sum(IsNull(B.basicMH,0)) basicMH,
		SUM(Isnull(CASE SUBSTRING(B.sMonth,6,2) 
	 	WHEN '01' THEN A.STMH01
	 	WHEN '02' THEN a.STMH02
		WHEN '03' THEN A.STMH03
	 	WHEN '04' THEN A.STMH04
		WHEN '05' THEN A.STMH05
	 	WHEN '06' THEN A.STMH06
	 	WHEN '07' THEN A.STMH07
	 	WHEN '08' THEN A.STMH08
	 	WHEN '09' THEN A.STMH09
	 	WHEN '10' THEN A.STMH10
	 	WHEN '11' THEN A.STMH11
	 	WHEN '12' THEN A.STMH12 END,0)  * B.pQty ) lpi_bunja,
 	 	sum(IsNull(B.actInMH,0)) lpi_bunmo 
	from 	tmhstandard a,TMHMONTHPRODLINE_S B
	where 	B.AreaCode 	= 	@ps_area  And 
	  	B.DivisionCode 	= 	@ps_div  And 
	  	B.WorkCenter 	like 	@ps_wc  And 
	  	B.sMonth 	Between	@ps_FromMonth And @ps_ToMonth  And
		B.WorkCenter 	*= 	A.WorkCenter	And 
 		B.ItemCode 	*= 	A.ItemCode  	And 
 		B.subLineCode 	*= 	A.subLineCode  	And 
 		B.subLineNo 	*= 	A.subLineNo  	And 
		cast(cast(substring(B.sMonth,1,4) as integer) - 1 as char) *= a.styear  and 
		A.styear		between	@lastYear_from and @lastYear_to
	GROUP BY B.sMonth ) D

--             ( Select 	B.sMonth,sum(IsNull(B.basicMH,0)) basicMH,
-- 		sum(IsNull(C.stMH,0) * IsNull(B.pQty,0)) lpi_bunja, 
-- 	 	sum(IsNull(B.actInMH,0)) lpi_bunmo 
--     	From 	TMHMONTHPRODLINE_S B, 
-- 	            (	SELECT WorkCenter, 
-- 		ItemCode, 
-- 		subLineCode, 
-- 		subLineNo, 
-- 		IsNull(stMH,0) stMH FROM tmhstandard 
-- 	   	WHERE	( AreaCode = @ps_area ) And 
-- 		 	( DivisionCode = @ps_div ) And 
-- 		 	( stYear = @lastYear ) ) C 
--   	Where 	( B.WorkCenter *= C.WorkCenter ) And 
-- 		( B.ItemCode *= C.ItemCode ) And 
-- 		( B.subLineCode *= C.subLineCode ) And 
-- 		( B.subLineNo *= C.subLineNo ) And 
-- 		( ( B.AreaCode = @ps_area ) And 
-- 	  	( B.DivisionCode = @ps_div ) And 
-- 	  	( B.WorkCenter like @ps_wc ) And 
-- 	  	( B.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
-- 	Group By B.sMonth ) D 

WHERE	( A.sMonth *= D.sMonth ) And 
 	( ( A.AreaCode = @ps_area ) AND  
  	( A.DivisionCode = @ps_div ) AND  
  	( A.WorkCenter like @ps_wc ) And 
  	( A.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
Group By A.sMonth, D.basicMH, D.lpi_bunja, D.lpi_bunmo 
Union
Select	sMonth 	= '9999.99', 
	 '누계', 
	jungsiMH	= sum(IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) ), 
	etcMH 		= sum(IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) ), 
	totMH 		= sum(IsNull(A.totMH,0)),
	excunpaidMH 	= sum(IsNull(A.excunpaidMH,0)), 
	excpaidMH 	= sum(IsNull(A.excpaidMH,0)), 
	totInMH 		= sum(IsNull(A.totInMH,0)), 
	gunteMH 	= sum(IsNull(A.gunteMH,0)), 
	ilboMH 		= sum(IsNull(A.ilboMH,0)), 
	bugaMH 	= sum(IsNull(A.bugaMH,0)), 
	ActInMH 		= sum(IsNull(A.ActInMH,0)),
	ActMH 		= sum(IsNull(A.ActMH,0)),
	UnuseMH 	= sum(IsNull(A.UnuseMH,0)),
	effDownMH 	= sum(IsNull(A.effDownMH,0)), 
	basicMH 	= IsNull(D.basicMH,0),
	lpi 		= Case IsNull(D.lpi_bunmo,0) When 0 Then 0 Else 
		       	round( IsNull(D.lpi_bunja,0) / IsNull(D.lpi_bunmo,0) * 100, 1) End, 
	NULL 
FROM 	TMHMONTH_S A, 
	(select	sum(IsNull(B.basicMH,0)) basicMH,
		SUM(Isnull(CASE SUBSTRING(B.sMonth,6,2) 
	 	WHEN '01' THEN A.STMH01
	 	WHEN '02' THEN a.STMH02
		WHEN '03' THEN A.STMH03
	 	WHEN '04' THEN A.STMH04
		WHEN '05' THEN A.STMH05
	 	WHEN '06' THEN A.STMH06
	 	WHEN '07' THEN A.STMH07
	 	WHEN '08' THEN A.STMH08
	 	WHEN '09' THEN A.STMH09
	 	WHEN '10' THEN A.STMH10
	 	WHEN '11' THEN A.STMH11
	 	WHEN '12' THEN A.STMH12 END,0)  * B.pQty ) lpi_bunja,
 	 	sum(IsNull(B.actInMH,0)) lpi_bunmo 
	from 	tmhstandard a,TMHMONTHPRODLINE_S B
	where 	B.AreaCode 	= 	@ps_area  And 
	  	B.DivisionCode 	= 	@ps_div  And 
	  	B.WorkCenter 	like 	@ps_wc  And 
	  	B.sMonth 	Between	@ps_FromMonth And @ps_ToMonth  And
		B.WorkCenter 	*= 	A.WorkCenter	And 
 		B.ItemCode 	*= 	A.ItemCode  	And 
 		B.subLineCode 	*= 	A.subLineCode  	And 
 		B.subLineNo 	*= 	A.subLineNo  	And 
		cast(cast(substring(B.sMonth,1,4) as integer) - 1 as char) *= a.styear  and 
		A.styear		between	@lastYear_from and @lastYear_to
	) D

-- 	( Select sum(IsNull(B.basicMH,0)) basicMH,
-- 		 sum(IsNull(C.stMH,0) * IsNull(B.pQty,0)) lpi_bunja, 
-- 		 sum(IsNull(B.actInMH,0)) lpi_bunmo 
-- 	    From TMHMONTHPRODLINE_S B, 
-- 		( SELECT WorkCenter, 
-- 			 ItemCode, 
-- 			 subLineCode, 
-- 			 subLineNo, 
-- 			 IsNull(stMH,0) stMH 
-- 		    FROM tmhstandard 
-- 		   WHERE ( AreaCode = @ps_area ) And 
-- 			 ( DivisionCode = @ps_div ) And 
-- 			 ( stYear = @lastYear ) ) C 
-- 	  Where ( B.WorkCenter *= C.WorkCenter ) And 
-- 		( B.ItemCode *= C.ItemCode ) And 
-- 		( B.subLineCode *= C.subLineCode ) And 
-- 		( B.subLineNo *= C.subLineNo ) And 
-- 		( ( B.AreaCode = @ps_area ) And 
-- 		  ( B.DivisionCode = @ps_div ) And 
-- 		  ( B.WorkCenter like @ps_wc ) And 
-- 		  ( B.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) ) D 

WHERE 	( ( A.AreaCode = @ps_area ) AND  
           	( A.DivisionCode = @ps_div ) AND  
	( A.WorkCenter like @ps_wc ) And 
           	( A.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
Group By D.basicMH, D.lpi_bunja, D.lpi_bunmo 

Update 	#Temp_MHList 
	Set dispRate_bunmo = IsNull(( Select totMH From #Temp_MHList A Where A.sMonth = #Temp_MHList.sMonth ), 0) 

/*
	Insert Into #Temp_MHList ( sMonth ) 
	     Select sMonth From #Temp_Month 
	      Where Not Exists ( Select sMonth From #Temp_MHList 
				  Where sMonth = #Temp_Month.sMonth ) 
*/
 Create Table #Temp_dispName 
	( sMonth	Char(7)		not null,
	  sMonthName    VarChar(12) 	null, 
	  Seq1		int,
	  Seq2		int		null,
	  dispLevel	Char(1),
	  dispName	VarChar(100) 	null,
	  dispMH	Numeric(8,1) 	null,
	  dispRate	Numeric(5,1) 	null ) 

	Begin

	Insert Into #Temp_dispName 
	  SELECT sMonth, 
		 sMonthName, 
		 1 Seq1,  
		 0 Seq2, 
		'1' dispLevel, 
		'   정시공수 (B)' dispName,
		 jungsiMH dispMH,
		Case dispRate_bunmo When 0 Then 0 Else 
		      round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate 
	    From #Temp_MHList 
	 Union 
	  SELECT sMonth, sMonthName, 2, 0, '1', '   정시외공수 (C)', 		etcMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End 	 	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 3, 0, '0', '총보유공수 (A=B+C)', 		totMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
	Select D.sMonth, D.sMonthName, 4, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'K' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	    Union
	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 

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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'K' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'K' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 5, 0, '1', '   무급공수 (E)', 		excunpaidMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	-- 평가제외 유급공수 'S' 
	Select D.sMonth, D.sMonthName, 6, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'S' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	      Union
	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'S' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'S' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 7, 0, '1', '   유급공수 (F)', 		excpaidMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 8, 0, '0', '평가제외공수 (D=E+F)', 	excunpaidMH + excpaidMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 9, 0, '0', '총투입공수 (G=A-D)', 	totInMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 유급근태사고공수 'B'
	Select D.sMonth, D.sMonthName, 10, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'B' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	      Union
	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'B' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'B' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 11, 0, '1', '   유급근태사고공수 (H)',	gunteMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 일보사고공수 'G'
	Select D.sMonth, D.sMonthName, 12, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'G' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	     Union
	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'G' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'G' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 13, 0, '1', '   일보사고공수 (I)',		ilboMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 부가작업공수 'F'
	Select D.sMonth, D.sMonthName, 14, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'F' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	     Union
	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'F' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'F' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 15, 0, '1', '   부가작업공수 (J)',		bugaMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 유휴공수 'U'
	Select D.sMonth, D.sMonthName, 16, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'U' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	     Union
   	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'U' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'U' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 17, 0, '1', '   유휴공수 (K)',		UnuseMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)',	gunteMH + ilboMH + bugaMH + UnuseMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',	ActInMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 20, 0, '0', '실동공수 (N=G-L)',		ActMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 능률저하 'Z' 
	Select D.sMonth, D.sMonthName, 21, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 1, 7) sMonth, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'Z' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By substring(D.WorkDay, 1, 7), D.mhGubun, D.mhCode 
	     Union
	       Select '9999.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( substring(D.WorkDay, 1, 7) Between @ps_FromMonth And @ps_ToMonth ) And 
			( D.mhGubun = 'Z' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) ) 
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sMonth *= C.sMonth ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'Z' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sMonth, D.sMonthName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sMonth, sMonthName, 22, 0, '1', '   능률저하공수',	effDownMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( effDownMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 23, 0, '0', '표준생산공수 (O)',basicMH,
		 Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 24, 0, '0', '실동율 (P=N/G)',	Case totInMH When 0 Then 0 Else 
							     round( ActMH / totInMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 25, 0, '0', '작업효율 (Q=O/N)',Case ActMH When 0 Then 0 Else 
							     round( basicMH / ActMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 26, 0, '0', '종합효율 (R=P*Q)',Case totInMH When 0 Then 0 Else 
							     round( basicMH / totInMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
	  SELECT sMonth, sMonthName, 27, 0, '0', 'LPI',		lpi, NULL					From #Temp_MHList 

	End 

  Select * From #Temp_dispName Order By sMonth, Seq1, Seq2  

Drop Table #Temp_MHList 
Drop Table #Temp_dispName 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

