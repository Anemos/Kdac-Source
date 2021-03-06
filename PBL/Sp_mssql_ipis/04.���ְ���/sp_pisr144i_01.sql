SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr144i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr144i_01]
GO

------------------------------------------------------------------
--	Lot 불합격간판 리스트조회
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr144i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_nowtime 		DateTime   	-- 공장 코드
AS
BEGIN

  SELECT A.PartKBNo,   
         A.AreaCode,   
         A.DivisionCode,   
         A.SupplierCode,   
         A.ItemCode,
	 F.PartModelID,
	 F.ReceiptLocation,
	 F.RackCode,
         A.PartType,   
         A.RackQty,   
         A.OrderChangeFlag,   
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
         A.ChangeForecastDate,   
         A.ChangeForecastEditNo,   
         A.ChangeForecastTime,   
         B.QCDATE,   
         B.QCTIME,   
         B.INSPECTORCODE,
	 D.SupplierKorName,
	 D.SupplierNo,
	 E.ItemName,
	 E.ItemSpec,
	 G.AreaName,
	 H.DivisionName,
	 @ps_nowtime As PrintTime  
    FROM TPARTKBSTATUS	A,   
         TQQCRESULT	B,  
         TDELIVERYLIST	C,
	 TMSTSUPPLIER   D,
	 TMSTITEM	E,
	 TMSTPARTKB	F,
	 TMSTAREA	G,
	 TMSTDIVISION	H
   WHERE B.AreaCode 		= @ps_areacode 	AND  
         B.DivisionCode 	= @ps_divcode 	AND  
         B.JUDGEFLAG 		= '2' 		AND  

         B.DELIVERYNO 		= C.DeliveryNo	and  
         B.AREACODE 		= C.AreaCode 	and  
         B.DIVISIONCODE 	= C.DivisionCode	and  
         B.SUPPLIERCODE 	= C.SupplierCode	and  
         C.DeliveryConfirm 	= 'Y' 		AND  
         C.DeliveryCancel 	= 'N' 		and

         B.AREACODE 		= A.AreaCode 	and  
         B.DIVISIONCODE 	= A.DivisionCode	and  
         B.SUPPLIERCODE 	= A.SupplierCode	and  
         B.ITEMCODE 		= A.ItemCode	and  
         B.DELIVERYNO 		= A.DeliveryNo 	and
         A.PartKBStatus 	= 'B' 		AND  

         A.SUPPLIERCODE 	= D.SupplierCode	and  
         A.ITEMCODE 		= E.ItemCode	AND

         F.AreaCode 		= A.AreaCode 	and  
         F.DivisionCode 	= A.DivisionCode	and  
         F.SupplierCode 	= A.SupplierCode	and  
         F.ItemCode 		= A.ItemCode	AND

	 G.AreaCode		= B.AreaCode	And
	 H.AreaCode		= B.AreaCode	And
	 H.DivisionCode		= B.DivisionCode

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

