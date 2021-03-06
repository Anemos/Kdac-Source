SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_sumMonth_prod]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_sumMonth_prod]
GO







/*********************************/
/*      월별 생산수량 집계       */
/*********************************/

CREATE PROCEDURE sp_pism010u_sumMonth_prod
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_sMonth		Char(7),		-- 집계년월 
	@ri_err			Int	OutPut 

AS
BEGIN

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         A.ItemCode,   
         substring(A.WorkDay, 1, 7) sMonth,   
         sum(IsNull(A.daypQty,0) + IsNull(A.nightpQty,0)) pQty,  
         sum(IsNull(A.UnuseMH,0)) UnuseMH, 
	 sum(IsNull(A.ActMH,0)) ActMH,   
         sum(IsNull(A.ActInMH,0)) ActInMH, 
	 round( Sum( BasicTime * ( IsNull(A.daypQty,0) + IsNull(A.nightpQty,0) ) / 3600 ) , 1) BasicMH 
    Into #Temp_Prod_s 
    FROM TMHREALPROD A, TMHDAILYSTATUS B 
   Where ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.WorkCenter = B.WorkCenter ) And 
	 ( A.WorkDay = B.WorkDay ) And 
	 ( ( A.AreaCode = @ps_area ) And 
	   ( A.DivisionCode = @ps_div ) And 
	   ( A.WorkCenter = @ps_wc ) And 
	   ( substring(A.WorkDay, 1, 7) = @ps_sMonth ) And 
	   ( IsNull(B.DailyStatus, '0') = '1' ) ) 
Group By A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         substring(A.WorkDay,1, 7), 
	 A.ItemCode 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- TMHMONTHPROD_S 에 있는 Data 가 #Temp_Prod_s 에 없는 경우 0 으로 Update 

  Update TMHMONTHPROD_S 
     Set pQty = 0,    
         UnuseMH = 0,   
         ActMH = 0,   
         ActInMH = 0,   
         BasicMH = 0,   
         LastEmp = 'Y',   
         LastDate = GetDate() 
    From TMHMONTHPROD_S A, 
	 ( Select B.AreaCode, 
		  B.DivisionCode, 
		  B.WorkCenter, 
		  B.ItemCode, 
		  B.sMonth 
	     From TMHMONTHPROD_S B 
	    Where ( B.AreaCode = @ps_area ) And 
		  ( B.DivisionCode = @ps_div ) And 
		  ( B.Workcenter = @ps_wc ) And 
		  ( B.sMonth = @ps_sMonth ) And 
		  ( Not Exists ( Select WorkCenter, ItemCode, sMonth 
				   From #Temp_Prod_s 
				  Where ( AreaCode = B.AreaCode ) And 
				        ( DivisionCode = B.DivisionCode ) And 
					( WorkCenter = B.WorkCenter ) And
					( sMonth = B.sMonth ) And 
					( ItemCode = B.ItemCode ) ) ) ) C 
  Where ( A.AreaCode = C.AreaCode ) And 
	( A.DivisionCode = C.DivisionCode ) And 
	( A.WorkCenter = C.WorkCenter ) And 
	( A.ItemCode = C.ItemCode ) And 
	( A.sMonth = C.sMonth ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- #Temp_Prod_s 에 있는 Data 가 TMHMONTHPROD_S 에 없는 경우 Insert 

  Insert INTO TMHMONTHPROD_S  
         ( AreaCode, DivisionCode, WorkCenter, ItemCode, sMonth, pQty, UnuseMH, ActMH,   
           ActInMH, BasicMH, LastEmp )  
  SELECT A.AreaCode, A.DivisionCode, A.WorkCenter, A.ItemCode, A.sMonth,   
	 A.pQty, 
	 A.UnuseMH, 
	 A.ActMH, 
	 A.ActInMH, 
	 A.BasicMH, 
	 'Y' 
    FROM #Temp_Prod_s A 
   Where Not Exists ( Select WorkCenter, ItemCode, sMonth 
		        From TMHMONTHPROD_S  
		       Where ( AreaCode = A.AreaCode ) And 
			     ( DivisionCode = A.DivisionCode ) And 
			     ( WorkCenter = A.WorkCenter ) And 
			     ( sMonth = A.sMonth ) And
			     ( ItemCode = A.itemCode ) ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- #Temp_Prod_s 에 있는 Data 가 TMHMONTHPROD_S 에 있는 경우 Update 

  UPDATE TMHMONTHPROD_S  
     SET pQty = A.pQty,   
         UnuseMH = A.UnuseMH,   
         ActMH = A.ActMH,   
         ActInMH = A.ActInMH,   
         BasicMH = A.BasicMH,   
         LastEmp = 'Y',   
         LastDate = GetDate() 
    From TMHMONTHPROD_S B, #Temp_Prod_s A 
   Where ( B.AreaCode = A.AreaCode ) And 
	 ( B.DivisionCode = A.DivisionCode ) And 
	 ( B.WorkCenter = A.WorkCenter ) And 
	 ( B.ItemCode = A.ItemCode ) And 
	 ( B.sMonth = A.sMonth ) 
	Select @ri_err = @@Error 
	Return @ri_err

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

