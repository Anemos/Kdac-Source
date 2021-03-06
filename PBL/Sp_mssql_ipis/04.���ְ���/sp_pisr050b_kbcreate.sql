SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr050b_kbcreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr050b_kbcreate]
GO


CREATE Procedure sp_pisr050b_kbcreate
            	@ps_areaCode 		Char(1), 
            	@ps_divCode    		Char(1), 
            	@ps_suppCode 		Char(5),
            	@ps_itemCode  		VarChar(12), 
	@ps_option		Char(1),		-- Create Option('N' : 정규간판, 'T' : 임시 간판)
	@pi_qty			Int,		-- 신규간판생성 수량
	@pi_rackqty		Int,		-- Rack 수용수(임시간판의 Rack수용수는 PB로 부터 받아야 한다.)
	@ps_empcode		Char(6),		-- 최종수정 작업자
            	@ri_errcode       	Int     Output 
As
Begin

Set NoCount ON

Declare	@ls_leftkbno		VarChar(9),	-- 간판 번호 S/N를 제외한 부분
	@li_lastsn		Int,		-- 간판 번호 S/N
	@ls_kbno		Char(11),	-- 간판 번호 
	@i			Int

Set NoCount On

  SELECT 	@ls_leftkbno	= Case When @ps_option = 'N' Then SubString(NormalKBSN, 1, 8) 
						Else SubString(TempKBSN, 1, 9) End,   
	   	@li_lastsn	= Convert(Integer, Case When @ps_option = 'N' Then SubString(NormalKBSN, 9, 3) 
						Else SubString(TempKBSN, 10, 2) End )   
    FROM 	TMSTPARTKB
   WHERE 	AreaCode 	=  @ps_areaCode 	AND  
               	DivisionCode 	=  @ps_divCode 	AND  
               	SupplierCode 	=  @ps_suppCode 	AND  
               	ItemCode 	=  @ps_itemCode  

Select	@i	= 0

Create	Table #Tmp_KBNo
(	AreaCode 		Char(1),
	DivisionCode 		Char(1),
	SupplierCode		Char(5),
	ItemCode		Char(12),
	KBNo			Char(11)
)

While @i < @pi_qty
Begin
	Select	@i		= @i + 1,
		@ls_kbno	= @ls_leftkbno + Case When @ps_option = 'N' Then 
							Right('000' + Rtrim(Convert(Char(3), @li_lastsn + @i)), 3)
						Else	Right('00' + Rtrim(Convert(Char(2), @li_lastsn + @i)), 2)
					   End

	Insert Into #Tmp_KBNo
	Values(@ps_areaCode, @ps_divCode, @ps_suppCode, @ps_itemCode, @ls_kbno)
End

Begin

	 INSERT 	TPARTKBSTATUS
	SELECT 	PartKBNo 		= B.KbNo,   
	   		AreaCode 		= B.AreaCode,   
	   		DivisionCode 		= B.DivisionCode,   
	   		SupplierCode 		= B.SupplierCode,   
    		            ItemCode 		= B.ItemCode,   
               		ApplyFrom 		= A.ApplyFrom,
               		PartType 		= A.PartType, 
               		RePrintFlag 		= 'Y',   			--재발행 필요Flag
               		RePrintCount 		= 0,   			--재발행 회수
               		PartKBGubun 		= @ps_option,   		--자재간판구분 'N'정규, 'T'임시
               		KBActiveGubun 		= 'S', 			--간판 Active 구분
	   		PartKBStatus 		= 'D',   			--간판 상태 'D'발주대기
               		KBOrderPossible 	= 'N',   
	   		RackQty 		= @pi_rackqty,   
               		OrderChangeFlag 	= 'N',   
               		PartOrderCancel 	= 'N',   
              		PartReceiptCancel 	= 'N',   
               		UseCenterGubun 	= A.UseCenterGubun,   
               		UseCenter 		= A.UseCenter,   
               		PartObeyDateFlag 	= '0',   
               		PartObeyTimeFlag 	= '0',   
              		PartOrderDate 		= NULL,   
               		PartOrderTime 		= NULL,   
               		PartForeCastDate 	= NULL,   
               		PartForecastEditNo 	= NULL,   
               		PartForecastTime 	= NULL,   
               		PartReceiptDate		= NULL,   
               		PartEditNo 		= NULL,   
               		PartReceiptTime 	= NULL,   
               		PartIncomeDate 	= NULL,   
               		PartIncomeTime 	= NULL,   
               		PartOrderNo 		= NULL,   		--발주번호
               		DeliveryNo 		= NULL,   		--납품표번호
               		BuyBackNo 		= NULL,   		--반출증번호
               		PartKBCreateDate 	= GetDate(),
               		PartKBPrintDate 	= NULL,   
               		OrderChangeTime 	= NULL,   
               		OrderChangeCode 	= NULL,   
               		ChangeForecastDate 	= NULL,   
               		ChangeForecastEditNo 	= NULL,   
               		ChangeForecastTime 	= NULL,   
               		OrderSeq	 	= NULL,   
               		LastEmp 		= 'Y',			-- Interface Flag 활용
               		LastDate 		= GetDate() 
	    FROM	TMSTPARTKB 	A, 
			#Tmp_KBNo 	B 
	  WHERE	A.AreaCode 	= B.AreaCode		AND  
              		A.DivisionCode 	= B.DivisionCode 	AND  
               		A.SupplierCode 	= B.SupplierCode 	AND  
               		A.ItemCode 	= B.ItemCode  


	SELECT	@ri_errcode = @@Error
	IF @ri_errcode <> 0 
	Begin 
		Set NoCount Off
		Return @ri_errcode
	End
End
Begin

	UPDATE	TMSTPARTKB
	      SET	NormalKBSN	= Case When @ps_option = 'N' Then @ls_kbno Else NormalKBSN End,
	  		TempKBSN	= Case When @ps_option = 'T' Then @ls_kbno Else TempKBSN End,
	  		LastEmp	= 'Y',				-- Interface Flag 활용
	  		LastDate	= GetDate()
   	 WHERE 	AreaCode 	=  @ps_areaCode  	AND  
               		DivisionCode 	=  @ps_divCode  	AND  
               		SupplierCode 	=  @ps_suppCode  	AND  
               		ItemCode 	=  @ps_itemCode  

	SELECT	@ri_errcode = @@Error
	IF @ri_errcode <> 0 
	Begin 
		Set NoCount Off
		Return @ri_errcode
	End
End

Drop Table #Tmp_KBNo
Set NoCount Off

End				-- Procedure End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

