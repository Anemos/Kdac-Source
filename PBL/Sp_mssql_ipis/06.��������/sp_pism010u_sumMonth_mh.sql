SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_sumMonth_mh]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_sumMonth_mh]
GO







/*********************************/
/*      월별 발생공수 집계       */
/*********************************/

CREATE PROCEDURE sp_pism010u_sumMonth_mh
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_sMonth		Char(7),		-- 집계년월 
	@ri_err			Int	OutPut	

AS
BEGIN

Declare @unuseMH	Numeric(6,1),
	@actMH		Numeric(6,1),
	@effDownMH	Numeric(6,1),
	@basicMH	Numeric(6,1),
	@delChk		Int, 
	@del_primaryData	VarChar(200) 


  SELECT A.AreaCode, A.DivisionCode, A.WorkCenter,   
         substring(A.WorkDay, 1, 7) sMonth,   
         Sum(IsNull(A.totMH,0)) totMH,   
         Sum(IsNull(A.jungsiMH,0)) jungsiMH,   
         Sum(IsNull(A.mSuppMH,0)) mSuppMH,   
         Sum(IsNull(A.pSuppMH,0)) pSuppMH,   
         Sum(IsNull(A.etcMH,0)) etcMH,   
         Sum(IsNull(A.etcmSuppMH,0)) etcmSuppMH,   
         Sum(IsNull(A.etcpSuppMH,0)) etcpSuppMH,   
         Sum(IsNull(A.excunpaidMH,0)) excunpaidMH,   
         Sum(IsNull(A.excpaidMH,0)) excpaidMH,   
         Sum(IsNull(A.totInMH,0)) totInMH,   
         Sum(IsNull(A.gunteMH,0)) gunteMH,   
         Sum(IsNull(A.ilboMH,0)) ilboMH,   
         Sum(IsNull(A.bugaMH,0)) bugaMH, 
	 Sum(IsNull(A.ActInMH,0)) ActInMH 
    Into #Temp_Month_s 
    FROM TMHDAILY A, TMHDAILYSTATUS B 
   Where ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.WorkCenter = B.WorkCenter ) And 
	 ( A.WorkDay = B.WorkDay ) And 
	 ( ( A.AreaCode = @ps_area ) And 
	   ( A.DivisionCode = @ps_div ) And 
	   ( A.WorkCenter = @ps_wc ) And 
	   ( substring(A.WorkDay, 1, 7) = @ps_sMonth ) And 
	   ( IsNull(B.DailyStatus,'0') = '1' ) )	-- 작업일보 확정값 
