SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr010u_partkbdel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr010u_partkbdel]
GO



----------------------------------------------------------------------
--           외주간판마스터 삭제처리 ( 신규 등록 후 간판발행 안된항목 ) 
----------------------------------------------------------------------

CREATE PROCEDURE sp_pisr010u_partkbdel
	@ps_areaCode		char(1),		--지역
 	@ps_divCode		char(1),		--공장
 	@ps_suppCode		char(5),		--업체	
 	@ps_itemCode		char(12),	--부품
 	@ri_err			Int	Output

AS
BEGIN

Declare	@li_kbCnt		int 

	Select	@li_kbCnt = count( TPARTKBSTATUS.PartKBNo )  
	FROM	TPARTKBSTATUS  
	WHERE 	TPARTKBSTATUS.AreaCode 	= @ps_areaCode	AND  
         		TPARTKBSTATUS.DivisionCode 	= @ps_divCode		AND  
         		TPARTKBSTATUS.SupplierCode 	= @ps_suppCode	AND  
         		TPARTKBSTATUS.ItemCode 	= @ps_itemCode  ;

If @li_kbCnt = 0 Return -1 -- @ri_err
-- 1. 이원화 정보 삭제
Begin
	DELETE FROM TMSTORDERRATE  
	WHERE 	AreaCode 	= @ps_areaCode  	AND  
		DivisionCode 	= @ps_divCode  	AND  
		SupplierCode 	= @ps_suppCode  	AND  
		ItemCode 	= @ps_itemCode    ;
End
Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err

-- 2. 발주입고현황 목록 삭제
Begin
	DELETE FROM TPARTORDERSTAUS
	WHERE 	AreaCode 	= @ps_areaCode	AND  
		DivisionCode 	= @ps_divCode 		AND  
		SupplierCode 	= @ps_suppCode 	AND  
		ItemCode 	= @ps_itemCode    ;
End
Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err

-- 3. 마지막 발주(납입)편수 항목 삭제
Begin
	DELETE FROM TPARTLASTEDIT
	WHERE 	AreaCode 	= @ps_areaCode	AND  
		DivisionCode 	= @ps_divCode 		AND  
		SupplierCode 	= @ps_suppCode 	AND  
		ItemCode 	= @ps_itemCode    ;
End
Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err

/*-- 4. 월간 자재소요계획 
Begin
	DELETE FROM TPARTMONTHPLAN
	WHERE 	AreaCode 	= @ps_areaCode	AND  
		DivisionCode 	= @ps_divCode 		AND  
		SupplierCode 	= @ps_suppCode 	AND  
		ItemCode 	= @ps_itemCode    ;
End
Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err
*/

-- 6. 간판기본정보 이력 삭제
Begin
	DELETE FROM TMSTPARTKBHIS
	WHERE AreaCode 	= @ps_areaCode	AND  
		DivisionCode 	= @ps_divCode 		AND  
		SupplierCode 	= @ps_suppCode 	AND  
		ItemCode 	= @ps_itemCode    ;
End
Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err

-- 7. 간판기본정보 삭제
Begin
	DELETE FROM TMSTPARTKB  
	WHERE AreaCode 	= @ps_areaCode	AND  
		DivisionCode 	= @ps_divCode 		AND  
		SupplierCode 	= @ps_suppCode  	AND  
		ItemCode 	= @ps_itemCode    ;
End
Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err

Return 0

END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

