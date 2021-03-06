SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr030p_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr030p_01]
GO


--------------------------------------------------------------------------
--		간판 월소요매수 ( 일자별 ) 조회 정보 출력
--------------------------------------------------------------------------

CREATE PROCEDURE sp_pisr030p_01
	@ps_areacode 		Char(1),   	-- 지역 코드
	@ps_divcode 		Char(1),   	-- 공장 코드
	@ps_suppcode 		Char(5),   	-- 업체전산화번호
	@ps_applydate 		Char(10)       	-- 기준일자
AS
BEGIN

Declare	@li_jabDays		Integer,	-- 작업일수
	@li_error		Int,
            @ls_applymonth		Char(7) 


Select	@ls_applymonth = left( @ps_applydate, 7 )

-- 해당월 작업일수 
Select	@li_jabDays = Count(*)   
  From 	TPARTCALENDAR
 Where 	AreaCode	= @ps_areacode			And
   	DivisionCode	= @ps_divcode			And
   	ApplyMonth	= @ls_applymonth		And 
   	( WorkGubun = 'W' Or WorkGubun = 'w' )  -- W (조업), H 휴무

If @li_jabDays < 1 
   Select @li_jabDays = 1 

Select 	AreaCode    	= A.AreaCode, 
           	DivisionCode    	= A.DivisionCode, 
         	ApplyMonth	= A.ApplyMonth,   
         	ApplyDate	= A.ApplyDate,   
         	DayNo		= A.DayNo,   
         	WorkGubun	= A.WorkGubun,   
         	Remark		= A.Remark,   
	HCount = ( Select Count(*) From TPARTCALENDAR  B Where B.AreaCode = @ps_areacode And B.DivisionCode = @ps_divcode And B.ApplyMonth = @ls_applymonth And B.WorkGubun = 'H' And B.ApplyDate <= A.ApplyDate )
       Into	#Tmp_CALENDAR
     From TPARTCALENDAR	A 
   WHERE 	A.ApplyMonth 	= @ls_applymonth 	And  
         		A.AreaCode 	= @ps_areacode 	And  
         		A.DivisionCode 	= @ps_divcode	

