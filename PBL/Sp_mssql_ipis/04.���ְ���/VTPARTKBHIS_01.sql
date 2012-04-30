/*
  File Name : VTPARTKBHIS_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  View Name  : VTPARTKBHIS_01
  Description : 사급자재 반출데이타용 VIEW
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2006.12
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[VTPARTKBHIS_01]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[VTPARTKBHIS_01]
GO

/* select * from VTPARTKBHIS_01 */

CREATE  View VTPARTKBHIS_01

As

SELECT 	PartKBNo = A.PartKBNo,
    ApplyDate = A.ApplyDate,
    PartOrderSeq = A.PartOrderSeq,
    AreaCode  = A.AreaCode,
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
    PartModelID = B.PartModelID,
    CostGubun = B.CostGubun,
    RackCode = B.RackCode,
    StockGubun = B.StockGubun,
    ReceiptLocation = B.ReceiptLocation,
    MailBoxNo = B.MailBoxNo,
    SafetyStock = B.SafetyStock,
		BuyBackFlag = B.BuyBackFlag
  FROM 	TPARTKBHIS 		A INNER JOIN TMSTPARTKBHIS 	B
    ON A.AreaCode		= B.AreaCode		And
		  A.DivisionCode		= B.DivisionCode	And
		  A.SupplierCode		= B.SupplierCode	And
		  A.ItemCode		= B.ItemCode And
		  B.ApplyFrom		<= A.PartIncomeDate	And
		  B.ApplyTo		>= A.PartIncomeDate
		INNER JOIN TMSTDIVISION 	D
		ON A.AreaCode		= D.AreaCode		And
		  A.DivisionCode		= D.DivisionCode
		LEFT OUTER JOIN TMSTSUPPLIER E
    ON A.SupplierCode		= E.SupplierCode
    INNER JOIN TMSTITEM 		F
    ON A.ItemCode		= F.ItemCode
  WHERE	A.PartKBStatus		= 'C'			And
    A.UseCenterGubun	= 'E'

go
