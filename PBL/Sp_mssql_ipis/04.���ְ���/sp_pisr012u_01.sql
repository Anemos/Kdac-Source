SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr012u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr012u_01]
GO



------------------------------------------------------------------
--         	업체 납입주기 수정	
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr012u_01
 	@ps_areaCode	 Char(1),   	-- 공장 코드
 	@ps_divCode	 Char(1),   	-- 공장 코드
 	@ps_suppCode	 Char(5)   	-- 업체 코드
AS
BEGIN

Set NoCount ON

Declare	@ls_maxdate	Char(10)

	Select	@ls_maxdate = '9999.12.31'


SELECT	A.AreaCode,   
	         	A.DivisionCode,   
	         	A.SupplierCode,   
	         	A.ApplyFrom,   
	         	A.ApplyTo,   
	         	A.SupplyTerm,   
	         	A.SupplyEditNo,   
	         	A.SupplyCycle,   
	         	A.LastEmp,   
	         	A.LastDate,   
	         	B.SupplierNo,   
	         	B.SupplierKorName,
		0 As InsChk  
    FROM 	TMSTPARTCYCLE	A,   
         		TMSTSUPPLIER		B  
   WHERE	A.SupplierCode 		= B.SupplierCode  and  
         		( A.AreaCode 		= @ps_areaCode  AND  
         		  A.DivisionCode 	= @ps_divCode  AND  
         		  A.SupplierCode 	= @ps_suppCode  AND  
         		  A.ApplyTo 		= '9999.12.31'  )    


Set NoCount Off

End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

