SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr161i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr161i_02]
GO


------------------------------------------------
--    개별간판 이력출력 화면( 간판목록 )
------------------------------------------------

CREATE Procedure sp_pisr161i_02
            @ps_partkbno	Char(11),	--간판번호 
            @ps_from	Char(10), 	--시작일자
            @ps_to		Char(10) 	--종료일자
As
Begin

Set NoCount ON

  Select	A.PartKBNo,   
        	A.PartType,   
         	A.PartKBGubun,   
         	A.RackQty,   
         	A.PartReceiptCancel,   
         	A.UseCenterGubun,   
         	A.UseCenter,   
         	A.PartObeyDateFlag,   
         	A.PartObeyTimeFlag,   
         	A.PartOrderTime,   
         	A.PartForeCastTime,   
         	A.PartReceiptTime,   
         	A.PartIncomeTime,   
         	A.OrderChangeFlag,   
         	A.ChangeForeCastTime,
         	A.PartOrderNo,
         	A.DeliveryNo,
         	A.BuyBackNo,
         	A.OrderSeq
    From 	TPARTKBSTATUS	A
 Where 	A.PartKBNo 	= @ps_partkbno	
 
Union
  Select	A.PartKBNo,   
        	A.PartType,   
         	A.PartKBGubun,   
         	A.RackQty,   
         	A.PartReceiptCancel,   
         	A.UseCenterGubun,   
         	A.UseCenter,   
         	A.PartObeyDateFlag,   
         	A.PartObeyTimeFlag,   
         	A.PartOrderTime,   
         	A.PartForeCastTime,   
         	A.PartReceiptTime,   
         	A.PartIncomeTime,   
         	A.OrderChangeFlag,   
         	A.ChangeForeCastTime,
         	A.PartOrderNo,
         	A.DeliveryNo,
         	A.BuyBackNo,
         	A.OrderSeq
    From 	TPARTKBHIS		A   
 Where 	A.PartKBNo 		= @ps_partkbno		And
	A.PartKBStatus 		= 'C'			And
	A.PartIncomeDate	>= @ps_from		And
	A.PartIncomeDate	<= @ps_to	


Set NoCount Off

End				-- Procedure End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

