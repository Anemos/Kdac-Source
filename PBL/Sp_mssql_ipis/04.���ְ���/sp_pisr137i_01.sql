SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr137i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr137i_01]
GO

------------------------------------------------------------------
--	반출확인취소 처리
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr137i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_applyfrom 		Char(10),   	-- 기준일자
 	@ps_applyto 		Char(10)   	-- 기준일자

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
		C.DeptName
    FROM 	TPARTBUYBACK	A,   
         		TMSTSUPPLIER	B,
		TMSTDEPT		C  
   WHERE 	A.AreaCode 		= @ps_areacode	AND  
         		A.DivisionCode 		like @ps_divcode	AND  
         		A.StatusFlag		= 'E' 			AND  
         		Convert(Char(10), A.OutTime, 102) >= @ps_applyfrom  AND
         		Convert(Char(10), A.OutTime, 102) <= @ps_applyto  AND
		
		A.BuyBackSupplier	= B.SupplierCode	AND

		A.BuyBackDept		= C.DeptCode
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

