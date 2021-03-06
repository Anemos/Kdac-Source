SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism190i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism190i_01]
GO








/*********************************************/ 
/*     월별 종합효율/가동율/작업효율 - 횡    */ 
/*********************************************/ 

CREATE PROCEDURE sp_pism190i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		VarChar(5),		-- 조 	
	@ps_FromMonth	Char(7), 		-- From 월
	@ps_ToMonth	Char(7)			-- To 월 
AS
BEGIN

Declare @lastYear	Char(4),
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

Create Table #Temp_MHList 
	( sMonth		Char(7) 	not null,
	  WorkCenter		VarChar(5)	not null,
	  WorkCenterName	VarChar(30)	null, 
	  totInMH		Numeric(8,1)	null,
	  ActMH			Numeric(8,1)	null,
	  basicMH		Numeric(8,1)	null, 
	  lpi_bunja		Numeric(12,4)	null, 
	  lpi_bunmo		Numeric(8,1)	null ) 

Set @lastYear = Cast ( Cast( substring(@ps_FromMonth,1,4) as Numeric(4) ) - 1 as Char(4) )

	Insert Into #Temp_MHList 
	  Select sMonth 	= substring(A.sMonth, 1, 7), 
		 WorkCenter     = A.WorkCenter, 
		 WorkCenterName = E.WorkCenterName, 
		 totInMH 	= sum(IsNull(A.totInMH,0)), 
	         ActMH 		= sum(IsNull(A.ActMH,0)),
		 basicMH 	= sum(IsNull(D.basicMH,0)),
		 lpi_bunja	= sum(IsNull(D.lpi_bunja,0)),
		 lpi_bunmo	= sum(IsNull(A.ActInMH,0)) 
	    FROM TMHMONTH_S A, 
		( Select B.WorkCenter, 
 			 B.sMonth, 
			 sum(IsNull(B.basicMH,0)) basicMH,
			 sum(IsNull(C.stMH,0) * IsNull(B.pQty,0)) lpi_bunja 
		    From TMHMONTHPRODLINE_S B, 
			( SELECT WorkCenter, 
				 ItemCode, 
				 subLineCode, 
				 subLineNo, 
				 IsNull(stMH,0) stMH 
			    FROM TMHSTANDARD 
			   WHERE ( AreaCode = @ps_area ) And 
				 ( DivisionCode = @ps_div ) And 
				 ( stYear = @lastYear ) ) C 
		  Where ( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( ( B.AreaCode = @ps_area ) And 
			  ( B.DivisionCode = @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( B.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
	       Group By B.WorkCenter, B.sMonth ) D, 
		 TMSTWORKCENTER E 
	   WHERE ( A.AreaCode = E.AreaCode ) And 
		 ( A.DivisionCode = E.DivisionCode ) And 
		 ( A.WorkCenter = E.WorkCenter ) And 
		 ( A.WorkCenter *= D.WorkCenter ) And 
		 ( A.sMonth *= D.sMonth ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( A.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
	Group By A.sMonth, A.WorkCenter, E.WorkCenterName 
Union
	  Select sMonth 	= '누계', 
		 WorkCenter     = A.WorkCenter, 
		 WorkCenterName = E.WorkCenterName, 
		 totInMH 	= sum(IsNull(A.totInMH,0)), 
	         ActMH 		= sum(IsNull(A.ActMH,0)),
		 basicMH 	= sum(IsNull(D.basicMH,0)),
		 lpi_bunja	= sum(IsNull(D.lpi_bunja,0)),
		 lpi_bunmo	= sum(IsNull(A.ActInMH,0)) 
	    FROM TMHMONTH_S A, 
		( Select B.WorkCenter, 
 			 B.sMonth, 
			 sum(IsNull(B.basicMH,0)) basicMH,
			 sum(IsNull(C.stMH,0) * IsNull(B.pQty,0)) lpi_bunja 
		    From TMHMONTHPRODLINE_S B, 
			( SELECT WorkCenter, 
				 ItemCode, 
				 subLineCode, 
				 subLineNo, 
				 IsNull(stMH,0) stMH 
			    FROM TMHSTANDARD 
			   WHERE ( AreaCode = @ps_area ) And 
				 ( DivisionCode = @ps_div ) And 
				 ( stYear = @lastYear ) ) C 
		  Where ( B.WorkCenter *= C.WorkCenter ) And 
			( B.ItemCode *= C.ItemCode ) And 
			( B.subLineCode *= C.subLineCode ) And 
			( B.subLineNo *= C.subLineNo ) And 
			( ( B.AreaCode = @ps_area ) And 
			  ( B.DivisionCode = @ps_div ) And 
			  ( B.WorkCenter like @ps_wc ) And 
			  ( B.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
	       Group By B.WorkCenter, B.sMonth ) D, 
		 TMSTWORKCENTER E 
	   WHERE ( A.AreaCode = E.AreaCode ) And 
		 ( A.DivisionCode = E.DivisionCode ) And 
		 ( A.WorkCenter = E.WorkCenter ) And 
		 ( A.WorkCenter *= D.WorkCenter ) And 
		 ( A.sMonth *= D.sMonth ) And 
		 ( ( A.AreaCode = @ps_area ) AND  
	           ( A.DivisionCode = @ps_div ) AND  
		   ( A.WorkCenter like @ps_wc ) And 
	           ( A.sMonth Between @ps_FromMonth And @ps_ToMonth ) ) 
	Group By A.WorkCenter, E.WorkCenterName 

/*
	Insert Into #Temp_MHList ( sMonth ) 
	     Select sMonth From #Temp_Month 
	      Where Not Exists ( Select sMonth From #Temp_MHList 
				  Where sMonth = #Temp_Month.sMonth ) 
*/
	Begin

	  SELECT sMonth, WorkCenter, WorkCenterName, 1 Seq, '종합효율' dispname, Case totInMH When 0 Then 0 Else
										      round( basicMH / totInMH * 100, 1 ) End dispmh From #Temp_MHList Union 
	  SELECT sMonth, WorkCenter, WorkCenterName, 2, '가 동 율', Case totInMH When 0 Then 0 Else
									 round( ActMH / totInMH	* 100, 1 ) End From #Temp_MHList Union 
	  SELECT sMonth, WorkCenter, WorkCenterName, 3, '작업효율', Case ActMH When 0 Then 0 Else 
									 round( basicMH / ActMH	* 100, 1 ) End From #Temp_MHList Union 
	  SELECT sMonth, WorkCenter, WorkCenterName, 4, 'L  P  I',  Case lpi_bunmo When 0 Then 0 Else
									 round( lpi_bunja / lpi_bunmo * 100, 1 ) End From #Temp_MHList Union 
	  SELECT sMonth, 'XXXXX', '', 1, '종합효율', Case sum(totInMH) When 0 Then 0 Else
								    round( sum(basicMH) / sum(totInMH) * 100, 1 ) End  
	    From #Temp_MHList Group By sMonth Union  
	  SELECT sMonth, 'XXXXX', '', 2, '가 동 율', Case sum(totInMH) When 0 Then 0 Else 
								    round( sum(ActMH) / sum(totInMH) * 100, 1 ) End 
	    From #Temp_MHList Group By sMonth Union 
	  SELECT sMonth, 'XXXXX', '', 3, '작업효율', Case sum(ActMH) When 0 Then 0 Else 
								    round( sum(basicMH) / sum(ActMH) * 100, 1 ) End 
	    From #Temp_MHList Group By sMonth Union 
	  SELECT sMonth, 'XXXXX', '', 4, 'L  P  I',  Case sum(lpi_bunmo) When 0 Then 0 Else 
								    round( sum(lpi_bunja) / sum(lpi_bunmo) * 100, 1 ) End 
	    From #Temp_MHList Group By sMonth 

	Order By sMonth, WorkCenter, Seq 

	End 
Drop Table #Temp_MHList 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

