SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr140i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr140i_02]
GO



------------------------------------------------------------------
--	기간별 발주현황
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr140i_02
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@ps_fromdate 		Char(10),   	-- 기준일자
 	@ps_todate 		Char(10)   	-- 기준일자
AS
BEGIN
  SELECT 	A.PartType,   
         		A.PartKBNo,   
         		A.ApplyFrom,   
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
         		A.PartIncomeDate,   
         		A.PartIncomeTime,   
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
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartKBStatus 		in ('A', 'B')		AND  	--'A'발주, 'B'가입고, 'C'입고, 'D'발주대기
        		A.PartOrderDate 		>= @ps_fromdate	AND  	--발주일자
         		A.PartOrderDate	 	<= @ps_todate		AND  	--발주일자

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
         		A.ItemCode 		= F.ItemCode  		And
		( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) like @ps_product

Union
  SELECT 	A.PartType,   
         		A.PartKBNo,   
         		A.ApplyFrom,   
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
         		A.PartIncomeDate,   
         		A.PartIncomeTime,   
         		A.OrderChangeTime,   
         		A.OrderChangeCode,   
         		A.ChangeForecastDate,   
         		A.ChangeForecastEditNo,   
         		A.ChangeForecastTime,   
         		C.OrderChangeName,  
		( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) As ProductGroup
    FROM 	TPARTKBHIS		A,   
         		TMSTITEM		B,   
         		TMSTORDERCHANGE	C,
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER	E,
		TMSTPARTKB		F
   WHERE 	A.AreaCode		= @ps_areacode		AND  
         		A.DivisionCode		= @ps_divcode		AND  
         		A.SupplierCode		like @ps_suppcode	AND  
         		A.ItemCode		like @ps_itemcode	AND  
         		A.PartKBStatus	 	= 'C'  			AND  	--정상적인 입고 'X' 입고취소
         		A.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		A.PartOrderCancel 	= 'N'			AND  	--'Y'발주취소, 'N'발주취소아님
        		A.PartOrderDate 		>= @ps_fromdate	AND  	--발주일자
         		A.PartOrderDate	 	<= @ps_todate		AND  	--발주일자

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
         		A.ItemCode 		= F.ItemCode  		And
		( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) like @ps_product

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

