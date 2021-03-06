SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr130i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr130i_01]
GO


------------------------------------------------------------------
--	간판발주서 발행현황
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr130i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_applyfrom 		Char(10),   	-- 기준일자
 	@ps_applyto 		Char(10)   	-- 기준일자
AS
BEGIN
  SELECT 	A.SupplierCode,   
         		A.PartOrderNo,   
         		A.PartOrderSeq,   
         		A.AreaCode,   
         		A.DivisionCode,   
         		H.DivisionName,   
         		A.OrderPrintFlag,   
         		A.OrderPrintDate,   
         		A.OrderRePrintDate,   
         		A.OrderCancel,   
		B.PartType,   
         		B.PartKBNo,   
         		B.ItemCode,   
         		C.ItemName,   
         		G.PartModelID,   
         		B.RackQty,   
         		E.SupplyTerm,   
         		E.SupplyEditNo,   
         		E.SupplyCycle,   
         		B.PartOrderDate,   
         		B.OrderChangeFlag,   
         		B.PartOrderTime,   
         		B.PartForeCastDate,   
         		B.PartForecastEditNo,   
         		B.PartForecastTime,   
         		B.OrderChangeTime,   
         		B.OrderChangeCode,   
         		B.ChangeForecastDate,   
         		B.ChangeForecastEditNo,   
         		B.ChangeForecastTime,   
         		D.OrderChangeName  
    FROM 	TPARTORDERLIST	A,
		TPARTKBSTATUS	B,   
         		TMSTITEM		C,   
         		TMSTORDERCHANGE	D,
		TMSTPARTCYCLE	E,
		TMSTPARTKB		G,
		TMSTDIVISION		H
   WHERE 	A.AreaCode 		= 	@ps_areacode 	AND  
         		A.DivisionCode 		like 	@ps_divcode 	AND  
         		A.SupplierCode 		= 	@ps_suppcode 	AND  
         		Convert(Char(10),A.OrderPrintDate , 102) >= @ps_applyfrom 	AND  
         		Convert(Char(10),A.OrderPrintDate , 102) <= @ps_applyto 	 	AND   
         		A.OrderPrintFlag 	= 'Y' 			AND    

         		A.PartOrderNo 		= B.PartOrderNo 		AND
         		A.AreaCode		= B.AreaCode		AND  
         		A.DivisionCode		= B.DivisionCode	AND  
         		A.SupplierCode		= B.SupplierCode	AND  
         		B.KBActiveGubun 	= 'A'  			AND  	--운용중인간판
        		B.PartKBStatus 		in ('A', 'B')		AND  	--'A'발주, 'B'가입고

         		B.ItemCode 		= C.ItemCode  		AND  

         		B.AreaCode 		*= D.AreaCode   	AND
         		B.DivisionCode 		*= D.DivisionCode   	AND
		B.OrderChangeCode 	*= D.OrderChangeCode 	AND

		A.AreaCode		= E.AreaCode		AND
		A.DivisionCode		= E.DivisionCode	AND
		A.SupplierCode		= E.SupplierCode	AND
         		E.ApplyFrom 		<= B.PartOrderDate  	AND
         		E.ApplyTo 		>= B.PartOrderDate  	AND

        		B.AreaCode 		= G.AreaCode		AND
        		B.DivisionCode 		= G.DivisionCode  	AND  
         		B.SupplierCode 		= G.SupplierCode  	AND  
         		B.ItemCode 		= G.ItemCode  		AND

		A.AreaCode		= H.AreaCode		AND
		A.DivisionCode		= H.DivisionCode
Union
  SELECT 	A.SupplierCode,   
         		A.PartOrderNo,   
         		A.PartOrderSeq,   
         		A.AreaCode,   
         		A.DivisionCode,   
         		H.DivisionName,   
         		A.OrderPrintFlag,   
         		A.OrderPrintDate,   
         		A.OrderRePrintDate,   
         		A.OrderCancel,   
		B.PartType,   
         		B.PartKBNo,   
         		B.ItemCode,   
         		C.ItemName,   
         		G.PartModelID,   
         		B.RackQty,   
         		E.SupplyTerm,   
         		E.SupplyEditNo,   
         		E.SupplyCycle,   
         		B.PartOrderDate,   
         		B.OrderChangeFlag,   
         		B.PartOrderTime,   
         		B.PartForeCastDate,   
         		B.PartForecastEditNo,   
         		B.PartForecastTime,   
         		B.OrderChangeTime,   
         		B.OrderChangeCode,   
         		B.ChangeForecastDate,   
         		B.ChangeForecastEditNo,   
         		B.ChangeForecastTime,   
         		D.OrderChangeName  
    FROM 	TPARTORDERLIST	A,
		TPARTKBHIS		B,   
         		TMSTITEM		C,   
         		TMSTORDERCHANGE	D,
		TMSTPARTCYCLE	E,
		TMSTPARTKB		G,
		TMSTDIVISION		H
   WHERE 	A.AreaCode 		= 	@ps_areacode 	AND  
         		A.DivisionCode 		like 	@ps_divcode 	AND  
         		A.SupplierCode 		= 	@ps_suppcode 	AND  
         		Convert(Char(10),A.OrderPrintDate , 102) >= @ps_applyfrom 	AND  
         		Convert(Char(10),A.OrderPrintDate , 102) <= @ps_applyto 	 	AND   
         		A.OrderPrintFlag 	= 'Y' 			AND    

         		A.PartOrderNo 		= B.PartOrderNo 	AND
         		A.AreaCode		= B.AreaCode		AND  
         		A.DivisionCode		= B.DivisionCode	AND  
         		A.SupplierCode		= B.SupplierCode	AND  
        		B.PartKBStatus 		= 'C'			AND  	--'A'발주, 'B'가입고, 'C' 입고

         		B.ItemCode 		= C.ItemCode  		AND  

         		B.AreaCode 		*= D.AreaCode   	AND
         		B.DivisionCode 		*= D.DivisionCode   	AND
		B.OrderChangeCode 	*= D.OrderChangeCode 	AND

		A.AreaCode		= E.AreaCode		AND
		A.DivisionCode		= E.DivisionCode	AND
		A.SupplierCode		= E.SupplierCode	AND
         		E.ApplyFrom 		<= B.PartOrderDate  	AND
         		E.ApplyTo 		>= B.PartOrderDate  	AND

        		B.AreaCode 		= G.AreaCode		AND
        		B.DivisionCode 		= G.DivisionCode  	AND  
         		B.SupplierCode 		= G.SupplierCode  	AND  
         		B.ItemCode 		= G.ItemCode  		AND

        		A.AreaCode 		= H.AreaCode		AND
		A.DivisionCode		= H.DivisionCode
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

