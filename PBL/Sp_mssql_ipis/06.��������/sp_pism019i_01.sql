SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism019i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism019i_01]
GO







/***************************************/ 
/*     작업일보 미작성 & 미확정현황    */ 
/***************************************/ 

CREATE PROCEDURE sp_pism019i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc 		Varchar(5),		-- 조 
	@ps_stMonth	Char(7)			-- 기준월 
AS
BEGIN


-- 미확정분 
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
	   ( A.WorkCenter = @ps_wc ) And 
	   ( A.DailyStatus = '0' ) And 
	   ( IsNull(B.WorkCenterGubun1,'') = 'K' ) And 
	   ( IsNull(B.WorkCenterGubun2,'') <> '' ) ) 
Union
-- 미작성분 
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
	  ( A.DGDEPTE = @ps_wc ) AND 
	  ( A.DGDAY In ( SELECT ApplyDate FROM TCALENDARSHOP 
			  WHERE ( AreaCode = @ps_area ) AND  
			        ( DivisionCode = @ps_div ) AND 
				( WorkGubun = 'W' ) ) ) And 
	  ( ( SELECT Count(dgempno) FROM TMHLABTAC  
	       WHERE ( DGDAY = A.DGDAY ) AND ( DGDEPTE = A.DGDEPTE ) AND 
		     ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) ) = 0 ) And 		-- 작업일 
	  ( IsNull(A.DGCD2R,'') + IsNull(A.DGCD3R,'') in ( '', '21' ) ) And 
	  ( IsNull(A.excFlag,'') = '' ) And 
	  ( IsNull(A.DGTIMER, 0) > 0 ) And 
	   ( IsNull(B.WorkCenterGubun1,'') = 'K' ) And 
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
	  ( A.DGDEPTE = @ps_wc ) AND 
--	  ( substring(A.DGDAY,1,7) = @ps_stMonth ) AND 
	  ( ( SELECT Count(dgempno) FROM TMHLABTAC  
	       WHERE ( DGDAY = A.DGDAY ) AND ( DGDEPTE = A.DGDEPTE ) AND 
		     ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) And ( IsNull(excFlag,'') = '' ) And 
		       ( IsNull(DGCD2R,'') + IsNull(DGCD3R,'') in ( '', '21' ) ) ) > 0 ) And 		-- 휴무일 
	  ( IsNull(B.WorkCenterGubun1,'') = 'K' ) And 
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

