SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism200i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism200i_02]
GO








/************************************************/ 
/*     완제품내 하위 품번별 실투입 공수 조회    */ 
/************************************************/ 

CREATE PROCEDURE sp_pism200i_02 
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_modItem	Varchar(12),		-- 완제품 코드 
	@ps_FromDate	Char(10),		-- FromDate
	@ps_ToDate	Char(10)		-- ToDate 
AS
BEGIN

  SELECT B.AreaCode,   
         B.DivisionCode,   
         B.BCHNO,   
         C.ItemName,   
         C.ItemSpec,   
         IsNull(D.pQty,0), 
         IsNull(D.actInMH,0) 
    FROM TMSTBOMDATA B,  
         TMSTITEM C, 
       ( Select ItemCode, 
		Sum(IsNull(A.daypQty,0) + IsNull(A.nightpQty,0) ) pQty, 
		Sum(IsNull(A.ActInMH,0)) actInMH 
	   From TMHREALPROD A, TMHDAILYSTATUS B 
	  Where ( A.AreaCode = B.AreaCode ) And 
		( A.DivisionCode = B.DivisionCode ) And 
		( A.WorkCenter = B.WorkCenter ) And 
		( A.WorkDay = B.WorkDay ) And 
		( ( A.AreaCode = @ps_area ) And 
		  ( A.DivisionCode = @ps_div ) And 
		  ( A.WorkDay Between @ps_FromDate And @ps_ToDate ) ) 
       Group By ItemCode ) D 
   WHERE ( B.BCHNO = C.ItemCode ) And 
	 ( B.BCHNO *= D.ItemCode ) And 
         ( ( B.AreaCode = @ps_area ) AND  
           ( B.DivisionCode = @ps_div ) AND  
           ( B.BMDNO = @ps_modItem ) And 
	   ( B.BFMDT = (  SELECT max(BFMDT)  
		            FROM TMSTBOMDATA  
			   WHERE ( AreaCode = B.AreaCode ) AND  
				 ( DivisionCode = B.DivisionCode ) AND  
				 ( BMDCD = B.BMDCD ) AND  
				 ( BMDNO = B.BMDNO ) And 
				 ( BFMDT <= @ps_ToDate ) ) ) ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

