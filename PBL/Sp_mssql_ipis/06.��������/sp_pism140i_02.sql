SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism140i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism140i_02]
GO

/*
Execute sp_pism140i_02
	@ps_area	= 'D',
	@ps_div		= 'V',
	@ps_wc		= '%',
	@ps_FromDate	= '2008.05.01',
	@ps_ToDate	= '2008.05.31'


Execute sp_pism140i_02_test 
	@ps_area	= 'D',
	@ps_div		= 'V',
	@ps_wc		= '%',
	@ps_FromDate	= '2008.05.01',
	@ps_ToDate	= '2008.05.31'

*/

/*********************************/ 
/*     일별 공수투입 상세현황    */ 
/*********************************/ 

CREATE PROCEDURE [dbo].[sp_pism140i_02]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		VarChar(5),		-- 조 	
	@ps_FromDate	Char(10), 		-- From Date
	@ps_ToDate 	Char(10)		-- To Date 
AS
BEGIN

Declare @lastYear_from	Char(4),
	@lastYear_to	Char(4),
	@days		int,
	@lstdays	Char(10),
	@lastDays	int,
	@cvtDays	Char(2) 

/*
 Create Table #Temp_Days ( days		char(2) null ) 

 Select @lstdays = Convert(Char(8), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, @ps_stMonth + '.01'))), 112) 
 Select @lastDays = Cast( substring(@lstdays, 7, 2) as int ), @days = 1 

 While @days <= @lastDays
 Begin
	Execute sp_pism000_cvtValue @pi_Value = @days, @ps_cvtValue = @cvtDays	Output 
	Insert Into #Temp_Days Values ( @cvtDays ) 
	Set @days = @days + 1 
 End 
*/

Set @lastYear_from	=	Cast ( Cast( substring(@ps_FromDate, 1, 4) as Numeric(4) ) - 1 as Char(4) )
Set @lastYear_to		=	Cast ( Cast( substring(@ps_ToDate, 1, 4) as Numeric(4) ) - 1 as Char(4) )

 Create Table #Temp_MHList 
	( sDay			Char(5)		not null, 
	  sDayName		VarChar(10)	null, 
	  jungsiMH		Numeric(8,1)	null,
	  etcMH			Numeric(8,1)	null,
	  totMH			Numeric(8,1)	null, 
	  excunpaidMH		Numeric(8,1)	null, 
	  excpaidMH		Numeric(8,1)	null, 
	  totInMH		Numeric(8,1)	null, 
	  gunteMH		Numeric(8,1)	null, 
	  ilboMH		Numeric(8,1)	null, 
	  bugaMH		Numeric(8,1)	null, 
	  ActInMH		Numeric(8,1)	null, 
	  ActMH			Numeric(8,1)	null, 
	  UnuseMH		Numeric(8,1)	null, 
	  effDownMH		Numeric(8,1)	null, 
	  basicMH		Numeric(8,1)	null, 
	  lpi			Numeric(8,1)	null,
	  dispRate_bunmo	Numeric(8,1)	null ) 

