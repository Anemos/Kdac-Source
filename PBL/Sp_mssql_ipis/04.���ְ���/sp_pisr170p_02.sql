SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr170p_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr170p_02]
GO

------------------------------------------------------------------
--	발주대기간판현황(기준일현재 2/2)
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr170p_02
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@pd_forecastdate	Char(10)   	-- 납입예정일자
AS
BEGIN
Set NoCount On

/*
Declare	@ls_applytime		Char(10)	
Select 	@ls_applytime = Convert(Char(10), @pdt_applytime, 102)
*/

  SELECT A.PartKBNo,   
         A.RackQty   
    FROM TPARTKBSTATUS		A   
   WHERE A.AreaCode 		= @ps_areacode 	AND  
         A.DivisionCode 	= @ps_divcode 	AND  
         A.SupplierCode 	= @ps_suppcode	AND  
         A.ItemCode	 	= @ps_itemcode	AND  
         A.PartKBStatus 	= 'A'		AND --'발주상태'
	 Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastDate Else A.PartForecastDate End = @pd_forecastdate
Order By A.PartKBNo

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

