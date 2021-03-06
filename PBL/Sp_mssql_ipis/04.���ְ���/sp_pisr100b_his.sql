SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr100b_his]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr100b_his]
GO


CREATE Procedure sp_pisr100b_his
            	@ps_partkbno	Char(11), 
            	@ps_applydate	Char(10), 
	@ps_empcode	Char(6), 
            	@ri_errcode       	Int     Output 
As
Begin

Set NoCount ON

Declare	@li_partorderseq	int	-- 자재발주순서( 하루에 몇번 )

  SELECT @li_partorderseq = Count(PartKBNo)
    FROM TPARTKBHIS
   WHERE PartKBNo 	=  @ps_partkbno 	AND  
         ApplyDate 	=  @ps_applydate 	

  Select @li_partorderseq = @li_partorderseq + 1

Begin
	INSERT 	TPARTKBHIS
	SELECT 	PartKBNo 		= A.PartKBNo,   
	   	ApplyDate 		= @ps_applydate,   	--발주일자기준
	   	PartOrderSeq 		= @li_partorderseq,   	--순서
	   	AreaCode 		= A.AreaCode,   
	   	DivisionCode 		= A.DivisionCode,   
	   	SupplierCode 		= A.SupplierCode,   
    		ItemCode 		= A.ItemCode,   
               	ApplyFrom 		= A.ApplyFrom,
               	PartType 		= A.PartType, 
               	RePrintFlag 		= A.RePrintFlag,   	
               	RePrintCount 		= A.RePrintCount,   			
               	PartKBGubun 		= A.PartKBGubun,  	--자재간판구분 'N'정규, 'T'임시
               	KBActiveGubun 		= A.KBActiveGubun,	--간판 Active 구분
	   	PartKBStatus 		= 'C', 			--간판 상태 'C' 입고
               	KBOrderPossible 	= A.KBOrderPossible,   
	   	RackQty 		= A.RackQty,   
               	OrderChangeFlag 	= A.OrderChangeFlag,   
               	PartOrderCancel 	= A.PartOrderCancel,   
              	PartReceiptCancel 	= A.PartReceiptCancel,   
               	UseCenterGubun	= A.UseCenterGubun,   
               	UseCenter 		= A.UseCenter,   
               	PartObeyDateFlag 	= A.PartObeyDateFlag,   
               	PartObeyTimeFlag 	= A.PartObeyTimeFlag,   
              	PartOrderDate 		= A.PartOrderDate,   
               	PartOrderTime 		= A.PartOrderTime,   
               	PartForeCastDate 	= A.PartForeCastDate,   
               	PartForecastEditNo 	= A.PartForecastEditNo,   
               	PartForecastTime 	= A.PartForecastTime,   
               	PartReceiptDate		= A.PartReceiptDate,   
               	PartEditNo 		= A.PartEditNo,   
               	PartReceiptTime 	= A.PartReceiptTime,   
               	PartIncomeDate 	= A.PartIncomeDate,   
               	PartIncomeTime 	= A.PartIncomeTime,   
               	PartOrderNo 		= A.PartOrderNo,   		--발주번호
               	DeliveryNo 		= A.DeliveryNo,   		--납품표번호
               	BuybackNo 		= A.BuybackNo,   		--반출증번호
               	PartKBCreateDate 	= A.PartKBCreateDate,
               	PartKBPrintDate 	= A.PartKBPrintDate,   
               	OrderChangeTime 	= A.OrderChangeTime,   
               	OrderChangeCode 	= A.OrderChangeCode,   
               	ChangeForecastDate 	= A.ChangeForecastDate,   
               	ChangeForecastEditNo 	= A.ChangeForecastEditNo,   
               	ChangeForecastTime 	= A.ChangeForecastTime,   
               	OrderSeq 		= A.OrderSeq,   
               	LastEmp 		= 'Y',				-- Interface Flag 활용
               	LastDate 		= GetDate() 
	   FROM	TPARTKBSTATUS 	A 
	  WHERE	A.PartKBNo 	= @ps_partkbno

	SELECT	@ri_errcode = @@Error
	IF @ri_errcode <> 0 
	Begin 
		Set NoCount Off
		Return @ri_errcode
	End
End

Set NoCount Off

End				-- Procedure End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

