SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr130p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr130p_01]
GO


------------------------------------------------------------------
--	간판발주서 발행현황
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr130p_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_orderno 		Char(12)	-- 발주리스트 번호
AS
BEGIN

  SELECT H.SupplierCode,   
         H.PartOrderNo,   
         H.AreaCode,   
         H.DivisionCode,   
         H.OrderPrintFlag,   
         H.OrderPrintDate,   
         H.OrderRePrintDate,   
         G.PartKBNo,   
         G.ItemCode,   
         G.PartType,   
         G.RackQty,   
         G.OrderChangeFlag,   
         G.PartOrderCancel,   
         G.PartOrderTime,   
         G.PartForecastDate,   
         G.PartForecastEditNo,   
         G.PartForecastTime,   
         G.ChangeForecastDate,   
         G.ChangeForecastEditNo,   
         G.ChangeForecastTime,   
         E.PartModelID,   
         D.SupplyTerm,   
         D.SupplyEditNo,   
         D.SupplyCycle,   
         A.AreaName,   
         B.DivisionName,   
         F.SupplierNo,   
         F.SupplierKorName,   
         C.ItemName,   
         C.ItemSpec,   
         I.OrderChangeName,   
         E.RackCode  
    FROM TMSTAREA		A,   
         TMSTDIVISION		B,   
         TMSTITEM		C,   
         TMSTPARTCYCLE		D,   
         TMSTPARTKB		E,   
         TMSTSUPPLIER		F,   
         TPARTKBSTATUS		G,   
         TPARTORDERLIST		H,   
         TMSTORDERCHANGE	I  
   WHERE H.AreaCode 		= @ps_areacode 		AND  
         H.DivisionCode 	= @ps_divcode 		AND  
         H.SupplierCode 	= @ps_suppcode 		AND  
         H.PartOrderNo 		= @ps_orderno 		AND  
         
	 H.AreaCode 		= A.AreaCode 		and  

         H.AreaCode 		= B.AreaCode 		and  
         H.DivisionCode 	= B.DivisionCode 	and  

         H.SupplierCode 	= F.SupplierCode 	and  

         H.AreaCode 		= G.AreaCode 		and  
         H.DivisionCode 	= G.DivisionCode 	and  
         H.SupplierCode 	= G.SupplierCode 	and  
         H.PartOrderNo 		= G.PartOrderNo 	and  
         G.PartOrderCancel 	= 'N' 			AND  
         G.PartKBStatus 	IN ('A','B' ) 		and

         G.ItemCode 		= C.ItemCode 		and  

         G.AreaCode 		= D.AreaCode 		and  
         G.DivisionCode 	= D.DivisionCode 	and  
         G.SupplierCode 	= D.SupplierCode 	and  
         G.PartOrderDate	>= D.ApplyFrom 		and  
         G.PartOrderDate	<= D.ApplyTo 		and  

         G.AreaCode 		= E.AreaCode 		and  
         G.DivisionCode 	= E.DivisionCode 	and  
         G.SupplierCode 	= E.SupplierCode 	and  
         G.ItemCode 		= E.ItemCode 		and  

         G.AreaCode 		*= I.AreaCode		and  
         G.DivisionCode 	*= I.DivisionCode	and  
         G.OrderChangeCode 	*= I.OrderChangeCode
Union
  SELECT H.SupplierCode,   
         H.PartOrderNo,   
         H.AreaCode,   
         H.DivisionCode,   
         H.OrderPrintFlag,   
         H.OrderPrintDate,   
         H.OrderRePrintDate,   
         G.PartKBNo,   
         G.ItemCode,   
         G.PartType,   
         G.RackQty,   
         G.OrderChangeFlag,   
         G.PartOrderCancel,   
         G.PartOrderTime,   
         G.PartForecastDate,   
         G.PartForecastEditNo,   
         G.PartForecastTime,   
         G.ChangeForecastDate,   
         G.ChangeForecastEditNo,   
         G.ChangeForecastTime,   
         E.PartModelID,   
         D.SupplyTerm,   
         D.SupplyEditNo,   
         D.SupplyCycle,   
         A.AreaName,   
         B.DivisionName,   
         F.SupplierNo,   
         F.SupplierKorName,   
         C.ItemName,   
         C.ItemSpec,   
         I.OrderChangeName,   
         E.RackCode  
    FROM TMSTAREA		A,   
         TMSTDIVISION		B,   
         TMSTITEM		C,   
         TMSTPARTCYCLE		D,   
         TMSTPARTKB		E,   
         TMSTSUPPLIER		F,   
         TPARTKBHIS		G,   
         TPARTORDERLIST		H,   
         TMSTORDERCHANGE	I  
   WHERE H.AreaCode 		= @ps_areacode 		AND  
         H.DivisionCode 	= @ps_divcode 		AND  
         H.SupplierCode 	= @ps_suppcode 		AND  
         H.PartOrderNo 		= @ps_orderno 		AND  
         
	 H.AreaCode 		= A.AreaCode 		and  

         H.AreaCode 		= B.AreaCode 		and  
         H.DivisionCode 	= B.DivisionCode 	and  

         H.SupplierCode 	= F.SupplierCode 	and  

         H.AreaCode 		= G.AreaCode 		and  
         H.DivisionCode 	= G.DivisionCode 	and  
         H.SupplierCode 	= G.SupplierCode 	and  
         H.PartOrderNo 		= G.PartOrderNo 	and  
         G.PartKBStatus 	= 'C'	 		and

         G.ItemCode 		= C.ItemCode 		and  

         G.AreaCode 		= D.AreaCode 		and  
         G.DivisionCode 	= D.DivisionCode 	and  
         G.SupplierCode 	= D.SupplierCode 	and  
         G.PartOrderDate	>= D.ApplyFrom 		and  
         G.PartOrderDate	<= D.ApplyTo 		and  

         G.AreaCode 		= E.AreaCode 		and  
         G.DivisionCode 	= E.DivisionCode 	and  
         G.SupplierCode 	= E.SupplierCode 	and  
         G.ItemCode 		= E.ItemCode 		and  

         G.AreaCode 		*= I.AreaCode		and  
         G.DivisionCode 	*= I.DivisionCode	and  
         G.OrderChangeCode 	*= I.OrderChangeCode

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

