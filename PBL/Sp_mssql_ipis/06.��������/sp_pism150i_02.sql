SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism150i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism150i_02]
GO







/*****************************************************/ 
/*     조별 부가작업/유휴/능률저하 발생내역 - 전체   */ 
/*****************************************************/ 

CREATE PROCEDURE sp_pism150i_02
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조 
	@ps_stFromDate	Char(10),		-- 기준일 From
	@ps_stToDate	Char(10),		-- 기준일 To 
	@ps_mhGubun	Char(1) 
AS
BEGIN

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkDay,   
         A.mhGubun,   
         A.mhCode,   
         B.mhName,   
         sum(IsNull(A.subMH,0)) submh_s
    FROM TMHDAILYSUB A,   
         TMHCODE B,   
         TMSTWORKCENTER C, 
	 TMHDAILYSTATUS D 
   WHERE ( A.AreaCode = C.AreaCode ) and  
         ( A.DivisionCode = C.DivisionCode ) and  
         ( A.WorkCenter = C.WorkCenter ) and  
         ( A.mhGubun = B.mhGubun ) and  
         ( A.mhCode = B.mhCode ) and  
	 ( A.AreaCode = D.AreaCode ) And 
	 ( A.DivisionCode = D.DivisionCode ) And 
	 ( A.WorkCenter = D.WorkCenter ) And 
	 ( A.WorkDay = D.WorkDay ) And 
         ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
	   ( A.WorkCenter like @ps_wc ) And 
	   ( A.mhGubun like @ps_mhGubun ) And 
	   ( A.WorkDay BETWEEN @ps_stFromDate AND @ps_stToDate ) And 
	   ( D.DailyStatus = '1' ) ) 
 Group By A.AreaCode,   
          A.DivisionCode,   
          A.WorkDay,   
          A.mhGubun,   
          A.mhCode,   
          B.mhName 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

