/*
	File Name	: sp_pisr143i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisr143i_01
	Description	: 간판 진행정보 조회 ( DataWindow )
	    이론매수 추가
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2006.12
	Author		: 
*/

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr143i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr143i_01]
GO



------------------------------------------------------------------
--	간판진행정보조회
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr143i_01
 	@ps_areacode 		Char(1),   	-- 지역 코드
 	@ps_divcode 		Char(1),   	-- 공장 코드
 	@ps_suppcode 		VarChar(5),   	-- 업체전산화번호
 	@ps_itemcode 		VarChar(12),   	-- 품번
 	@ps_product 		VarChar(2),   	-- 제품군
 	@ps_applytime 		DateTime   	-- 기준시간
AS
BEGIN
-- begin calcKB count
Declare @ls_applymonth    Char(7),    -- 익월 ( 기준일자 다음달 )
  @li_jabDays   Integer,    -- 작업일수
  @li_Term    Integer,    -- 납입 Trem
  @li_EditNo    Integer,    -- 납입 편수
  @li_Cycle   Integer,    -- 납입 Cycle
  @ls_maxdate   Char(10), -- 적용종료일 ( 납입 주기 )
  @li_error   Int

Select @ls_applymonth   = substring( Convert(Char(10), DateAdd(Month, -1, Convert(DateTime, convert(char(7),getdate(),102) + '.01',102)), 102),1 , 7 )
Select @ls_maxdate  = '9999.12.31'

-- 해당월 작업일수
Select  @li_jabDays = Count(*)
  From  TPARTCALENDAR
 Where  AreaCode  = @ps_areacode      And
    DivisionCode  = @ps_divcode     And
    ApplyMonth  = @ls_applymonth    And
    (   WorkGubun        = 'W' or       WorkGubun        = 'w'  )  -- W (조업), H 휴무

If @li_jabDays < 1
   Select @li_jabDays = 20

   SELECT   AreaCode    = B.AreaCode,
          DivisionCode    = B.DivisionCode,
          SupplierCode    = B.SupplierCode,
          PartType    = B.PartType,               -- 제품구분
          ItemCode    = B.ItemCode,             -- 품번
          ItemName    = D.ItemName,             -- 품명
          ItemSpec    = D.ItemSpec,             -- 규격
          PartModelID     = B.PartModelID,            -- 배번호
        PartForecastQty   = ceiling( A.PartForecastQty * C.OrderRate / 100 ),   -- 월자재소요예정량
        RackQty     = B.RackQty,                -- 수용수
        JabDays   = @li_jabDays,               -- 월간 조업일수
        NormalKBSN    = B.NormalKBSN, -- 정규간판최종 SN
        TempKBSN    = B.TempKBSN,   -- 임시간판최종 SN
        PartKBPrintCount  = B.PartKBPrintCount,
        PartKBActiveCount = B.PartKBActiveCount,
        PartKBPlanCount = B.PartKBPlanCount,
        SafetyStock   = B.SafetyStock,
        MonthQty    = ceiling( ceiling( cast(A.PartForecastQty as decimal(13,6)) * C.OrderRate / 100 ) / B.RackQty ), -- 월간판소요매수
        dayQty      = 0,
        modQty      = 0,
        calcKbCnt   = 0       -- 간판이론매수
      Into    #Tmp_JabDays
      FROM  TPARTMONTHPLAN  A,
              TMSTPARTKB    B,
      TMSTORDERRATE C,
      TMSTITEM    D
     WHERE  A.ApplyMonth  = @ls_applymonth  And
              A.AreaCode  = @ps_areacode  And
              A.DivisionCode  = @ps_divcode   And

              A.AreaCode  = B.AreaCode    And
              A.DivisionCode  = B.DivisionCode  And
              A.ItemCode  = B.ItemCode    And
              B.SupplierCode  = @ps_suppcode  And

              A.AreaCode  = C.AreaCode    And
              A.DivisionCode  = C.DivisionCode  And
              A.ItemCode  = C.ItemCode    And
              B.SupplierCode  = C.SupplierCode  And

              A.ItemCode  = D.ItemCode




