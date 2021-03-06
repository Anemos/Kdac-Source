SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr120u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr120u_02]
GO





------------------------------------------------------------------
--        		발주변경(제품군별 납입예정일 수정)  데이타윈도우
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr120u_02
 	@ps_areaCode		Char(1),		-- 지역
 	@ps_divCode	 	Char(1),   	-- 공장
 	@ps_productgroup 	VarChar(5),   	-- 제품군
 	@ps_itemCode	 	VarChar(12),   	-- 품번
 	@ps_applyDate	 	Char(10)   	-- 적용기준일자
AS
BEGIN

Set NoCount ON
/*
Declare	@ls_applyDate		Char(10)	-- 적용기준일자

  SELECT 	@ls_applyDate	= Case When @ps_applyDate = '%' Then PartOrderDate Else @ps_applyDate End   
     FROM 	TPARTKBSTATUS
   WHERE	PartKBNo		= @ps_partkbNo
*/

Create	Table #Tmp_ProductGroup
(	ItemCode		Char(12),
	ProductGroup		VarChar(5)
)
Begin
	Insert Into #Tmp_ProductGroup
	Select	Distinct
		A.ItemCode,
		A.ProductGroup
	From	TMSTMODEL	A
	Where	A.AreaCode		= @ps_areaCode	And
		A.DivisionCode		= @ps_divCode		And
		isNull(A.ProductGroup, '') <> ''			And
		A.ItemClass   		In ('10', '40', '50')	And
		A.ItemBuySource	In ('02', '04') 		
End

  SELECT 	A.PartKBNo,   
         		A.AreaCode,   
         		A.DivisionCode,   
         		D.DivisionName,   
         		A.SupplierCode,   
         		E.SupplierNo,   
         		E.SupplierKorName,   
         		A.ItemCode,   
         		F.ItemName,   
         		F.ItemSpec,   
         		A.ApplyFrom,   
         		A.PartType,   
--         		A.RePrintFlag,   
--         		A.RePrintCount,   
--         		A.PartKBGubun,   
--         		A.KBActiveGubun,   
--         		A.PartKBStatus,   
--         		A.KBOrderPossible,   
         		A.RackQty,   
         		A.OrderChangeFlag,   
--         		A.PartOrderCancel,   
--         		A.PartReceiptCancel,   
         		A.UseCenterGubun,   
         		A.UseCenter,   
--         		A.PartObeyDateFlag,   
--         		A.PartObeyTimeFlag,   
         		A.PartOrderDate,   
         		A.PartOrderTime,   
         		A.PartForecastDate,   
         		A.PartForecastEditNo,   
         		A.PartForecastTime,   
--         		A.PartReceiptDate,   
--         		A.PartEditNo,   
--         		A.PartReceiptTime,   
--         		A.PartIncomeDate,   
--         		A.PartIncomeTime,   
--         		A.PartOrderNo,   
         		A.DeliveryNo,   
--         		A.PartKBCreateDate,   
--         		A.PartKBPrintDate,   
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
         		H.PartModelID   
  FROM 		TPARTKBSTATUS 	A,
           		TMSTDIVISION 		D,
           		TMSTSUPPLIER 	E,
           		TMSTITEM 		F,
           		TMSTPARTCYCLE 	G,
		TMSTPARTKB		H,
		#Tmp_ProductGroup	I
WHERE		A.AreaCode		= @ps_areaCode	And
		A.DivisionCode		= @ps_divCode		And
--		A.SupplierCode		like @ps_suppCode	And
		A.ItemCode		like @ps_itemCode	And
		A.PartForecastDate	= @ps_applyDate	And	-- 납입예정일이 변경당일 이후
		A.PartKBStatus		= 'A'			And	-- 발주상태
		IsNull(A.DeliveryNo, '') 	= '' 			And 	-- 납품표 미발행

		A.AreaCode		= D.AreaCode		And
		A.DivisionCode		= D.DivisionCode	And

		A.SupplierCode		= E.SupplierCode	And

		A.ItemCode		= F.ItemCode		And

		A.AreaCode		= G.AreaCode		And
		A.DivisionCode		= G.DivisionCode	And
		A.SupplierCode		= G.SupplierCode	And
		A.PartOrderDate 		>= G.ApplyFrom		And
		A.PartOrderDate 		<= G.ApplyTo		And

		A.AreaCode		= H.AreaCode		And
		A.DivisionCode		= H.DivisionCode	And
		A.SupplierCode		= H.SupplierCode	And
		A.ItemCode		= H.ItemCode		And

		A.ItemCode		= I.ItemCode		And
		I.ProductGroup		= @ps_productgroup	

Drop Table #Tmp_ProductGroup

Set NoCount Off

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

