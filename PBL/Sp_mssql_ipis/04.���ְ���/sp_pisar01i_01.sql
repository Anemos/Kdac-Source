/*
  File Name : sp_pisar01i_01.SQL
  SYSTEM    : KDAC ���� ���� ���� �ý���
  Procedure Name  : sp_pisar01i_01
  Description : 
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.02.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisar01i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisar01i_01]
GO

------------------------------------------------------------------
--         ��ü�� �����ؼ� ��Ȳ ��� ( DataWindow )			--
-- exec sp_pisar01i_01 '%','%','D0142','2003.06.01','2003.06.30','Y'
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisar01i_01
	@ps_area		Char(1),	-- ����
	@ps_division		Char(1),	-- ����
	@ps_supplier		VarChar(5),	-- ��ü
	@ps_applyfrom		Char(10),	-- ��������(����)
	@ps_applyto		Char(10),  	-- ��������(����)
	@ps_tempchk	Char(1)
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
		KBGubun	= A.PartKBGubun,	-- ���Ǳ��� ( N;���԰���, T;�ӽð��� )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- �����ؼ�����
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- �ð��ؼ�����
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime	End,	-- ���Կ����ð�
		ReceiptTime	= A.PartReceiptTime	-- ���Խð�
From		TPARTKBHIS_ALL		A
WHERE		A.AreaCode	like @ps_area		And
		A.DivisionCode	like @ps_division		And
		A.SupplierCode	like @ps_supplier	And
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
		KBGubun		= A.PartKBGubun,	-- ���Ǳ��� ( N;���԰���, T;�ӽð��� )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- �����ؼ�����
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- �ð��ؼ�����
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForeCastTime Else A.PartForeCastTime	End,	-- ���Կ����ð�
		ReceiptTime	= A.PartReceiptTime	-- ���Խð�
From		TPARTKBSTATUS_ALL	A
WHERE		A.AreaCode	like @ps_area		And
		A.DivisionCode	like @ps_division		And
		A.SupplierCode	like @ps_supplier	And
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

if @ps_tempchk = 'Y'

	SELECT 		AreaCode 	= B.AreaCode,
		DivisionCode 	= C.DivisionCode,
		DivisionName 	= C.DivisionName,
		SupplierCode 	= A.SupplierCode,
		SupplierNo	= D.SupplierNo,
		SupplierName	= D.SupplierKorName,	
		ItemQty		= A.ItemQty,

		TotalQty	= ( Select 	Count(*)			-- ��ü���� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode ),
		TempQty	= ( Select 	Count(*)				-- �ӽð��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'T' ),
		DayOkQty	= ( Select 	Count(*)				-- �����ؼ����Ǽ�
				       From	#RECEIPT_tmp	H
				     Where H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 1),
		TimeOkQty	= ( Select 	Count(*)			-- �ð��ؼ����Ǽ�	
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 1 ) ,
		UnderDayQty	= ( Select 	Count(*)				-- �������ؼ��� ���԰��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				      and		H.SupplierCode		= A.SupplierCode 
				      and		H.ObeyDateFlag		= 0 
					and	Convert( Char(10), H.ForeCastTime, 102) > Convert( Char(10), H.ReceiptTime, 102) ),
		UnderTimeQty	= ( Select 	Count(*)				-- ����ð��ؼ��� ���԰��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     and		H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		> H.ReceiptTime  ),
		Day1Qty	= ( Select 	Count(*)				-- 1�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Day2Qty	= ( Select 	Count(*)				-- 2�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Day3Qty	= ( Select 	Count(*)				-- 3�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Day4Qty	= ( Select 	Count(*)				-- 4�� �̻���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) >= 4 ),
		Time1Qty	= ( Select 	Count(*)				-- 1�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Time2Qty	= ( Select 	Count(*)				-- 2�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime   
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Time3Qty	= ( Select 	Count(*)				-- 3�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Time4Qty	= ( Select 	Count(*)				-- 4�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 4 ),
		Time5Qty	= ( Select 	Count(*)				-- 5�ð� �̻� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) >= 5 ),
		AreaName		= B.AreaName,
		FromDate	= @ps_applyfrom,
		ToDate		= @ps_applyto	
	FROM		#SUPPLIER_tmp	A,
		TMSTAREA	B,
		TMSTDIVISION	C,
		TMSTSUPPLIER	D,
		( SELECT DISTINCT Areacode, Divisioncode FROM #RECEIPT_tmp) E
	WHERE		B.AreaCode	= C.Areacode		And
		C.AreaCode	= E.Areacode			And
		C.DivisionCode	= E.Divisioncode		And
		A.SupplierCode 	= D.SupplierCode

else

	SELECT 		AreaCode 	= B.AreaCode,
		DivisionCode 	= C.DivisionCode,
		DivisionName 	= C.DivisionName,
		SupplierCode 	= A.SupplierCode,
		SupplierNo	= D.SupplierNo,
		SupplierName	= D.SupplierKorName,	
		ItemQty		= A.ItemQty,

		TotalQty	= ( Select 	Count(*)			-- ��ü���� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode ),
		TempQty	= ( Select 	Count(*)				-- �ӽð��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'T' ),
		DayOkQty	= ( Select 	Count(*)				-- �����ؼ����Ǽ�
				       From	#RECEIPT_tmp	H
				     Where H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
 					and		H.KBGubun		<> 'T'
				     and		H.ObeyDateFlag		= 1),
		TimeOkQty	= ( Select 	Count(*)			-- �ð��ؼ����Ǽ�	
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
					and		H.KBGubun		<> 'T'
				     and		H.ObeyTimeFlag		= 1 ) ,
		UnderDayQty	= ( Select 	Count(*)				-- �������ؼ��� ���԰��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and		H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
					and	Convert( Char(10), H.ForeCastTime, 102) > Convert( Char(10), H.ReceiptTime, 102) ),
		UnderTimeQty	= ( Select 	Count(*)				-- ����ð��ؼ��� ���԰��� ��
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		> H.ReceiptTime  ),
		Day1Qty	= ( Select 	Count(*)				-- 1�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Day2Qty	= ( Select 	Count(*)				-- 2�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Day3Qty	= ( Select 	Count(*)				-- 3�� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Day4Qty	= ( Select 	Count(*)				-- 4�� �̻���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) >= 4 ),
		Time1Qty	= ( Select 	Count(*)				-- 1�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Time2Qty	= ( Select 	Count(*)				-- 2�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime   
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Time3Qty	= ( Select 	Count(*)				-- 3�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Time4Qty	= ( Select 	Count(*)				-- 4�ð� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 4 ),
		Time5Qty	= ( Select 	Count(*)				-- 5�ð� �̻� ���
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) >= 5 ),
		AreaName		= B.AreaName,
		FromDate	= @ps_applyfrom,
		ToDate		= @ps_applyto	
	FROM		#SUPPLIER_tmp	A,
		TMSTAREA	B,
		TMSTDIVISION	C,
		TMSTSUPPLIER	D,
		( SELECT DISTINCT Areacode, Divisioncode FROM #RECEIPT_tmp) E
	WHERE		B.AreaCode	= C.Areacode		And
		C.AreaCode	= E.Areacode			And
		C.DivisionCode	= E.Divisioncode		And
		A.SupplierCode 	= D.SupplierCode

Drop Table	#SUPPLIER_tmp
Drop Table	#RECEIPT_tmp

End	-- End PROCEDURE

GO

