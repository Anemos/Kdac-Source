SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism210i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism210i_02]
GO







/***************************************************/ 
/*     월별 제품내 하위 품번별 실투입 공수 조회    */ 
/***************************************************/ 

CREATE PROCEDURE sp_pism210i_02 
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_modItem	Varchar(12),		-- 완제품 코드 
	@ps_dispDay	Char(10)		-- 기준월
AS
BEGIN

 Declare @actInMH	numeric(6,1) 

  SELECT B.AreaCode,   
         B.DivisionCode,   
	 D.sMonth, 
         B.BCHNO ItemCode,   
         C.ItemName,   
         C.ItemSpec,   
         IsNull(D.pQty,0) pQty, 
         IsNull(D.actInMH,0) actInMH 
    Into #Temp_actInMH 
    FROM TMSTBOMDATA B,  
         TMSTITEM C, 
       ( Select substring(sMonth,6,2) sMonth,
		ItemCode, 
		Sum(IsNull(pQty,0)) pQty, 
		Sum(IsNull(ActInMH,0)) actInMH 
	   From TMHMONTHPROD_S 
	  Where ( AreaCode = @ps_area ) And 
		( DivisionCode = @ps_div ) And 
		( sMonth = substring(@ps_dispDay,1,4) ) 
       Group By substring(sMonth,6,2), ItemCode ) D 
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
				 ( BFMDT <= @ps_dispDay ) ) ) ) 

 Select AreaCode, 
	DivisionCode, 
	ItemCode,
	ItemName,
	ItemSpec, 
	sum(IsNull(pQty,0)) tot_pQty, 
	sum(IsNull(actInMH,0)) tot_actInMH, 
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
	ItemCode,
	ItemName,
	ItemSpec 

  Update #Temp_actInMH_disp
     Set m01 = Case B.sMonth When '01' Then B.actInMH / B.pQty Else 0 End, 
	 m02 = Case B.sMonth When '02' Then B.actInMH / B.pQty Else 0 End, 
	 m03 = Case B.sMonth When '03' Then B.actInMH / B.pQty Else 0 End, 
	 m04 = Case B.sMonth When '04' Then B.actInMH / B.pQty Else 0 End, 
	 m05 = Case B.sMonth When '05' Then B.actInMH / B.pQty Else 0 End, 
	 m06 = Case B.sMonth When '06' Then B.actInMH / B.pQty Else 0 End, 
	 m07 = Case B.sMonth When '07' Then B.actInMH / B.pQty Else 0 End, 
	 m08 = Case B.sMonth When '08' Then B.actInMH / B.pQty Else 0 End, 
	 m09 = Case B.sMonth When '09' Then B.actInMH / B.pQty Else 0 End, 
	 m10 = Case B.sMonth When '10' Then B.actInMH / B.pQty Else 0 End, 
	 m11 = Case B.sMonth When '11' Then B.actInMH / B.pQty Else 0 End, 
	 m12 = Case B.sMonth When '12' Then B.actInMH / B.pQty Else 0 End 
    From #Temp_actInMH_disp A, #Temp_actInMH B 
   Where ( A.AreaCode = B.AreaCode ) And 
	 ( A.DivisionCode = B.DivisionCode ) And 
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

