SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr140i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr140i_01]
GO



------------------------------------------------------------------
--	발주 / 가입고 현황 조회( 현재상태 )
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr140i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@ps_kbstatus 		Char(1),   	-- 간판상태
 	@ps_applydate 		Char(10)	-- 기준일자
AS
BEGIN
  SELECT 	A.PartType,   
         		A.PartKBNo,   
         		A.SupplierCode,   
         		E.SupplierNo,   
         		E.SupplierKorName,   
         		A.DivisionCode,   
         		A.ItemCode,   
         		B.ItemName,   
         		F.PartModelID,   
         		A.RackQty,   
         		D.SupplyTerm,   
         		D.SupplyEditNo,   
         		D.SupplyCycle,   
         		A.PartOrderDate,   
         		A.OrderChangeFlag,   
         		A.PartOrderTime,   
         		A.PartObeyDateFlag,
         		A.PartObeyTimeFlag,   
         		A.PartForeCastDate,   
         		A.PartForecastEditNo,   
         		A.PartForecastTime,   
         		A.PartReceiptDate,   
         		A.PartEditNo,   
         		A.PartReceiptTime,   
         		A.OrderChangeTime,   
         		A.OrderChangeCode,   
         		A.ChangeForecastDate,   
         		A.ChangeForecastEditNo,   
         		A.ChangeForecastTime,   
         		C.OrderChangeName,
		( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) As ProductGroup
    FROM 	TPARTKBSTATUS	A,   
         		TMSTITEM		B,   
         		TMSTORDERCHANGE	C,
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER		E,
		TMSTPARTKB		F
   WHERE 	A.AreaCode		= @ps_areacode		AND  
         		A.DivisionCode		= @ps_divcode		AND  
         		A.SupplierCode		like @ps_suppcode	AND  
         		A.ItemCode		like @ps_itemcode	AND  
         		A.PartOrderCancel 	= 'N'  			AND  --발주취소안된 간판
         		A.KBActiveGubun 	= 'A'  			AND  --운용중인간판
         		A.PartKBStatus 		= @ps_kbstatus		AND  --'A'발주, 'B'가입고(납품)

         		A.ItemCode 		= B.ItemCode  		AND  

         		A.AreaCode 		*= C.AreaCode   	AND
         		A.DivisionCode 		*= C.DivisionCode   	AND
		A.OrderChangeCode 	*= C.OrderChangeCode 	AND

		A.AreaCode		= D.AreaCode		AND
		A.DivisionCode		= D.DivisionCode	AND
		A.SupplierCode		= D.SupplierCode	AND
         		D.ApplyFrom 		<= A.PartOrderDate  	AND
         		D.ApplyTo 		>= A.PartOrderDate  	AND

         		A.SupplierCode 		= E.SupplierCode  	AND  
         		
        		A.AreaCode 		= F.AreaCode		AND
        		A.DivisionCode 		= F.DivisionCode  	AND  
         		A.SupplierCode 		= F.SupplierCode  	AND  
         		A.ItemCode 		= F.ItemCode  		AND
		
		( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) like @ps_product
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

