SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr120u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr120u_01]
GO




------------------------------------------------------------------
--        		발주변경(납입예정일 수정) 데이타윈도우
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr120u_01
 	@ps_areaCode		Char(1),	-- 지역
 	@ps_divCode	 	Char(1),   	-- 공장
 	@ps_suppCode	 	VarChar(5),   	-- 업체
 	@ps_itemCode	 	VarChar(12),   	-- 품번
 	@ps_product	 	VarChar(2),   	-- 제품군
 	@ps_applyDate	 	Char(10)   	-- 납입예정일자
AS
BEGIN

Set NoCount ON
/*
Declare	@ls_applyDate		Char(10)	-- 적용기준일자

  SELECT 	@ls_applyDate	= Case When @ps_applyDate = '%' Then PartOrderDate Else @ps_applyDate End   
     FROM 	TPARTKBSTATUS
   WHERE	PartKBNo		= @ps_partkbNo
*/
  SELECT 	A.PartKBNo,   
         	A.AreaCode,   
         	A.DivisionCode,   
         	A.SupplierCode,   
         	E.SupplierNo,   
         	E.SupplierKorName,   
         	A.ItemCode,   
         	F.ItemName,   
         	F.ItemSpec,   
         	A.ApplyFrom,   
         	A.PartType,   
         	A.RackQty,   
         	A.OrderChangeFlag,   
         	A.UseCenterGubun,   
         	A.UseCenter,   
         	A.PartOrderDate,   
         	A.PartOrderTime,   
         	A.PartForecastDate,   
         	A.PartForecastEditNo,   
         	A.PartForecastTime,   
         	A.DeliveryNo,   
         	A.OrderChangeTime,   
         	A.OrderChangeCode,   
         	A.ChangeForecastDate,   
         	A.ChangeForecastEditNo,   
         	A.ChangeForecastTime,   
         	A.LastEmp,   
         	A.LastDate,
		G.ApplyFrom		As Cycle_ApplyFrom ,
		G.ApplyTo		As Cycle_ApplyTo ,
		G.SupplyTerm ,
           	G.SupplyEditNo ,
           	G.SupplyCycle, 
         	H.PartModelID,
		( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = A.AreaCode And I.DivisionCode = A.DivisionCode And I.ItemCode = A.ItemCode ) As ProductGroup
  FROM 		TPARTKBSTATUS 	A,
           	TMSTSUPPLIER 	E,
           	TMSTITEM 	F,
           	TMSTPARTCYCLE 	G,
		TMSTPARTKB	H
WHERE		A.AreaCode		= @ps_areaCode		And
		A.DivisionCode		= @ps_divCode		And
		A.SupplierCode		like @ps_suppCode	And
		A.ItemCode		like @ps_itemCode	And
		A.PartForecastDate	= @ps_applyDate		And	-- 납입예정일
		A.PartKBStatus		= 'A'			And	-- 발주상태
		IsNull(A.DeliveryNo, '')= '' 			And 	-- 납품표 미발행

		A.SupplierCode		= E.SupplierCode	And

		A.ItemCode		= F.ItemCode		And

		A.AreaCode		= G.AreaCode		And
		A.DivisionCode		= G.DivisionCode	And
		A.SupplierCode		= G.SupplierCode	And
		A.PartOrderDate 	>= G.ApplyFrom		And
		A.PartOrderDate 	<= G.ApplyTo		And

		A.AreaCode		= H.AreaCode		And
		A.DivisionCode		= H.DivisionCode	And
		A.SupplierCode		= H.SupplierCode	And
		A.ItemCode		= H.ItemCode		And

		( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = A.AreaCode And I.DivisionCode = A.DivisionCode And I.ItemCode = A.ItemCode ) like @ps_product

Set NoCount Off

End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

