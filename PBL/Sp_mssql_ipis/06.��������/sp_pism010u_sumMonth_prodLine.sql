SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_sumMonth_prodLine]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_sumMonth_prodLine]
GO








/**************************************/
/*      월별 Line별 생산수량 집계     */
/**************************************/

CREATE PROCEDURE sp_pism010u_sumMonth_prodLine 
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
	 A.subLineCode, 
	 A.subLineNo, 
         substring(A.WorkDay, 1, 7) sMonth,   
         sum(IsNull(A.daypQty,0) + IsNull(A.nightpQty,0)) pQty,  
         sum(IsNull(A.UnuseMH,0)) UnuseMH, 
	 sum(IsNull(A.ActMH,0)) ActMH,   
         sum(IsNull(A.ActInMH,0)) ActInMH, 
	 round( Sum( BasicTime * ( IsNull(A.daypQty,0) + IsNull(A.nightpQty,0) ) / 3600 ) , 1) BasicMH 
    Into #Temp_ProdLine_s 
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
	 A.ItemCode, 
	 A.subLineCode, 
	 A.subLineNo 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 


-- TMHMONTHPRODLINE_S 에 있는 Data 가 #Temp_ProdLine_s 에 없는 경우 0 으로 Update 

  Update TMHMONTHPRODLINE_S
     Set pQty = 0,   
         UnuseMH = 0,   
         ActMH = 0,   
         ActInMH = 0,   
         BasicMH = 0,   
         LastEmp = 'Y',   
         LastDate = GetDate()  
    From TMHMONTHPRODLINE_S A, 
	 ( Select B.AreaCode, 
		  B.DivisionCode, 
		  B.WorkCenter, 
		  B.ItemCode, 
		  B.subLineCode, 
		  B.subLineNo, 
		  B.sMonth 
	     From TMHMONTHPRODLINE_S B 
	    Where ( B.AreaCode = @ps_area ) And 
		  ( B.DivisionCode = @ps_div ) And 
		  ( B.Workcenter = @ps_wc ) And 
		  ( B.sMonth = @ps_sMonth ) And 
		  ( Not Exists ( Select ItemCode, subLineCode, subLineNo 
				   From #Temp_ProdLine_s 
				  Where ( AreaCode = B.AreaCode ) And 
				        ( DivisionCode = B.DivisionCode ) And 
					( WorkCenter = B.WorkCenter ) And
					( sMonth = B.sMonth ) And
					( ItemCode = B.ItemCode ) And 
					( subLineCode = B.subLineCode ) And 
					( subLineNo = B.subLineNo ) ) ) ) C 
  Where ( A.AreaCode = C.AreaCode ) And 
	( A.DivisionCode = C.DivisionCode ) And 
	( A.WorkCenter = C.WorkCenter ) And 
	( A.ItemCode = C.ItemCode ) And 
	( A.subLineCode = A.subLineCode ) And 
	( A.subLineNo = A.subLineNo ) And 
	( A.sMonth = C.sMonth ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- #Temp_ProdLine_s 에 있는 Data 가 TMHMONTHPRODLINE_S 에 없는 경우 Insert 

  Insert INTO TMHMONTHPRODLINE_S
         ( AreaCode, DivisionCode, WorkCenter, ItemCode, subLineCode, subLineNo, sMonth,   
           pQty, UnuseMH, ActMH, ActInMH, BasicMH, LastEmp )  
  SELECT A.AreaCode, A.DivisionCode, A.WorkCenter, A.ItemCode, 
	 A.subLineCode, 
	 A.subLineNo, 
	 A.sMonth,   
	 A.pQty, 
	 A.UnuseMH, 
	 A.ActMH, 
	 A.ActInMH, 
	 A.BasicMH, 
	 'Y' 
    FROM #Temp_ProdLine_s A 
   Where Not Exists ( Select ItemCode, subLineCode, subLineNo 
		        From TMHMONTHPRODLINE_S  
		       Where ( AreaCode = A.AreaCode ) And 
			     ( DivisionCode = A.DivisionCode ) And 
			     ( WorkCenter = A.WorkCenter ) And 
			     ( sMonth = A.sMonth ) And 
			     ( ItemCode = A.ItemCode ) And 
			     ( subLineCode = A.subLineCode ) And 
			     ( subLineNo = A.subLineNo ) ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- #Temp_ProdLine_s 에 있는 Data 가 TMHMONTHPRODLINE_S 에 있는 경우 Update 

  UPDATE TMHMONTHPRODLINE_S  
     Set pQty = A.pQty, 
         UnuseMH = A.UnuseMH,   
         ActMH = A.ActMH,  
         ActInMH = A.ActInMH,    
         BasicMH = A.BasicMH,  
         LastEmp = 'Y',   
         LastDate = GetDate()  
    From TMHMONTHPRODLINE_S B, #Temp_ProdLine_s A 
   Where ( B.AreaCode = A.AreaCode ) And 
	 ( B.DivisionCode = A.DivisionCode ) And 
	 ( B.WorkCenter = A.WorkCenter ) And 
	 ( B.ItemCode = A.ItemCode ) And 
	 ( B.subLineCode = A.subLineCode ) And 
	 ( B.subLineNo = A.subLineNo ) And 
	 ( B.sMonth = A.sMonth ) 
	Select @ri_err = @@Error 
	Return @ri_err

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

