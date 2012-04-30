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
exec sp_pisr135b_01 'D','A','%','Y'
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
    DivisionName = A.DivisionName,
    SupplierCode = A.SupplierCode,
    SupplierNo = A.SupplierNo,
    SupplierKorName = A.SupplierKorName,
    ItemCode = A.ItemCode,
    ItemName = A.ItemName,
    ItemSpec = A.ItemSpec,
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
    PartModelID = A.PartModelID,
    CostGubun = A.CostGubun,
    RackCode = A.RackCode,
    StockGubun = A.StockGubun,
    ReceiptLocation = A.ReceiptLocation,
    MailBoxNo = A.MailBoxNo,
    SafetyStock = A.SafetyStock,
		SelectChk = case A.BuyBackNo when @ps_buybackNo then 1 else 0 end,
		BuyBackFlag = A.BuyBackFlag
  FROM 	VTPARTKBHIS_01 A
  WHERE	A.AreaCode		= @ps_areacode	And
		A.DivisionCode		= @ps_divcode	And
		A.UseCenter		like @ps_suppcode	And
		( isNull(A.BuyBackNo, '') 	= ''  Or A.BuyBackNo = @ps_buybackNo ) 

END
