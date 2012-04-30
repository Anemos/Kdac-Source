SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO






------------------------------------------------------------------
--         ��ü�� �����ؼ� ��Ȳ ��� ( DataWindow )			--
-- exec sp_pisr180i_01 'D','A','D0142','2003.10.01','2003.10.31'
------------------------------------------------------------------
ALTER       PROCEDURE sp_pisr180i_01
	@ps_area		Char(1),	-- ����
	@ps_division		Char(1),	-- ����
	@ps_supplier		VarChar(5),	-- ��ü
--	@ps_product		VarChar(2),	-- ��ǰ��
--	@ps_item		VarChar(12),	-- ǰ��
	@ps_applyfrom		Char(10),	-- ��������(����)
	@ps_applyto		Char(10)	-- ��������(����)
AS
BEGIN

Begin

Create	Table	#RECEIPT_tmp
	( 	KBNo		Char(11),
		ApplyDate	Char(10),
		IncomeSeq	Integer,
		AreaCode	Char(1),
		DivisionCode	Char(1),
		SupplierCode	VarChar(5),
		ItemCode	VarChar(12), 
--		ProductGroup	Char(2), 
		KBGubun		Char(1), 
		ObeyDateFlag	Bit		Null, 
		ObeyTimeFlag	Bit		Null, 
		ForeCastTime	DateTime	Null, 
		ReceiptTime	DateTime	Null	 )

INSERT INTO	#RECEIPT_tmp( KBNo, ApplyDate,IncomeSeq, AreaCode, DivisionCode, SupplierCode, ItemCode, KBGubun, ObeyDateFlag, ObeyTimeFlag, 
				ForeCastTime, ReceiptTime )-- �Ⱓ�� �ش� ���� ���� TABLE ����
SELECT		KBNo 		= A.PartKBNo,		-- ���ǹ�ȣ
		ApplyDate 	= A.ApplyDate,		-- ��������
		IncomeSeq 	= A.PartOrderSeq,	-- ����
		AreaCode 	= A.AreaCode,		-- ����
		DivisionCode 	= A.DivisionCode,	-- ����
		SupplierCode 	= A.SupplierCode,	-- ��ü
		ItemCode	= A.ItemCode,		-- ǰ��
--		ProductGroup	= ( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ), 
		KBGubun	= A.PartKBGubun,	-- ���Ǳ��� ( N;���԰���, T;�ӽð��� )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- �����ؼ�����
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- �ð��ؼ�����
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime	End,	-- ���Կ����ð�
		ReceiptTime	= A.PartReceiptTime	-- ���Խð�
From		TPARTKBHIS		A
WHERE		A.AreaCode	= @ps_area		And
		A.DivisionCode	= @ps_division		And
		A.SupplierCode	like @ps_supplier	And
--		A.ItemCode	like @ps_item		And
		A.PartKBStatus	= 'C'			And
		Convert( Char(10), A.PartReceiptTime, 102) >= @ps_applyfrom	And
		Convert( Char(10), A.PartReceiptTime, 102) <= @ps_applyto	

--		( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ) like @ps_product 

Union
SELECT		KBNo 		= A.PartKBNo,		-- ���ǹ�ȣ
		ApplyDate 	= A.PartOrderDate,	-- ��������
		IncomeSeq 	= 1,			-- ����
		AreaCode 	= A.AreaCode,		-- ����
		DivisionCode 	= A.DivisionCode,	-- ����
		SupplierCode 	= A.SupplierCode,	-- ��ü
		ItemCode	= A.ItemCode,		-- ǰ��
--		ProductGroup	= ( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ),
		KBGubun		= A.PartKBGubun,	-- ���Ǳ��� ( N;���԰���, T;�ӽð��� )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- �����ؼ�����
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- �ð��ؼ�����
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForeCastTime Else A.PartForeCastTime	End,	-- ���Կ����ð�
		ReceiptTime	= A.PartReceiptTime	-- ���Խð�
From		TPARTKBSTATUS	A
WHERE		A.AreaCode	= @ps_area		And
		A.DivisionCode	= @ps_division		And
		A.SupplierCode	like @ps_supplier	And
--		A.ItemCode	like @ps_item		And
		A.PartKBStatus	= 'B'			And	-- ���԰� �����ΰ� ( �������� )
		Convert( Char(10), A.PartReceiptTime, 102) >= @ps_applyfrom	And
		Convert( Char(10), A.PartReceiptTime, 102) <= @ps_applyto

--		( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ) like @ps_product 

End	-- insert into

-- ���ְ��Ǿ�ü ��� �� ǰ���  ( #SUPPLIER_tmp )
  SELECT 	SupplierCode	= A.SupplierCode,   
		ItemQty		= Count( Distinct A.ItemCode )
    INTO	#SUPPLIER_tmp
    FROM	#RECEIPT_tmp	A,
		TMSTSUPPLIER	B
   WHERE	B.SupplierCode 	= A.SupplierCode
Group By	A.SupplierCode

-- �� ����Ÿ
SELECT 		AreaCode 	= B.AreaCode,
		DivisionCode 	= C.DivisionCode,
		DivisionName 	= C.DivisionName,
		SupplierCode 	= A.SupplierCode,
		SupplierNo	= D.SupplierNo,
		SupplierName	= D.SupplierKorName,	
		ItemQty		= A.ItemQty,

		TotalQty	= ( Select 	Count(*)			-- ��ü���� ��
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode ),
		TempQty	= ( Select 	Count(*)				-- �ӽð��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'T' ),		DayOkQty	= ( Select 	Count(*)				-- �����ؼ����Ǽ�
				       From	#RECEIPT_tmp	H
				     Where H.SupplierCode		= A.SupplierCode
--		          		and		H.KBGubun		= 'N'
 				     and		H.ObeyDateFlag		= 1),
		TimeOkQty	= ( Select 	Count(*)			-- �ð��ؼ����Ǽ�	
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode
--					and		H.KBGubun		= 'N' 
				     and		H.ObeyTimeFlag		= 1 ) ,
		UnderQty	= ( Select 	Count(*)				-- ������ ���԰��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		> H.ReceiptTime  ),
		Day1Qty	= ( Select 	Count(*)				-- 1�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 1 ),		Day2Qty	= ( Select 	Count(*)				-- 2�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Day3Qty	= ( Select 	Count(*)				-- 3�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Day4Qty	= ( Select 	Count(*)				-- 4�� �̻���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) >= 4 ),
		Time1Qty	= ( Select 	Count(*)				-- 1�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Time2Qty	= ( Select 	Count(*)				-- 2�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime   
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Time3Qty	= ( Select 	Count(*)				-- 3�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Time4Qty	= ( Select 	Count(*)				-- 4�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 4 ),
		Time5Qty	= ( Select 	Count(*)				-- 5�ð� �̻� ���
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
--				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) >= 5 )	
FROM		#SUPPLIER_tmp	A,
		TMSTAREA	B,
		TMSTDIVISION	C,
		TMSTSUPPLIER	D
WHERE		B.AreaCode	= @ps_area		And
		C.AreaCode	= @ps_area		And
		C.DivisionCode	= @ps_division		And
		A.SupplierCode 	= D.SupplierCode

Drop Table	#SUPPLIER_tmp
Drop Table	#RECEIPT_tmp

End	-- End PROCEDURE





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

