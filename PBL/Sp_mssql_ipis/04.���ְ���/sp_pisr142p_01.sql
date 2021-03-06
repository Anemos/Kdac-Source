SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr142p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr142p_01]
GO

------------------------------------------------------------------
--	발주대기간판현황(기준일현재 1/2)
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr142p_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@pdt_applytime 		DateTime   	-- 조회기준시간
AS
BEGIN
Set NoCount On


Declare	@ls_applytime		Char(10)		
Select 	@ls_applytime = Convert(Char(10), @pdt_applytime, 102)	


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
	 @pdt_applytime 	As ApplyTime
    FROM TMSTAREA		A,   
         TMSTDIVISION		B,   
         TMSTSUPPLIER		C,   
         TMSTITEM		D,   
         TMSTPARTKB		E,   
         TPARTKBSTATUS		F,   
	 TMSTPARTKBHIS		G
   WHERE F.AreaCode 		= @ps_areacode		AND  
         F.DivisionCode 	= @ps_divcode		AND  
         F.SupplierCode 	Like @ps_suppcode	AND  
         F.ItemCode	 	Like @ps_itemcode	AND  
         F.KBActiveGubun 	= 'A'  			AND  --운용중인간판(Active)
         F.PartKBStatus 	In ('C','D')		AND  --'C'입고처리, 'D'발주대기
	 
	 F.AreaCode 		= A.AreaCode 		and  

         F.AreaCode 		= B.AreaCode 		and  
         F.DivisionCode 	= B.DivisionCode 	and  

         F.SupplierCode 	= C.SupplierCode 	and  

         F.ItemCode 		= D.ItemCode 		and  

         F.AreaCode 		= E.AreaCode 		and  
         F.DivisionCode 	= E.DivisionCode 	and  
         F.SupplierCode 	= E.SupplierCode 	and  
         F.ItemCode 		= E.ItemCode 		and

         F.AreaCode 		= G.AreaCode 		and  
         F.DivisionCode 	= G.DivisionCode 	and  
         F.SupplierCode 	= G.SupplierCode 	and  
         F.ItemCode 		= G.ItemCode 		and
         G.ApplyFrom 		<= @ls_applytime 	and
         G.ApplyTo 		>= @ls_applytime 	and
	 G.UseFlag		= 'N'			And	-- 사용중단이 아닌것

	 ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = F.AreaCode And I.DivisionCode = F.DivisionCode And I.ItemCode = F.ItemCode ) Like @ps_product

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

