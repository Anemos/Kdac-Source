SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr070b_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr070b_01]
GO



------------------------------------------------------------------
--	가입고처리(납품표Scanning)
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr070b_01
 	@ps_deliveryno 		Char(12),   	-- 납품표번호
 	@ps_partkbstatus	Char(1),   	-- 간판상태
 	@ps_applydate		Char(10)   	-- 납입일자

AS
BEGIN
  SELECT 	A.PartKBNo,   
         		A.AreaCode,   
         		A.DivisionCode,   
         		A.SupplierCode,   
         		A.ItemCode,   
         		A.ApplyFrom,   
         		A.PartType,   
         		A.PartKBStatus,   
         		A.RackQty,   
         		A.OrderChangeFlag,   
         		A.PartOrderCancel,   
         		A.PartReceiptCancel,   
         		A.UseCenterGubun,   
         		A.UseCenter,   
         		A.PartObeyDateFlag,   
         		A.PartObeyTimeFlag,   
         		A.PartOrderDate,   
         		A.PartOrderTime,   
         		A.PartForecastDate,   
         		A.PartForecastEditNo,   
         		A.PartForecastTime,   
         		A.PartReceiptDate,   
         		A.PartEditNo,   
         		A.PartReceiptTime,   
         		A.DeliveryNo,   
         		A.OrderChangeTime,   
         		A.OrderChangeCode,   
         		A.ChangeForecastDate,   
         		A.ChangeForecastEditNo,   
         		A.ChangeForecastTime,   
         		A.OrderSeq,   
         		A.LastEmp,   
         		A.LastDate,   
         		B.SupplierNo,   
         		B.SupplierKorName,   
         		C.ItemName,   
         		C.ItemSpec,   
         		D.PartModelID,   
         		E.SupplyTerm,   
         		E.SupplyEditNo,   
         		E.SupplyCycle,   
         		F.OrderChangeName,
		Case  When  ( 	SELECT count(TQQCITEM.ITEMCODE)  
				   FROM TQQCITEM  
			    	WHERE TQQCITEM.AREACODE 		= A.AreaCode 		AND  
						TQQCITEM.DIVISIONCODE 	= A.DivisionCode 	AND  
						TQQCITEM.ITEMCODE 		= A.ItemCode 		AND  
						TQQCITEM.SUPPLIERCODE 	= A.SupplierCode 	AND  
						TQQCITEM.QCGUBUN 		= 'C'			AND  
						TQQCITEM.APPLYDATEFROM 	<= @ps_applydate )  > 0 Then 1 Else 0 End TqQCItem	
    FROM 	TPARTKBSTATUS	A,   
         		TMSTSUPPLIER	B,   
         		TMSTITEM		C,   
         		TMSTPARTKB		D,   
         		TMSTPARTCYCLE	E,   
         		TMSTORDERCHANGE	F  
   WHERE 	A.DeliveryNo 		= @ps_deliveryno     	and
		A.PartOrderCancel 	= 'N'  			and  --발주취소안된 간판
         		A.KBActiveGubun 	= 'A'  			and  --운용중인간판
         		A.PartKBStatus 		= @ps_partkbstatus	and  --A.발주상태간판, B.가입고상태간판

         		A.SupplierCode 		= B.SupplierCode  	and  

         		A.ItemCode 		= C.ItemCode  		and  

         		A.AreaCode 		= D.AreaCode  		and  
         		A.DivisionCode 		= D.DivisionCode  	and  
         		A.SupplierCode 		= D.SupplierCode  	and  
         		A.ItemCode 		= D.ItemCode  		and  

         		A.AreaCode 		= E.AreaCode  		and  
         		A.DivisionCode 		= E.DivisionCode  	and  
         		A.SupplierCode 		= E.SupplierCode  	and  
         		A.PartOrderDate 	>= E.ApplyFrom  	and  
         		A.PartOrderDate 	<= E.ApplyTo  		and  

		A.AreaCode 		*= F.AreaCode 		and  
         		A.DivisionCode 		*= F.DivisionCode 	and  
         		A.OrderChangeCode 	*= F.OrderChangeCode 
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

