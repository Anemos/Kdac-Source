SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eisr130i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eisr130i_01]
GO

------------------------------------------------------------------
--      업체별 납기준수 현황(공장별) 			--
------------------------------------------------------------------
CREATE PROCEDURE sp_eisr130i_01
	@ps_area		Char(1),	-- 지역
	@ps_division		Char(1),	-- 공장
	@ps_supplier		VarChar(5),	-- 업체
	@ps_applyfrom		Char(10),	-- 기준일자(시작)
	@ps_applyto		Char(10)	-- 기준일자(종료)
AS
BEGIN

Begin

Create	Table	#RECEIPT_tmp
	( 	AreaCode	Char(1),
		DivisionCode	Char(1),
		SupplierCode	VarChar(5),
		ItemCode	VarChar(12), 
		KBNo		Char(11),
		ApplyDate	Char(10),
		IncomeSeq	Integer,
		KBGubun		Char(1), 
		ObeyDateFlag	Bit		Null, 
		ObeyTimeFlag	Bit		Null, 
		ForeCastTime	DateTime	Null, 
		ReceiptTime	DateTime	Null	 )

INSERT INTO	#RECEIPT_tmp( AreaCode, DivisionCode, SupplierCode, ItemCode, KBNo, ApplyDate,IncomeSeq, KBGubun, ObeyDateFlag, ObeyTimeFlag, 
				ForeCastTime, ReceiptTime )-- 기간내 해당 공장 간판 TABLE 정리
SELECT		AreaCode 	= A.AreaCode,		-- 지역
		DivisionCode 	= A.DivisionCode,	-- 공장
		SupplierCode 	= A.SupplierCode,	-- 업체
		ItemCode	= A.ItemCode,		-- 품번
		KBNo 		= A.PartKBNo,		-- 간판번호
		ApplyDate 	= A.ApplyDate,		-- 발주일자
		IncomeSeq 	= A.PartOrderSeq,	-- 순번
		KBGubun		= A.PartKBGubun,	-- 간판구분 ( N;정규간판, T;임시간판 )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- 날자준수여부
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- 시간준수여부
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime	End,	-- 납입예정시간
		ReceiptTime	= A.PartReceiptTime	-- 납입시간
From		TPARTKBHIS		A
WHERE		A.AreaCode	= @ps_area		And
		A.DivisionCode	= @ps_division		And
		--A.SupplierCode	like @ps_supplier	And
		A.PartKBStatus	= 'C'			And
		Convert( Char(10), A.PartReceiptTime, 102) >= @ps_applyfrom	And
		Convert( Char(10), A.PartReceiptTime, 102) <= @ps_applyto	
Union
SELECT		AreaCode 	= A.AreaCode,		-- 지역
		DivisionCode 	= A.DivisionCode,	-- 공장
		SupplierCode 	= A.SupplierCode,	-- 업체
		ItemCode	= A.ItemCode,		-- 품번
		KBNo 		= A.PartKBNo,		-- 간판번호
		ApplyDate 	= A.PartOrderDate,	-- 발주일자
		IncomeSeq 	= 1,			-- 순번
		KBGubun		= A.PartKBGubun,	-- 간판구분 ( N;정규간판, T;임시간판 )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- 날자준수여부
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- 시간준수여부
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForeCastTime Else A.PartForeCastTime	End,	-- 납입예정시간
		ReceiptTime	= A.PartReceiptTime	-- 납입시간
From		TPARTKBSTATUS	A
WHERE		A.AreaCode	= @ps_area		And
		A.DivisionCode	= @ps_division		And
		--A.SupplierCode	like @ps_supplier	And
		A.PartKBStatus	= 'B'			And	-- 가입고 상태인것 ( 개별간판 )
		Convert( Char(10), A.PartReceiptTime, 102) >= @ps_applyfrom	And
		Convert( Char(10), A.PartReceiptTime, 102) <= @ps_applyto


End	-- insert into

