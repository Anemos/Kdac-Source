SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr160i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr160i_02]
GO



------------------------------------------------
--    개별간판 이력조회 화면( 간판목록 )
------------------------------------------------

CREATE Procedure sp_pisr160i_02
            @ps_areaCode		Char(1), 
            @ps_divCode    		Char(1), 
            @ps_suppCode 		Char(5),
            @ps_ItemCode 		VarChar(12)
As
Begin

Set NoCount ON

  Select	A.PartKBNo,   
         	A.AreaCode,   
         	A.DivisionCode,   
         	A.SupplierCode,   
        	A.ItemCode,   
         	A.PartKBGubun,   
         	A.KBActiveGubun,   
         	A.PartKBStatus,   
         	A.RackQty,   
         	A.PartOrderTime,   
         	A.PartForeCastTime,   
         	A.PartReceiptTime,   
         	A.PartIncomeTime,   
         	A.OrderChangeFlag,   
         	A.ChangeForeCastTime   
    From 	TPARTKBSTATUS	A   
 Where 	A.AreaCode 	= @ps_areaCode  	AND  
         	A.DivisionCode 	= @ps_divCode 		AND  
         	A.SupplierCode 	= @ps_suppCode  	And
	A.ItemCode 	= @ps_ItemCode 

Set NoCount Off

End				-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

