SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr190i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr190i_01]
GO

--------------------------------------------------
--	입고대기일수 현황		--
-------------------------------------------------
CREATE Procedure sp_pisr190i_01
	@ps_area		Char(1),	--지역
	@ps_division		Char(1),	--공장
        @ps_supplier 		VarChar(5), 	--업체
        @ps_item 		VarChar(12), 	--품번
        @ps_product 		VarChar(2), 	--제품군
	@ps_fromDate		Char(10),	--범위1
        @ps_toDate		Char(10) 	--범위2

AS
Begin
Set NoCount ON

SELECT 	B.AreaCode, B.DivisionCode, B.SupplierCode, B.ItemCode,
	TotNkbQty 	= Sum( isNull(B.TotNkbQty, 0) ),
	TotTkbQty 	= Sum( isNull(B.TotTkbQty, 0) ),
	Day0_N 		= Sum( isNull(B.Day0_N, 0) ),
	Day0_T 		= Sum( isNull(B.Day0_T, 0) ),
	Day1_N 		= Sum( isNull(B.Day1_N, 0) ),
	Day1_T 		= Sum( isNull(B.Day1_T, 0) ),
	Day2_N 		= Sum( isNull(B.Day2_N, 0) ),
	Day2_T 		= Sum( isNull(B.Day2_T, 0) ),
	Day345_N	= Sum( isNull(B.Day345_N, 0) ),
	Day345_T	= Sum( isNull(B.Day345_T, 0) ),
	Day6_N 		= Sum( isNull(B.Day6_N, 0) ),
	Day6_T 		= Sum( isNull(B.Day6_T, 0) )
  INTO  #KBCOUNT_tmp
  From 	( -- 
	SELECT  AreaCode,DivisionCode,SupplierCode,ItemCode,   
		Count(*) As TotNkbQty,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '0' Then Count(*) Else 0 End As Day0_N,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '1' Then Count(*) Else 0 End As Day1_N,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '2' Then Count(*) Else 0 End As Day2_N,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '3' Then Count(*) Else 0 End As Day345_N,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '6' Then Count(*) Else 0 End As Day6_N,
		0 As TotTkbQty,
		0 As Day0_T,
		0 As Day1_T,
		0 As Day2_T,
		0 As Day345_T,
		0 As Day6_T
    	  FROM 	TPARTKBHIS  A
  	 WHERE 	A.AreaCode 	= @ps_area		And 
		A.DivisionCode	= @ps_division		And 
		A.SupplierCode	like @ps_supplier	And
		A.ItemCode 	like @ps_item		And
		( Select Top 1 D.ProductGroup From TMSTMODEL D Where D.AreaCode = A.AreaCode And D.DivisionCode = A.DivisionCode And D.ItemCode = A.ItemCode ) like @ps_product And
		A.PartKBGubun	= 'N' 			And
		A.PartKBStatus	= 'C' 			And
		A.PartIncomeDate >= @ps_fromDate	And
		A.PartIncomeDate <= @ps_toDate	
      Group By  AreaCode,DivisionCode,SupplierCode,ItemCode,
		( Case 
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
			Else '6' 
		  End )

	 Union  All

	SELECT  AreaCode,DivisionCode,SupplierCode,ItemCode,   
		0 As TotNkbQty,
		0 As Day0_N,
		0 As Day1_N,
		0 As Day2_N,
		0 As Day345_N,
		0 As Day6_N,
		Count(*) As TotTkbQty,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '0' Then Count(*) Else 0 End As Day0_T,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '1' Then Count(*) Else 0 End As Day1_T,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '2' Then Count(*) Else 0 End As Day2_T,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '3' Then Count(*) Else 0 End As Day345_T,
		Case When (	Case 
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
				When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
				Else '6' 
				End
			  ) = '6' Then Count(*) Else 0 End As Day6_T
    	  FROM 	TPARTKBHIS  A
  	 WHERE 	A.AreaCode 	= @ps_area		And 
		A.DivisionCode	= @ps_division		And 
		A.SupplierCode	like @ps_supplier	And
		A.ItemCode 	like @ps_item		And
		( Select Top 1 D.ProductGroup From TMSTMODEL D Where D.AreaCode = A.AreaCode And D.DivisionCode = A.DivisionCode And D.ItemCode = A.ItemCode ) like @ps_product And
		A.PartKBGubun	= 'T' 			And
		A.PartKBStatus	= 'C' 			And
		A.PartIncomeDate >= @ps_fromDate	And
		A.PartIncomeDate <= @ps_toDate	
      Group By  AreaCode,DivisionCode,SupplierCode,ItemCode,
		( Case 
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 0 Then '0'
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 1 Then '1'
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) = 2 Then '2'
			When DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) >= 3  and DATEDIFF( day, A.PartReceiptTime, A.PartIncomeTime ) <= 5 Then '3'
			Else '6' 
		  End )

	) As B
Group By  AreaCode,DivisionCode,SupplierCode,ItemCode

  SELECT 	A.AreaCode,   
         	A.DivisionCode,   
         	A.SupplierCode,   
         	C.SupplierKorName,   
         	C.SupplierNo,   
         	A.ItemCode,   
         	B.ItemName,   
         	B.ItemSpec,   
         	F.SupplyTerm,   
         	F.SupplyEditNo,   
         	F.SupplyCycle,
		A.TotNkbQty, 
		A.TotTkbQty, 
		A.Day0_N,
		A.Day0_T,
		A.Day1_N,
		A.Day1_T,
		A.Day2_N,
		A.Day2_T,
		A.Day345_N,	
		A.Day345_T,	
		A.Day6_N,
		A.Day6_T,
		( Select Top 1 D.ProductGroup From TMSTMODEL D Where D.AreaCode = A.AreaCode And D.DivisionCode = A.DivisionCode And D.ItemCode = A.ItemCode ) As ProductGroup
    FROM 	#KBCOUNT_tmp	A,
         	TMSTITEM	B,   
         	TMSTSUPPLIER 	C,   
         	TMSTPARTCYCLE 	F
   WHERE 	A.ItemCode 		= B.ItemCode 		and  

         	A.SupplierCode 		= C.SupplierCode 	and  
		
		A.AreaCode 		= F.AreaCode	 	and  
         	A.DivisionCode 		= F.DivisionCode 	and  
         	A.SupplierCode 		= F.SupplierCode	and  
         	F.ApplyTo		= '9999.12.31'

Drop Table #KBCOUNT_tmp

Set NoCount Off


End		-- Procedure End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

