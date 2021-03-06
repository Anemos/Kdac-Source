SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr200p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr200p_01]
GO

--------------------------------------------------------------------------
--		외주간판 이원화품번 발주비율 출력
--------------------------------------------------------------------------

CREATE PROCEDURE sp_pisr200p_01
	@ps_areaCode 		Char(1),	-- 지역 코드
	@ps_divCode 		Char(1),	-- 공장 코드
	@ps_itemCode 		VarChar(12),	-- 품번
	@ps_applyDate 		Char(10)	-- 기준일자
AS
BEGIN

Declare	@ls_applyMonth		char(7)		-- 기준월
Select	@ls_applyMonth		= substring(@ps_applyDate, 1, 7 )


-- 2원화된 항목을 검색한다.
	 SELECT	ItemCode
	   INTO	#ITEM_tmp
	   FROM	TMSTPARTKB
	  WHERE	AreaCode	= 	@ps_areaCode		And
		DivisionCode	= 	@ps_divCode		And
		ItemCode	like 	@ps_itemCode
	GROUP BY ItemCode
	 HAVING	Count(*) > 1

  SELECT 
	AreaCode	= B.AreaCode,   
	AreaName	= E.AreaName,   
	DivisionCode	= B.DivisionCode,   
	DivisionName	= F.DivisionName,   
        ItemCode	= B.ItemCode,   
        SupplierCode	= B.SupplierCode,   
        OrderRate	= A.OrderRate,   
	PartType	= B.PartType,
	ItemName	= C.ItemName,
	ItemSpec	= C.ItemSpec,
	ModelID		= B.PartModelID,
	SupplierName	= D.SupplierKorName,	
	SupplierNo	= D.SupplierNo,	
	OrderQty_3	= (	SELECT	SUM( isNull(X.PartOrderQty,0) )
				FROM	TPARTORDERSTAUS 	X
				WHERE	X.AreaCode		= B.AreaCode
				and	X.DivisionCode		= B.DivisionCode	
				and	X.SupplierCode		= B.SupplierCode
				and	X.ItemCode		= B.ItemCode		
				and	X.ApplyDate		>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	X.ApplyDate		< @ls_applyMonth + '.01' 
			  ),	-- 당월 이전 3개월 발주자재수량
	OrderQty_1	= (	SELECT	SUM( isNull(X.PartOrderQty,0) )
				FROM	TPARTORDERSTAUS 	X
				WHERE	X.AreaCode		= B.AreaCode
				and	X.DivisionCode		= B.DivisionCode	
				and	X.SupplierCode		= B.SupplierCode
				and	X.ItemCode		= B.ItemCode		
				and	X.ApplyDate		>= @ls_applyMonth + '.01'
				and	X.ApplyDate		<= @ps_applyDate
			  ),	-- 당월 발주자재수량
	NapipCnt_3	= (	SELECT	Count( * )
				FROM	TPARTKBHIS		Y				
				WHERE	Y.AreaCode		= B.AreaCode	
				and	Y.DivisionCode		= B.DivisionCode	
				and	Y.SupplierCode		= B.SupplierCode
				and	Y.ItemCode		= B.ItemCode		
				and	Y.PartKBStatus		= 'C'	-- 입고
				and	Y.PartReceiptDate	>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	Y.PartReceiptDate	< @ls_applyMonth + '.01' 
			  ) +	
			  (	SELECT	Count( * )
				FROM	TPARTKBSTATUS		Z				
				WHERE	Z.AreaCode		= B.AreaCode	
				and	Z.DivisionCode		= B.DivisionCode	
				and	Z.SupplierCode		= B.SupplierCode
				and	Z.ItemCode		= B.ItemCode		
				and	Z.PartKBStatus		= 'B '	-- 가입고
				and	Z.PartReceiptDate	>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	Z.PartReceiptDate	< @ls_applyMonth + '.01' 
			  ),	-- 당월 이전 3개월 납입간판매수
	NapipObeyCnt_3	= (	SELECT	Count( * )
				FROM	TPARTKBHIS		Y				
				WHERE	Y.AreaCode		= B.AreaCode	
				and	Y.DivisionCode		= B.DivisionCode	
				and	Y.SupplierCode		= B.SupplierCode
				and	Y.ItemCode		= B.ItemCode		
				and	Y.PartKBStatus		= 'C'	-- 입고
				and	Y.PartReceiptDate	>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	Y.PartReceiptDate	< @ls_applyMonth + '.01' 
				and 	Y.PartObeyTimeFlag	= 1	
			  ) +	
			  (	SELECT	Count( * )
				FROM	TPARTKBSTATUS		Z				
				WHERE	Z.AreaCode		= B.AreaCode	
				and	Z.DivisionCode		= B.DivisionCode	
				and	Z.SupplierCode		= B.SupplierCode
				and	Z.ItemCode		= B.ItemCode		
				and	Z.PartKBStatus		= 'B '	-- 가입고
				and	Z.PartReceiptDate	>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	Z.PartReceiptDate	< @ls_applyMonth + '.01' 
				and 	Z.PartObeyTimeFlag	= 1	
			  ),	-- 당월 이전 3개월 납입간판 중 시간준수간판매수
	NapipCnt_1	= (	SELECT	Count( * )
				FROM	TPARTKBHIS		Y				
				WHERE	Y.AreaCode		= B.AreaCode	
				and	Y.DivisionCode		= B.DivisionCode	
				and	Y.SupplierCode		= B.SupplierCode
				and	Y.ItemCode		= B.ItemCode		
				and	Y.PartKBStatus		= 'C'	-- 입고
				and	Y.PartIncomeDate	>= @ls_applyMonth + '.01'
				and	Y.PartIncomeDate	<= @ps_applyDate
			  ) +	
			  (	SELECT	Count( * )
				FROM	TPARTKBSTATUS		Z				
				WHERE	Z.AreaCode		= B.AreaCode	
				and	Z.DivisionCode		= B.DivisionCode	
				and	Z.SupplierCode		= B.SupplierCode
				and	Z.ItemCode		= B.ItemCode		
				and	Z.PartKBStatus		= 'B '	-- 가입고
				and	Z.PartIncomeDate	>= @ls_applyMonth + '.01'
				and	Z.PartIncomeDate	<= @ps_applyDate
			  ),	-- 당월 납입간판매수
	NapipObeyCnt_1	= (	SELECT	Count( * )
				FROM	TPARTKBHIS		Y				
				WHERE	Y.AreaCode		= B.AreaCode	
				and	Y.DivisionCode		= B.DivisionCode	
				and	Y.SupplierCode		= B.SupplierCode
				and	Y.ItemCode		= B.ItemCode		
				and	Y.PartKBStatus		= 'C'	-- 입고
				and	Y.PartIncomeDate	>= @ls_applyMonth + '.01'
				and	Y.PartIncomeDate	<= @ps_applyDate
				and 	Y.PartObeyTimeFlag	= 1	
			  ) +	
			  (	SELECT	Count( * )
				FROM	TPARTKBSTATUS		Z				
				WHERE	Z.AreaCode		= B.AreaCode	
				and	Z.DivisionCode		= B.DivisionCode	
				and	Z.SupplierCode		= B.SupplierCode
				and	Z.ItemCode		= B.ItemCode		
				and	Z.PartKBStatus		= 'B '	-- 가입고
				and	Z.PartIncomeDate	>= @ls_applyMonth + '.01'
				and	Z.PartIncomeDate	<= @ps_applyDate
				and 	Z.PartObeyTimeFlag	= 1	
			  ),	-- 당월 납입간판 중 시간준수 매수
	ApplyDate	= @ps_applyDate
    FROM
	TMSTORDERRATE		A, 
	TMSTPARTKB		B,
	TMSTITEM		C,
	TMSTSUPPLIER		D,
	TMSTAREA		E,
	TMSTDIVISION		F
   WHERE
	B.AreaCode	= @ps_areaCode
and	B.DivisionCode	= @ps_divCode 
and 	B.ItemCode	IN  ( SELECT ItemCode
				From #ITEM_tmp 	) 
and	B.AreaCode	= A.AreaCode 
and	B.DivisionCode	= A.DivisionCode 
and 	B.SupplierCode	= A.SupplierCode 
and 	B.Itemcode	= A.ItemCode 

and	B.ItemCode	= C.ItemCode 

and	B.SupplierCode	= D.SupplierCode 

and	B.AreaCode	= E.AreaCode 

and	B.AreaCode	= F.AreaCode 
and	B.DivisionCode	= F.DivisionCode 

Drop Table #ITEM_tmp

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

