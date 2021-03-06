SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_08]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_08]
GO







/******************************/
/*     작업일보 세부공수      */
/******************************/

CREATE PROCEDURE sp_pism010u_08
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wday	Char(10),		-- 작업일자
	@ps_mhGbn 	Char(1) 		-- 공수구분 

AS
BEGIN

  SELECT  '1' EmpGbn, 
	   A.DivisionCode ,
           A.AreaCode ,
	   A.WorkCenter ,
	   A.WorkDay ,
	   A.subMH ,
	   B.MHGubun ,
	   B.MHCode ,
	   B.MHName ,
	   B.PrintSq,
	   Case When ( SELECT totMH FROM TMHDAILY  
		        WHERE ( AreaCode = @ps_area ) AND  
			      ( DivisionCode = @ps_div ) AND  
			      ( WorkCenter = @ps_wc ) AND  
			      ( WorkDay = @ps_wday ) AND  
			      ( EmpGubun = '1' ) ) > 0 Then B.inputFlag 
	   Else '0' End inputFlag 
     FROM TMHDAILYDETAIL A, TMHCODE B 
    WHERE ( B.MHGubun *= A.MHGubun) and 
  	  ( B.MHCode *= A.MHCode) and 
	  ( ( A.AreaCode = @ps_area ) and 
	    ( A.DivisionCode = @ps_div ) and 
	    ( A.WorkCenter = @ps_wc ) and 
	    ( A.EmpGubun = '1' ) And 
	    ( A.WorkDay = @ps_wday ) and 
	    ( B.MHGubun = @ps_mhGbn ) And ( B.UseFlag = '1' ) ) 

Union

  SELECT  '2' EmpGbn, 
	   A.DivisionCode ,
	   A.AreaCode ,
	   A.WorkCenter ,
	   A.WorkDay ,
	   A.subMH ,
	   B.MHGubun ,
	   B.MHCode ,
	   B.MHName ,
	   B.PrintSq,
	   Case When ( SELECT totMH FROM TMHDAILY  
		        WHERE ( AreaCode = @ps_area ) AND  
			      ( DivisionCode = @ps_div ) AND  
			      ( WorkCenter = @ps_wc ) AND  
			      ( WorkDay = @ps_wday ) AND  
			      ( EmpGubun = '2' ) ) > 0 Then B.inputFlag 
	   Else '0' End inputFlag 
     FROM TMHDAILYDETAIL A, TMHCODE B 
    WHERE ( B.MHGubun *= A.MHGubun) and 
          ( B.MHCode *= A.MHCode) and 
          ( ( A.AreaCode = @ps_area ) and 
            ( A.DivisionCode = @ps_div ) and 
            ( A.WorkCenter = @ps_wc ) and 
	    ( A.EmpGubun = '2' ) And 
            ( A.WorkDay = @ps_wday ) and 
            ( B.MHGubun = @ps_mhGbn ) And ( B.UseFlag = '1' ) ) 
  ORDER BY EmpGbn, B.PrintSq  ASC

END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

