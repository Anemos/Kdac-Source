SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr142p_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr142p_03]
GO

------------------------------------------------------------------
--	간판입고이력(기간별) 1/2
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr142p_03
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@ps_fromdate 		Char(10),   	-- 조회시작일자
 	@ps_todate 		Char(10)   	-- 조회종료일자
AS
BEGIN
Set NoCount On

/*
Declare	@ls_applytime		Char(16)		-- 입고기준시간
Select 	@ls_applytime = @ps_applydate + ' 20:00'	-- 일간마감고려
*/

  SELECT F.AreaCode,   
         A.AreaName,   
         F.DivisionCode,   
         B.DivisionName,   
         F.SupplierCode,   
         C.SupplierNo,   
         C.SupplierKorName,   
         F.ItemCode,   
         D.ItemName,
	 E.PartModelID,   
	 ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = F.AreaCode And I.DivisionCode = F.DivisionCode And I.ItemCode = F.ItemCode ) As ProductGroup,
         Count(F.PartKBNo) 	As KBCount,
         Sum(F.RackQty) 	As ItemQty,
	 @ps_fromdate 		As ApplyFrom,
	 @ps_todate 		As ApplyTo
    FROM TMSTAREA		A,   
         TMSTDIVISION		B,   
         TMSTSUPPLIER		C,   
         TMSTITEM		D,   
         TMSTPARTKB		E,   
         TPARTKBHIS		F   
   WHERE F.AreaCode 		= @ps_areacode 		AND  
         F.DivisionCode 	= @ps_divcode 		AND  
         F.SupplierCode 	like @ps_suppcode	AND  
         F.ItemCode	 	like @ps_itemcode	AND  
         F.PartKBStatus 	= 'C'	 		And
         F.PartIncomeDate	>= @ps_fromdate		And 
         F.PartIncomeDate	<= @ps_todate		And
	 
	 F.AreaCode 		= A.AreaCode 		and  

         F.AreaCode 		= B.AreaCode 		and  
         F.DivisionCode 	= B.DivisionCode 	and  

         F.SupplierCode 	= C.SupplierCode 	and  

         F.ItemCode 		= D.ItemCode 		and  

         F.AreaCode 		= E.AreaCode 		and  
         F.DivisionCode 	= E.DivisionCode 	and  
         F.SupplierCode 	= E.SupplierCode 	and  
         F.ItemCode 		= E.ItemCode 		and
	 
	 ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = F.AreaCode And I.DivisionCode = F.DivisionCode And I.ItemCode = F.ItemCode ) like @ps_product

Group By F.AreaCode,   
         A.AreaName,   
         F.DivisionCode,   
         B.DivisionName,   
         F.SupplierCode,   
         C.SupplierNo,   
         C.SupplierKorName,   
         F.ItemCode,   
         D.ItemName,
	 E.PartModelID   
	 
Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

