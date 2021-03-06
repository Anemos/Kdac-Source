SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eism030i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eism030i_01]
GO


/***********************/ 
/*     비가동 WORST    */ 
/***********************/ 

CREATE PROCEDURE sp_eism030i_01 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장	
	@ps_stMonth		Char(7),		-- 기준년월 
	@ps_mhGubun		Char(1)			-- 공수구분 
AS
BEGIN

Declare @totMH	Numeric(6,1) 

	CREATE TABLE #Temp_notOperation
	(
		MHGubun		Char(1)		null,
		MHCode 		Char(2)		null,
		MHName 		VarChar(20)	null, 
		subMH		Numeric(4,1)	null 
	)


	     Insert Into #Temp_notOperation 
		  SELECT A.mhGubun, 
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
		           ( ( substring(A.WorkDay, 1, 7) = @ps_stMonth ) ) AND  
		           ( A.mhGubun = @ps_mhGubun ) And 
			   ( C.DailyStatus = '1' ) ) 
		Group By A.mhGubun, A.mhCode, B.mhName 

	Select @totMH = sum(subMH) From #Temp_notOperation 

	SELECT A.mhGubun,
	       A.mhCode, 
	       A.mhName,   
	       A.subMH, 
	       Case @totMH When 0 Then 0 Else
		    round( A.subMH / @totMH * 100, 1 ) End rate 
          FROM #Temp_notOperation A  
	  Order By rate desc 

Drop Table #Temp_notOperation
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

