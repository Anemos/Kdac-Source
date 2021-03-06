SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism210i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism210i_01]
GO







/******************************************/ 
/*     월별 제품단위당 실투입공수 조회    */ 
/******************************************/ 

CREATE PROCEDURE sp_pism210i_01 
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_prodGroup	Varchar(4),		-- 제품군 
	@ps_modGroup	Char(3),		-- 모델군 
	@ps_dispDay	Char(10)		-- 기준년도 
AS
BEGIN

 Declare @actInMH	Numeric(6,1) 

  Select substring(sMonth,6,2) sMonth, 
	 ItemCode, 
	 Sum( IsNull(pQty,0) ) pQty,
	 Sum( IsNull(ActInMH,0) ) actInMH 
    Into #Temp_sYear 
    From TMHMONTHPROD_S
   Where ( AreaCode = @ps_area ) And 
	 ( DivisionCode = @ps_div ) And 
	 ( substring(sMonth,1,4) = substring(@ps_dispDay,1,4) ) 
Group By substring(sMonth,6,2), ItemCode 

  SELECT B.AreaCode, 
         B.DivisionCode,   
	 A.sMonth, 
         B.BMDCD ProductGroup,
	 F.ProductGroupName, 
	 E.ModelGroup, 
       ( Select ModelGroupName From TMSTMODELGROUP 
	  Where ( Areacode = B.AreaCode ) And 
		( DivisionCode = B.DivisionCode ) And 
		( ProductGroup = B.BMDCD ) And 
		( ModelGroup = E.ModelGroup ) ) ModelGroupName, 
	 B.BMDNO ItemCode,
	 D.ItemName,
	 D.ItemSpec,
	 IsNull(C.stockQty,0) stockQty,  
	 sum( ( Case IsNull(A.pQty,0) When 0 Then 0 Else
		( IsNull(B.BPRQT,0) * IsNull(C.stockQty,0) ) / 
		  IsNull(A.pQty,0) End ) * IsNull(A.actInMH,0) ) tot_actMH 
    Into #Temp_actInMH 
    FROM #Temp_sYear A,   
         TMSTBOMDATA B, 
       ( Select substring(TraceDate,6,2) sMonth, 
		ItemCode, 
		Sum( IsNull(StockQty,0) ) stockQty 
	   From TLOTNO 
	  Where ( AreaCode = @ps_area ) And 
		( DivisionCode = @ps_div ) And 
		( substring(TraceDate, 1, 4) = substring(@ps_dispDay,1,4) ) 
       Group By substring(TraceDate,6,2), ItemCode ) C, 
	 TMSTITEM D, 
	 TMSTMODEL E, 
	 TMSTPRODUCTGROUP F 
   WHERE ( B.AreaCode *= E.AreaCode ) And 
	 ( B.DivisionCode *= E.DivisionCode ) And 
	 ( B.BMDCD *= E.ProductGroup ) And 
	 ( B.BMDNO *= E.ItemCode ) And 
	 ( B.AreaCode *= F.AreaCode ) And 
	 ( B.DivisionCode *= F.DivisionCode ) And 
	 ( B.BMDCD *= F.ProductGroup ) And 
	 ( B.BCHNO = A.ItemCode ) And 
	 ( A.sMonth *= C.sMonth ) And 
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
				 ( BFMDT <= @ps_dispDay ) ) ) ) 
Group By B.AreaCode,   
         B.DivisionCode,   
	 A.sMonth, 
         B.BMDCD, 
	 F.ProductGroupName, 
	 E.ModelGroup, 
	 B.BMDNO,
	 D.ItemName,
	 D.ItemSpec,
	 C.stockQty

 Select AreaCode, 
	DivisionCode, 
	ProductGroup,
	ProductGroupName,
	ModelGroup,
	ModelGroupName, 
	ItemCode,
	ItemName,
	ItemSpec, 
	sum(IsNull(tot_actMH,0)) tot_actMH, 
	@actInMH m01,
	@actInMH m02,
	@actInMH m03,
	@actInMH m04,
	@actInMH m05,
	@actInMH m06,
	@actInMH m07,
	@actInMH m08,
	@actInMH m09,
	@actInMH m10,
	@actInMH m11,
	@actInMH m12 
   Into #Temp_actInMH_disp 
   From #Temp_actInMH 
 Group By AreaCode, 
	DivisionCode, 
	ProductGroup,
	ProductGroupName,
	ModelGroup,
	ModelGroupName, 
	ItemCode,
	ItemName,
	ItemSpec 

  Update #Temp_actInMH_disp
     Set m01 = Case B.sMonth When '01' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m02 = Case B.sMonth When '02' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m03 = Case B.sMonth When '03' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m04 = Case B.sMonth When '04' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m05 = Case B.sMonth When '05' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m06 = Case B.sMonth When '06' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m07 = Case B.sMonth When '07' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m08 = Case B.sMonth When '08' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m09 = Case B.sMonth When '09' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m10 = Case B.sMonth When '10' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m11 = Case B.sMonth When '11' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End, 
	 m12 = Case B.sMonth When '12' Then Case B.stockQty When 0 Then 0 Else B.tot_actMH / B.stockQty End 
				       Else 0 End  
    From #Temp_actInMH_disp A, #Temp_actInMH B 
   Where ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
	 ( A.ProductGroup = B.ProductGroup ) And 
	 ( A.ItemCode = B.ItemCode ) 

 Select * From #Temp_actInMH_disp 

Drop Table #Temp_actInMH 
Drop Table #Temp_sYear 
Drop Table #Temp_actInMH_disp 

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

