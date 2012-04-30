/*
  File Name : sp_pisar01i_01.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
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
--         업체별 납기준수 현황 출력 ( DataWindow )			--
-- exec sp_pisar01i_01 '%','%','D0142','2003.06.01','2003.06.30','Y'
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisar01i_01
	@ps_area		Char(1),	-- 지역
	@ps_division		Char(1),	-- 공장
	@ps_supplier		VarChar(5),	-- 업체
	@ps_applyfrom		Char(10),	-- 기준일자(시작)
	@ps_applyto		Char(10),  	-- 기준일자(종료)
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
				ForeCastTime, ReceiptTime )-- 기간내 해당 공장 간판 TABLE 정리
SELECT		KBNo 		= A.PartKBNo,		-- 간판번호
		ApplyDate 	= A.ApplyDate,		-- 발주일자
		IncomeSeq 	= A.PartOrderSeq,	-- 순번
		AreaCode 	= A.AreaCode,		-- 지역
		DivisionCode 	= A.DivisionCode,	-- 공장
		SupplierCode 	= A.SupplierCode,	-- 업체
		ItemCode	= A.ItemCode,		-- 품번
		KBGubun	= A.PartKBGubun,	-- 간판구분 ( N;정규간판, T;임시간판 )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- 날자준수여부
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- 시간준수여부
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime	End,	-- 납입예정시간
		ReceiptTime	= A.PartReceiptTime	-- 납입시간
From		TPARTKBHIS_ALL		A
WHERE		A.AreaCode	like @ps_area		And
		A.DivisionCode	like @ps_division		And
		A.SupplierCode	like @ps_supplier	And
		A.PartKBStatus	= 'C'			And
		Convert( Char(10), A.PartReceiptTime, 102) >= @ps_applyfrom	And
		Convert( Char(10), A.PartReceiptTime, 102) <= @ps_applyto

--		( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ) like @ps_product 

Union
SELECT		KBNo 		= A.PartKBNo,		-- 간판번호
		ApplyDate 	= A.PartOrderDate,	-- 발주일자
		IncomeSeq 	= 1,			-- 순번
		AreaCode 	= A.AreaCode,		-- 지역
		DivisionCode 	= A.DivisionCode,	-- 공장
		SupplierCode 	= A.SupplierCode,	-- 업체
		ItemCode	= A.ItemCode,		-- 품번
		KBGubun		= A.PartKBGubun,	-- 간판구분 ( N;정규간판, T;임시간판 )
		ObeyDateFlag	= A.PartObeyDateFlag,	-- 날자준수여부
		ObeyTimeFlag	= A.PartObeyTimeFlag,	-- 시간준수여부
		ForeCastTime	= Case A.OrderChangeFlag When 'Y' Then A.ChangeForeCastTime Else A.PartForeCastTime	End,	-- 납입예정시간
		ReceiptTime	= A.PartReceiptTime	-- 납입시간
From		TPARTKBSTATUS_ALL	A
WHERE		A.AreaCode	like @ps_area		And
		A.DivisionCode	like @ps_division		And
		A.SupplierCode	like @ps_supplier	And
		A.PartKBStatus	= 'B'			And	-- 가입고 상태인것 ( 개별간판 )
		Convert( Char(10), A.PartReceiptTime, 102) >= @ps_applyfrom	And
		Convert( Char(10), A.PartReceiptTime, 102) <= @ps_applyto

--		( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ) like @ps_product 

End	-- insert into

-- 외주간판업체 목록 및 품목수  ( #SUPPLIER_tmp )
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

		TotalQty	= ( Select 	Count(*)			-- 전체간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode ),
		TempQty	= ( Select 	Count(*)				-- 임시간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'T' ),
		DayOkQty	= ( Select 	Count(*)				-- 일자준수간판수
				       From	#RECEIPT_tmp	H
				     Where H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 1),
		TimeOkQty	= ( Select 	Count(*)			-- 시간준수간판수	
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 1 ) ,
		UnderDayQty	= ( Select 	Count(*)				-- 납기일준수전 납입간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				      and		H.SupplierCode		= A.SupplierCode 
				      and		H.ObeyDateFlag		= 0 
					and	Convert( Char(10), H.ForeCastTime, 102) > Convert( Char(10), H.ReceiptTime, 102) ),
		UnderTimeQty	= ( Select 	Count(*)				-- 납기시간준수전 납입간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     and		H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		> H.ReceiptTime  ),
		Day1Qty	= ( Select 	Count(*)				-- 1일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Day2Qty	= ( Select 	Count(*)				-- 2일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Day3Qty	= ( Select 	Count(*)				-- 3일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Day4Qty	= ( Select 	Count(*)				-- 4일 이상경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) >= 4 ),
		Time1Qty	= ( Select 	Count(*)				-- 1시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Time2Qty	= ( Select 	Count(*)				-- 2시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime   
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Time3Qty	= ( Select 	Count(*)				-- 3시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Time4Qty	= ( Select 	Count(*)				-- 4시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 4 ),
		Time5Qty	= ( Select 	Count(*)				-- 5시간 이상 경과
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

		TotalQty	= ( Select 	Count(*)			-- 전체간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode ),
		TempQty	= ( Select 	Count(*)				-- 임시간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.KBGubun		= 'T' ),
		DayOkQty	= ( Select 	Count(*)				-- 일자준수간판수
				       From	#RECEIPT_tmp	H
				     Where H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
 					and		H.KBGubun		<> 'T'
				     and		H.ObeyDateFlag		= 1),
		TimeOkQty	= ( Select 	Count(*)			-- 시간준수간판수	
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
					and		H.KBGubun		<> 'T'
				     and		H.ObeyTimeFlag		= 1 ) ,
		UnderDayQty	= ( Select 	Count(*)				-- 납기일준수전 납입간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and		H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
					and	Convert( Char(10), H.ForeCastTime, 102) > Convert( Char(10), H.ReceiptTime, 102) ),
		UnderTimeQty	= ( Select 	Count(*)				-- 납기시간준수전 납입간판 수
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		> H.ReceiptTime  ),
		Day1Qty	= ( Select 	Count(*)				-- 1일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime 
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Day2Qty	= ( Select 	Count(*)				-- 2일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Day3Qty	= ( Select 	Count(*)				-- 3일 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime  
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Day4Qty	= ( Select 	Count(*)				-- 4일 이상경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyDateFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime
				     and		DateDiff( Day, H.ForeCastTime, H.ReceiptTime ) >= 4 ),
		Time1Qty	= ( Select 	Count(*)				-- 1시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 1 ),
		Time2Qty	= ( Select 	Count(*)				-- 2시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime   
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 2 ),
		Time3Qty	= ( Select 	Count(*)				-- 3시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode 
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 3 ),
		Time4Qty	= ( Select 	Count(*)				-- 4시간 경과
				       From	#RECEIPT_tmp	H
				     Where	H.Areacode = B.Areacode
				     	and		H.Divisioncode = C.Divisioncode
				     	and 	H.SupplierCode		= A.SupplierCode  
				     and		H.ObeyTimeFlag		= 0 
					and		H.KBGubun		<> 'T'
				     and		H.ForeCastTime		< H.ReceiptTime    
				     and		DateDiff( Hour, H.ForeCastTime, H.ReceiptTime ) = 4 ),
		Time5Qty	= ( Select 	Count(*)				-- 5시간 이상 경과
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

