SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr140p_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr140p_02]
GO

------------------------------------------------------------------
--	발주간판현황(기준일현재 2/2)
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr140p_02
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@pdt_forecasttime 	DateTime,   	-- 납입예정시간
 	@pi_editno 		Integer   	-- 납입예정편수
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
         A.PartOrderCancel 	= 'N'  		AND  --발주취소안된 간판
         A.KBActiveGubun 	= 'A'  		AND  --운용중인간판(Active)
         A.PartKBStatus 	= 'A'	 	AND  --'A'발주
	 Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime   Else A.PartForecastTime   End = @pdt_forecasttime And
	 Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastEditNo Else A.PartForecastEditNo End = @pi_editno 
Order By A.PartKBNo

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

