USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism040u_02_upload]    Script Date: 05/04/2012 10:33:53 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/***************************************************************************/
/*        전년도 기준공수 조회 (기준월 월별공수, 기준월평균, 연간평균)     */
/***************************************************************************/

ALTER  PROCEDURE [dbo].[sp_pism040u_02_upload]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		Varchar(5),		-- 조
	@ps_stYear	Char(4),		-- 기준년 
	@ps_lastEmp 	VarChar(6) 
AS
BEGIN

-- Declare @Month 	int, 
-- 	@SQLString 	NVARCHAR(4000), 
-- 	@SQLString_1 	NVARCHAR(4000), 
-- 	@SQLString_2 	NVARCHAR(4000), 
-- 	@Chk  		int,
-- 	@Cnt		int,
-- 	@cvtMonth	Char(2) 
-- Set @Month = 1 
-- Set @Cnt = 1 
-- 
-- 	CREATE TABLE #Temp -- 기준월 월별공수, 기준월평균, 기준년평균 조회용 
-- 	(
-- 		WorkCenter	Varchar(5)	not null,
-- 		ItemCode	Varchar(12)	not null,
-- 		subLineCode	Varchar(7)	not null, 
-- 		subLineNo	char(1)		not null, 
-- 		stMonthAvg	Numeric(7,5)	null,
-- 		stYearAvg	Numeric(7,5)	null,
-- 		mh_01		Numeric(7,5)	null, 
-- 		mh_02		Numeric(7,5)	null,
-- 		mh_03		Numeric(7,5)	null,
-- 		mh_04		Numeric(7,5)	null,
-- 		mh_05		Numeric(7,5)	null,
-- 		mh_06		Numeric(7,5)	null,
-- 		mh_07		Numeric(7,5)	null,
-- 		mh_08		Numeric(7,5)	null,
-- 		mh_09		Numeric(7,5)	null,
-- 		mh_10		Numeric(7,5)	null,
-- 		mh_11		Numeric(7,5)	null,
-- 		mh_12		Numeric(7,5)	null
-- 	)
-- 
-- 	Execute sp_pism040u_01 	@ps_area 	= @ps_area, 
-- 				@ps_div		= @ps_div, 
-- 				@ps_stYear	= @ps_stYear, 
-- 				@ps_wc		= @ps_wc, 
-- 				@ps_lastEmp	= @ps_lastEmp 
-- 	If @@Error <> 0 Goto Exit_pr 
-- 
-- -- 기준월별 집계
-- 
-- 	Set @SQLString_1 = N'Insert Into #Temp ( WorkCenter, ItemCode, subLineCode, subLineNo' 
-- 	Set @SQLString_2 = N' ) Select A.WorkCenter, A.ItemCode, A.subLineCode, A.subLineNo' 
-- 
-- 	WHILE @Month <= 12 
-- 	BEGIN
-- 		Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth	Output 
-- 		If @@Error <> 0 Goto Exit_pr 
-- 
-- 		Select @Chk = Count(stMonth) From TMHSTMONTH 
-- 		Where ( AreaCode  = @ps_area ) And ( DivisionCode = @ps_div ) And ( stYear = @ps_stYear ) And ( stMonth = @cvtMonth ) 
-- 		
-- 		If @Chk > 0 
-- 		Begin
-- 
-- 			Set @SQLString_1 = @SQLString_1 + ', mh_' + @cvtMonth  
-- 			Set @SQLString_2 = @SQLString_2 + ", Case Sum( case When substring(A.sMonth, 6, 2) = '" + @cvtMonth  + "' Then IsNull(A.pQty,0) Else 0 End ) When 0 Then 0 Else " + 
-- 							    "Sum( case When substring(A.sMonth, 6, 2) = '" + @cvtMonth  + "' Then IsNull(A.ActInMH,0) Else 0 End ) / " + 
-- 							    "Sum( case When substring(A.sMonth, 6, 2) = '" + @cvtMonth  + "' Then IsNull(A.pQty,0) Else 0 End ) End "
-- 			Set @Cnt = @Cnt + 1 
-- 		End 
-- 
-- 		Set @Month = @Month + 1 
-- 	END
-- 
-- 	Begin
-- 
-- 		Set @SQLString = @SQLString_1 + @SQLString_2 + 
-- 				 " FROM TMHMONTHPRODLINE_S A WHERE ( A.AreaCode = '" + @ps_area + "' ) AND ( A.DivisionCode = '" + @ps_div + "' ) AND " + 
-- 				 "( substring(A.sMonth, 1, 4) = '" + @ps_stYear + "' ) And ( A.WorkCenter like '" + @ps_wc + "' ) " + 
-- 				 "Group By A.AreaCode, A.DivisionCode, A.WorkCenter, substring(A.sMonth, 1, 4), A.ItemCode, A.subLineCode, A.subLineNo " 
-- 
-- 		EXEC sp_executesql @SQLString
-- 		If @@Error <> 0 Goto Exit_pr
-- 	End 
-- 
-- -- 연간 집계 
-- 	Begin 
-- 
-- 	Update #Temp 
-- 	   Set stYearAvg = Case IsNull(A.pQty,0) When 0 Then 0 Else 
-- 				Round( IsNull(A.ActInMh,0) / IsNull(A.pQty,0), 5 ) End 
-- 	  From ( SELECT WorkCenter, ItemCode, subLineCode, subLineNo, sum(ActInMH ) ActInMH, sum(pQty) pQty
-- 	    	   FROM TMHMONTHPRODLINE_S A 
-- 		 WHERE ( A.AreaCode = @ps_area ) And 
-- 		       ( A.DivisionCode = @ps_div ) And 
-- 		       ( A.Workcenter like @ps_wc ) And 
-- 		       ( substring(A.sMonth, 1, 4) = @ps_stYear ) 
--  	          Group By A.AreaCode, A.DivisionCode, A.Workcenter, A.ItemCode, A.subLineCode, A.subLineNo ) A 
-- 	 Where ( #Temp.Workcenter = A.WorkCenter ) And 
-- 	       ( #Temp.ItemCode = A.ItemCode ) And
-- 	       ( #Temp.subLineCode = A.subLineCode ) And 
-- 	       ( #Temp.subLineNo = A.subLineNo ) 
--         If @@Error <> 0 Goto Exit_pr 
-- 
-- 	End 
-- 
-- -- 기준월 집계
-- 	Begin
-- 
-- 	Update #Temp 
-- 	   Set stMonthAvg = Case IsNull(A.pQty,0) When 0 Then 0 Else 
-- 				 Round( IsNull(A.ActInMh,0) / IsNull(A.pQty,0), 5 ) End 
-- 
-- 	  From  ( SELECT B.WorkCenter, B.ItemCode, B.subLineCode, B.subLineNo, sum(B.ActInMH ) ActInMH, sum(B.pQty) pQty  
-- 		    FROM TMHMONTHPRODLINE_S B, TMHSTMONTH C 
-- 	           WHERE ( B.AreaCode = C.AreaCode ) and  
-- 		         ( B.DivisionCode = C.DivisionCode ) and  
-- 		         ( B.sMonth = C.stYear + '.' + C.stMonth ) And
-- 		         ( ( B.AreaCode = @ps_area ) And 
-- 			   ( B.DivisionCode = @ps_div ) And 
-- 		           ( B.Workcenter like @ps_wc ) And 
-- 			   ( substring(B.sMonth, 1, 4) = @ps_stYear ) ) 
--                	Group By B.AreaCode, B.DivisionCode, B.WorkCenter, B.ItemCode, B.subLineCode, B.subLineNo ) A  
-- 	Where ( #Temp.Workcenter = A.WorkCenter ) And 
-- 	      ( #Temp.ItemCode = A.ItemCode ) And 
-- 	      ( #Temp.subLineCode = A.subLineCode ) And 
-- 	      ( #Temp.subLineNo = A.subLineNo ) 
-- 
-- 	       If @@Error <> 0 Goto Exit_pr 
-- 	End 
-- 
-- -- 기준공수 등록 
-- 	Begin 
-- 	Update TMHSTANDARD  
--  	   Set stMH = Case When IsNull(B.stMonthAvg,0) = 0 Then B.stYearAvg Else B.stMonthAvg End, 
-- 	       lastEmp = 'Y' 
-- 	  From TMHSTANDARD A, #Temp B 
-- 	 Where ( A.WorkCenter = B.WorkCenter ) And 
-- 	       ( A.ItemCode = B.ItemCode ) And 
-- 	       ( A.subLineCode = B.subLineCode ) And 
-- 	       ( A.subLineNo = B.subLineNo ) And 
-- 	       ( IsNull(A.stMH,0) = 0 ) --( IsNull(A.modifyFlag,'') <> '1' )
-- 	If @@Error <> 0 Goto Exit_pr  
-- 	End 

    SELECT A.AreaCode,   
	   A.DivisionCode,   
	   A.stYear,   
	   A.WorkCenter,   
	   F.WorkCenterName, 
	   C.ProductGroup,
	   E.ProductGroupName, 
	   A.ItemCode,   
	   D.ItemName, 
	   A.subLineCode, 
	   A.subLineNo, 
	   A.stMH, 0,0,0,0,0,0,0,0,0,0,0,0,0,0 ,
-- 	   B.stMonthAvg,
-- 	   B.stYearAvg, 
-- 	   B.mh_01,
-- 	   B.mh_02,
-- 	   B.mh_03,
-- 	   B.mh_04,
-- 	   B.mh_05,
-- 	   B.mh_06,
-- 	   B.mh_07,
-- 	   B.mh_08,
-- 	   B.mh_09,
-- 	   B.mh_10,
--            B.mh_11,
-- 	   B.mh_12,
	   A.modifyFlag, 
	   A.Lastemp,   
	   A.LastDate
     FROM TMHSTANDARD A, 
-- 	  #Temp B, 
	  TMSTMODEL C,   
          TMSTITEM D,   
          TMSTPRODUCTGROUP E,   
          TMSTWORKCENTER F  
    WHERE 
-- 	  ( A.WorkCenter *= B.WorkCenter ) And 
-- 	  ( A.ItemCode *= B.ItemCode ) And 
-- 	  ( A.subLineCode *= B.subLineCode ) And 
-- 	  ( A.subLineNo *= B.subLineNo ) And 
	  ( A.AreaCode = C.AreaCode ) And 
	  ( A.DivisionCode = C.DivisionCode ) And 
	  ( A.AreaCode = C.AreaCode ) And 
	  ( A.DivisionCode = C.DivisionCode ) And 
	  ( A.ItemCode = C.ItemCode ) And 
	  ( A.AreaCode = E.AreaCode ) And 
	  ( A.DivisionCode = E.DivisionCode ) And 
	  ( A.AreaCode = F.AreaCode ) And 
	  ( A.DivisionCode = F.DivisionCode ) And 
	  ( A.WorkCenter = F.WorkCenter ) And 
	  ( C.ItemCode = D.ItemCode ) And 
          ( C.ProductGroup = E.ProductGroup ) And 
	  ( ( A.AreaCode = @ps_area ) AND  
	    ( A.DivisionCode = @ps_div ) AND  
	    ( A.stYear = @ps_stYear ) AND  
	    ( A.WorkCenter like @ps_wc ) )  

-- Exit_pr:
-- DROP TABLE #Temp

END
