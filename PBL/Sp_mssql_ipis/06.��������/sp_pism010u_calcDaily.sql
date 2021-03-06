SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_calcDaily]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_calcDaily]
GO







/*****************************/
/*     작업일보 공수 집계    */
/*****************************/ 

CREATE PROCEDURE sp_pism010u_calcDaily
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wday	Char(10), 		-- 작업일자
	@ri_Error	int Output 

AS 
BEGIN 

-- 평가제외 무급 

	Update TMHDAILY 
	   Set excunpaidMH = IsNull(A.excunpaidMH,0) 
	  From ( Select EmpGubun, Sum(IsNull(subMH,0)) as excunpaidMH From TMHDAILYDETAIL B, TMHCODE C
		 Where ( B.mhGubun = C.mhGubun ) And ( B.mhCode = C.mhCode ) And
		       ( ( B.AreaCode = @ps_area ) And ( B.DivisionCode = @ps_div ) And 
		         ( B.WorkCenter = @ps_wc ) And ( B.WorkDay = @ps_wday ) And 
		         ( B.mhGubun = 'K' ) And ( C.mhLevel = 3 ) ) Group By B.EmpGubun ) A 
 	 Where ( TMHDAILY.AreaCode = @ps_area ) And ( TMHDAILY.DivisionCode = @ps_div ) And
	       ( TMHDAILY.WorkCenter = @ps_wc ) And ( TMHDAILY.WorkDay = @ps_wday ) And 
	       ( TMHDAILY.EmpGubun = A.EmpGubun )  
	If @@Error <> 0 Goto Exit_pr 

-- 평가제외 유급 

	Update TMHDAILY 
	   Set excpaidMH = IsNull(A.excpaidMH,0) 
	  From ( Select EmpGubun, Sum(IsNull(subMH,0)) as excpaidMH From TMHDAILYDETAIL B, TMHCODE C
		 Where ( B.mhGubun = C.mhGubun ) And ( B.mhCode = C.mhCode ) And
		       ( ( B.AreaCode = @ps_area ) And ( B.DivisionCode = @ps_div ) And 
		         ( B.WorkCenter = @ps_wc ) And ( B.WorkDay = @ps_wday ) And 
		         ( B.mhGubun = 'S' ) And ( C.mhLevel = 3 ) ) Group By B.EmpGubun ) A 
 	 Where ( TMHDAILY.AreaCode = @ps_area ) And ( TMHDAILY.DivisionCode = @ps_div ) And
	       ( TMHDAILY.WorkCenter = @ps_wc ) And ( TMHDAILY.WorkDay = @ps_wday ) And 
	       ( TMHDAILY.EmpGubun = A.EmpGubun )  
	If @@Error <> 0 Goto Exit_pr 

-- 유급근태사고 

	Update TMHDAILY 
	   Set gunteMH = IsNull(A.gunteMH,0) 
	  From ( Select EmpGubun, Sum(IsNull(subMH,0)) as gunteMH From TMHDAILYDETAIL B, TMHCODE C
		 Where ( B.mhGubun = C.mhGubun ) And ( B.mhCode = C.mhCode ) And
		       ( ( B.AreaCode = @ps_area ) And ( B.DivisionCode = @ps_div ) And 
		         ( B.WorkCenter = @ps_wc ) And ( B.WorkDay = @ps_wday ) And 
		         ( B.mhGubun = 'B' ) And ( C.mhLevel = 3 ) ) Group By B.EmpGubun ) A 
 	 Where ( TMHDAILY.AreaCode = @ps_area ) And ( TMHDAILY.DivisionCode = @ps_div ) And
	       ( TMHDAILY.WorkCenter = @ps_wc ) And ( TMHDAILY.WorkDay = @ps_wday ) And 
	       ( TMHDAILY.EmpGubun = A.EmpGubun )  
	If @@Error <> 0 Goto Exit_pr 

-- 일보사고 

	Update TMHDAILY 
	   Set ilboMH = IsNull(A.ilboMH,0) 
	  From ( Select EmpGubun, Sum(IsNull(subMH,0)) as ilboMH From TMHDAILYDETAIL B, TMHCODE C
		 Where ( B.mhGubun = C.mhGubun ) And ( B.mhCode = C.mhCode ) And
		       ( ( B.AreaCode = @ps_area ) And ( B.DivisionCode = @ps_div ) And 
		         ( B.WorkCenter = @ps_wc ) And ( B.WorkDay = @ps_wday ) And 
		         ( B.mhGubun = 'G' ) And ( C.mhLevel = 3 ) ) Group By B.EmpGubun ) A 
 	 Where ( TMHDAILY.AreaCode = @ps_area ) And ( TMHDAILY.DivisionCode = @ps_div ) And
	       ( TMHDAILY.WorkCenter = @ps_wc ) And ( TMHDAILY.WorkDay = @ps_wday ) And 
	       ( TMHDAILY.EmpGubun = A.EmpGubun )  
	If @@Error <> 0 Goto Exit_pr 

-- 총투입공수, 실투입공수 재계산 

  UPDATE TMHDAILY  
     SET totInMH = IsNull( totmh, 0 ) - ( isNull( excunpaidmh, 0 ) + isNull( excpaidmh, 0 ) ), 
         ActInMH = ( isNull( totmh, 0 ) - ( isNull( excunpaidmh, 0 ) + isNull( excpaidmh, 0 ) ) ) - 
		   ( isNull( guntemh, 0 ) + isNull( ilbomh, 0 ) + isNull( bugamh, 0 ) ) 
   WHERE ( TMHDAILY.AreaCode = @ps_area ) AND  
         ( TMHDAILY.DivisionCode = @ps_div ) AND  
         ( TMHDAILY.WorkCenter = @ps_wc ) AND  
         ( TMHDAILY.WorkDay = @ps_wday ) 

Exit_pr:

Select	@ri_Error	= @@Error
 Return @ri_Error

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

