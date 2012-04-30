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

CREATE PROCEDURE sp_pism100i_01
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
		 F.divtarLPI, 
		 F.tar_LPI 
	    FROM #Temp_Month A, 
		 ( SELECT substring(C.sMonth, 6, 2) sMonth, 
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
			  ( ( D.stYear = @lastYear ) And 
			    ( C.AreaCode = @ps_area ) And 
			    ( C.DivisionCode = @ps_div ) And 
			    ( C.WorkCenter like @ps_wc ) And 
			    ( substring(C.sMonth, 1, 4) = @ps_stYear ) ) 
		 Group By substring(C.sMonth, 6, 2) ) B,
		 ( Select Distinct substring(tarMonth, 6, 2) tarMonth,  
			  Case @ps_wc When '%' Then IsNull(divtarLPI,0) Else IsNull(tarLPI,0) End tar_LPI,
			  IsNull(divtarLPI,0) divtarLPI 
		     From TMHVALUETARGET
		    Where ( AreaCode = @ps_area ) And 
			  ( DivisionCode = @ps_div ) And 
			  ( WorkCenter like @ps_wc ) And 
			  ( substring(tarMonth, 1, 4) = @ps_stYear ) ) F 
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

