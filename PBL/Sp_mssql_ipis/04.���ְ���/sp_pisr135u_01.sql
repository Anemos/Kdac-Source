SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr135u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr135u_01]
GO

------------------------------------------------------------------
--	사급품반출증작성 간판리스트
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr135u_01
 		@ps_areacode		Char(1),		-- 지역코드
 		@ps_divcode		Char(1),		-- 공장코드
 		@ps_suppcode		VarChar(7),	-- 반출처 코드
 		@ps_buybackNo	VarChar(11)	-- 반출증 발행번호
AS
BEGIN
Set NoCount ON

Set NoCount ON

  SELECT 	A.PartKBNo,   
         		A.ApplyDate,   
         		A.PartOrderSeq,   
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
         		A.RackQty,   
         		A.UseCenterGubun,   
         		A.UseCenter,   
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
         		A.BuyBackNo,   
         		A.OrderChangeTime,   
         		A.OrderChangeCode,   
         		A.ChangeForecastDate,   
         		A.ChangeForecastEditNo,   
         		A.ChangeForecastTime,   
         		A.LastEmp,   
         		A.LastDate,
         		H.PartModelID,   
         		B.CostGubun,   
         		B.RackCode,   
         		B.StockGubun,   
         		B.ReceiptLocation,   
         		B.MailBoxNo,   
         		B.SafetyStock,
		case A.BuyBackNo when @ps_buybackNo then 1 else 0 end  As SelectChk	   
  FROM 	TPARTKBHIS 		A,
           		TMSTPARTKBHIS 	B,
           		TMSTDIVISION 	D,
           		TMSTSUPPLIER 	E,
           		TMSTITEM 		F,
		TMSTPARTKB		H
WHERE	A.AreaCode		= @ps_areacode	And
		A.DivisionCode		like @ps_divcode	And
         		A.PartKBStatus		= 'C'			And
         		A.UseCenterGubun	= 'E'			And	-- 사용처 : 외주업체 'E', 사내 'I'   
		A.UseCenter		like @ps_suppcode	And
		( isNull(A.BuyBackNo, '') 	= ''  Or A.BuyBackNo = @ps_buybackNo ) And

		A.AreaCode		= B.AreaCode		And
		A.DivisionCode		= B.DivisionCode	And
		A.SupplierCode		= B.SupplierCode	And
		A.ItemCode		= B.ItemCode		And
		B.ApplyFrom		<= A.PartIncomeDate	And
		B.ApplyTo		>= A.PartIncomeDate	And

		A.AreaCode		= D.AreaCode		And
		A.DivisionCode		= D.DivisionCode	And

		A.SupplierCode		= E.SupplierCode	And

		A.ItemCode		= F.ItemCode		And

		A.AreaCode		= H.AreaCode		And
		A.DivisionCode		= H.DivisionCode	And
		A.SupplierCode		= H.SupplierCode	And
		A.ItemCode		= H.ItemCode	

Set NoCount Off
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

