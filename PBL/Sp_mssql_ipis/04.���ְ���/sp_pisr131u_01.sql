SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr131u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr131u_01]
GO


------------------------------------------------------------------
--	신규 발주List 발행
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr131u_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_listno 		VarChar(12)   	-- 발주List번호
AS
BEGIN
  SELECT 	B.PartKBNo,   
         	B.AreaCode,   
         	B.DivisionCode,   
         	B.SupplierCode,   
         	B.ItemCode,   
         	B.ApplyFrom,   
         	B.PartType,   
         	B.RackQty,   
         	B.OrderChangeFlag,   
         	B.PartOrderTime,   
         	B.PartForecastTime,   
         	B.PartOrderNo,   
         	B.ChangeForecastTime,   
         	B.LastEmp,   
         	B.LastDate,   
         	D.ItemName,   
         	D.ItemSpec,   
         	E.PartModelID,   
         	A.SupplyTerm,   
         	A.SupplyEditNo,   
         	A.SupplyCycle,   
         	F.OrderChangeName  
    FROM 	TMSTPARTCYCLE	A,   
         	TPARTKBSTATUS	B,   
         	TMSTITEM	D,  
         	TMSTPARTKB	E,   
         	TMSTORDERCHANGE	F   
   WHERE 	B.AreaCode 		= @ps_areacode		and  
         	B.DivisionCode 		= @ps_divcode	 	and  
         	B.SupplierCode 		= @ps_suppcode	 	and  
         	B.PartKBStatus 		= 'A'	 		and
         	isNull(B.PartOrderNo,'') In ('',@ps_listno)	and 		    

         	A.AreaCode 		= @ps_areacode		and  
         	A.DivisionCode 		= @ps_divcode 		and  
         	A.SupplierCode 		= @ps_suppcode 		and  
         	A.ApplyFrom 		<= B.PartOrderDate	and  
         	A.ApplyTo 		>= B.PartOrderDate	and  

         	B.ItemCode 		= D.ItemCode 		and  

         	E.AreaCode 		= B.AreaCode 		and  
         	E.DivisionCode 		= B.DivisionCode 	and  
         	E.SupplierCode 		= B.SupplierCode 	and  
         	E.ItemCode 		= B.ItemCode 		and  

         	B.AreaCode 		*= F.AreaCode 		and  
         	B.DivisionCode 		*= F.DivisionCode 	and  
         	B.OrderChangeCode 	*= F.OrderChangeCode 	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

