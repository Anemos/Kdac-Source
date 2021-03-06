SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr135u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr135u_02]
GO


------------------------------------------------------------------
--	사급품반출증작성 
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr135u_02
 		@ps_areacode		Char(1),		-- 지역코드
 		@ps_divcode		Char(1),		-- 공장코드
 		@ps_buybackno	VarChar(11),	-- 반출증 발행번호
 		@ps_buybackdept	VarChar(5)	-- 반출부서
AS
BEGIN
Set NoCount ON

Set NoCount ON

  SELECT 	D.AreaCode,   
         		D.DivisionCode,   
         		D.BuyBackNo,   
         		D.BuyBackDept,   
         		D.BuyBackSupplier,   
         		D.BuyBackEmp,   
         		D.BuyBackTime,   
         		D.BuyBackDate,   
         		D.ApprovalEmp,   
         		D.ApprovalTime,   
         		D.CarNo,   
         		D.TakingName,   
         		D.OutEmp,   
         		D.OutTime,   
         		D.StatusFlag,   
         		D.Remark01,   
         		D.Remark02,   
         		D.LastEmp,   
         		D.LastDate,   
         		C.SupplierNo,   
         		C.SupplierKorName,   
         		B.EmpName,   
         		A.DeptName  
    FROM 	TMSTDEPT		A,   
         		TMSTEMP		B,   
         		TMSTSUPPLIER	C,   
         		TPARTBUYBACK	D  
   WHERE 	D.BuyBackDept 	= A.DeptCode 		and  
         		D.BuyBackSupplier 	= C.SupplierCode 	and  
         		D.BuyBackEmp 		*= B.EmpNo 		and  
         		D.AreaCode 		= @ps_areacode 	AND  
         		D.DivisionCode 		= @ps_divcode 		AND  
         		D.BuyBackNo 		= @ps_buybackno 	AND  
         		D.BuyBackDept 	= @ps_buybackdept 

Set NoCount Off
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

