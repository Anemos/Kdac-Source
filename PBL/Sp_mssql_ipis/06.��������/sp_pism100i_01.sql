SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism100i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism100i_01]
GO









/************************/ 
/*     월별 LPI 조회    */ 
/************************/ 

CREATE PROCEDURE [dbo].[sp_pism100i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stYear	Char(4)			-- 기준년도
AS
BEGIN

Declare @Month		int,
	@cvtMonth	Char(2), 
	@lastYear	char(4) 

	CREATE TABLE #Temp_Month 
	(
		stMonth		Char(2)		not null 
	)

Set @lastYear = Cast ( Cast( @ps_stYear as Numeric(4) ) - 1 as Char(4) )
Set @Month = 1

	WHILE @Month <= 12
	Begin
		Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth	Output 
		Insert Into #Temp_Month Values ( @cvtMonth ) 
		Set @Month = @Month + 1 
	End 


	  SELECT A.stMonth, 
		 IsNull(B.LPI_bunja,0) LPI_bunja, 
		 IsNull(B.LPI_bunmo,0) LPI_bunmo, 
		 Case IsNull(B.LPI_bunmo,0) When 0 Then 0 Else
		      round( IsNull(B.LPI_bunja,0) / IsNull(B.LPI_bunmo,0) * 100, 1 ) End LPI,
		G.divtarlpi ,
                            F.tar_LPI
	    FROM #Temp_Month A, 
		 ( SELECT substring(C.sMonth, 6, 2) sMonth, 
			  sum( IsNull(CASE SUBSTRING(C.sMonth,6,2) 
			 	WHEN '01' THEN D.STMH01
			 	WHEN '02' THEN D.STMH02
			 	WHEN '03' THEN D.STMH03
			 	WHEN '04' THEN D.STMH04
			 	WHEN '05' THEN D.STMH05
			 	WHEN '06' THEN D.STMH06
			 	WHEN '07' THEN D.STMH07
			 	WHEN '08' THEN D.STMH08
			 	WHEN '09' THEN D.STMH09
			 	WHEN '10' THEN D.STMH10
			 	WHEN '11' THEN D.STMH11
			 	WHEN '12' THEN D.STMH12 END,0) * IsNull(C.pQty,0) ) LPI_bunja,
			  sum( IsNull(C.ActInMH,0) ) LPI_bunmo 
		     FROM TMHMONTHPRODLINE_S C, 
		    	  tmhstandard D 
		    WHERE ( C.AreaCode = D.AreaCode ) and  
			  ( C.DivisionCode = D.DivisionCode ) and  
		          	  ( C.WorkCenter = D.WorkCenter ) and  
			  ( C.ItemCode = D.ItemCode ) and  
			  ( C.subLineCode = D.subLineCode ) And 
			  ( C.subLineNo = D.subLineNo ) And 
			  ( ( D.stYear = @lastYear ) And 
			    ( C.AreaCode = @ps_area ) And 
			    ( C.DivisionCode = @ps_div ) And 
			    ( C.WorkCenter like @ps_wc ) And 
			    ( substring(C.sMonth, 1, 4) = @ps_stYear ) ) 
		 Group By substring(C.sMonth, 6, 2) ) B,
                            ( Select  distinct substring(tarmonth,6,2) tarmonth, IsNull(tarLPI,0) tar_LPI	
         		     From TMHVALUETARGET
		    Where ( AreaCode = @ps_area ) And 
			  ( DivisionCode = @ps_div ) And 
			  ( WorkCenter like @ps_wc ) And (@ps_wc <> '%')  And
			  ( substring(tarMonth, 1, 4) = @ps_stYear and substring(tarMonth,6, 2) < '13'  )
		  Union	
                              Select  distinct substring(tarmonth,6,2) tarmonth, IsNull(tarLPI,0) tar_LPI	
         		     From TMHDIVVALUETARGET
		    Where ( AreaCode = @ps_area ) And 
			  ( DivisionCode = @ps_div ) And 
			  (@ps_wc = '%')   And  
			  ( substring(tarMonth, 1, 4) = @ps_stYear and substring(tarMonth,6, 2) < '13'  )) F,
                              ( Select  distinct substring(tarmonth,6,2) tarmonth, IsNull(tarLPI,0) divtarlpi 
		      From TMHVALUETARGET
		     Where ( AreaCode = @ps_area ) And 
			  ( DivisionCode = @ps_div ) And 
			  ( WorkCenter like @ps_wc ) And (@ps_wc <> '%')  And
			  ( substring(tarMonth, 1, 4) = @ps_stYear and substring(tarMonth,6, 2) = '13'  )
                                 Union	
                                Select  distinct substring(tarmonth,6,2) tarmonth, IsNull(tarLPI,0) divtarlpi
         		     From TMHDIVVALUETARGET
		    Where ( AreaCode = @ps_area ) And 
			  ( DivisionCode = @ps_div ) And 
			  (@ps_wc = '%')   And  
			  ( substring(tarMonth, 1, 4) = @ps_stYear and substring(tarMonth,6, 2) = '13'  )) G 
	     WHERE ( A.stMonth *= F.tarMonth ) And 
		   ( A.stMonth *= B.sMonth ) 
	Order By A.stMonth 
	
Drop Table #Temp_Month

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