-- 외주간판업체 목록 및 품목수  ( #SUPPLIER_tmp )
  SELECT 	SupplierCode	= A.SupplierCode,   
		ItemQty		= Count( Distinct A.ItemCode )
    INTO	#SUPPLIER_tmp
    FROM	#RECEIPT_tmp	A,
		TMSTSUPPLIER	B
   WHERE	B.SupplierCode 	= A.SupplierCode
Group By	A.SupplierCode


-- 각 간판매수를 Count한다.
SELECT 		AreaCode 	= B.AreaCode,
		AreaName 	= B.AreaName,
		DivisionCode 	= C.DivisionCode,
		DivisionName 	= C.DivisionName,
		SupplierCode 	= A.SupplierCode,
		SupplierNo	= D.SupplierNo,
		SupplierKorName	= D.SupplierKorName,	
		ItemQty		= A.ItemQty,
		TotalQty	= ( Select 	Count(*)			-- 전체간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode ),
		TempQty	= ( Select 	Count(*)				-- 임시간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'T' ),		DayOkQty	= ( Select 	Count(*)				-- 일자준수간판수
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 1 ),
		TimeOkQty	= ( Select 	Count(*)				-- 시간준수간판수
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 1 ),
		UnderQty	= ( Select 	Count(*)				-- 납기전 납입간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		> H.ReceiptTime  ),
		Day1Qty	= ( Select 	Count(*)				-- 1일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 1 ),		Day2Qty	= ( Select 	Count(*)				-- 2일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Day3Qty	= ( Select 	Count(*)				-- 3일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Day4Qty	= ( Select 	Count(*)				-- 4일 이상경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) >= 4 ),
		Time1Qty	= ( Select 	Count(*)				-- 1시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Time2Qty	= ( Select 	Count(*)				-- 2시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Time3Qty	= ( Select 	Count(*)				-- 3시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Time4Qty	= ( Select 	Count(*)				-- 4시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 4 ),
		Time5Qty	= ( Select 	Count(*)				-- 5시간 이상 경과
				       From	#RECEIPT_tmp	H
				     Where	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'N' 				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) >= 5 )	
INTO		#SELECT_tmp
FROM		#SUPPLIER_tmp	A,
		TMSTAREA	B,
		TMSTDIVISION	C,
		TMSTSUPPLIER	D
WHERE		B.AreaCode	= @ps_area		And
		C.AreaCode	= @ps_area		And
		C.DivisionCode	= @ps_division		And
		A.SupplierCode 	= D.SupplierCode

-- 실데이타 SELECT
SELECT 		AreaCode ,
		AreaName,
		DivisionCode,
		DivisionName,
		SupplierCode,
		SupplierNo,
		SupplierKorName,	
		ItemQty,
		TotalQty,
		TempQty,
		Round( (isNull(TempQty,0)*1.0)/ isNull(TotalQty,0) * 100.0, 2 ) As TempRate,		DayOkQty,
		Round( (isNull(DayOkQty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As DayRate,		TimeOkQty,
		Round( (isNull(TimeOkQty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As TimeRate,		UnderQty,
		Round( (isNull(UnderQty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As UnderRate,		Day1Qty,		Round( (isNull(Day1Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As DayRate1,		Day2Qty,
		Round( (isNull(Day2Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As DayRate2,
		Day3Qty,
		Round( (isNull(Day3Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As DayRate3,		Day4Qty,
		Round( (isNull(Day4Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As DayRate4,		Time1Qty,
		Round( (isNull(Time1Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As TimeRate1,		Time2Qty,
		Round( (isNull(Time2Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As TimeRate2,		Time3Qty,
		Round( (isNull(Time3Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As TimeRate3,		Time4Qty,
		Round( (isNull(Time4Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As TimeRate4,		Time5Qty,	
		Round( (isNull(Time5Qty,0)*1.0)/ (isNull(TotalQty,0) - isNull(TempQty,0)) * 100.0, 2 ) As TimeRate5FROM		#SELECT_tmp
WHERE		(isNull(TotalQty,0) - isNull(TempQty,0)) > 0

Drop Table	#SUPPLIER_tmp
Drop Table	#RECEIPT_tmp
Drop Table	#SELECT_tmp

End	-- End PROCEDURE
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

