SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr050b_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr050b_03]
GO


------------------------------------------------------------------
--        	업체별 출력 간판 마스타
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr050b_03
 	@ps_areaCode	 	Char(1),   	-- 공장 코드
 	@ps_divCode	 	Char(1),   	-- 공장 코드
 	@ps_suppCode	 	VarChar(5)   	-- 업체 코드
AS
BEGIN

Set NoCount ON

SELECT 	A.AreaCode ,
       		A.DivisionCode ,
       		A.SupplierCode ,
       		A.ItemCode ,
       		A.ApplyFrom ,
       		A.PartType ,
       		A.PartModelID ,
       		A.CostGubun ,
       		A.RackQty ,
       		A.UseFlag ,
       		A.NormalKBSN ,
       		A.TempKBSN ,
       		A.PartKBPrintCount ,
       		A.PartKBActiveCount ,
       		A.PartKBPlanCount ,
       		B.ItemName,     
       		B.ItemSpec,
		( Select Top 1 C.ProductGroup  From TMSTMODEL C Where A.AreaCode = C.AreaCode and A.DivisionCode = C.DivisionCode and A.ItemCode = C.ItemCode ) As ProductGroup
  FROM 	TMSTPARTKB 	A,
       		TMSTITEM     	B
 WHERE 	A.ItemCode 	= B.ItemCode  		and  
       		A.AreaCode 	= @ps_areaCode  	and  
       		A.DivisionCode	= @ps_divCode  	and  
       		A.SupplierCode	= @ps_suppCode  
Set NoCount Off

End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

