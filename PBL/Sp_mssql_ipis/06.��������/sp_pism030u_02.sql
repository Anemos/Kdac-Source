SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism030u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism030u_02]
GO





/********************************/
/*    조별 생산모델 유사그룹    */
/********************************/ 

CREATE PROCEDURE sp_pism030u_02
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wcGroup	VarChar(30), 		-- 유사군 
	@ps_dispday	Char(10) 

AS 
BEGIN 
  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
	 C.WorkCenterName, 
         A.ItemCode,   
         B.ItemName,   
         B.ItemSpec, 
         A.subLineCode,   
         A.subLineNo,   
         A.wcItemGroup,   
         A.Seq,   
         A.UseFlag,
	 D.BasicTime, 
	 A.LastEmp, 
	 A.LastDate 
    FROM TMHWCITEM A, TMSTITEM B, TMSTWORKCENTER C, VROUTBASICTIME D 
   WHERE ( A.AreaCode = C.AreaCode ) And 
	 ( A.DivisionCode = C.DivisionCode ) And 
	 ( A.WorkCenter = C.WorkCenter ) And 
	 ( A.ItemCode = B.ItemCode ) and  
	 ( A.AreaCode = D.AreaCode ) And 
	 ( A.DivisionCode = D.DivisionCode ) And 
	 ( A.WorkCenter = D.WorkCenter ) And 
	 ( A.ItemCode = D.ItemCode ) And 
	 ( A.subLineCode = D.subLineCode ) And 
	 ( A.subLineNo = D.subLineNo ) And 
         ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
           ( A.WorkCenter like @ps_wc ) AND  
           ( IsNull(A.wcItemGroup, '') like @ps_wcGroup ) And 
	   ( IsNull(A.useFlag,'0') <> '3' ) And 
       	   ( D.ApplyDate = ( SELECT max(ApplyDate)  
			       FROM VROUTBASICTIME 
		              WHERE ( AreaCode = A.AreaCode ) AND  
				    ( DivisionCode = A.DivisionCode ) AND  
				    ( WorkCenter = A.WorkCenter ) AND  
				    ( ItemCode = A.ItemCode ) And 
				    ( subLineCode = A.subLineCode ) And 
				    ( subLineNo = A.subLineNo ) And 
				    ( ApplyDate <= @ps_dispday ) ) ) ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