Group By A.AreaCode, A.DivisionCode, A.WorkCenter,   
         substring(A.WorkDay, 1, 7) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- TMHMONTH_S 에 있는 Data 가 #Temp_Month_s 에 없는 경우 0 으로 Update 

  Update TMHMONTH_S 
     Set totMH = 0,   
         jungsiMH = 0,   
         mSuppMH = 0,   
         pSuppMH = 0,   
         etcMH = 0,   
         etcmSuppMH = 0,   
         etcpSuppMH = 0,   
         excunpaidMH = 0,   
         excpaidMH = 0,   
         totInMH = 0,   
         gunteMH = 0,   
         ilboMH = 0,   
         bugaMH = 0,   
         ActInMH = 0,   
         LastEmp = 'Y',   
         LastDate = GetDate() 
    From TMHMONTH_S A, 
	 ( Select B.AreaCode, 
		  B.DivisionCode, 
		  B.WorkCenter, 
		  B.sMonth 
	     From TMHMONTH_S B  
	    Where ( B.AreaCode = @ps_area ) And 
		  ( B.DivisionCode = @ps_div ) And 
		  ( B.Workcenter = @ps_wc ) And 
		  ( B.sMonth = @ps_sMonth ) And 
		  ( Not Exists ( Select WorkCenter, sMonth 
				   From #Temp_Month_s 
				  Where ( AreaCode = B.AreaCode ) And 
				        ( DivisionCode = B.DivisionCode ) And 
					( WorkCenter = B.WorkCenter ) And 
					( sMonth = B.sMonth ) ) ) ) C 
  Where ( A.AreaCode = C.AreaCode ) And 
	( A.DivisionCode = C.DivisionCode ) And 
	( A.WorkCenter = C.WorkCenter ) And 
	( A.sMonth = C.sMonth ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- #Temp_Month_s 에 있는 Data 가 TMHMONTH_S 에 없는 경우 Insert 

Insert INTO TMHMONTH_S  
         ( AreaCode, DivisionCode, WorkCenter, sMonth, totMH, jungsiMH, mSuppMH, pSuppMH, etcMH,   
           etcmSuppMH, etcpSuppMH, excunpaidMH, excpaidMH, totInMH, gunteMH, ilboMH, bugaMH, ActInMH, LastEmp ) 
  SELECT A.AreaCode, A.DivisionCode, A.WorkCenter,   
         A.sMonth,   
         A.totMH,   
         A.jungsiMH,   
         A.mSuppMH,   
         A.pSuppMH,    
         A.etcMH,   
         A.etcmSuppMH,   
         A.etcpSuppMH,   
         A.excunpaidMH,   
         A.excpaidMH,   
         A.totInMH,   
         A.gunteMH,   
         A.ilboMH,   
         A.bugaMH, 
	 A.ActInMH, 
	 'Y'  
    FROM #Temp_Month_s A 
   Where Not Exists ( Select sMonth 
		        From TMHMONTH_S 
		       Where ( AreaCode = A.AreaCode ) And 
			     ( DivisionCode = A.DivisionCode ) And 
			     ( WorkCenter = A.WorkCenter ) And
			     ( sMonth = A.sMonth ) ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

-- #Temp_Month_s 에 있는 Data 가 TMHMONTH_S 에 있는 경우 Update 

  Update TMHMONTH_S 
     Set totMH = A.totMH,   
         jungsiMH = A.jungsiMH,   
         mSuppMH = A.mSuppMH,   
         pSuppMH = A.pSuppMH,   
         etcMH = A.etcMH,   
         etcmSuppMH = A.etcmSuppMH,   
         etcpSuppMH = A.etcpSuppMH,   
         excunpaidMH = A.excunpaidMH,   
         excpaidMH = A.excpaidMH,   
         totInMH = A.totInMH,   
         gunteMH = A.gunteMH,   
         ilboMH = A.ilboMH,   
         bugaMH = A.bugaMH,   
         ActInMH = A.ActInMH,   
         LastEmp = 'Y',   
         LastDate = GetDate()  
    From #Temp_Month_s A, TMHMONTH_S B 
   Where ( B.AreaCode = A.AreaCode ) And 
	 ( B.DivisionCode = A.DivisionCode ) And 
	 ( B.WorkCenter = A.WorkCenter ) And 
	 ( B.sMonth = A.sMonth ) 
	Select @ri_err = @@Error 
	If @ri_err <> 0 Return @ri_err 

 Select @unuseMH = Sum(IsNull(A.UnuseMH,0)), 
	@actMH   = Sum(IsNull(A.ActMH,0)) 
   From TMHMONTHPROD_S A 
  Where ( ( A.AreaCode = @ps_area ) And 
	  ( A.DivisionCode = @ps_div ) And 
	  ( A.WorkCenter = @ps_wc ) And 
	  ( A.sMonth = @ps_sMonth ) ) 
 
  SELECT @effDownMH = Sum(IsNull(A.subMH,0)) 
    FROM TMHDAILYSUB A, TMHDAILYSTATUS B 
   WHERE ( A.AreaCode = B.AreaCode ) AND 
	 ( A.DivisionCode = B.DivisionCode ) AND  
	 ( A.WorkCenter = B.WorkCenter ) AND 
	 ( A.WorkDay = B.WorkDay ) AND 
	 ( ( A.AreaCode = @ps_area ) And 
	   ( A.DivisionCode = @ps_div ) And 
	   ( A.WorkCenter = @ps_wc ) And 
 	   ( substring(A.WorkDay, 1, 7) = @ps_sMonth ) And 
	   ( IsNull(B.DailyStatus,'0') = '1' ) And 
 	   ( mhGubun = 'Z' ) ) 

  Select @basicMH = round( Sum( BasicTime * ( IsNull(A.daypQty,0) + IsNull(A.nightpQty,0) ) / 3600 ) , 1)
    From TMHREALPROD A, TMHDAILYSTATUS B 
   Where ( A.AreaCode = B.AreaCode ) AND 
  	 ( A.DivisionCode = B.DivisionCode ) AND  
	 ( A.WorkCenter = B.WorkCenter ) AND 
	 ( A.WorkDay = B.WorkDay ) AND 
	 ( ( A.AreaCode = @ps_area ) And 
	   ( A.DivisionCode = @ps_div ) And 
	   ( A.WorkCenter = @ps_wc ) And
	   ( substring(A.WorkDay, 1, 7) = @ps_sMonth ) And 
	   ( IsNull(B.DailyStatus,'0') = '1' ) ) 

	Update TMHMONTH_S 
	   Set UnuseMH 		= IsNull(@unuseMH,0),
	       ActMH   		= IsNull(@actMH,0),
	       effDownMH	= IsNull(@effDownMH,0), 
	       BasicMH   	= IsNull(@basicMH,0),
	       LastEmp 		= 'Y',
	       LastDate		= GetDate() 
	 Where ( AreaCode 	= @ps_area ) And 
	       ( DivisionCode = @ps_div ) And 
	       ( WorkCenter = @ps_wc ) And 
	       ( sMonth = @ps_sMonth ) 
	Select @ri_err = @@Error 
	Return @ri_err

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

