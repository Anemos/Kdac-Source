SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr131p_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr131p_02]
GO


------------------------------------------------------------------
--	간판발주서 발행( 간판번호,수용수 )
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr131p_02
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_parttype 		Char(1),   	-- 부품구분
 	@ps_forecasttime	DateTime,   	-- 납입예정시간
 	@pi_editno 		Integer,   	-- 납입예정편수
 	@ps_orderno 		Char(12)	-- 발주리스트 번호
AS
BEGIN

  SELECT A.PartKBNo,   
         A.RackQty   
    FROM TPARTKBSTATUS		A   
   WHERE A.AreaCode		= @ps_areacode		And
         A.DivisionCode		= @ps_divcode	 	And
         A.SupplierCode		= @ps_suppcode		And
         A.ItemCode		= @ps_itemcode		And
         A.PartType		= @ps_parttype		And
	 Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastTime   Else A.PartForecastTime   End = @ps_forecasttime 	And
	 Case A.OrderChangeFlag When 'Y' Then A.ChangeForecastEditNo Else A.PartForecastEditNo End = @pi_editno		And
         A.PartKBStatus 	= 'A'			AND  --'A'발주
         A.PartOrderNo 		= @ps_orderno 
Order By A.PartKBNo

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

