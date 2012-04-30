SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism030u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism030u_01]
GO








/**************************/
/*     Routing Sheet      */
/**************************/ 

CREATE PROCEDURE sp_pism030u_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_dispday	Char(10) 		-- Disp일자 

AS 
BEGIN 

  SELECT A.AreaCode,   
	 A.DivisionCode,   
	 A.WorkCenter,   
	 E.WorkCenterName, 
	 A.ApplyDate,   
	 B.ProductGroup, 
	 D.ProductGroupName,   
	 A.ItemCode,   
	 C.ItemName,   
	 C.ItemSpec, 
	 A.SubLineCode,   
	 A.SubLineNo,   
	 A.BasicTime 
     FROM VROUTBASICTIME A,
          TMSTMODEL B,   
          TMSTITEM C,   
          TMSTPRODUCTGROUP D, 
	  TMSTWORKCENTER E 
    WHERE ( A.AreaCode = E.AreaCode ) And 
	  ( A.DivisionCode = E.DivisionCode ) And 
	  ( A.WorkCenter = E.WorkCenter ) And 
	  ( A.AreaCode = B.AreaCode ) and  
          ( A.DivisionCode = B.DivisionCode ) and  
	  ( A.ItemCode = B.ItemCode ) And 
          ( B.ItemCode = C.ItemCode ) and  
          ( A.AreaCode = D.AreaCode ) and  
          ( A.DivisionCode = D.DivisionCode ) and  
          ( B.ProductGroup = D.ProductGroup ) and  
          ( ( A.AreaCode =  @ps_area) AND  
            ( A.DivisionCode = @ps_div ) AND  
            ( A.WorkCenter like @ps_wc ) AND 
            ( A.ApplyDate = ( SELECT max(C.ApplyDate)  
	   		        FROM VROUTBASICTIME C 
 		               WHERE ( C.AreaCode = A.AreaCode ) AND  
				     ( C.DivisionCode = A.DivisionCode ) AND  
				     ( C.WorkCenter = A.WorkCenter ) AND  
				     ( C.ItemCode = A.ItemCode ) And 
				     ( C.subLineCode = A.subLinecode ) And 
				     ( C.subLineNo = A.subLineNo ) And 
				     ( C.ApplyDate <= @ps_dispday ) ) ) And 
	   Not Exists ( SELECT ItemCode 
			  FROM TMHWCITEM  
			 WHERE ( AreaCode = A.AreaCode  ) AND  
			       ( DivisionCode = A.DivisionCode ) AND  
			       ( WorkCenter = A.WorkCenter ) AND  
			       ( ItemCode = A.ItemCode ) AND  
			       ( subLineCode = A.SubLinecode ) AND  
			       ( subLineNo = A.SubLineNo ) ) ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

