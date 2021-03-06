SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism200i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism200i_01]
GO







/*****************************************/ 
/*     완제품 단위당 실투입 공수 조회    */ 
/*****************************************/ 

CREATE PROCEDURE sp_pism200i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_prodGroup   VarChar(2),		-- 제품군 
	@ps_modGroup	Char(3),		-- 모델군 
	@ps_FromDate	Char(10),		-- FromDate
	@ps_ToDate	Char(10)		-- ToDate 
AS
BEGIN

  Select ItemCode, 
	 Sum( IsNull(daypQty,0) + IsNull(nightpQty,0) ) pQty,
	 Sum( IsNull(ActInMH,0) ) actInMH 
    Into #Temp_sMonth 
    From TMHREALPROD 
   Where ( AreaCode = @ps_area ) And 
	 ( DivisionCode = @ps_div ) And 
	 ( WorkDay Between @ps_FromDate And @ps_ToDate ) And 
	 ( IsNull(ActInMH,0) > 0 ) 
Group By ItemCode ;

  SELECT B.AreaCode, 
         B.DivisionCode,   
         B.BMDCD,
	 F.ProductGroupName, 
	 E.ModelGroup, 
       ( Select ModelGroupName From TMSTMODELGROUP 
	  Where ( Areacode = B.AreaCode ) And 
		( DivisionCode = B.DivisionCode ) And 
		( ProductGroup = B.BMDCD ) And 
		( ModelGroup = E.ModelGroup ) ) ModelGroupName, 
	 B.BMDNO,
	 D.ItemName,
	 D.ItemSpec,
	 IsNull(C.stockQty,0) stockQty,  
         sum( ( IsNull(A.actInMH,0) ) / 
		IsNull(A.pQty,0) * IsNull(B.BPRQT,0) * IsNull(C.StockQty,0) ), 
	  sum(IsNull(A.actInMH,0)) 
    FROM #Temp_sMonth A,   
         TMSTBOMDATA B, 
       ( Select ItemCode, Sum( IsNull(StockQty,0) ) stockQty 
	   From TLOTNO 
	  Where ( AreaCode = @ps_area ) And 
		( DivisionCode = @ps_div ) And 
		( TraceDate Between @ps_FromDate And @ps_ToDate )  
       Group By ItemCode ) C, 
	 TMSTITEM D, 
	 TMSTMODEL E, 
	 TMSTPRODUCTGROUP F 
   WHERE ( B.AreaCode = E.AreaCode ) And 
	 ( B.DivisionCode = E.DivisionCode ) And 
	 ( B.BMDCD = E.ProductGroup ) And 
	 ( B.BMDNO = E.ItemCode ) And 
	 ( B.AreaCode = F.AreaCode ) And 
	 ( B.DivisionCode *= F.DivisionCode ) And 
	 ( B.BMDCD = F.ProductGroup ) And 
	 ( B.BCHNO = A.ItemCode ) And 
	 ( B.BMDNO *= C.ItemCode ) And
	 ( B.BMDNO = D.ItemCode ) And 
	 ( ( B.AreaCode = @ps_area ) And 
	   ( B.DivisionCode = @ps_div ) And 
           ( B.BMDCD = @ps_prodGroup ) And 
	   ( E.ModelGroup like @ps_modGroup ) And 
	   ( B.BFMDT = (  SELECT max(BFMDT)  
		            FROM TMSTBOMDATA  
			   WHERE ( AreaCode = B.AreaCode ) AND  
				 ( DivisionCode = B.DivisionCode ) AND  
				 ( BMDCD = B.BMDCD ) AND  
				 ( BMDNO = B.BMDNO ) And 
				 ( BFMDT <= @ps_ToDate ) ) ) ) 
Group By B.AreaCode,   
         B.DivisionCode,   
         B.BMDCD, 
	 F.ProductGroupName, 
	 E.ModelGroup, 
	 B.BMDNO,
	 D.ItemName,
	 D.ItemSpec,
	 C.stockQty

Drop Table #Temp_sMonth 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

