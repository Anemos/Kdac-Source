SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr135p_print]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr135p_print]
GO

------------------------------------------------------------------
--	사급품반출증발행번호별 간판리스트
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr135p_print
 		@ps_buybackno	Char(11),	-- 반출증번호
 		@ps_applydate		Char(10)	-- 반출일자
AS
BEGIN
  SELECT 	A.ItemCode, 	  
         		C.ItemName,   
         		C.ItemSpec,   
         		C.ItemUnit,   
         		B.CostGubun,	
         		Sum(A.RackQty)	 As Qty		
       INTO	#Tmp_BuyBack
      FROM 	TPARTKBHIS		A,   
         		TMSTPARTKBHIS	B,   
         		TMSTITEM		C
   WHERE 	A.BuyBackNo 		= @ps_buybackno	and  
		A.PartKBStatus 		= 'C'			and  
		
         		A.AreaCode 		= B.AreaCode 		and  
         		A.DivisionCode 		= B.DivisionCode 	and  
         		A.SupplierCode 		= B.SupplierCode 	and  
         		A.ItemCode 		= B.ItemCode 		and  
         		@ps_applydate 		>= B.ApplyFrom 		and  
         		@ps_applydate 		<= B.ApplyTo 		and  

         		A.ItemCode 		= C.ItemCode 	
Group By	A.ItemCode, 	 
         		C.ItemName,   
         		C.ItemSpec,   
         		C.ItemUnit,   
         		B.CostGubun	

  SELECT 	A.BuyBackNo,   
        		A.BuyBackDept,   
        		A.BuyBackSupplier,   
        		A.BuyBackEmp,   
        		A.BuyBackDate,   
        		A.ApprovalEmp,   
         		A.CarNo,   
         		A.TakingName,   
         		A.Remark01,   
         		B.SupplierNo,
		B.SupplierKorName,  
		C.DeptName,
		D.ItemCode, 	  
         		D.ItemName,   
         		D.ItemSpec,   
         		D.ItemUnit,   
         		D.CostGubun,	
         		D.Qty,
		F.AreaName,
		G.DivisionName,
		E.EmpName
    FROM 	TPARTBUYBACK	A,   
         		TMSTSUPPLIER	B,
		TMSTDEPT		C,
		#Tmp_BuyBack		D,
		TMSTEMP		E,
		TMSTAREA		F,
		TMSTDIVISION		G
   WHERE 	A.BuyBackNo		= @ps_buybackno	AND  
		A.BuyBackSupplier	= B.SupplierCode	AND
		A.BuyBackDept		= C.DeptCode		AND
		A.ApprovalEmp		*= E.EmpNo		AND
		A.AreaCode		= F.AreaCode		AND
		A.AreaCode		= G.AreaCode		AND
		A.DivisionCode		= G.DivisionCode	

Drop Table       #Tmp_BuyBack   		

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

