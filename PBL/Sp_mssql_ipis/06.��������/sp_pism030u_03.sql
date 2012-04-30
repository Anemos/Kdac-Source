SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism030u_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism030u_03]
GO








/*****************************************/
/*    조별 Routing & 생산모델 유사그룹   */
/*****************************************/ 

CREATE PROCEDURE sp_pism030u_03 
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_dispDay	Char(10) 		-- 기준일자 

AS 
BEGIN 

  SELECT A.AreaCode,   
	 A.DivisionCode,   
	 A.WorkCenter,   
	 E.WorkCenterName, 
	 A.ApplyDate,   
	 IsNull(F.wcItemGroup,'') wcItemGroup, 
	 B.ProductGroup, 
	 D.ProductGroupName,   
	 A.ItemCode,   
	 C.ItemName,   
	 C.ItemSpec, 
	 A.SubLineCode,   
	 A.SubLineNo,   
	 A.BasicTime,
	 IsNull(F.Seq,0) Seq 
    FROM VROUTBASICTIME A,
         TMSTMODEL B,   
         TMSTITEM C,   
         TMSTPRODUCTGROUP D, 
	 TMSTWORKCENTER E, 
	 TMHWCITEM F 
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
	  ( A.AreaCode *= F.AreaCode ) And 
	  ( A.DivisionCode *= F.DivisionCode ) And 
	  ( A.WorkCenter *= F.WorkCenter ) And 
	  ( A.ItemCode *= F.ItemCode ) And 
	  ( A.subLineCode *= F.subLineCode ) And 
	  ( A.subLineNo *= F.subLineNo ) And 
          ( ( A.AreaCode =  @ps_area ) AND  
            ( A.DivisionCode = @ps_div ) AND  
            ( A.WorkCenter = @ps_wc ) AND 
	    ( IsNull(F.useFlag,'0') <> '3' ) And 
            ( A.ApplyDate = ( SELECT max(C.ApplyDate)  
	   		        FROM VROUTBASICTIME C 
 		               WHERE ( C.AreaCode = A.AreaCode ) AND  
				     ( C.DivisionCode = A.DivisionCode ) AND  
				     ( C.WorkCenter = A.WorkCenter ) AND  
				     ( C.ItemCode = A.ItemCode ) And 
				     ( C.subLineCode = A.subLineCode ) And 
				     ( C.subLineNo = A.subLineNo ) And 
				     ( C.ApplyDate <= @ps_dispDay ) ) ) ) 
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

