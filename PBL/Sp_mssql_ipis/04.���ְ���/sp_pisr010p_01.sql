SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr010p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr010p_01]
GO


----------------------------------------------------------
--            	외주간판 기본정보 출력
----------------------------------------------------------
CREATE PROCEDURE sp_pisr010p_01
 	@ps_areaCode	 Char(1),   	-- 지역 코드
 	@ps_divCode	 Char(1),   	-- 공장 코드
 	@ps_suppCode	 VarChar(5),   	-- 업체
 	@ps_itemCode	 VarChar(12),   	-- 품번
 	@ps_product	 VarChar(2)   	-- 제품군
AS
BEGIN

Set NoCount ON

  SELECT 	A.AreaCode,   
         		C.AreaName,   
         		A.DivisionCode,   
         		D.DivisionName,   
         		A.SupplierCode,   
         		E.SupplierNo,   
         		E.SupplierKorName,  
         		A.ItemCode,   
         		F.ItemName,   
         		F.ItemSpec,   
         		A.ApplyFrom,   
         		A.PartType,   
         		A.ChangeFlag,   
         		A.PartModelID,   
         		A.PartID,   
         		A.UseCenterGubun,   
         		A.UseCenter,   
         		A.CostGubun,   
         		A.RackQty,   
         		A.RackCode,   
         		A.StockGubun,   
         		A.ReceiptLocation,   
         		A.MailBoxNo,   
         		A.SafetyStock,   
         		A.UseFlag,   
         		A.AutoReorderFlag,   
         		A.KBUseFlag,   
         		A.ChangeDate,   
         		A.NormalKBSN,   
         		A.TempKBSN,   
         		A.PartKBPrintCount,   
         		A.PartKBActiveCount,   
         		A.PartKBPlanCount,   
         		A.LastEmp,   
         		A.LastDate,   
         		B.SupplyTerm,   
         		B.SupplyEditNo,   
         		B.SupplyCycle,   
		( Select Top 1 G.ProductGroup From TMSTMODEL G  Where G.AreaCode = A.AreaCode and  G.DivisionCode = A.DivisionCode and G.ItemCode = A.ItemCode ) As ProductGroup
         		
    FROM 	TMSTPARTKB		A,   
         		TMSTPARTCYCLE	B,   
         		TMSTAREA		C,   
         		TMSTDIVISION		D,   
         		TMSTSUPPLIER  	E,
         		TMSTITEM		F   
   WHERE 	A.AreaCode 		= @ps_areaCode  	and  
         		A.DivisionCode 		= @ps_divCode  	and  
         		A.SupplierCode 		like @ps_suppCode  	and  
         		A.ItemCode 		like @ps_itemCode  	and  

         		A.AreaCode 		= B.AreaCode  		and  
         		A.DivisionCode 		= B.DivisionCode  	and  
         		A.SupplierCode 		= B.SupplierCode  	and  
         		A.ApplyFrom 		>= B.ApplyFrom  	and  
         		A.ApplyFrom 		<= B.ApplyTo  		and  

         		A.AreaCode 		= C.AreaCode  		and  

         		A.AreaCode 		= D.AreaCode  		and  
         		A.DivisionCode 		= D.DivisionCode     	And

         		A.SupplierCode 		= E.SupplierCode  	and  

         		A.ItemCode 		= F.ItemCode  		and

		( Select Top 1 G.ProductGroup From TMSTMODEL G  Where G.AreaCode = A.AreaCode and  G.DivisionCode = A.DivisionCode and G.ItemCode = A.ItemCode ) like @ps_product

Set NoCount Off

End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

