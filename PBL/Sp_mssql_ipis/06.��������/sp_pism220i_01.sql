SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism220i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism220i_01]
GO







/*********************************************/ 
/*     완제품 단위당 표준시간 개선율 조회    */ 
/*********************************************/ 

CREATE PROCEDURE sp_pism220i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_prodGroup   VarChar(4),		-- 제품군 
	@ps_modGroup	Char(3),		-- 모델군 
	@ps_dispDay	Char(10)		-- 기준월
AS
BEGIN

 Declare @lastYear	Char(4) 

 Set @lastYear = Cast ( Cast( substring(@ps_dispDay, 1, 4) as Numeric(4) ) - 1 as Char(4) )

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
	 sum(IsNull(A.pQty,0)) pQty, 
	 sum(IsNull(C.BasicTime,0)) BasicTime, 
	 sum(IsNull(C.lst_basicTime,0)) lst_basicTime 
    FROM TMHMONTHPROD_S A, 
         TMSTBOMDATA B, 
	( SELECT A.ItemCode, 
		 sum(IsNull(A.BasicTime,0)) BasicTime, 
	       ( Select sum(IsNull(B.BasicTime,0)) 
		   From TMHREALPROD B 
		  Where ( B.AreaCode = A.AreaCode ) And 
			( B.DivisionCode = A.DivisionCode ) And 
			( B.ItemCode = A.ItemCode ) And 
			( B.WorkDay = ( SELECT max(WorkDay) 
					  FROM TMHREALPROD  
	        			 WHERE ( AreaCode = A.AreaCode ) AND  
					       ( DivisionCode = A.DivisionCode ) And 
					       ( substring(WorkDay,1,4) = @lastYear ) ) ) ) lst_basicTime 
	    FROM TMHREALPROD A 
	   WHERE ( A.AreaCode = @ps_area ) And 
		 ( A.DivisionCode = @ps_div ) And 
	         ( A.WorkDay = ( SELECT max(WorkDay) 
	                           FROM TMHREALPROD  
	                          WHERE ( AreaCode = A.AreaCode ) AND  
	                                ( DivisionCode = A.DivisionCode ) And 
					( ItemCode = A.ItemCode ) And 
					( substring(WorkDay,1,7) = substring(@ps_dispDay,1,7) ) ) ) 
	Group By A.AreaCode, A.DivisionCode, A.ItemCode ) C, 
	 TMSTITEM D, 
	 TMSTMODEL E, 
	 TMSTPRODUCTGROUP F 
   WHERE ( B.AreaCode *= A.AreaCode ) ANd 
	 ( B.DivisionCode *= A.DivisionCode ) And 	
	 ( B.BMDNO *= A.ItemCode ) And 
	 ( B.AreaCode = E.AreaCode ) And 
	 ( B.DivisionCode = E.DivisionCode ) And 
	 ( B.BMDCD = E.ProductGroup ) And 
	 ( B.BMDNO = E.ItemCode ) And 
	 ( B.AreaCode = F.AreaCode ) And 
	 ( B.DivisionCode = F.DivisionCode ) And 
	 ( B.BMDCD = F.ProductGroup ) And 
	 ( ( B.BMDNO *= C.ItemCode ) Or 
	   ( B.BCHNO *= C.ItemCode ) )And 
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
         B.BMDCD, 
	 F.ProductGroupName, 
	 E.ModelGroup, 
	 B.BMDNO,
	 D.ItemName,
	 D.ItemSpec 
Order By B.AreaCode, 
         B.DivisionCode,   
         B.BMDCD,
	 E.ModelGroup, 
	 B.BMDNO 	 

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