Select 	AreaCode    	= A.AreaCode, 
           	DivCode    	= A.DivisionCode, 
           	SuppCode 	= B.SupplierCode, 
           	ItemCode  	= A.ItemCode,
	PartModelID	= B.PartModelID,
	PartType	= B.PartType,
	RackQty	= B.RackQty,
	MonthItemQty	= ceiling( A.PartForecastQty * C.OrderRate / 100.0 ),
            	MonthQty 	= ceiling( ceiling( A.PartForecastQty * C.OrderRate / 100.0 ) / B.RackQty ),
	WorkGubun_1 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.01' ),
	WorkGubun_2 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.02' ),
	WorkGubun_3 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.03' ),
	WorkGubun_4 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.04' ),
	WorkGubun_5 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.05' ),
	WorkGubun_6 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.06' ),
	WorkGubun_7 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.07' ),
	WorkGubun_8 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.08' ),
	WorkGubun_9 =   ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.09' ),
	WorkGubun_10 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.10' ),
	WorkGubun_11 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.11' ),
	WorkGubun_12 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.12' ),
	WorkGubun_13 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.13' ),
	WorkGubun_14 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.14' ),
	WorkGubun_15 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.15' ),
	WorkGubun_16 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.16' ),
	WorkGubun_17 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.17' ),
	WorkGubun_18 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.18' ),
	WorkGubun_19 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.19' ),
	WorkGubun_20 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.20' ),
	WorkGubun_21 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.21' ),
	WorkGubun_22 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.22' ),
	WorkGubun_23 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.23' ),
	WorkGubun_24 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.24' ),
	WorkGubun_25 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.25' ),
	WorkGubun_26 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.26' ),
	WorkGubun_27 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.27' ),
	WorkGubun_28 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.28' ),
	WorkGubun_29 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.29' ),
	WorkGubun_30 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.30' ),
	WorkGubun_31 = ( Select WorkGubun From #Tmp_CALENDAR Where AreaCode = @ps_areacode And DivisionCode = @ps_divcode And ApplyDate = @ls_applymonth + '.31' ), 
          	dayQty 	= 0,
          	modQty = 0 
       Into	#Tmp_JabDays
     From 	TPARTMONTHPLAN	A, 
		TMSTPARTKB 		B, 
		TMSTORDERRATE 	C
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
         		B.SupplierCode 	= C.SupplierCode/*	And
 	EXISTS (SELECT 	*  
	        	   FROM 	TPARTCALENDAR C   
	             WHERE 	C.AreaCode 	= A.AreaCode 		AND  
		     		C.DivisionCode 	= A.DivisionCode 	AND  
         	    			C.ApplyMonth	= A.ApplyMonth		)	*/

 Update #Tmp_JabDays 
      Set dayQty = floor( MonthQty / @li_jabDays )

 Update #Tmp_JabDays 
      Set modQty = MonthQty - ( DayQty * @li_jabDays )

 SELECT  AreaCode		 = A.AreaCode,   
  	   AreaName		 = B.AreaName,   
  	   DivisionCode		 = A.DivCode,   
  	   DivisionName		 = C.DivisionName,   
  	   SupplierCode		 = A.SuppCode,   
  	   SupplierKorName	 = D.SupplierKorName,   
  	   SupplierNo		 = D.SupplierNo,   
       	   ItemCode 		 = A.ItemCode,            -- 품번
       	   ItemName 		 = E.ItemName,           -- 품명
       	   ItemSpec 		 = E.ItemSpec,            -- 규격
	   PartType		 = A.PartType,	         --부품구분
	   PartModelID		 = A.PartModelID,       -- 배번호
	   MonthItemQty		 = A.MonthItemQty,     -- 월소요예정량
	   RackQty		 = A.RackQty,	         -- 수용수
               day_1			= Case WorkGubun_1 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.01' ) >= 1 Then DayQty + 1 else DayQty End End, 
               day_2			= Case WorkGubun_2 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.02' ) >= 2 Then DayQty + 1 else DayQty End End, 
               day_3			= Case WorkGubun_3 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.03' ) >= 3 Then DayQty + 1 else DayQty End End, 
               day_4			= Case WorkGubun_4 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.04' ) >= 4 Then DayQty + 1 else DayQty End End, 
               day_5			= Case WorkGubun_5 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.05' ) >= 5 Then DayQty + 1 else DayQty End End, 
               day_6			= Case WorkGubun_6 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.06' ) >= 6 Then DayQty + 1 else DayQty End End, 
               day_7			= Case WorkGubun_7 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.07' ) >= 7 Then DayQty + 1 else DayQty End End, 
               day_8			= Case WorkGubun_8 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.08' ) >= 8 Then DayQty + 1 else DayQty End End, 
               day_9			= Case WorkGubun_9 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.09' ) >= 9 Then DayQty + 1 else DayQty End End, 
               day_10		= Case WorkGubun_10 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.10' ) >= 10 Then DayQty + 1 else DayQty End End, 
               day_11		= Case WorkGubun_11 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.11' ) >= 11 Then DayQty + 1 else DayQty End End, 
               day_12		= Case WorkGubun_12 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.12' ) >= 12 Then DayQty + 1 else DayQty End End, 
               day_13		= Case WorkGubun_13 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.13' ) >= 13 Then DayQty + 1 else DayQty End End, 
               day_14		= Case WorkGubun_14 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.14' ) >= 14 Then DayQty + 1 else DayQty End End, 
               day_15		= Case WorkGubun_15 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.15' ) >= 15 Then DayQty + 1 else DayQty End End, 
               day_16		= Case WorkGubun_16 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.16' ) >= 16 Then DayQty + 1 else DayQty End End, 
               day_17		= Case WorkGubun_17 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.17' ) >= 17 Then DayQty + 1 else DayQty End End, 
               day_18		= Case WorkGubun_18 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.18' ) >= 18 Then DayQty + 1 else DayQty End End, 
               day_19		= Case WorkGubun_19 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.19' ) >= 19 Then DayQty + 1 else DayQty End End, 
               day_20		= Case WorkGubun_20 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.20' ) >= 20 Then DayQty + 1 else DayQty End End, 
               day_21		= Case WorkGubun_21 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.21' ) >= 21 Then DayQty + 1 else DayQty End End, 
               day_22		= Case WorkGubun_22 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.22' ) >= 22 Then DayQty + 1 else DayQty End End, 
               day_23		= Case WorkGubun_23 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.23' ) >= 23 Then DayQty + 1 else DayQty End End, 
               day_24		= Case WorkGubun_24 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.24' ) >= 24 Then DayQty + 1 else DayQty End End, 
               day_25		= Case WorkGubun_25 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.25' ) >= 25 Then DayQty + 1 else DayQty End End, 
               day_26		= Case WorkGubun_26 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.26' ) >= 26 Then DayQty + 1 else DayQty End End, 
               day_27		= Case WorkGubun_27 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.27' ) >= 27 Then DayQty + 1 else DayQty End End, 
               day_28		= Case WorkGubun_28 When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.28' ) >= 28 Then DayQty + 1 else DayQty End End, 
               day_29		= Case WorkGubun_29 When Null Then NULL When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.29' ) >= 29 Then DayQty + 1 else DayQty End End, 
               day_30		= Case WorkGubun_30 When Null Then NULL When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.30' ) >= 30 Then DayQty + 1 else DayQty End End, 
               day_31		= Case WorkGubun_31 When Null Then NULL When 'H' Then NULL Else Case When modQty + ( SELECT HCount FROM #Tmp_CALENDAR WHERE  ApplyDate = @ls_applymonth + '.31' ) >= 31 Then DayQty + 1 else DayQty End End, 
               MonthQty                    	= A.MonthQty,	--월간 간판소요매수
               dayQty                        	= A.DayQty, 	--일 간판소요매수
               modQty                       	= A.modQty,
	  applyMonth		= @ls_applymonth,	-- 기준월
               jabDays		= @li_jabDays 		-- 해당월 작업일수
    FROM  	#Tmp_JabDays 		A,
		TMSTAREA		B,
		TMSTDIVISION		C,
		TMSTSUPPLIER	D,
		TMSTITEM		E
WHERE	A.AreaCode	= B.AreaCode		And
		A.AreaCode	= C.AreaCode		And
		A.DivCode	= C.DivisionCode	And
		A.SuppCode	= D.SupplierCode	And
		A.ItemCode	= E.ItemCode	
		
Drop Table #Tmp_JabDays
Drop Table #Tmp_CALENDAR

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

