/*
  File Name : sp_pisr135b_01.sql
  SYSTEM    : 외주간판 System
  Procedure Name  : sp_pisr135b_01
  Description : 사급품반출증작성 간판리스트 ( new : 2003.07.15 )
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisr135b_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisr135b_01]
GO

/*
exec sp_pisr135b_01 'D','A','%','','Y'
*/

Create Procedure sp_pisr135b_01
 	@ps_areacode		Char(1),		-- 지역코드
 	@ps_divcode		Char(1),		-- 공장코드
 	@ps_suppcode		VarChar(7),	-- 반출처 코드
 	@ps_buybackNo	VarChar(11)	-- 반출증 발행번호

AS

BEGIN
  SELECT 	PartKBNo = A.PartKBNo,
    ApplyDate = A.ApplyDate,
    PartOrderSeq = A.PartOrderSeq,
    DivisionCode = A.DivisionCode,
    DivisionName = D.DivisionName,
    SupplierCode = A.SupplierCode,
    SupplierNo = E.SupplierNo,
    SupplierKorName = E.SupplierKorName,
    ItemCode = A.ItemCode,
    ItemName = F.ItemName,
    ItemSpec = F.ItemSpec,
    ApplyFrom = A.ApplyFrom,
    PartType = A.PartType,
    RackQty = A.RackQty,
    UseCenterGubun = A.UseCenterGubun,
    UseCenter = A.UseCenter,
    PartOrderDate = A.PartOrderDate,
    PartOrderTime = A.PartOrderTime,
    PartForecastDate = A.PartForecastDate,
    PartForecastEditNo = A.PartForecastEditNo,
    PartForecastTime = A.PartForecastTime,
    PartReceiptDate = A.PartReceiptDate,
    PartEditNo = A.PartEditNo,
    PartReceiptTime = A.PartReceiptTime,
    PartIncomeDate = A.PartIncomeDate,
    PartIncomeTime = A.PartIncomeTime,
    PartOrderNo = A.PartOrderNo,
    DeliveryNo = A.DeliveryNo,
    BuyBackNo = A.BuyBackNo,
    OrderChangeTime = A.OrderChangeTime,
    OrderChangeCode = A.OrderChangeCode,
    ChangeForecastDate = A.ChangeForecastDate,
    ChangeForecastEditNo = A.ChangeForecastEditNo,
    ChangeForecastTime = A.ChangeForecastTime,
    LastEmp = A.LastEmp,
    LastDate = A.LastDate,
    PartModelID = H.PartModelID,
    CostGubun = B.CostGubun,
    RackCode = B.RackCode,
    StockGubun = B.StockGubun,
    ReceiptLocation = B.ReceiptLocation,
    MailBoxNo = B.MailBoxNo,
    SafetyStock = B.SafetyStock,
		SelectChk = case A.BuyBackNo when @ps_buybackNo then 1 else 0 end,
		BuyBackFlag = B.BuyBackFlag
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

END
