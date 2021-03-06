SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr050b_06]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr050b_06]
GO


------------------------------------------------------------------
--        	출력 간판리스트 선택
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr050b_06
 	@ps_areaCode	 	Char(1),   	-- 지역 코드
 	@ps_divCode	 	Char(1),   	-- 공장 코드
 	@ps_suppCode	 	VarChar(5),   	-- 업체 코드
 	@ps_itemCode	 	VarChar(12),   	-- 품번 코드
 	@as_rePrFlag	 	Char(1)   	-- 재발행구분
AS
BEGIN

Set NoCount ON

  SELECT 	A.PartKBNo,   
         		A.DivisionCode,   
         		A.SupplierCode,   
         		A.ItemCode,   
         		A.RePrintFlag,   
         		A.PartKBGubun,   
         		A.KBActiveGubun,   
         		A.PartKBStatus,   
         		CASE WHEN A.PartKBGubun = 'T' THEN 
			A.RackQty 
		ELSE 
		( 	SELECT B.RackQty 
			FROM TMSTPARTKB B 
			WHERE A.AreaCode 	= B.AreaCode 		And 
				A.DivisionCode 	= B.DivisionCode 	And 
				A.SupplierCode 	= B.SupplierCode 	And 
				A.ItemCode 	= B.ItemCode 	)
		END AS RackQty,   
         		A.PartOrderTime,   
         		A.PartForeCastTime,   
         		A.PartReceiptTime,   
         		A.PartIncomeTime,   
         		A.OrderChangeFlag,   
         		A.ChangeForeCastTime,   
         		'N' prkbChk 
    FROM	TPARTKBSTATUS  A
   WHERE 	A.AreaCode 	= @ps_areaCode  	AND  
         		A.DivisionCode 	= @ps_divCode   	AND  
         		A.SupplierCode 	= @ps_suppCode  	AND  
         		A.ItemCode 	= @ps_itemCode  	And
         		A.RePrintFlag 	= @as_rePrFlag  
Set NoCount Off

End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

