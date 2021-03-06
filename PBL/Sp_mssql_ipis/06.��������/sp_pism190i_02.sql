SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism190i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism190i_02]
GO








/*************************************************/ 
/*     일별 종합효율/가동율/작업효율/LPI - 횡    */ 
/*************************************************/ 

CREATE PROCEDURE sp_pism190i_02
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		VarChar(5),		-- 조 	
	@ps_FromDate	Char(10), 		-- From Date
	@ps_ToDate 	Char(10)		-- To Date 
AS
BEGIN

Declare @lastYear	Char(4),
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

 Set @lastYear = Cast ( Cast( substring(@ps_FromDate, 1, 4) as Numeric(4) ) - 1 as Char(4) )

 Create Table #Temp_MHList 
	( sDay			Char(10)	not null,
	  WorkCenter		VarChar(5)	not null,
	  WorkCenterName	VarChar(30)	null,
	  totInMH		Numeric(8,1)	null,
	  ActMH 		Numeric(8,1)	null,
	  basicMH		Numeric(8,1)	null,	
	  lpi_bunja		Numeric(12,4)	null,
	  lpi_bunmo		Numeric(8,1)	null ) 

	Insert Into #Temp_MHList 
	  Select sDay 		= substring(A.WorkDay,6,5), 
		 WorkCenter	= A.WorkCenter,
		 WorkCenterName = E.WorkCenterName, 
		 totInMH 	= sum(IsNull(A.totInMH,0)), 
	         ActMH 		= IsNull(D.actMH,0),
		 basicMH 	= IsNull(D.basicMH,0), 
		 lpi_bunja	= IsNull(D.lpi_bunja,0), 
		 lpi_bunmo	= sum(IsNull(A.ActInMH,0)) 
	    FROM TMHDAILY A, 
		 TMHDAILYSTATUS B, 
		( Select B.WorkCenter, 
 			 B.WorkDay,
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
			  ( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			  ( A.DailyStatus = '1' ) )  
	       Group By B.WorkCenter, B.WorkDay ) D,
		 TMSTWORKCENTER E 
	   WHERE ( A.AreaCode = B.AreaCode ) And 
		 ( A.DivisionCode = B.DivisionCode ) And 
		 ( A.WorkCenter = B.WorkCenter ) And 
		 ( A.WorkDay = B.WorkDay ) And 
	    	 ( A.WorkCenter *= D.WorkCenter ) And 
		 ( A.WorkDay *= D.WorkDay ) And 
		 ( A.AreaCode = E.AreaCode ) And 
		 ( A.DivisionCode = E.DivisionCode ) And 
		 ( A.WorkCenter = E.WorkCenter ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( A.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
		   ( B.DailyStatus = '1' ) ) 
	Group By substring(A.WorkDay,6,5), A.WorkCenter, E.WorkCenterName, D.actMH, D.basicMH, D.lpi_bunja
Union
	  Select sDay 		= '누계', 
		 WorkCenter	= A.WorkCenter,
		 WorkCenterName = E.WorkCenterName, 
		 totInMH 	= sum(IsNull(A.totInMH,0)), 
	         ActMH 		= IsNull(D.actMH,0),
		 basicMH 	= IsNull(D.basicMH,0), 
		 lpi_bunja	= IsNull(D.lpi_bunja,0), 
		 lpi_bunmo	= sum(IsNull(A.ActInMH,0)) 
	    FROM TMHDAILY A, 
		 TMHDAILYSTATUS B, 
		( Select B.WorkCenter, 
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
			  ( B.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
			  ( A.DailyStatus = '1' ) )  
	       Group By B.WorkCenter ) D,
		 TMSTWORKCENTER E 
	   WHERE ( A.AreaCode = B.AreaCode ) And 
		 ( A.DivisionCode = B.DivisionCode ) And 
		 ( A.WorkCenter = B.WorkCenter ) And 
		 ( A.WorkDay = B.WorkDay ) And 
	    	 ( A.WorkCenter *= D.WorkCenter ) And 
		 ( A.AreaCode = E.AreaCode ) And 
		 ( A.DivisionCode = E.DivisionCode ) And 
		 ( A.WorkCenter = E.WorkCenter ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( A.WorkDay Between @ps_FromDate And @ps_ToDate ) And 
		   ( B.DailyStatus = '1' ) ) 
	Group By A.WorkCenter, E.WorkCenterName, D.actMH, D.basicMH, D.lpi_bunja 


/*
	Insert Into #Temp_MHList ( sDay ) 
	     Select days From #Temp_Days 
	      Where Not Exists ( Select sDay From #Temp_MHList 
				  Where sDay = #Temp_Days.days ) */
	Begin

	  SELECT sDay, WorkCenter, WorkCenterName, 1 Seq, '종합효율' dispname, Case totInMH When 0 Then 0 Else 
							     round( basicMH / totInMH * 100, 1 ) End dispmh From #Temp_MHList Union 
	  SELECT sDay, WorkCenter, WorkCenterName, 2, '가 동 율',   Case totInMH When 0 Then 0 Else 
							     round( ActMH / totInMH * 100, 1 ) End From #Temp_MHList Union 
	  SELECT sDay, WorkCenter, WorkCenterName, 3, '작업효율',	Case ActMH When 0 Then 0 Else 
							     round( basicMH / ActMH * 100, 1 ) End From #Temp_MHList Union 
	  SELECT sDay, WorkCenter, WorkCenterName, 4, 'L  P  I', Case lpi_bunmo When 0 Then 0 Else
							     round( lpi_bunja / lpi_bunmo * 100, 1 ) End From #Temp_MHList Union 

	  SELECT sDay, 'XXXXX', '', 1, '종합효율' dispname, Case sum(totInMH) When 0 Then 0 Else
									   round( sum(basicMH) / sum(totInMH) * 100, 1 ) End dispmh 
	    From #Temp_MHList Group By sDay Union 
	  SELECT sDay, 'XXXXX', '', 2, '가 동 율', Case sum(totInMH) When 0 Then 0 Else 
								  round( sum(ActMH) / sum(totInMH) * 100, 1 ) End 
	    From #Temp_MHList Group By sDay Union 
	  SELECT sDay, 'XXXXX', '', 3, '작업효율', Case sum(ActMH) When 0 Then 0 Else 
								  round( sum(basicMH) / sum(ActMH) * 100, 1 ) End 
	    From #Temp_MHList Group By sDay Union 
	  SELECT sDay, 'XXXXX', '', 4, 'L  P  I',  Case sum(lpi_bunmo) When 0 Then 0 Else
								  round( sum(lpi_bunja) / sum(lpi_bunmo) * 100, 1 ) End 
	    From #Temp_MHList Group By sDay 

	Order By sDay, WorkCenter, Seq 

	End 

Drop Table #Temp_MHList 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

