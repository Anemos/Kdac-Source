SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr020i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr020i_01]
GO


------------------------------------------------
--    외주간판마스터 수정 이력조회 
------------------------------------------------

CREATE Procedure sp_pisr020i_01
            @ps_areaCode		Char(1), 
            @ps_divCode    		Char(1), 
            @ps_suppCode 		Char(5),
            @ps_itemCode  		VarChar(12) 
--            @ri_errcode       Int     Output 
As
Begin

Set NoCount ON


Create	Table #Tmp_ItemList
(	AreaCode 	Char(1),
	DivisionCode 	Char(1),
	SupplierCode	Char(5),
	ItemCode	Char(12)
)

	Insert #Tmp_ItemList
		Select	A.AreaCode,	
			A.DivisionCode,
			A.SupplierCode,
			A.ItemCode
		From	TMSTPARTKB	A
		Where 	A.AreaCode 		= @ps_areaCode 	And
			A.DivisionCode 		= @ps_divCode 		And
			A.SupplierCode 		like @ps_suppCode 	And
			A.ItemCode 		like @ps_itemCode 

Create	Table #Tmp_ApplyFrom
(	AreaCode 	Char(1),
	DivisionCode 	Char(1),
	SupplierCode	Char(5),
	ItemCode	Char(12),
	ApplyFrom	Char(10),
	ApplyChk	Char(1)
)

	Insert #Tmp_ApplyFrom
		Select	X.AreaCode,	
			X.DivisionCode,
			X.SupplierCode,
			X.ItemCode,
			X.ApplyFrom,
			'X'
		From 	(	Select	A.AreaCode,	
					A.DivisionCode,
					A.SupplierCode,
					A.ItemCode,
					B.ApplyFrom
				From 	#Tmp_ItemList A, TMSTPARTKBHIS B
				Where 	A.AreaCode 	= B.AreaCode 		And
					A.DivisionCode 	= B.DivisionCode 	And
					A.SupplierCode 	= B.SupplierCode 	And
					A.ItemCode 	= B.ItemCode 	) As X
		Where 	Exists ( 
				Select 	* 
				from 	TMSTPARTCYCLE C
				Where 	X.AreaCode 	= C.AreaCode 		And
					X.DivisionCode 	= C.DivisionCode 	And
					X.SupplierCode 	= C.SupplierCode 	And
					X.ApplyFrom      = C.ApplyFrom		)
		Union
		Select	Y.AreaCode,	
			Y.DivisionCode,
			Y.SupplierCode,
			Y.ItemCode,
			Y.ApplyFrom,
			'Y'
		From 	(	Select	A.AreaCode,	
					A.DivisionCode,
					A.SupplierCode,
					A.ItemCode,
					B.ApplyFrom
				From 	#Tmp_ItemList A, TMSTPARTKBHIS B
				Where 	A.AreaCode 	= B.AreaCode 		And
					A.DivisionCode 	= B.DivisionCode 	And
					A.SupplierCode 	= B.SupplierCode 	And
					A.ItemCode 	= B.ItemCode 	) As Y
		Where 	Not Exists ( 
				Select 	* 
				from 	TMSTPARTCYCLE C
				Where 	Y.AreaCode 	= C.AreaCode 		And
					Y.DivisionCode 	= C.DivisionCode 	And
					Y.SupplierCode 	= C.SupplierCode 	And
					Y.ApplyFrom      = C.ApplyFrom		)
		Union
		Select	Z.AreaCode,	
			Z.DivisionCode,
			Z.SupplierCode,
			Z.ItemCode,
			Z.ApplyFrom,
			'Z'
		From 	(	Select	A.AreaCode,	
					A.DivisionCode,
					A.SupplierCode,
					A.ItemCode,
					B.ApplyFrom
				From 	#Tmp_ItemList A, TMSTPARTCYCLE B
				Where 	A.AreaCode 	= B.AreaCode 		And
					A.DivisionCode 	= B.DivisionCode 	And
					A.SupplierCode 	= B.SupplierCode ) As Z
		Where 	Not Exists ( 
				Select 	* 
				from 	TMSTPARTKBHIS C
				Where 	Z.AreaCode 	= C.AreaCode 		And
					Z.DivisionCode 	= C.DivisionCode 	And
					Z.SupplierCode 	= C.SupplierCode 	And
					Z.ItemCode	= C.ItemCode		And
					Z.ApplyFrom      = C.ApplyFrom		)
		Order By 5 ASC

Begin
	Select	A.AreaCode,	
		A.DivisionCode,
		A.SupplierCode,
		A.ItemCode,
         		D.ItemName,
		A.ApplyFrom,
         		B.PartType,   
         		B.ChangeFlag,   
         		B.PartModelID,   
         		B.PartID,   
         		B.UseCenterGubun,   
         		B.UseCenter,   
         		B.CostGubun,   
         		B.RackQty,   
         		B.RackCode,   
         		B.StockGubun,   
         		B.ReceiptLocation,   
         		B.MailBoxNo,   
       		convert( char(1), C.SupplyTerm ) + '-' + convert( char(1), C.SupplyEditNo ) + '-' + convert( char(1), C.SupplyCycle ), 
		B.SafetyStock,   
	         	B.UseFlag,   
         		B.KBUseFlag,   
         		B.ChangeDate,
		A.ApplyChk   
	From 	#Tmp_ApplyFrom As A, TMSTPARTKBHIS As B, TMSTPARTCYCLE As C, TMSTITEM As D 
	Where 	A.AreaCode 	= B.AreaCode 		And
		A.DivisionCode 	= B.DivisionCode 	And
		A.SupplierCode 	= B.SupplierCode 	And
		A.ItemCode 	= B.ItemCode 		And
		A.ApplyFrom 	>= B.ApplyFrom		And
		A.ApplyFrom 	<= B.ApplyTo		And		A.ApplyFrom 	>= C.ApplyFrom		And
		A.ApplyFrom 	<= C.ApplyTo		And
		A.AreaCode 	= C.AreaCode 		And
		A.DivisionCode 	= C.DivisionCode 	And
		A.SupplierCode 	= C.SupplierCode 	And

		A.ItemCode 	= D.ItemCode 		


End
		
Drop Table #Tmp_ItemList
Drop Table #Tmp_ApplyFrom

Set NoCount Off

End				-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