Update #Tmp_JabDays
      Set dayQty    = ceiling( cast(MonthQty as decimal(13,6)) / @li_jabDays )

Update #Tmp_JabDays
      Set modQty    = MonthQty - ( DayQty * @li_jabDays )

   SELECT   @li_Term  = A.SupplyTerm,
          @li_EditNo  = A.SupplyEditNo,
          @li_Cycle = A.SupplyCycle
      FROM  TMSTPARTCYCLE A
     WHERE  A.AreaCode  = @ps_areacode  And
              A.DivisionCode  = @ps_divcode   And
              A.SupplierCode  = @ps_suppcode  And
              A.ApplyTo   = @ls_maxdate

Update #Tmp_JabDays
      Set calcKbCnt   = Case When @li_EditNo = 0 Then 0
                                  Else ceiling( dayQty * ( @li_Term * ( 1 + @li_Cycle ) / @li_EditNo + SafetyStock ) ) End

-- end calcKB count
  SELECT 	A.AreaCode,   
         		A.DivisionCode,   
         		A.PartType,   
         		A.SupplierCode,   
         		E.SupplierNo,   
         		E.SupplierKorName,   
         		A.ItemCode,   
         		B.ItemName,   
         		A.PartModelID,   
         		A.RackQty,   
         		D.SupplyTerm,   
         		D.SupplyEditNo,   
         		D.SupplyCycle,   
		( Select Top 1 G.ProductGroup From TMSTMODEL 	G 
			Where 	G.AreaCode 	= A.AreaCode 		And 
				G.DivisionCode 	= A.DivisionCode 	And 
				G.ItemCode 	= A.ItemCode ) 		As ProductGroup,
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	= 'A'			And
				( Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastTime Else F.PartForecastTime End ) >= @ps_applytime ) As Order1Cnt,
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	= 'A'			And
				( Case F.OrderChangeFlag When 'Y' Then F.ChangeForecastTime Else F.PartForecastTime End ) < @ps_applytime ) As Order2Cnt,
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	= 'B'		) 	As ReceiptCnt,
		H.calcKbCnt As CacKbCnt
    FROM 	TMSTPARTKB		A left outer join #Tmp_JabDays H
      ON A.AreaCode		= H.AreaCode		AND
		    A.DivisionCode		= H.DivisionCode	AND
		    A.SupplierCode		= H.SupplierCode	AND
        A.ItemCode 		= H.ItemCode,
		TMSTITEM		B,   
		TMSTPARTCYCLE	D,
		TMSTSUPPLIER	E
   WHERE 	A.AreaCode		= @ps_areacode	AND  
         		A.DivisionCode		= @ps_divcode		AND  
         		A.SupplierCode		like @ps_suppcode	AND  
         		A.ItemCode		like @ps_itemcode	AND  

         		A.ItemCode 		= B.ItemCode  		AND  

		A.AreaCode		= D.AreaCode		AND
		A.DivisionCode		= D.DivisionCode	AND
		A.SupplierCode		= D.SupplierCode	AND
		A.ApplyFrom		>= D.ApplyFrom		AND
		A.ApplyFrom		<= D.ApplyTo		AND

         		A.SupplierCode 		= E.SupplierCode  	AND  
         		
		( Select Count( F.PartKBNo ) From TPARTKBSTATUS 	F 
			Where 	F.AreaCode 	= A.AreaCode 		And 
				F.DivisionCode 	= A.DivisionCode 	And 
				F.SupplierCode 	= A.SupplierCode 	And 
				F.ItemCode 	= A.ItemCode 		And
				F.PartKBStatus	In ( 'A', 'B' )	) > 0 	And

		( Select Top 1 G.ProductGroup From TMSTMODEL 	G 
			Where 	G.AreaCode 	= A.AreaCode 		And 
				G.DivisionCode 	= A.DivisionCode 	And 
				G.ItemCode 	= A.ItemCode 	) like @ps_product 
    
Drop Table #Tmp_JabDays

END

