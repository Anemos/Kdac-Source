SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr170i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr170i_01]
GO


------------------------------------------------------------------
--        		납기지연간판현황
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr170i_01
 	@ps_area	 	Char(1),   	-- 지역
 	@ps_div	 		Char(1),   	-- 공장
 	@ps_supp	 	VarChar(5),   	-- 업체
 	@ps_item	 	VarChar(12),   	-- 품번
 	@ps_product	 	VarChar(2),   	-- 제품군
 	@pi_day1	 	Integer,   	-- 범위1
 	@pi_day2	 	Integer,   	-- 범위2
 	@pd_Time	 	DateTime   	-- 적용기준일자
AS
BEGIN

Set NoCount ON

  SELECT 	A.PartKBNo,   
         	A.AreaCode,   
         	C.AreaName,   
         	A.DivisionCode,   
         	D.DivisionName,   
         	A.SupplierCode,   
         	E.SupplierNo,   
         	E.SupplierKorName,   
         	A.ItemCode,   
         	F.ItemName,   
         	F.ItemSpec,   
         	A.PartType,   
         	A.PartKBGubun,   
         	A.RackQty,   
         	A.OrderChangeFlag,   
         	A.PartReceiptCancel,   
         	A.UseCenterGubun,   
         	A.UseCenter,   
         	A.PartOrderDate,   
         	A.PartOrderTime,   
         	A.PartForecastTime,   
         	A.PartReceiptTime,   
         	A.OrderChangeCode,   
         	A.ChangeForecastTime,   
		G.SupplyTerm ,
           	G.SupplyEditNo ,
           	G.SupplyCycle, 
         	H.PartModelID,
		( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ) As ProductGroup,
		DATEDIFF(day, Case OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime End, @pd_Time )  As Days 
  FROM 		TPARTKBSTATUS 	A,
           	TMSTAREA 	C,
           	TMSTDIVISION 	D,
           	TMSTSUPPLIER 	E,
           	TMSTITEM 	F,
           	TMSTPARTCYCLE 	G,
		TMSTPARTKB	H
WHERE		A.AreaCode		= @ps_area		And
		A.DivisionCode		= @ps_div		And
		A.SupplierCode		like @ps_supp		And
		A.ItemCode		like @ps_item		And
		A.PartKBStatus		= 'A'			And
		Case OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime End < @pd_Time	And
		DATEDIFF(day, Case OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime End, @pd_Time ) >= @pi_day1	And
		DATEDIFF(day, Case OrderChangeFlag When 'Y' Then A.ChangeForecastTime Else A.PartForecastTime End, @pd_Time ) <= @pi_day2	And

		( Select Top 1 B.ProductGroup From TMSTMODEL B Where B.AreaCode = A.AreaCode And B.DivisionCode = A.DivisionCode And B.ItemCode = A.ItemCode ) like @ps_product And

		A.AreaCode		= C.AreaCode		And
		A.AreaCode		= D.AreaCode		And
		A.DivisionCode		= D.DivisionCode	And
		A.SupplierCode		= E.SupplierCode	And
		A.ItemCode		= F.ItemCode		And

		A.AreaCode		= G.AreaCode		And
		A.DivisionCode		= G.DivisionCode	And
		A.SupplierCode		= G.SupplierCode	And
		G.ApplyFrom		<= A.PartOrderDate	And
		G.ApplyTo		>= A.PartOrderDate	And

		A.AreaCode		= H.AreaCode		And
		A.DivisionCode		= H.DivisionCode	And
		A.SupplierCode		= H.SupplierCode	And
		A.ItemCode		= H.ItemCode	

Set NoCount Off

End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

