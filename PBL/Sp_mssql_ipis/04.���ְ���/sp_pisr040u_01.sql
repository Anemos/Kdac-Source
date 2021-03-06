SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr040u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr040u_01]
GO



--------------------------------------------------------------------------
--		외주간판 업체 이원화비율 조정 데이타윈도우		--
--------------------------------------------------------------------------

CREATE PROCEDURE sp_pisr040u_01
	@ps_areaCode 		Char(1),		-- 지역 코드
	@ps_divCode 		Char(1),		-- 공장 코드
	@ps_itemCode 		VarChar(12),	-- 품번
	@ps_applyDate 		Char(10)	-- 기준일자
AS
BEGIN

Set NoCount On

Declare	@ls_applyMonth		char(7)		-- 납입시간입력값   
Select	@ls_applyMonth		= substring(@ps_applyDate, 1, 7 )


-- 2원화된 항목을 검색한다.
	 SELECT	ItemCode
	   INTO	#ITEM_tmp
	   FROM	TMSTPARTKB
	  WHERE	AreaCode	= 	@ps_areaCode		And
		DivisionCode	= 	@ps_divCode		And
		ItemCode	like 	@ps_itemCode
	GROUP BY	ItemCode
	 HAVING	Count(*) > 1

  SELECT 
	AreaCode	= B.AreaCode,   
        DivisionCode	= B.DivisionCode,   
        ItemCode	= B.ItemCode,   
        SupplierCode	= B.SupplierCode,   
        OrderRate	= A.OrderRate,   
	PartType	= B.PartType,
	ItemName	= C.ItemName,
	ModelID		= B.PartModelID,
	SupplierName	= D.SupplierKorName,	
	IpgoY		= (	SELECT
					SUM( E.RackQty )
				FROM	TPARTKBHIS	E				
				WHERE	E.AreaCode		= B.AreaCode	
				and	E.DivisionCode		= B.DivisionCode	
				and	E.SupplierCode		= B.SupplierCode
				and	E.ItemCode		= B.ItemCode		
				and	E.PartKBStatus		= 'C'
				and	E.PartIncomeDate	>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	E.PartIncomeDate	< @ls_applyMonth + '.01' 
				and 	E.PartObeyTimeFlag	= 1	
			  ),	-- 3개월치 납입시간준수 납입량
	IpgoN		= (	SELECT
					SUM( E.RackQty )
				FROM	TPARTKBHIS	E				
				WHERE	E.AreaCode		= B.AreaCode	
				and	E.DivisionCode		= B.DivisionCode	
				and	E.SupplierCode		= B.SupplierCode
				and	E.ItemCode		= B.ItemCode		
				and	E.PartKBStatus		= 'C'
				and	E.PartIncomeDate	>= convert( varchar(10), Dateadd( Month, -3, Convert(DateTime, @ls_applyMonth + '.01') ), 102 )
				and	E.PartIncomeDate	< @ls_applyMonth + '.01' 
				and 	E.PartObeyTimeFlag	= 0
			  ),	-- 3개월치 납입시간미준수 납입량
	IpgoY2		= (	SELECT
					SUM( E.RackQty )
				FROM	TPARTKBHIS	E				
				WHERE	E.AreaCode		= B.AreaCode	
				and	E.DivisionCode		= B.DivisionCode	
				and	E.SupplierCode		= B.SupplierCode
				and	E.ItemCode		= B.ItemCode		
				and	E.PartKBStatus		= 'C'
				and	E.PartIncomeDate	>= @ls_applyMonth + '.01'
				and	E.PartIncomeDate	<= @ps_applyDate
				and 	E.PartObeyTimeFlag	= 1
			  ),	-- 당월 납입시간준수 납입량
	IpgoN2		= (	SELECT
					SUM( E.RackQty )
				FROM	TPARTKBHIS	E				
				WHERE	E.AreaCode		= B.AreaCode	
				and	E.DivisionCode		= B.DivisionCode	
				and	E.SupplierCode		= B.SupplierCode
				and	E.ItemCode		= B.ItemCode		
				and	E.PartKBStatus		= 'C'
				and	E.PartIncomeDate	>= @ls_applyMonth + '.01'
				and	E.PartIncomeDate	<= @ps_applyDate
				and 	E.PartObeyTimeFlag	= 0
			  ),	-- 당월 납입시간미준수 납입량
	ReRate		= A.OrderRate
    FROM
	TMSTORDERRATE	A, 
	TMSTPARTKB		B,
	TMSTITEM		C,
	TMSTSUPPLIER		D
   WHERE	
	B.AreaCode	= A.AreaCode 
and	B.DivisionCode	= A.DivisionCode 
and 	B.SupplierCode	= A.SupplierCode 
and 	B.Itemcode	= A.ItemCode 
and	B.ItemCode	= C.ItemCode 
and	B.SupplierCode	= D.SupplierCode 
and	B.AreaCode	= @ps_areaCode
and	B.DivisionCode	= @ps_divCode 
and 	B.ItemCode	IN  ( SELECT ItemCode
				From #ITEM_tmp 	) 
			

Drop Table #ITEM_tmp

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