Insert Into #Temp_MHList 
	Select	sDay 		= substring(A.WorkDay,6,5), 
		substring(A.WorkDay,6,2) + '월 ' + substring(A.WorkDay,9,2) + '일', 
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
		ActMH 		= IsNull(D.actMH,0),
		UnuseMH 	= IsNull(D.unuseMH,0),
		effDownMH 	= IsNull(F.effDownMH,0), 
		basicMH 	= IsNull(D.basicMH,0), 
		lpi 		= Case sum(IsNull(A.ActInMH,0)) When 0 Then 0 Else 
		round( IsNull(D.lpi_bunja,0) / sum(IsNull(A.ActInMH,0)) * 100, 1) End, 
		NULL 
	FROM 	TMHDAILY A, TMHDAILYSTATUS B, 

		(Select B.WorkDay,sum(IsNull(B.ActMH,0)) actMH,sum(IsNull(B.UnuseMH,0)) unuseMH, 
		 round(sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) ) / 3600,1) basicMH,
		 sum(IsNull(CASE SUBSTRING(B.WorkDay,6,2) 
			 	WHEN '01' THEN STMH01
			 	WHEN '02' THEN STMH02
			 	WHEN '03' THEN STMH03
			 	WHEN '04' THEN STMH04
			 	WHEN '05' THEN STMH05
			 	WHEN '06' THEN STMH06
			 	WHEN '07' THEN STMH07
			 	WHEN '08' THEN STMH08
			 	WHEN '09' THEN STMH09
			 	WHEN '10' THEN STMH10
			 	WHEN '11' THEN STMH11
			 	WHEN '12' THEN STMH12 END,0) *
				 ( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) )) lpi_bunja 
		From 	TMHDAILYSTATUS A,TMHREALPROD B, tmhstandard C
		Where 	( A.AreaCode = B.AreaCode ) And 
			( A.DivisionCode = B.DivisionCode ) And 
			( A.WorkCenter = B.WorkCenter ) And 
			( A.WorkDay = B.WorkDay ) And 
			( B.AreaCode *= C.AreaCode ) And 
			( B.DivisionCode *= C.DivisionCode ) And 
			( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( C.Styear	between	@lastYear_from and @lastYear_to ) and
			(cast(cast(substring(B.WorkDay,1,4) as integer) - 1 as char) *= c.styear )  and 
			( ( B.AreaCode = @ps_area ) And 
			( B.DivisionCode = @ps_div ) And 
			( B.WorkCenter like @ps_wc ) And 
			( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( A.DailyStatus = '1' ) )  
			Group By B.WorkDay ) D,

-- 		(Select B.WorkDay,sum(IsNull(B.ActMH,0)) actMH,sum(IsNull(B.UnuseMH,0)) unuseMH, 
-- 		 round(sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) ) / 3600,1) basicMH,
-- 		 sum(IsNull(C.stMH,0) * ( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) )) lpi_bunja 
-- 		 From 	TMHDAILYSTATUS A,TMHREALPROD B, 
-- 			(SELECT WorkCenter,ItemCode,subLineCode,subLineNo,IsNull(stMH,0) stMH 
-- 			 FROM tmhstandard 
-- 			 WHERE ( AreaCode = @ps_area ) And 
-- 			 ( DivisionCode = @ps_div ) And 
-- 			 ( stYear = @lastYear ) ) C 
-- 		Where 	( A.AreaCode = B.AreaCode ) And 
-- 			( A.DivisionCode = B.DivisionCode ) And 
-- 			( A.WorkCenter = B.WorkCenter ) And 
-- 			( A.WorkDay = B.WorkDay ) And 
-- 			( B.WorkCenter *= C.WorkCenter ) And 
-- 			( B.ItemCode *= C.ItemCode ) And 
-- 			( B.subLineCode *= C.subLineCode ) And 
-- 			( B.subLineNo *= C.subLineNo ) And 
-- 			( ( B.AreaCode = @ps_area ) And 
-- 			( B.DivisionCode = @ps_div ) And 
-- 			( B.WorkCenter like @ps_wc ) And 
-- 			( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
-- 			( A.DailyStatus = '1' ) )  
-- 			Group By B.WorkDay ) D,

		(SELECT B.WorkDay,sum(IsNull(B.subMH,0)) effDownMH 
		 FROM TMHDAILYSTATUS A, TMHDAILYSUB B 
		 WHERE ( A.AreaCode = B.AreaCode ) And 
			( A.DivisionCode = B.DivisionCode ) And 
			( A.WorkCenter = B.WorkCenter ) And 
			( A.WorkDay = B.Workday ) And 
			( ( A.AreaCode = @ps_area ) AND  
			( A.DivisionCode = @ps_div ) AND  
			( A.WorkCenter like @ps_wc ) And 
			( B.mhGubun = 'Z' ) And
			( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And
			( A.DailyStatus = '1' ) ) 
			Group By B.WorkDay ) F
	WHERE	( A.AreaCode = B.AreaCode ) And 
		( A.DivisionCode = B.DivisionCode ) And 
		( A.WorkCenter = B.WorkCenter ) And 
		( A.WorkDay = B.WorkDay ) And 
		( A.WorkDay *= D.WorkDay ) And 
		( A.WorkDay *= F.WorkDay ) And 
		( ( A.AreaCode = @ps_area ) AND  
		( A.DivisionCode = @ps_div ) AND  
		( A.WorkCenter like @ps_wc ) And 
		( A.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
		( B.DailyStatus = '1' ) ) 
		Group By A.WorkDay, D.actMH, D.unuseMH, F.effDownMH, D.basicMH, D.lpi_bunja
	Union 
	
	Select	'99.99', 
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
		 ActInMH 	= sum(IsNull(A.ActInMH,0)),
		 ActMH 		= IsNull(D.actMH,0),
		 UnuseMH 	= IsNull(D.unuseMH,0),
		 effDownMH 	= IsNull(F.effDownMH,0), 
		 basicMH 	= IsNull(D.basicMH,0), 
		 lpi 		= Case sum(IsNull(A.ActInMH,0)) When 0 Then 0 Else 
				       round( IsNull(D.lpi_bunja,0) / sum(IsNull(A.ActInMH,0)) * 100, 1) End, 
		 NULL 
	FROM 	TMHDAILY A,TMHDAILYSTATUS B, 


		(Select	sum(IsNull(B.ActMH,0)) actMH,sum(IsNull(B.UnuseMH,0)) unuseMH, 
		 	round(sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) ) / 3600,1) basicMH,
		 	sum(IsNull(CASE SUBSTRING(B.WorkDay,6,2) 
				 	WHEN '01' THEN STMH01
				 	WHEN '02' THEN STMH02
				 	WHEN '03' THEN STMH03
				 	WHEN '04' THEN STMH04
				 	WHEN '05' THEN STMH05
				 	WHEN '06' THEN STMH06
				 	WHEN '07' THEN STMH07
				 	WHEN '08' THEN STMH08
				 	WHEN '09' THEN STMH09
				 	WHEN '10' THEN STMH10
				 	WHEN '11' THEN STMH11
				 	WHEN '12' THEN STMH12 END,0) * ( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) )) lpi_bunja 
		 From 	TMHDAILYSTATUS A,TMHREALPROD B, tmhstandard C
	  	 Where 	( A.AreaCode = B.AreaCode ) And 
		 	( A.DivisionCode = B.DivisionCode ) And 
		 	( A.WorkCenter = B.WorkCenter ) And 
			( A.WorkDay = B.WorkDay ) And 
			( B.AreaCode *= C.AreaCode ) And 
			( B.DivisionCode *= C.DivisionCode ) And 
			( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( C.Styear	between	@lastYear_from and @lastYear_to ) and
			(cast(cast(substring(B.WorkDay,1,4) as integer) - 1 as char) *= c.styear )  and 
			( ( B.AreaCode = @ps_area ) And 
			  ( B.DivisionCode = @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			  ( A.DailyStatus = '1' ) ) ) D,

-- 		(Select	sum(IsNull(B.ActMH,0)) actMH,sum(IsNull(B.UnuseMH,0)) unuseMH, 
-- 		 	round(sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) ) / 3600,1) basicMH,
-- 		 	sum(IsNull(C.stMH,0) 
-- 				* ( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) )) lpi_bunja 
-- 		 From 	TMHDAILYSTATUS A,TMHREALPROD B, 
-- 			(SELECT WorkCenter,ItemCode,subLineCode,subLineNo, 
-- 				 IsNull(stMH,0) stMH 
-- 			  FROM tmhstandard 
-- 			  WHERE ( AreaCode = @ps_area ) And 
-- 				 ( DivisionCode = @ps_div ) And 
-- 				 ( stYear = @lastYear ) ) C 
-- 	  	 Where 	( A.AreaCode = B.AreaCode ) And 
-- 		 	( A.DivisionCode = B.DivisionCode ) And 
-- 		 	( A.WorkCenter = B.WorkCenter ) And 
-- 			( A.WorkDay = B.WorkDay ) And 
-- 			( B.WorkCenter *= C.WorkCenter ) And 
-- 			( B.ItemCode *= C.ItemCode ) And 
-- 			( B.subLineCode *= C.subLineCode ) And 
-- 			( B.subLineNo *= C.subLineNo ) And 
-- 			( ( B.AreaCode = @ps_area ) And 
-- 			  ( B.DivisionCode = @ps_div ) And 
-- 			  ( B.WorkCenter like @ps_wc ) And 
-- 			  ( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
-- 			  ( A.DailyStatus = '1' ) ) ) D,
		(SELECT	sum(IsNull(B.subMH,0)) effDownMH FROM TMHDAILYSTATUS A, TMHDAILYSUB B 
		 WHERE 	( A.AreaCode = B.AreaCode ) And 
			( A.DivisionCode = B.DivisionCode ) And 
			( A.WorkCenter = B.WorkCenter ) And 
			( A.WorkDay = B.Workday ) And 
			( ( A.AreaCode = @ps_area ) AND  
		           	( A.DivisionCode = @ps_div ) AND
		           	( A.Workcenter like @ps_wc ) AND    
		           	( B.mhGubun = 'Z' ) And
			( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And
			( A.DailyStatus = '1' ) ) ) F 
	WHERE 	( A.AreaCode = B.AreaCode ) And 
		( A.DivisionCode = B.DivisionCode ) And 
		( A.WorkCenter = B.WorkCenter ) And 
		( A.WorkDay = B.WorkDay ) And 
		( ( A.AreaCode = @ps_area ) AND  
		  ( A.DivisionCode = @ps_div ) AND  
		  ( A.WorkCenter like @ps_wc ) And 
		  ( A.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
		  ( B.DailyStatus = '1' ) ) 
	Group By D.actMH, D.unuseMH, F.effDownMH, D.basicMH, D.lpi_bunja


Update #Temp_MHList 
	Set dispRate_bunmo = IsNull(( Select totMH From #Temp_MHList A Where A.sDay = #Temp_MHList.sDay ), 0) 

/*
	Insert Into #Temp_MHList ( sDay ) 
	     Select days From #Temp_Days 
	      Where Not Exists ( Select sDay From #Temp_MHList 
				  Where sDay = #Temp_Days.days ) */

Create 	Table #Temp_dispName 
	(sDay		Char(5)		not null,
	sDayName      VarChar(10) 	null, 
	Seq1		int,
	Seq2		int		null,
	dispLevel	Char(1),
	dispName	VarChar(100) 	null,
	dispMH	Numeric(8,1) 	null,
	dispRate	Numeric(5,1) 	null ) 

Begin

Insert 	Into #Temp_dispName 
	SELECT 	sDay, 
		sDayName, 
		1 Seq1,  
		0 Seq2, 
		'1' dispLevel, 
		'   정시공수 (B)' dispName, 
		jungsiMH dispMH, 
		Case dispRate_bunmo When 0 Then 0 Else 
		round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate 
	From #Temp_MHList 
	
	Union 

	SELECT 	sDay, sDayName, 2, 0, '1', '   정시외공수 (C)', 		etcMH, 
		Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End 		From #Temp_MHList Union 
	SELECT	sDay, sDayName, 3, 0, '0', '총보유공수 (A=B+C)', 		totMH, 
		Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End 		From #Temp_MHList Union 
	-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
	Select 	D.sDay, D.sDayName, 4, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End 
	From 	#Temp_MHList D,TMHCODE B, 
	     	(Select 	substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
		 From	TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
		 Where 	( F.AreaCode = D.AreaCode ) And 
			( F.DivisionCode = D.DivisionCode ) And 
			( F.WorkCenter = D.WorkCenter ) And 
			( F.WorkDay = D.WorkDay ) And 
			( D.mhGubun = E.mhGubun ) And 
			( D.mhCode = E.mhCode ) And 
			( ( D.AreaCode = @ps_area ) And 
			( D.DivisionCode = @ps_div ) And 
			( D.WorkCenter like @ps_wc ) And 
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'K' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     	Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
	     	Union
	       	Select 	'99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
		From 	TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F 
		Where 	( F.AreaCode = D.AreaCode ) And 
			( F.DivisionCode = D.DivisionCode ) And 
			( F.WorkCenter = D.WorkCenter ) And 
			( F.WorkDay = D.WorkDay ) And 
			( D.mhGubun = E.mhGubun ) And 
			( D.mhCode = E.mhCode ) And 
			( ( D.AreaCode = @ps_area ) And 
			( D.DivisionCode = @ps_div ) And 
			( D.WorkCenter like @ps_wc ) And 
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'K' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     	Group By D.mhGubun, D.mhCode ) C 
	 Where	( D.sDay *= C.sDay ) And 
	       	( B.mhGubun *= C.mhGubun ) And 	
	       	( B.mhCode *= C.mhCode ) And 
	       	( B.mhGubun = 'K' ) And
	       	( IsNull(B.useFlag,'0') = '1' ) 
      	Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 

	Union 

	SELECT sDay, sDayName, 5, 0, '1', '   무급공수 (E)', 		excunpaidMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	-- 평가제외 유급공수 'S' 
	Select D.sDay, D.sDayName, 6, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'S' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
	     Union
	       Select '99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'S' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sDay *= C.sDay ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'S' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sDay, sDayName, 7, 0, '1', '   유급공수 (F)', 		excpaidMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	  SELECT sDay, sDayName, 8, 0, '0', '평가제외공수 (D=E+F)', 	excunpaidMH + excpaidMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End From #Temp_MHList Union 
	  SELECT sDay, sDayName, 9, 0, '0', '총투입공수 (G=A-D)', 	totInMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 유급근태사고공수 'B'
	Select D.sDay, D.sDayName, 10, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'B' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
	     Union
	       Select '99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'B' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sDay *= C.sDay ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	

	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'B' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sDay, sDayName, 11, 0, '1', '   유급근태사고공수 (H)',	gunteMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 일보사고공수 'G'
	Select D.sDay, sDayName, 12, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'G' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
	     Union
	       Select '99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'G' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sDay *= C.sDay ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'G' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sDay, sDayName, 13, 0, '1', '   일보사고공수 (I)',	ilboMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 부가작업공수 'F'
	Select D.sDay, D.sDayName, 14, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'F' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
	     Union 
	       Select '99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'F' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sDay *= C.sDay ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'F' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sDay, sDayName, 15, 0, '1', '   부가작업공수 (J)',	bugaMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 유휴공수 'U'
	Select D.sDay, D.sDayName, 16, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'U' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
 	     Union
	       Select '99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'U' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sDay *= C.sDay ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'U' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sDay, sDayName, 17, 0, '1', '   유휴공수 (K)',		UnuseMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	  SELECT sDay, sDayName, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)',	gunteMH + ilboMH + bugaMH + UnuseMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	  SELECT sDay, sDayName, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',	ActInMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	  SELECT sDay, sDayName, 20, 0, '0', '실동공수 (N=G-L)',		ActMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	-- 능률저하 'Z' 
	Select D.sDay, D.sDayName, 21, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)), 
		 Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End  
	  From #Temp_MHList D, 
	       TMHCODE B, 
	     ( Select substring(D.WorkDay, 6, 5) sDay, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'Z' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By substring(D.WorkDay, 6, 5), D.mhGubun, D.mhCode 
	     Union
	       Select '99.99', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH 
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
			( D.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			( D.mhGubun = 'Z' ) And 
			( IsNull(E.UseFlag,'0') = '1' ) And 
			( F.DailyStatus = '1' ) )  
	     Group By D.mhGubun, D.mhCode ) C 
	 Where ( D.sDay *= C.sDay ) And 
	       ( B.mhGubun *= C.mhGubun ) And 	
	       ( B.mhCode *= C.mhCode ) And 
	       ( B.mhGubun = 'Z' ) And
	       ( IsNull(B.useFlag,'0') = '1' ) 
      Group By D.sDay, D.sDayName, B.printSq, B.mhName, D.dispRate_bunmo 
	Union 
	  SELECT sDay, sDayName, 22, 0, '1', '   능률저하공수',	effDownMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( effDownMH / dispRate_bunmo * 100, 1 ) End	From #Temp_MHList Union 
	  SELECT sDay, sDayName, 23, 0, '0', '표준생산공수 (O)',	basicMH, 
		 Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End		From #Temp_MHList Union 
	  SELECT sDay, sDayName, 24, 0, '0', '실동율 (P=N/G)',	Case totInMH When 0 Then 0 Else 
							     round( ActMH / totInMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
	  SELECT sDay, sDayName, 25, 0, '0', '작업효율 (Q=O/N)',	Case ActMH When 0 Then 0 Else 
							     round( basicMH / ActMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
	  SELECT sDay, sDayName, 26, 0, '0', '종합효율 (R=P*Q)',	Case totInMH When 0 Then 0 Else 
							     round( basicMH / totInMH * 100, 1 ) End, NULL	From #Temp_MHList Union 
	  SELECT sDay, sDayName, 27, 0, '0', 'LPI',		lpi, NULL					From #Temp_MHList  

	End 

	Select * From #Temp_dispName Order By sDay, Seq1, Seq2 

Drop Table #Temp_MHList 
Drop Table #Temp_dispName 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

