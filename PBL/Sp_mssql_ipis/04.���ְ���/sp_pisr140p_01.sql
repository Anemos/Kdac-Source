SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr140p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr140p_01]
GO

------------------------------------------------------------------
--	발주간판현황(기준일현재 1/2)
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr140p_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@pdt_applytime 		DateTime   	-- 조회기준시간
AS
BEGIN
Set NoCount On

/*
Declare	@ls_applytime		Char(16)		-- 입고기준시간
Select 	@ls_applytime = @ps_applydate + ' 20:00'	-- 일간마감고려
*/

  SELECT DISTINCT
	 F.AreaCode,   
         F.DivisionCode,   
         F.SupplierCode,   
         F.ItemCode,   
	 Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastTime   Else F.PartForecastTime   End As ForecastTime,
	 Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastEditNo Else F.PartForecastEditNo End As EditNo,
	 ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = F.AreaCode And I.DivisionCode = F.DivisionCode And I.ItemCode = F.ItemCode ) As ProductGroup
    INTO #PARTKBORDER_tmp
    FROM TPARTKBSTATUS		F   
   WHERE F.AreaCode 		= @ps_areacode		AND  
         F.DivisionCode 	= @ps_divcode		AND  
         F.SupplierCode 	like @ps_suppcode	AND  
         F.ItemCode	 	like @ps_itemcode	AND  
         F.PartOrderCancel 	= 'N'  			AND  --발주취소안된 간판
         F.KBActiveGubun 	= 'A'  			AND  --운용중인간판(Active)
         F.PartKBStatus 	= 'A'			AND  --'A'발주
	 ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = F.AreaCode And I.DivisionCode = F.DivisionCode And I.ItemCode = F.ItemCode ) like @ps_product


  SELECT F.AreaCode,   
         A.AreaName,   
         F.DivisionCode,   
         B.DivisionName,   
         F.SupplierCode,   
         C.SupplierNo,   
         C.SupplierKorName,   
         F.ItemCode,   
         D.ItemName,
	 E.PartModelID, 
	 F.ProductGroup,
         ( Select Count(G.PartKBNo) 
	     From TPARTKBSTATUS G
	    Where F.AreaCode 		= G.AreaCode		AND  
         	F.DivisionCode 		= G.DivisionCode	AND  
         	F.SupplierCode 		= G.SupplierCode	AND  
         	F.ItemCode	 	= G.ItemCode		AND  
         	G.PartOrderCancel 	= 'N'  			AND  --발주취소안된 간판
         	G.KBActiveGubun 	= 'A'  			AND  --운용중인간판(Active)
         	G.PartKBStatus 		= 'A'			AND  --'A'발주
	 	Case G.OrderChangeFlag When 'Y' Then G.ChangeForecastTime   Else G.PartForecastTime   End = F.ForecastTime And
	 	Case G.OrderChangeFlag When 'Y' Then G.ChangeForecastEditNo Else G.PartForecastEditNo End = F.EditNo ) As KBCount,
         ( Select Sum(G.RackQty) 
	     From TPARTKBSTATUS G
	    Where F.AreaCode 		= G.AreaCode		AND  
         	F.DivisionCode 		= G.DivisionCode	AND  
         	F.SupplierCode 		= G.SupplierCode	AND  
         	F.ItemCode	 	= G.ItemCode		AND  
         	G.PartOrderCancel 	= 'N'  			AND  --발주취소안된 간판
         	G.KBActiveGubun 	= 'A'  			AND  --운용중인간판(Active)
         	G.PartKBStatus 		= 'A'			AND  --'A'발주
	 	Case G.OrderChangeFlag When 'Y' Then G.ChangeForecastTime   Else G.PartForecastTime   End = F.ForecastTime And
	 	Case G.OrderChangeFlag When 'Y' Then G.ChangeForecastEditNo Else G.PartForecastEditNo End = F.EditNo ) As ItemQty,
	 @pdt_applytime 	As ApplyTime,
	 F.ForecastTime,
	 F.EditNo
    FROM TMSTAREA		A,   
         TMSTDIVISION		B,   
         TMSTSUPPLIER		C,   
         TMSTITEM		D,   
         TMSTPARTKB		E,   
         #PARTKBORDER_tmp   	F
   WHERE F.AreaCode 		= A.AreaCode 		and  

         F.AreaCode 		= B.AreaCode 		and  
         F.DivisionCode 	= B.DivisionCode 	and  

         F.SupplierCode 	= C.SupplierCode 	and  

         F.ItemCode 		= D.ItemCode 		and  

         F.AreaCode 		= E.AreaCode 		and  
         F.DivisionCode 	= E.DivisionCode 	and  
         F.SupplierCode 	= E.SupplierCode 	and  
         F.ItemCode 		= E.ItemCode 	

Order By F.AreaCode,   
         F.DivisionCode,   
         F.SupplierCode,   
         F.ItemCode,   
	 F.ForecastTime,
	 F.EditNo
         


Drop Table #PARTKBORDER_tmp

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

