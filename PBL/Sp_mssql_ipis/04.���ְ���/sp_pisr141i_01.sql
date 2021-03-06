SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr141i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr141i_01]
GO



------------------------------------------------------------------
--	가입고 현황 조회( 현재상태 )
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr141i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@pdt_applytime 		DateTime   	-- 조회기준시간

AS
BEGIN
--
Set NoCount On

  SELECT A.PartType,   
         A.PartKBNo,   		--2
         A.SupplierCode,   	--3
         E.SupplierNo,   
         E.SupplierKorName,   
         A.DivisionCode,   	--6
         A.ItemCode,   		--7
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
         A.ChangeForecastDate,   
         A.ChangeForecastEditNo,   
         A.ChangeForecastTime,   
         C.OrderChangeName,
	( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) As ProductGroup
    FROM TPARTKBSTATUS		A,   
         TMSTITEM		B,   
         TMSTORDERCHANGE	C,
	 TMSTPARTCYCLE		D,
	 TMSTSUPPLIER		E,
	 TMSTPARTKB		F
   WHERE A.AreaCode		= @ps_areacode		AND  
         A.DivisionCode		= @ps_divcode		AND  
         A.SupplierCode		like @ps_suppcode	AND  
         A.ItemCode		like @ps_itemcode	AND  
         A.PartOrderCancel 	= 'N'  			AND  --발주취소안된 간판
         A.KBActiveGubun 	= 'A'  			AND  --운용중인간판(Active)
         A.PartKBStatus 	= 'B'			AND  --'B'가입고(납품)
         A.PartReceiptTime	<= @pdt_applytime 	And

         A.ItemCode 		= B.ItemCode  		AND  

         A.AreaCode 		*= C.AreaCode   	AND
         A.DivisionCode 	*= C.DivisionCode   	AND
	 A.OrderChangeCode 	*= C.OrderChangeCode 	AND

 	 A.AreaCode		= D.AreaCode		AND
	 A.DivisionCode		= D.DivisionCode	AND
	 A.SupplierCode		= D.SupplierCode	AND
         D.ApplyFrom 		<= A.PartOrderDate  	AND
         D.ApplyTo 		>= A.PartOrderDate  	AND

         A.SupplierCode 	= E.SupplierCode  	AND  
         		
         A.AreaCode 		= F.AreaCode		AND
         A.DivisionCode 	= F.DivisionCode  	AND  
         A.SupplierCode 	= F.SupplierCode  	AND  
         A.ItemCode 		= F.ItemCode  		AND
		
	 ( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) like @ps_product

Union
  SELECT A.PartType,   
         A.PartKBNo,   		--2
         A.SupplierCode,   	--3
         E.SupplierNo,   
         E.SupplierKorName,   
         A.DivisionCode,    	--6
         A.ItemCode,   		--7
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
         A.ChangeForecastDate,   
         A.ChangeForecastEditNo,   
         A.ChangeForecastTime,   
         C.OrderChangeName,
	( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) As ProductGroup
    FROM TPARTKBHIS		A,   
         TMSTITEM		B,   
         TMSTORDERCHANGE	C,
	 TMSTPARTCYCLE		D,
	 TMSTSUPPLIER		E,
	 TMSTPARTKB		F
   WHERE A.AreaCode		= @ps_areacode		AND  
         A.DivisionCode		= @ps_divcode		AND  
         A.SupplierCode		like @ps_suppcode	AND  
         A.ItemCode		like @ps_itemcode	AND  
         A.PartKBStatus 	= 'C'			AND  -- 'C'입고 , 'X'입고삭제
         A.PartReceiptTime	<= @pdt_applytime 	And         
         A.PartIncomeTime 	>  @pdt_applytime 	And		

         A.ItemCode 		= B.ItemCode  		AND  

         A.AreaCode 		*= C.AreaCode   	AND
         A.DivisionCode 	*= C.DivisionCode   	AND
	 A.OrderChangeCode 	*= C.OrderChangeCode 	AND

 	 A.AreaCode		= D.AreaCode		AND
	 A.DivisionCode		= D.DivisionCode	AND
	 A.SupplierCode		= D.SupplierCode	AND
         D.ApplyFrom 		<= A.PartOrderDate  	AND
         D.ApplyTo 		>= A.PartOrderDate  	AND

         A.SupplierCode 	= E.SupplierCode  	AND  
         		
         A.AreaCode 		= F.AreaCode		AND
         A.DivisionCode 	= F.DivisionCode  	AND  
         A.SupplierCode 	= F.SupplierCode  	AND  
         A.ItemCode 		= F.ItemCode  		AND
		
	 ( Select Top 1 G.ProductGroup From TMSTMODEL G Where G.AreaCode = A.AreaCode And G.DivisionCode = A.DivisionCode And G.ItemCode = A.ItemCode ) like @ps_product

Order By 6, 3, 7, 2


Set NoCount Off


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

