SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr137u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr137u_01]
GO


------------------------------------------------------------------
--	반출증승인요청 처리
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr137u_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_carno 		VarChar(20)   	-- 차량 번호

AS
BEGIN
  SELECT 	A.AreaCode,   
         		A.DivisionCode,   
         		A.BuyBackNo,   
        		A.BuyBackDept,   
        		A.BuyBackSupplier,   
        		A.BuyBackEmp,   
        		A.BuyBackTime,   
        		A.BuyBackDate,   
        		A.ApprovalEmp,   
         		A.ApprovalTime,   
         		A.CarNo,   
         		A.TakingName,   
         		A.OutEmp,   
         		A.OutTime,   
         		A.StatusFlag,   
         		A.Remark01,   
         		A.Remark02,   
         		A.LastEmp,   
        		A.LastDate,   
		B.SupplierNo,
		B.SupplierKorName,  
		C.DeptName,
		0 As selectchk  
    FROM 	TPARTBUYBACK	A,   
         		TMSTSUPPLIER	B,
		TMSTDEPT		C  
   WHERE 	A.AreaCode 		= @ps_areacode	AND  
         		A.DivisionCode 		like @ps_divcode	AND  
         		A.CarNo 		like @ps_carno 		AND  
         		A.StatusFlag		= 'D' 			AND  
		
		A.BuyBackSupplier	= B.SupplierCode	AND

		A.BuyBackDept		= C.DeptCode
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

