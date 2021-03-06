SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr011i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr011i_02]
GO



----------------------------------------------------------
--            외주간판품목 검색 ( 품명(Name) )		--
----------------------------------------------------------
CREATE PROCEDURE sp_pisr011i_02
 	@ps_areaCode	 Char(1),   	-- 지역 코드
 	@ps_divCode	 Char(1),   	-- 공장 코드
 	@ps_itemName	 VarChar(30)   	-- 품명
AS
BEGIN

Set NoCount ON

	Create	Table #Tmp_ItemList
	(	AreaCode 	Char(1),
		DivisionCode 	Char(1),
		ItemCode	Char(12),
		ItemName	VarChar(30)
	)
	
		Insert #Tmp_ItemList
			Select	Distinct
				A.AreaCode,	
				A.DivisionCode,
				A.ItemCode, 
				B.ItemName
			From	TMSTMODEL	A,
				TMSTITEM	B
			Where 	A.AreaCode 	= @ps_areaCode 	And
				A.DivisionCode 	= @ps_divCode 		And
				A.ItemCode 	= B.ItemCode 		And
				B.ItemName	like @ps_itemName 

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
    FROM TMSTPARTKB		A,   
         	#Tmp_ItemList		B , 
         	TMSTSUPPLIER	C 
   WHERE 
         	A.supplierCode 	= C.supplierCode  	AND 
           	A.AreaCode 	= B.AreaCode  		AND  
            A.DivisionCode 	= B.DivisionCode	AND  
            A.ItemCode 	= B.ItemCode


Drop Table #Tmp_ItemList
Set NoCount Off

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

