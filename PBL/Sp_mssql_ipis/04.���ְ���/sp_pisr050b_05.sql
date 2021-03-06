SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr050b_05]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr050b_05]
GO



------------------------------------------------------------------
--        	업체별 출력 간판 마스타
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr050b_05
 	@ps_areaCode	 	Char(1),   	-- 공장 코드
 	@ps_divCode	 	Char(1),   	-- 공장 코드
 	@ps_suppCode	 	VarChar(5),   	-- 업체 코드
 	@ps_parttype	 	Char(1)   	-- 부품구분
AS
BEGIN

Set NoCount ON

  SELECT 	A.AreaCode,   
         		A.DivisionCode,   
         		A.SupplierCode,   
         		A.ItemCode,   
         		B.ItemName,   
        	 	A.ApplyFrom,   
         		A.PartType,   
         		A.PartModelID,   
         		A.ChangeFlag,   
         		A.PartID,   
         		A.UseCenterGubun,   
         		A.UseCenter,   
         		A.CostGubun,   
         		A.RackQty,   
         		A.RackCode,   
         		A.StockGubun,   
         		A.ReceiptLocation,   
         		A.MailBoxNo,   
         		A.SafetyStock,   
         		A.UseFlag,   
         		A.AutoReorderFlag,   
         		A.KBUseFlag,   
         		A.ChangeDate,   
         		A.NormalKBSN,   
         		A.TempKBSN,   
         		A.PartKBPrintCount,   
         		A.PartKBActiveCount,   
         		A.PartKBPlanCount,   
         		A.LastEmp,   
         		A.LastDate,  
		( Select Count( C.PartKBNo) 
		    From	TPARTKBSTATUS C 
		  Where	A.AreaCode 	= C.AreaCode 		And
			A.DivisionCode 	= C.DivisionCode 	And
			A.SupplierCode	= C.SupplierCode	And
			A.ItemCode	= C.ItemCode		And
			C.RePrintFlag	= 'Y' )	As planprkbCnt,
         		0 	As prkbCnt,   
         		'N' 	As prkbChk   
    FROM 	TMSTPARTKB	A,   
         		TMSTITEM  	B
   WHERE 	A.ItemCode	= B.ItemCode  		AND  
          		A.AreaCode 	= @ps_areaCode  	AND  
          		A.DivisionCode 	= @ps_divCode 		AND  
          		A.SupplierCode 	= @ps_suppCode  	AND  
          		A.PartType 	= @ps_parttype 

Set NoCount Off

End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

