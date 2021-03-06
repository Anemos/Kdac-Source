SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism150i_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism150i_03]
GO







/***********************/ 
/*     비가동 WORST    */ 
/***********************/ 

CREATE PROCEDURE sp_pism150i_03
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stFromDate	Char(10),		-- 기준일 From
	@ps_stToDate	Char(10),		-- 기준일 To 
	@ps_retCondition	Char(1) 	-- 조회기준 
AS
BEGIN

Declare @totMH	Numeric(8,1) 

	CREATE TABLE #Temp_notOperation
	(
		WorkCenter	VarChar(6)	null,
		MHGubun		Char(1)		null,
		MHCode 		Char(2)		null,
		MHName 		VarChar(20)	null, 
		subMH		Numeric(4,1)	null 
	)


	If @ps_retCondition = '0'	-- 전체
	     Insert Into #Temp_notOperation 
		  SELECT '', '', 
			 A.mhCode,   
			 B.mhName, 
		         sum(A.subMH)  
		    FROM TMHDAILYSUB A,
			 TMHCODE B, 
			 TMHDAILYSTATUS C 
		   WHERE ( A.AreaCode = C.AreaCode ) And 
			 ( A.DivisionCode = C.DivisionCode ) And 
			 ( A.Workcenter = C.WorkCenter ) And 
			 ( A.WorkDay = C.WorkDay ) And 
			 ( A.mhGubun *= B.mhGubun ) And 
			 ( A.mhCode *= B.mhCode ) And 
			 ( ( A.AreaCode = @ps_area ) AND  
		           ( A.DivisionCode = @ps_div ) AND  
		           ( A.WorkCenter like @ps_wc ) AND  
		           ( ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) ) AND  
		           ( A.mhGubun in ( 'U', 'F', 'G', 'B' ) ) And 
			   ( C.DailyStatus = '1' ) ) 
		Group By A.mhCode, B.mhName 


	If @ps_retCondition = '1'	-- 조별
	     Insert Into #Temp_notOperation 
		  SELECT A.WorkCenter, 
			 '', 
			 A.mhCode,   
			 B.mhName, 
		         sum(A.subMH)  
		    FROM TMHDAILYSUB A,
			 TMHCODE B, 
			 TMHDAILYSTATUS C 
		   WHERE ( A.AreaCode = C.AreaCode ) And 
			 ( A.DivisionCode = C.DivisionCode ) And 
			 ( A.WorkCenter = C.WorkCenter ) And 
			 ( A.WorkDay = C.WorkDay ) And 
			 ( A.mhGubun *= B.mhGubun ) And 
			 ( A.mhCode *= B.mhCode ) And 
		   	 ( ( A.AreaCode = @ps_area ) AND  
		           ( A.DivisionCode = @ps_div ) AND  
		           ( A.WorkCenter like @ps_wc ) AND  
		           ( ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) ) AND  
		           ( A.mhGubun in ( 'U', 'F', 'G', 'B' ) ) And 
			   ( C.DailyStatus = '1' ) ) 
		Group By A.WorkCenter, A.mhCode, B.mhName 

	If @ps_retCondition = '2'	-- 공수구분별
	     Insert Into #Temp_notOperation 
		  SELECT '', 
			 A.mhGubun, 
			 A.mhCode,   
			 B.mhName, 
		         sum(A.subMH)  
		    FROM TMHDAILYSUB A,
			 TMHCODE B, 
			 TMHDAILYSTATUS C 
		   WHERE ( A.AreaCode = C.AreaCode ) And 
			 ( A.DivisionCode = C.DivisionCode ) And 
			 ( A.WorkCenter = C.WorkCenter ) And 
			 ( A.WorkDay = C.WorkDay ) And 
			 ( A.mhGubun *= B.mhGubun ) And 
			 ( A.mhCode *= B.mhCode ) And 
		   	 ( ( A.AreaCode = @ps_area ) AND  
		           ( A.DivisionCode = @ps_div ) AND  
		           ( A.WorkCenter like @ps_wc ) AND  
		           ( ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) ) AND  
		           ( A.mhGubun in ( 'U', 'F', 'G', 'B' ) ) And 
			   ( C.DailyStatus = '1' ) ) 
		Group By A.mhGubun, A.mhCode, B.mhName 

	If @ps_retCondition = '3'	-- 조별 & 공수구분별 
	     Insert Into #Temp_notOperation 
		  SELECT A.WorkCenter, 
			 A.mhGubun, 
			 A.mhCode,   
			 B.mhName, 
		         sum(A.subMH)  
		    FROM TMHDAILYSUB A,
			 TMHCODE B, 
			 TMHDAILYSTATUS C 
		   WHERE ( A.AreaCode = C.AreaCode ) And 
			 ( A.DivisionCode = C.DivisionCode ) And 
			 ( A.WorkCenter = C.WorkCenter ) And 
			 ( A.WorkDay = C.WorkDay ) And 
			 ( A.mhGubun *= B.mhGubun ) And 
			 ( A.mhCode *= B.mhCode ) And 
		   	 ( ( A.AreaCode = @ps_area ) AND  
		           ( A.DivisionCode = @ps_div ) AND  
		           ( A.WorkCenter like @ps_wc ) AND  
		           ( ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) ) AND  
		           ( A.mhGubun in ( 'U', 'F', 'G', 'B' ) ) And 
			   ( C.DailyStatus = '1' ) ) 
		Group By A.WorkCenter, A.mhGubun, A.WorkCenter, A.mhCode, B.mhName 

	Select @totMH = sum(subMH) From #Temp_notOperation 

	SELECT A.WorkCenter,
	       C.WorkCenterName,
	       A.mhGubun,
	       A.mhCode, 
	       A.mhName,   
	       A.subMH, 
	       Case @totMH When 0 Then 0 Else
		    round( A.subMH / @totMH * 100, 1 ) End rate 
          FROM #Temp_notOperation A, 
	       TMSTWORKCENTER C 	 
         WHERE ( C.AreaCode = @ps_area ) And 
	       ( C.DivisionCode = @ps_div ) And 
	       ( A.WorkCenter *= C.WorkCenter ) 
	  Order By rate desc 

Drop Table #Temp_notOperation
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

