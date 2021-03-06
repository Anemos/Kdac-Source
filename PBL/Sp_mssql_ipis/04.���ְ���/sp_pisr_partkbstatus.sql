SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr_partkbstatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr_partkbstatus]
GO



------------------------------------------------------------------
--        		외주간판 상태 및 기본 정보 
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr_partkbstatus
 	@ps_partkbNo	 	Char(11),   	-- 간판번호
 	@ps_applyDate	 	Char(10)   	-- 적용기준일자
AS
BEGIN

Set NoCount ON

Declare	@ls_applyDate		Char(10)	-- 적용기준일자

  SELECT 	@ls_applyDate	= Case When @ps_applyDate = '%' Then PartOrderDate Else @ps_applyDate End   
     FROM 	TPARTKBSTATUS
   WHERE	PartKBNo		= @ps_partkbNo

  SELECT 	A.PartKBNo,   
         		A.AreaCode,   
         		C.AreaName,   
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
         		A.RePrintFlag,   
         		A.RePrintCount,   
         		A.PartKBGubun,   
         		A.KBActiveGubun,   
         		A.PartKBStatus,   
         		A.KBOrderPossible,   
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
         		A.PartIncomeDate,   
         		A.PartIncomeTime,   
         		A.PartOrderNo,   
         		A.DeliveryNo,   
         		A.PartKBCreateDate,   
         		A.PartKBPrintDate,   
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
  		B.ApplyFrom		As Mst_ApplyFrom,   
  		B.ApplyTo		As Mst_ApplyTo,   
         		B.ChangeFlag,   
         		H.PartModelID,   
         		B.CostGubun,   
         		B.RackCode,   
         		B.StockGubun,   
         		B.ReceiptLocation,   
         		B.MailBoxNo,   
         		B.SafetyStock,   
         		B.UseFlag,   
         		B.AutoReorderFlag,   
         		B.KBUseFlag  
  FROM 		TPARTKBSTATUS 	A,
           		TMSTPARTKBHIS 	B,
           		TMSTAREA 		C,
           		TMSTDIVISION 		D,
           		TMSTSUPPLIER 	E,
           		TMSTITEM 		F,
           		TMSTPARTCYCLE 	G,
		TMSTPARTKB		H
WHERE		A.PartKBNo		= @ps_partkbNo		And

		A.AreaCode		= B.AreaCode		And
		A.DivisionCode		= B.DivisionCode	And
		A.SupplierCode		= B.SupplierCode	And
		A.ItemCode		= B.ItemCode		And
		B.ApplyFrom		<= @ls_applyDate	And
		B.ApplyTo		>= @ls_applyDate	And

		A.AreaCode		= C.AreaCode		And

		A.AreaCode		= D.AreaCode		And
		A.DivisionCode		= D.DivisionCode	And

		A.SupplierCode		= E.SupplierCode	And

		A.ItemCode		= F.ItemCode		And

		A.AreaCode		= G.AreaCode		And
		A.DivisionCode		= G.DivisionCode	And
		A.SupplierCode		= G.SupplierCode	And
		G.ApplyFrom		<= @ls_applyDate	And
		G.ApplyTo		>= @ls_applyDate	And

		A.AreaCode		= H.AreaCode		And
		A.DivisionCode		= H.DivisionCode	And
		A.SupplierCode		= H.SupplierCode	And
		A.ItemCode		= H.ItemCode	

Set NoCount Off

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

