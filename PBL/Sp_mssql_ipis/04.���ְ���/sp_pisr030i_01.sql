SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr030i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr030i_01]
GO



------------------------------------------------------------------
--	기준월 자재 소요량 예시			
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr030i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		Char(5),   	-- 업체전산화번호
 	@ps_applydate 		Char(10)	-- 기준일자
AS
BEGIN

Declare	@ls_applymonth		Char(7),	-- 기준월 
	@li_jabDays		Integer,	-- 작업일수
	@li_error		Int

--Select @ls_applymonth = substring( Convert(Char(10), DateAdd(Month, 1, Convert(DateTime, @ps_applydate,102)), 102),1 , 7 )
Select @ls_applymonth = substring( @ps_applydate,1 , 7 )

-- 해당월 작업일수 
Select	@li_jabDays = Count(*)   
  From 	TPARTCALENDAR
 Where 	AreaCode	= @ps_areacode			And
   	DivisionCode	= @ps_divcode			And
   	ApplyMonth	= @ls_applymonth		And
--   	ApplyMonth	= left( @ps_applydate, 7 )	And
   	(   WorkGubun        = 'W' or       WorkGubun        = 'w'  )  -- W (조업), H 휴무

If @li_jabDays < 1 
   Select @li_jabDays = 1 

	  SELECT 	A.ItemCode,   
	         		D.ItemName,   
	         		D.ItemSpec,   
	         		B.PartModelID,   
               		MonthQty 	= ceiling( A.PartForecastQty * C.OrderRate / 100.0 ), -- 월소요매수  
--	         		A.PartForecastQty,   
	         		B.RackQty,   
	         		B.PartType,
			JobDays	= @li_jabDays
	    FROM 	TPARTMONTHPLAN	A,   
	         		TMSTPARTKB		B,  
			TMSTORDERRATE	C,   
			TMSTITEM		D   
	   WHERE 	A.ApplyMonth 	= @ls_applymonth 	And  
	         		A.AreaCode 	= @ps_areacode 	And  
	         		A.DivisionCode 	= @ps_divcode		And

	         		A.AreaCode 	= B.AreaCode	 	And  
	         		A.DivisionCode 	= B.DivisionCode 	And  
	         		A.ItemCode 	= B.ItemCode		And
	         		B.SupplierCode 	= @ps_suppcode	And

	         		A.AreaCode 	= C.AreaCode	 	And  
	         		A.DivisionCode 	= C.DivisionCode 	And  
	         		A.ItemCode 	= C.ItemCode		And
	         		B.SupplierCode 	= C.SupplierCode	And

	         		A.ItemCode 	= D.ItemCode		


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

