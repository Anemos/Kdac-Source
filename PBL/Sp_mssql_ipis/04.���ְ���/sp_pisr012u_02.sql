SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr012u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr012u_02]
GO



------------------------------------------------------------------
--         	업체 납입주기 수정 ( 납입편수 별 납품시간 입력 )	
------------------------------------------------------------------
CREATE PROCEDURE sp_pisr012u_02
 	@ps_areaCode	 	Char(1),   	-- 공장 코드
 	@ps_divCode	 	Char(1),   	-- 공장 코드
 	@as_standardDate	VarChar(10),   	-- 적용시작기준일자
 	@ps_suppCode	 	VarChar(5)   	-- 업체 코드
AS
BEGIN

Declare	@ls_InputTime		char(5)		-- 납입시간입력값   
Select	@ls_InputTime	= '    '


Set NoCount ON

	SELECT	AreaCode,   
	         		DivisionCode,   
	         		SupplierCode,   
	        		ApplyFrom,   
	        		PartEditNo,   
	        		PartEditTime,   
	        		@ls_InputTime AS InputTime,   
	        		ApplyTo,   
	         		LastEmp,   
	         		LastDate  
	    FROM 	TMSTPARTEDIT  
	   WHERE 	AreaCode 	= @ps_areaCode  	AND  
	         		DivisionCode 	= @ps_divCode  	AND  
	         		SupplierCode 	= @ps_suppCode  	AND  
	         		ApplyFrom 	<= @as_standardDate  	AND  
	         		ApplyTo 	>= @as_standardDate     


Set NoCount Off

End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

