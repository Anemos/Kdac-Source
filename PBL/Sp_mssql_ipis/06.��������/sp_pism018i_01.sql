SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism018i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism018i_01]
GO







/*********************************/ 
/*     작업일보 작성현황 조회    */ 
/*********************************/ 

CREATE PROCEDURE sp_pism018i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc 		Varchar(5),		-- 조 
	@ps_stFromDate	Char(10),		-- 기준일 From
	@ps_stToDate	Char(10)		-- 기준일 To 
AS
BEGIN

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         A.WorkDay,   
	 B.WorkCenterName, 
	 A.DailyStatus, 
	 A.InputTime, 
         A.Remark,   
         A.InputEmp,   
	 C.EmpName, 
         A.LastDate  
    FROM TMHDAILYSTATUS A,
	 TMSTWORKCENTER B,
	 TMSTEMP C 
   WHERE ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.WorkCenter = B.WorkCenter ) And 
	 ( A.InputEmp *= C.EmpNo ) And 
	 ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
	   ( A.WorkCenter like @ps_wc ) And 
           ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) And 
	   ( B.WorkCenterGubun1 = 'K' ) And 
	   ( IsNull(B.WorkCenterGubun2,'') <> '' ) ) 
Union
   SELECT distinct 
	  @ps_area, 
	  @ps_div, 
	  A.DGDEPTE, 
	  A.DGDAY, 
	  B.WorkCenterName, 
	  'X', 
	  NULL, 
	  NULL, 
	  NULL, 
	  NULL, 
	  NULL 
     FROM TMHLABTAC A, TMSTWORKCENTER B 
    WHERE ( B.AreaCode = @ps_area ) And 
	  ( B.DivisionCode = @ps_div ) And 
	  ( B.WorkCenter = A.DGDEPTE ) And 
	  ( A.DGDEPTE like @ps_wc ) AND 
	  ( A.DGDAY Between @ps_stFromDate And @ps_stToDate ) AND 
	  ( ( SELECT Count(dgempno) FROM TMHLABTAC  
	       WHERE ( DGDAY = A.DGDAY ) AND ( DGDEPTE = A.DGDEPTE ) AND 
		     ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) ) = 0 ) And  
	  ( IsNull(A.DGCD1R,'') + IsNull(A.DGCD2R,'') + IsNull(A.DGCD3R,'') = '' ) And 
	  ( IsNull(A.excFlag,'') = '' ) And 
	  ( IsNull(A.DGTIMER, 0) > 0 ) And 
	  ( B.WorkCenterGubun1 = 'K' ) And 
	  ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 
Not Exists ( Select WorkDay From TMHDAILYSTATUS 
	      Where ( AreaCode = @ps_area ) And 
		    ( DivisionCode = @ps_div ) And 
		    ( WorkCenter = A.DGDEPTE ) And 
		    ( WorkDay = A.DGDAY ) ) 
Union
   SELECT distinct 
	  @ps_area, 
	  @ps_div, 
	  A.DGDEPTE, 
	  A.DGDAY, 
	  B.WorkCenterName, 
	  'X', 
	  NULL, 
	  NULL, 
	  NULL, 
	  NULL, 
	  NULL 
     FROM TMHLABTAC A, TMSTWORKCENTER B 
    WHERE ( B.AreaCode = @ps_area ) And 
	  ( B.DivisionCode = @ps_div ) And 
	  ( B.WorkCenter = A.DGDEPTE ) And 
	  ( A.DGDEPTE like @ps_wc ) AND 
	  ( A.DGDAY Between @ps_stFromDate And @ps_stToDate ) AND 
	  ( ( SELECT Count(dgempno) FROM TMHLABTAC  
	       WHERE ( DGDAY = A.DGDAY ) AND ( DGDEPTE = A.DGDEPTE ) AND 
		     ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) And ( IsNull(excFlag,'') = '' ) ) > 0 ) And  
	  ( IsNull(A.DGCD1R,'') + IsNull(A.DGCD2R,'') + IsNull(A.DGCD3R,'') = '' ) And 
	  ( IsNull(A.excFlag,'') = '' ) And 
	  ( IsNull(A.DGTIMER, 0) > 0 ) And 
	  ( B.WorkCenterGubun1 = 'K' ) And 
	  ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 
Not Exists ( Select WorkDay From TMHDAILYSTATUS 
	      Where ( AreaCode = @ps_area ) And 
		    ( DivisionCode = @ps_div ) And 
		    ( WorkCenter = A.DGDEPTE ) And 
		    ( WorkDay = A.DGDAY ) ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

