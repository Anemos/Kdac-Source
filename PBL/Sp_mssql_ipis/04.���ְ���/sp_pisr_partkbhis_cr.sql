SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr_partkbhis_cr]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr_partkbhis_cr]
GO



--------------------------------------------------------
--             외주간판마스터 History 생성
--------------------------------------------------------

CREATE PROCEDURE sp_pisr_partkbhis_cr
 @ps_areaCode		char(1),		--지역
 @ps_divCode		char(1),		--공장
 @ps_suppCode		char(5),		--업체	
 @ps_itemCode		char(12),	--부품
 @ps_applyFrom 	char(10),	-- 적용시작일자 
 @ps_lastEmp		varChar(6),	-- 수정자 
 @ri_err			Int	Output
AS
BEGIN

Declare	@ls_MaxDate		char(10),		-- 년도 Type 의 최대치
            @ls_lastdate		char(10),		-- Scheduling End Date('YYYY.MM.DD')
            @li_Cnt 			int 

-- Parameter Initialize
Select	@ls_MaxDate	= '9999.12.31'
Select	@ls_lastdate	= Convert(Char(10), DateAdd(Day, -1, Convert(DateTime, @ps_applyFrom,102)), 102)

Select	@li_Cnt = Count(*)
  From  TMSTPARTKB A, TMSTPARTKBHIS B 
Where	A.AreaCode 	= B.AreaCode 		And
	A.DivisionCode 	= B.DivisionCode 	And
	A.SupplierCode 	= B.SupplierCode 	And
	A.ItemCode	= B.ItemCode 		And
	A.ApplyFrom	= B.ApplyFrom 		And
         ( 	B.AreaCode 	= @ps_areaCode	And 
         	B.DivisionCode 	= @ps_divCode 		And 
         	B.SupplierCode	= @ps_suppCode 	And 
	B.ItemCode	= @ps_itemCode 	And
	B.ApplyTo	= @ls_MaxDate  ) 

If @li_Cnt = 0 
Begin
  INSERT INTO TMSTPARTKBHIS  
  SELECT A.AreaCode,   
	A.DivisionCode,   
         	A.SupplierCode,   
  	A.ItemCode,   
        	A.ApplyFrom,   
        	@ls_lastdate, 
        	A.PartType,   
        	A.ChangeFlag,   
       	A.PartModelID,   
        	A.PartID,   
         	A.UseCenterGubun,   
        	A.UseCenter,   
         	A.CostGubun,   
        	A.RackQty,   
         	A.RackCode,   
	A.StockGubun,   
         	A.ReceiptLocation,   
        	A.MailBoxNo,   
         	A.SafetyStock,   
         	A.UseFlag,   
         	A.AutoReorderFlag,   
      	A.KBUseFlag,   
         	A.ChangeDate,   
         	A.NormalKBSN,   
         	A.TempKBSN,   
         	A.PartKBPrintCount,   
         	A.PartKBActiveCount,   
         	A.PartKBPlanCount,
	'Y',			-- Interface Flag 활용
   	Getdate()
    FROM TMSTPARTKB A
    Where A.AreaCode 	= @ps_areaCode 	And
    	A.DivisionCode 	= @ps_divCode 		And
          	A.SupplierCode 	= @ps_suppCode 	And
          	A.itemCode 	= @ps_itemCode 
End

If @li_Cnt > 0 
Begin
  UPDATE TMSTPARTKBHIS
     SET ApplyTo = @ls_lastdate, 
         PartType	 =	 A.PartType,   
         ChangeFlag =	 A.ChangeFlag,   
         PartModelID = A.PartModelID,   
         PartID = A.PartID,   
         UseCenterGubun = A.UseCenterGubun,   
         UseCenter = A.UseCenter,   
         CostGubun = A.CostGubun,   
         RackQty = A.RackQty,   
         RackCode = A.RackCode,   
         StockGubun = A.StockGubun,   
         ReceiptLocation = A.ReceiptLocation,   
         MailBoxNo = A.MailBoxNo,   
         SafetyStock = A.SafetyStock,   
         UseFlag = A.UseFlag,   
         AutoReorderFlag = A.AutoReorderFlag,   
         KBUseFlag = A.KBUseFlag,   
         ChangeDate = A.ChangeDate,   
         NormalKBSN = A.NormalKBSN,   
         TempKBSN = A.TempKBSN,   
         PartKBPrintCount = A.PartKBPrintCount,   
         PartKBActiveCount = A.PartKBActiveCount,   
         PartKBPlanCount = A.PartKBPlanCount,   
         LastEmp = 'Y',		--Interface Flag 활용   
         LastDate = A.LastDate 
    FROM TMSTPARTKB A 
   WHERE ( A.AreaCode = TMSTPARTKBHIS.AreaCode ) and  
         ( A.DivisionCode = TMSTPARTKBHIS.DivisionCode ) and  
         ( A.SupplierCode = TMSTPARTKBHIS.SupplierCode ) and  
         ( A.ItemCode = TMSTPARTKBHIS.ItemCode ) and  
         ( A.ApplyFrom = TMSTPARTKBHIS.ApplyFrom ) and  
         ( ( A.AreaCode = @ps_areaCode ) AND  
           ( A.DivisionCode = @ps_divCode ) AND  
           ( A.SupplierCode = @ps_suppcode ) AND  
           ( A.ItemCode = @ps_itemCode ) And
           ( TMSTPARTKBHIS.ApplyTo = @ls_MaxDate ))
End 

Select	@ri_err	= @@Error
If @ri_err <> 0 Return @ri_err

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

