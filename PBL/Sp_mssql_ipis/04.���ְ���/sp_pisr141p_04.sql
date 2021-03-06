SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr141p_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr141p_04]
GO

------------------------------------------------------------------
--	간판가입고이력(기간별) 2/2
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr141p_04
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_fromdate 		Char(10),   	-- 조회시작일자
 	@ps_todate 		Char(10)   	-- 조회종료일자
AS
BEGIN
Set NoCount On

  SELECT A.PartKBNo,   
         A.RackQty   
    FROM TPARTKBSTATUS		A   
   WHERE A.AreaCode 		= @ps_areacode 	AND  
         A.DivisionCode 	= @ps_divcode 	AND  
         A.SupplierCode 	= @ps_suppcode	AND  
         A.ItemCode	 	= @ps_itemcode	AND  
         A.PartKBStatus 	= 'B'	 	And
   	 A.PartReceiptDate	>= @ps_fromdate	AND  	--가입고일자
         A.PartReceiptDate	<= @ps_todate
Union
  SELECT A.PartKBNo,   
         A.RackQty   
    FROM TPARTKBHIS		A   
   WHERE A.AreaCode 		= @ps_areacode 	AND  
         A.DivisionCode 	= @ps_divcode 	AND  
         A.SupplierCode 	= @ps_suppcode	AND  
         A.ItemCode	 	= @ps_itemcode	AND  
         A.PartKBStatus 	= 'C'	 	And
   	 A.PartReceiptDate	>= @ps_fromdate	AND  	--가입고일자
         A.PartReceiptDate	<= @ps_todate
Order By 1

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

