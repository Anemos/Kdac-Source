SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr011i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr011i_01]
GO



----------------------------------------------------------
--            	외주간판품목 검색( 품번(No)		--
----------------------------------------------------------
CREATE PROCEDURE sp_pisr011i_01
 	@ps_areaCode	 Char(1),   	-- 지역 코드
 	@ps_divCode	 Char(1),   	-- 공장 코드
 	@ps_itemCode	 VarChar(12)   	-- 품번
AS
BEGIN

Set NoCount ON

  SELECT A.AreaCode,   
         	A.DivisionCode,   
         	A.SupplierCode,
	C.SupplierKorName, 
         	A.ItemCode,   
         	B.ItemName,   
         	A.ApplyFrom,   
         	A.PartType,   
         	A.ChangeFlag,   
         	A.PartModelID,   
         	A.PartID,   
         	A.UseCenterGubun,   
         	Case IsNull(A.UseCenterGubun, '') When 'I' Then 
			( SELECT D.WorkCenterName FROM TMSTWORKCENTER D
				WHERE 	D.DivisionCode 	= A.DivisionCode  And
                  				D.WorkCenter 	= A.UseCenter  )
         	Else
			( SELECT D.SupplierKorName  
				 FROM TMSTSUPPLIER D   
				WHERE D.SupplierCode 	= A.UseCenter  ) End as UseCenterNm,
         	A.UseCenter,   
         	A.CostGubun,   
         	A.RackQty,   
         	A.RackCode,   
         	A.StockGubun,   
         	A.ReceiptLocation,   
         	A.MailBoxNo,   
         	A.SafetyStock,   
         	A.UseFlag,   
         	A.AutoReorderFlag,   
         	A.KBUseFlag,   
         	A.ChangeDate,   
         	A.NormalKBSN,   
         	A.TempKBSN,   
         	A.PartKBPrintCount,   
         	A.PartKBActiveCount,   
         	A.PartKBPlanCount,   
         	A.LastEmp,   
         	A.LastDate   
    FROM TMSTPARTKB	A,   
         	TMSTITEM	B, 
         	TMSTSUPPLIER	C 
   WHERE A.ItemCode 	= B.ItemCode  	AND  
         	A.supplierCode 	= C.supplierCode  AND 
           	A.AreaCode 	= @ps_areaCode  	AND  
            A.DivisionCode 	= @ps_divCode 		AND  
            A.ItemCode 	= @ps_itemCode      

Set NoCount Off

End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

