SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr143i_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr143i_03]
GO

------------------------------------------------------------------
--	발주진행정보 상세조회( 미납간판 ) 
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr143i_03
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@ps_applytime 		DateTime	-- 기준일자
AS
BEGIN

  SELECT 	A.PartType,   
         		A.ItemCode,   
         		B.ItemName,   
         		F.PartModelID,   
         		( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) As ProductGroup,
         		A.PartKBNo,   
         		A.RackQty,   
         		A.PartOrderTime,   
         		A.PartForecastTime,   
         		A.PartReceiptTime,   
         		A.ChangeForecastTime,   
         		A.PartObeyDateFlag,
         		A.PartObeyTimeFlag,   
         		A.OrderChangeFlag,   
         		C.OrderChangeName,
		A.AreaCode,   
         		A.DivisionCode,   
		A.SupplierCode,   
         		E.SupplierNo,   
         		E.SupplierKorName,
		D.SupplyTerm,   
         		D.SupplyEditNo,   
         		D.SupplyCycle   
    FROM 	TPARTKBSTATUS	A,   
         		TMSTITEM		B,   
         		TMSTORDERCHANGE	C,
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER	E,
		TMSTPARTKB		F
   WHERE 	A.AreaCode		= @ps_areacode	AND  
         		A.DivisionCode		= @ps_divcode		AND  
         		A.SupplierCode		like @ps_suppcode	AND  
         		A.ItemCode		like @ps_itemcode	AND  
         		A.KBActiveGubun 	= 'A'  			AND  --운용중인간판 'A',  Sleeping 'S'
         		A.PartKBStatus 		= 'A'			AND  --'A'발주, 'B'가입고(납품)
		( Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime End ) < @ps_applytime And

         		A.ItemCode 		= B.ItemCode  		AND  

         		A.AreaCode 		*= C.AreaCode   		AND
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

