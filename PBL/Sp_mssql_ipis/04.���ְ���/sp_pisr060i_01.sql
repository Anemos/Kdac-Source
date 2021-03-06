SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr060i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr060i_01]
GO



------------------------------------------------------------------
--		남품표 발행현황 조회 ( 업체별 )
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr060i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_applydate 		Char(10)	-- 기준일자
AS
BEGIN
  SELECT 	A.DeliveryNo,   
         		A.DeliveryPrintDate,   
         		A.DeliveryRePrintDate,   
         		B.PartType,   
         		B.PartKBNo,   
         		B.SupplierCode,   
         		G.SupplierNo,   
         		G.SupplierKorName,   
         		B.DivisionCode,   
         		B.ItemCode,   
         		D.ItemName,   
         		H.PartModelID,   
         		B.RackQty,   
         		F.SupplyTerm,   
         		F.SupplyEditNo,   
         		F.SupplyCycle,   
         		B.PartOrderDate,   
         		B.PartOrderTime,   
         		B.PartForeCastDate,   
         		B.PartForecastEditNo,   
         		B.PartForecastTime,   
         		B.OrderChangeTime,   
         		B.OrderChangeFlag,   
         		B.ChangeForecastDate,   
         		B.ChangeForecastEditNo,   
         		B.ChangeForecastTime,   
         		E.OrderChangeName  
    FROM 	TDELIVERYLIST	A,   
         		TPARTKBSTATUS	B,   
         		TMSTITEM		D,   
         		TMSTORDERCHANGE	E,
		TMSTPARTCYCLE	F,
		TMSTSUPPLIER	G,
		TMSTPARTKB		H
   WHERE 	B.AreaCode		= @ps_areacode		AND  
         		B.DivisionCode		= @ps_divcode		AND  
         		B.SupplierCode		= @ps_suppcode	AND  
         		B.PartOrderCancel 	= 'N'  			AND  --발주취소안된 간판
         		B.KBActiveGubun 	= 'A'  			AND  --운용중인간판
         		B.PartKBStatus 		= 'A'  			AND  --발주상태간판

		A.SupplierCode		= B.SupplierCode	AND
		A.DeliveryNo		= B.DeliveryNo		AND  --납품표번호
         		A.DeliveryPrintFlag 	= 'Y'  			AND  --납품표발행
         		A.DeliveryConfirm 	= 'N'  			AND  --납입상태(미납)
         		A.DeliveryCancel 	= 'N'  			AND  --납품표취소안됨

         		B.ItemCode 		= D.ItemCode  		AND  

         		B.AreaCode 		*= E.AreaCode   		AND
         		B.DivisionCode 		*= E.DivisionCode   	AND
		B.OrderChangeCode 	*= E.OrderChangeCode 	AND

		B.AreaCode		= F.AreaCode		AND
		B.DivisionCode		= F.DivisionCode		AND
		B.SupplierCode		= F.SupplierCode	AND
         		F.ApplyFrom 		<= B.PartOrderDate  	AND
         		F.ApplyTo 		>= B.PartOrderDate  	AND

         		B.SupplierCode 		= G.SupplierCode  	AND  
         		
        		B.AreaCode 		= H.AreaCode		AND
        		B.DivisionCode 		= H.DivisionCode  	AND  
         		B.SupplierCode 		= H.SupplierCode  	AND  
         		B.ItemCode 		= H.ItemCode  		

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

