SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr143i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr143i_01]
GO



------------------------------------------------------------------
--	간판진행정보조회
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr143i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@ps_applytime 		DateTime   	-- 기준시간
AS
BEGIN
  SELECT 	A.AreaCode,   
         		A.DivisionCode,   
         		A.PartType,   
         		A.SupplierCode,   
         		E.SupplierNo,   
         		E.SupplierKorName,   
         		A.ItemCode,   
         		B.ItemName,   
         		A.PartModelID,   
         		A.RackQty,   
         		D.SupplyTerm,   
         		D.SupplyEditNo,   
         		D.SupplyCycle,   
		( Select Top 1 G.ProductGroup From TMSTMODEL 	G 
			Where 	G.AreaCode 	= A.AreaCode 		And 
				G.DivisionCode 	= A.DivisionCode 	And 
				G.ItemCode 	= A.ItemCode ) 		As ProductGroup,
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	= 'A'			And
				( Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastTime Else F.PartForecastTime End ) >= @ps_applytime ) As Order1Cnt,
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	= 'A'			And
				( Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastTime Else F.PartForecastTime End ) < @ps_applytime ) As Order2Cnt,
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	= 'B'		) 	As ReceiptCnt
    FROM 	TMSTPARTKB		A,
		TMSTITEM		B,   
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER	E
   WHERE 	A.AreaCode		= @ps_areacode	AND  
         		A.DivisionCode		= @ps_divcode		AND  
         		A.SupplierCode		like @ps_suppcode	AND  
         		A.ItemCode		like @ps_itemcode	AND  

         		A.ItemCode 		= B.ItemCode  		AND  

		A.AreaCode		= D.AreaCode		AND
		A.DivisionCode		= D.DivisionCode	AND
		A.SupplierCode		= D.SupplierCode	AND
		A.ApplyFrom		>= D.ApplyFrom		AND
		A.ApplyFrom		<= D.ApplyTo		AND

         		A.SupplierCode 		= E.SupplierCode  	AND  
         		
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	In ( 'A', 'B' )	) > 0 	And

		( Select Top 1 G.ProductGroup From TMSTMODEL 	G 
			Where 	G.AreaCode 	= A.AreaCode 		And 
				G.DivisionCode 	= A.DivisionCode 	And 
				G.ItemCode 	= A.ItemCode 	) like @ps_product
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

