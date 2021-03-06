SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr131p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr131p_01]
GO


------------------------------------------------------------------
--	간판발주서 발행
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr131p_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_orderno 		VarChar(12)	-- 발주리스트 번호
AS
BEGIN

Set NoCount On

Declare	@ls_maxdate	Char(10)
Select	@ls_maxdate = '9999.12.31'

  SELECT DISTINCT
	 F.AreaCode,   
         F.DivisionCode,   
         F.SupplierCode,   
         F.ItemCode,   
         F.PartType,   
	 Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastTime   Else F.PartForecastTime   End As ForecastTime,
	 Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastEditNo Else F.PartForecastEditNo End As EditNo
    INTO #PARTKBORDERLIST_tmp
    FROM TPARTKBSTATUS		F   
   WHERE F.AreaCode 		= @ps_areacode	AND  
         F.DivisionCode 	= @ps_divcode	AND  
         F.SupplierCode 	= @ps_suppcode	AND  
         F.PartKBStatus 	= 'A'		AND  --'A'발주
         F.PartOrderNo 		= @ps_orderno 

  SELECT H.PartOrderNo,   
         H.OrderPrintDate,   
         H.OrderRePrintDate,   
         H.AreaCode,   
         A.AreaName,   
         H.DivisionCode,   
         B.DivisionName,   
         H.SupplierCode,   
         F.SupplierNo,   
         F.SupplierKorName,   
         D.SupplyTerm,   
         D.SupplyEditNo,   
         D.SupplyCycle,   
         G.ItemCode,   
         C.ItemName,
         E.PartModelID,   	
         G.PartType,   
         G.ForecastTime,   	--납입예정시간
         G.EditNo,   		--납입예정편수
	( Select Count(*) 
	    From TPARTKBSTATUS I
	   WHERE I.AreaCode		= H.AreaCode		And
	         I.DivisionCode		= H.DivisionCode 	And
	         I.SupplierCode		= H.SupplierCode	And
	         I.ItemCode		= G.ItemCode		And
	         I.PartType		= G.PartType		And
		 Case I.OrderChangeFlag When 'Y' Then I.ChangeForecastTime   Else I.PartForecastTime   End = G.ForecastTime And
		 Case I.OrderChangeFlag When 'Y' Then I.ChangeForecastEditNo Else I.PartForecastEditNo End = G.EditNo	    And
	         I.PartKBStatus 	= 'A'			AND  --'A'발주
	         I.PartOrderNo 		= @ps_orderno ) As KBCount,
	( Select Sum(I.RackQty) 
	    From TPARTKBSTATUS I
	   WHERE I.AreaCode		= H.AreaCode		And
	         I.DivisionCode		= H.DivisionCode 	And
	         I.SupplierCode		= H.SupplierCode	And
	         I.ItemCode		= G.ItemCode		And
	         I.PartType		= G.PartType		And
		 Case I.OrderChangeFlag When 'Y' Then I.ChangeForecastTime   Else I.PartForecastTime   End = G.ForecastTime And
		 Case I.OrderChangeFlag When 'Y' Then I.ChangeForecastEditNo Else I.PartForecastEditNo End = G.EditNo	    And
	         I.PartKBStatus 	= 'A'			AND  --'A'발주
	         I.PartOrderNo 		= @ps_orderno ) As ItemQty
    FROM TMSTAREA		A,   
         TMSTDIVISION		B,   
         TMSTITEM		C,   
         TMSTPARTCYCLE		D,   
         TMSTPARTKB		E,   
         TMSTSUPPLIER		F,   
         #PARTKBORDERLIST_tmp	G,   
         TPARTORDERLIST		H   
   WHERE H.AreaCode 		= @ps_areacode 		AND  
         H.DivisionCode 	= @ps_divcode 		AND  
         H.SupplierCode 	= @ps_suppcode 		AND  
         H.PartOrderNo 		= @ps_orderno 		AND  
         
	 H.AreaCode 		= A.AreaCode 		and  

         H.AreaCode 		= B.AreaCode 		and  
         H.DivisionCode 	= B.DivisionCode 	and  

         G.ItemCode 		= C.ItemCode 		and  

         H.AreaCode 		= D.AreaCode 		and  
         H.DivisionCode 	= D.DivisionCode 	and  
         H.SupplierCode 	= D.SupplierCode 	and  
         D.ApplyTo		= @ls_maxdate 		and  

         G.AreaCode 		= E.AreaCode 		and  
         G.DivisionCode 	= E.DivisionCode 	and  
         G.SupplierCode 	= E.SupplierCode 	and  
         G.ItemCode 		= E.ItemCode 		and

         H.SupplierCode 	= F.SupplierCode 

Order By H.AreaCode,   
         H.DivisionCode,   
         H.SupplierCode,   
         G.ItemCode,   
         G.ForecastTime,   
         G.EditNo   

Drop Table #PARTKBORDERLIST_tmp

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

