SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism050u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism050u_02]
GO





/*****************************/
/*     조별 목표지수 조회    */
/*****************************/

CREATE PROCEDURE sp_pism050u_02
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		Varchar(5),		-- 조
	@ps_stYear	Char(4),		-- 기준년 
	@ps_LastEmp	Varchar(6)		-- 최종수정자 
AS
BEGIN

Declare @lastYear	char(4) 

Set @lastYear = Cast ( Cast( @ps_stYear as Numeric(4) ) - 1 as Char(4) )

	Execute sp_pism050u_01  
			@ps_area	= @ps_area,
			@ps_div		= @ps_div,
			@ps_wc		= @ps_wc,
			@ps_stYear	= @ps_stYear,
			@ps_LastEmp	= @ps_LastEmp 
	If @@Error <> 0 Goto Exit_pr 

 SELECT A.WorkCenter, 
	sum( IsNull( A.totInMH, 0) ) totInMH,
	sum( IsNull( A.actMH, 0) ) actMH,
	sum( IsNull( A.BasicMH, 0) ) BasicMH,
	( Select Count(Distinct sMonth) From TMHMONTHPROD_S 
	   Where ( AreaCode = A.AreaCode) And 
		 ( DivisionCode = A.DivisionCode ) And 
		 ( WorkCenter = A.WorkCenter ) And 
		 ( substring( sMonth, 1, 4 ) = @lastYear ) And 
		 ( substring( sMonth, 6, 2 ) In ( Select stMonth From TMHSTMONTH 
						   Where ( AreaCode = A.AreaCode ) And 
							 ( DivisionCode = A.DivisionCode ) And 
							 ( stYear = @lastYear ) ) ) And 
		 ( IsNull(pQty,0) > 0 ) ) prodChk 
  Into #Temp_lstProduct
  FROM TMHMONTH_S A 
 WHERE ( A.AreaCode = @ps_area ) AND  
       ( A.DivisionCode = @ps_div ) AND  
       ( A.WorkCenter like @ps_wc ) AND  
       ( substring(A.sMonth, 1, 4) = @lastYear ) And 
       ( substring(A.sMonth, 6, 2) In ( Select stMonth From TMHSTMONTH 
				         Where ( AreaCode = A.AreaCode ) And 
					       ( DivisionCode = A.DivisionCode ) And 
					       ( stYear = @lastYear ) ) ) 
Group By A.AreaCode, A.DivisionCode, A.WorkCenter

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
	 B.WorkCenterName, 
         A.tarMonth,   
         A.totInMH,   
         A.ActMH,   
         A.basicMH,   
         A.tarLPI,   
 	 A.LastEmp, 
	 A.LastDate, 
	 C.tarLPI, 
	 Case D.prodChk When 0 Then 0 Else D.totInMH / D.prodChk End lst_totInMH, 
	 Case D.prodChk When 0 Then 0 Else D.actMH / D.prodChk End lst_actMH, 
	 Case D.prodChk When 0 Then 0 Else D.BasicMH / D.prodChk End lst_BasicMH 
    FROM TMHVALUETARGET A, TMSTWORKCENTER B, TMHDIVVALUETARGET C,
	 #Temp_lstProduct D 
   WHERE ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.WorkCenter = B.WorkCenter ) And  
	 ( A.AreaCode = C.AreaCode ) And 
	 ( A.DivisionCode = C.DivisionCode ) And 
	 ( A.tarMonth = C.tarMonth ) And 
	 ( A.WorkCenter *= D.WorkCenter ) And 
	 ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
           ( A.WorkCenter like @ps_wc ) AND  
           ( substring(A.tarMonth, 1, 4) = @ps_stYear ) And 
	   ( B.WorkCenterGubun1 = 'K' ) And 
	   ( IsNull(B.WorkCenterGubun2,'') <> '' ) ) 
Union
  SELECT A.AreaCode,   
         A.DivisionCode,   
         'XXXXX',   
	 '', 
         A.tarMonth,   
         sum( IsNull(A.totInMH,0) ), 
         sum( IsNull(A.ActMH,0) ),  
         sum( IsNull(A.basicMH,0) ), 
         0.0, 
	 '', 
	 getdate(), 
	 C.tarLPI, 
	 sum( IsNull(D.totInMH, 0) ) lst_totInMH, 
	 sum( IsNull(D.actMH, 0) ) lst_actMH, 
	 sum( IsNull(D.BasicMH, 0) ) lst_BasicMH 
    FROM TMHVALUETARGET A, TMSTWORKCENTER B, TMHDIVVALUETARGET C,
	 #Temp_lstProduct D 
   WHERE ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.WorkCenter = B.WorkCenter ) And  
	 ( A.AreaCode = C.AreaCode ) And 
	 ( A.DivisionCode = C.DivisionCode ) And 
	 ( A.tarMonth = C.tarMonth ) And 
	 ( A.WorkCenter *= D.WorkCenter ) And 
	 ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
           ( substring(A.tarMonth, 1, 4) = @ps_stYear ) And 
	   ( B.WorkCenterGubun1 = 'K' ) And 
	   ( IsNull(B.WorkCenterGubun2,'') <> '' ) ) 
Group By A.AreaCode,   
         A.DivisionCode, 
         A.tarMonth,
	 C.tarLPI 
Order By 3, 5 

Drop Table #Temp_lstProduct 

Exit_pr:

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

