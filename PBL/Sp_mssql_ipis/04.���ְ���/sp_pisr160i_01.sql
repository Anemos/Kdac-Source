SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr160i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr160i_01]
GO



------------------------------------------------
--    개별간판 이력조회 화면( 품번목록 )
------------------------------------------------

CREATE Procedure sp_pisr160i_01
            @ps_areaCode		Char(1), 
            @ps_divCode    		Char(1), 
            @ps_suppCode 		Char(5)
As
Begin

Set NoCount ON

  Select 	A.AreaCode,   
	A.DivisionCode,   
         	A.SupplierCode,   
         	A.ItemCode,   
         	B.ItemName, 
         	B.ItemSpec, 
         	A.ApplyFrom,   
         	A.PartType,   
         	A.PartModelID,   
         	A.PartKBPrintCount,   							-- 발행매수
	( Select count(*)  
    	    From TPARTKBSTATUS 	E  
   	 Where	A.AreaCode 	= E.AreaCode 		AND  
         		A.DivisionCode 	= E.DivisionCode 	AND  
         		A.SupplierCode 	= E.SupplierCode 	AND  
         		A.ItemCode 	= E.ItemCode 		AND  
         		isNull(E.PartKBPrintDate, '')  = ''  )		As NprCnt,	-- 미발행매수
	( Select count(*)  
    	    From TPARTKBSTATUS 	E  
   	 Where	A.AreaCode 	= E.AreaCode 		AND  
         		A.DivisionCode 	= E.DivisionCode 	AND  
         		A.SupplierCode 	= E.SupplierCode 	AND  
         		A.ItemCode 	= E.ItemCode 		AND  
         		E.KBActiveGubun = 'S'  ) 			As sleepingCnt,	-- Sleeping 매수
	( Select count(*)  
    	    From TPARTKBSTATUS 	E  
   	 Where	A.AreaCode 	= E.AreaCode 		AND  
         		A.DivisionCode 	= E.DivisionCode 	AND  
         		A.SupplierCode 	= E.SupplierCode 	AND  
         		A.ItemCode 	= E.ItemCode 		AND  
         		E.PartKBStatus = 'A'  ) 				As baljuCnt,	-- 발주상태매수
	( Select count(*)  
    	    From TPARTKBSTATUS 	E  
   	 Where	A.AreaCode 	= E.AreaCode 		AND  
         		A.DivisionCode 	= E.DivisionCode 	AND  
         		A.SupplierCode 	= E.SupplierCode 	AND  
         		A.ItemCode 	= E.ItemCode 		AND  
         		E.PartKBStatus = 'B'  ) 				As gaipgoCnt,	-- 가입고상태매수
	( Select count(*)  
    	    From TPARTKBSTATUS 	E  
   	 Where	A.AreaCode 	= E.AreaCode 		AND  
         		A.DivisionCode 	= E.DivisionCode 	AND  
         		A.SupplierCode 	= E.SupplierCode 	AND  
         		A.ItemCode 	= E.ItemCode 		AND  
         		E.PartKBStatus = 'C'  ) 				As ipgoCnt	-- 입고후발주대기상태매수
    From 	TMSTPARTKB		A,   
         	TMSTITEM		B
 Where 	A.AreaCode 	= @ps_areaCode  	AND  
         	A.DivisionCode 	= @ps_divCode 		AND  
         	A.SupplierCode 	= @ps_suppCode  	And

	A.ItemCode 	= B.ItemCode 


Set NoCount Off

End				-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

