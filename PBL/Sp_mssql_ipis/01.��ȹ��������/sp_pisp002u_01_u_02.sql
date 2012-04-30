/*
	File Name	: sp_pisp002u_01_u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp002u_01_u_02
	Description	: 일일 생산 계획 계산 - 02 번째
			  월간생산계획(tplanmonth) 을 일일생산계획으로 계산한다.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 16
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u_02]
GO


/*
Declare	@ls_error		varchar(2),	-- Transaction 수행 에러 값
	@ls_errortext		varchar(30)	-- Transaction 수행 에러 내역

Execute sp_pisp002u_01_u_02
	@ps_option		= 'F',
	@ps_planmonth		= '2002.09',
	@ps_plandate		= '2002.09.06',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '%',
	@pi_rackqty		= 20,
	@pi_planqty		= 3000,
	@pi_changeqty		= 3000,
	@ps_last_workday	= '2002.09.18',
	@pi_work_count		= 10,
	@ps_empcode		= 'KJS',
	@ps_error		= @ls_error	output,
	@ps_errortext		= @ls_errortext	output

Select	@ls_error, @ls_errortext

select * from tplanmonth

select dividerate from tmstkb

update tplanday
set changeqty = 100
where itemcode in ('10456266A', '10456267A')

select *
from tsrorder
where itemcode in ('10456266A',
'10456267A',
'511513',
'511514',
'511517')
*/


Create Procedure sp_pisp002u_01_u_02
	@ps_option		char(1),		-- Scheduling Option('F' : First, 'S' : After First)
	@ps_planmonth		char(7),		-- 계획월 ('YYYY.MM')
	@ps_plandate		char(10),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1),
	@ps_itemcode		varchar(12),	-- 품번
	@pi_planqty		int,
	@pi_changeqty		int,
	@ps_last_workday	char(10),
	@pi_work_count		int,
	@ps_empcode		varchar(6),	-- 최종수정작업자
	@ps_error		varchar(2)	output,		-- 에러
	@ps_errortext		varchar(100)	output		-- 에러 내역

As
Begin

Declare	@ls_plandate		char(10),	-- 계산 시작일('YYYY.MM.DD')
	@li_scheduling_plan	Integer,		-- Scheduling Plan
	@ls_lastday		char(10),	-- Scheduling End Date('YYYY.MM.DD')
	@ls_workgubun		char(1),		-- Loop Date 작업구분(W/H)
	@li_rackqty		int,		-- 간판 수용수
	@li_planqty		Int,		-- 기준계획수량
	@li_changeqty		Int,		-- 운영계획수량
	@li_lot_tot		Int,		-- 총 조립 Lot 수
	@ln_lot_day		Numeric(5,1),	-- 일일 조립 Lot 수(소수점 포함)
	@li_lot_day		Int,		-- 일일 조립 Lot 수(내림)
	@li_lot_insert		Int,		-- 일일 조립 Lot 수(내림) : Table Modify Value
	@li_lot_sum		Int,		-- Cummlative Sum of 일일 조립 Lot 
	@ln_minus_lot		Numeric(5,1),	-- 일일 조립 Lot 수(소숫점 아래)
	@ln_minus_loop		Numeric(5,1),	-- Cumulative Sum of 일일 조립 Lot 수(소숫점 아래)
	@li_devide		Int,		-- 나머지 Check
	@li_count		int,
	@ls_error		varchar(2),	-- Transaction 수행 에러 값
	@ls_errortext		varchar(100)	-- Transaction 수행 에러 내역

--select '03 시작'

-- 첫번째 Scheduling 이거나, 월초(1일)부터 생산계획을 재계산 할경우에 Scheduling할 계획수량을 운영계획으로 Setting한다.
-- 그 외의 경우는 운영계획 - 생산실적의 수량으로 Scheduling을 수행한다.
Select	@li_scheduling_plan	= Case	When @ps_option = 'F' Or Right(@ps_plandate, 2) = '01' Then @pi_changeqty
					Else @pi_changeqty - Sum(IsNull(ChangeQty, 0))
				  End
  From	tplanday
 Where	PlanDate	Like @ps_planmonth + '.__'	And
	PlanDate	< @ps_plandate			And
	DivisionCode	= @ps_divisioncode		And
	WorkCenter	= @ps_workcenter		And
	LineCode	= @ps_linecode			And
	ItemCode	= @ps_itemcode


If @li_scheduling_plan is Null
	Select @li_scheduling_plan = @pi_changeqty


If @li_scheduling_plan < 0
Begin
	Select	@ps_error	= '00',
		@ps_errortext	= '일일생산계획을 계산하려는 생산수량이 0 보다 작은 값입니다.'
	Return
End

--select '총합' = @li_scheduling_plan


-- 간판 Rack 수용수 구하기
Select	@li_rackqty	= IsNull(RackQty, 1)
  From	tmstkb
 Where	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
	WorkCenter	= @ps_workcenter	And
	LineCode	= @ps_linecode		And
	ItemCode	= @ps_itemcode		

-- 일일 생산 계획 초기화
Update	tplanday
   Set	ChangeQty	= 0,
	NormalKBCount	= 0,
	NormalKBQty	= 0,
	TempKBCount	= 0,
	TempKBQty	= 0,
	LastEmp		= 'Y', --@ps_empcode,
	LastDate		= GetDate()
  From	tplanday		A
 Where	A.PlanDate	Like @ps_planmonth + '.__'	And
	A.PlanDate	>= @ps_plandate			And
	A.AreaCode	= @ps_areacode			And
	A.DivisionCode	= @ps_divisioncode		And
	A.WorkCenter	= @ps_workcenter		And
	A.LineCode	= @ps_linecode			And
	A.ItemCode	= @ps_itemcode

If @@Error <> 0
Begin
	Select	@ps_error	= '00',
		@ps_errortext	= '일일생산계획을 초기화 하는 도중에 오류가 발생하였습니다.'
	Return
End


-- 총 조립 Lot수 계산(DataType변환을 위하여 1.0을 곱한다.)
-- select Ceiling(6/5) = 1,	select Ceiling(6 * 1.0/5) = 2
-- 생산계획이 Rack 수용수의 배수가 아닐경우에 Lot수는 올림처리한다.
Select	@li_lot_tot	= Ceiling((@li_scheduling_plan * 1.0) / @li_rackqty)

-- 일일 조립 Lot수 계산
Select	@ln_lot_day	= (@li_lot_tot * 1.0) / @pi_work_count

Select	@li_lot_day	= Floor(@ln_lot_day),
	@li_lot_insert	= Floor(@ln_lot_day),
	@li_lot_sum	= 0,
	@ln_minus_lot	= @ln_lot_day - Floor(@ln_lot_day),
	@ln_minus_loop	= @ln_lot_day - Floor(@ln_lot_day)


Select	@ls_plandate	= @ps_plandate,
	@ls_lastday	= Convert(Char(10), DateAdd(Day, -1, Convert(DateTime, Convert(Char(7), 
				  DateAdd(Month, 1, Convert(DateTime, @ps_plandate)), 102) + '.01')), 102)

-- 일일 평균화 생산계획 Generate
While @ls_plandate <= @ls_lastday
Begin
	-- 작업구분이 'W'인 날에만 생산계획 Assign
	-- Work Calendar 에서 근무일수 등을 구하자.
	Select	@ls_workgubun	= WorkGubun,
		@li_count	= Count(WorkGubun)
	  From	tcalendarwork
	 Where	AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		ApplyMonth		= @ps_planmonth		And
		ApplyDate		= @ls_plandate
	Group By WorkGubun		
	If @li_count = 0-- Work Calendar가 없으면 Shop Calendar 을 이용하자.
	Begin				
		Select	@ls_workgubun	= WorkGubun,
			@li_count	= Count(WorkGubun)
		  From	tcalendarshop
		 Where	AreaCode		= @ps_areacode		And
			DivisionCode		= @ps_divisioncode	And
			ApplyMonth		= @ps_planmonth		And
			ApplyDate		= @ls_plandate
		Group By WorkGubun
		If @li_count = 0 -- 어라.. Shop Calendar 도 없네..누굴 조지지...그냥 나가야지..헤헤
		Begin
			GoTo Proc_No_Item
		End
	End

--select	@ls_plandate, @ls_workgubun, @ps_last_workday, @li_scheduling_plan, @pi_work_count

	If @ls_workgubun = 'W'
	Begin
		If @ln_minus_loop >= 1.0
		Begin
			Select	@li_lot_insert	= @li_lot_day + 1,
				@ln_minus_loop	= @ln_minus_loop - 1.0
		End

		-- 마지막 근무날 나머지 분에 대하여 올림처리하여 계획에 반영한다.
		If @ls_plandate = @ps_last_workday
		Begin
			Select	@li_lot_sum	= @li_lot_sum + @li_lot_insert

			If @li_lot_sum > @li_lot_tot
			Begin
				While @li_lot_sum > @li_lot_tot
				Begin
					Select	@li_lot_sum	= @li_lot_sum - 1,
						@li_lot_insert	= @li_lot_insert - 1
				End
			End
			Else
			Begin
				While @li_lot_sum < @li_lot_tot
				Begin
					Select	@li_lot_sum	= @li_lot_sum + 1,
						@li_lot_insert	= @li_lot_insert + 1
				End
			End
		End				-- 마지막 작업일일 경우 End
		Else
		Begin
			Select	@li_lot_sum	= @li_lot_sum + @li_lot_insert
			If @li_lot_sum > @li_lot_tot
			Begin
				While @li_lot_sum > @li_lot_tot
				Begin
					Select	@li_lot_sum	= @li_lot_sum - 1,
						@li_lot_insert	= @li_lot_insert - 1
				End
			End
		End

		If @ps_option = 'F'
			Select	@li_planqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End,
				@li_changeqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End
		Else
		Begin
		-- 재계산시 생산계획이 추가된 경우 고려
			If Exists( 
				Select	PlanQty
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
				)
			-- 기존의 생산계획이 변경된 경우 일일평균화 생산계획에서 Select
				Select	@li_planqty	= PlanQty,
					@li_changeqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
			Else
			-- 생산계획이 추가된 경우 기준계획은 0 으로 Insert
				Select	@li_planqty	= 0,
					@li_changeqty	= Case When @ls_workgubun = 'W' Then @li_lot_insert * @li_rackqty Else 0 End
		End
	End
	Else
	Begin
		If @ps_option = 'F'
			Select	@li_planqty	= 0,
				@li_changeqty	= 0
		Else
		Begin
		-- 재계산시 생산계획이 추가된 경우 고려
			If Exists( 
				Select	PlanQty
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
				)
			-- 기존의 생산계획이 변경된 경우 일일평균화 생산계획에서 Select
				Select	@li_planqty	= PlanQty,
					@li_changeqty	= 0
				  From	tplanday
				 Where	PlanDate	= @ls_plandate		And
					AreaCode	= @ps_areacode		And
					DivisionCode	= @ps_divisioncode	And
					WorkCenter	= @ps_workcenter	And
					LineCode	= @ps_linecode		And
					ItemCode	= @ps_itemcode
			Else
			-- 생산계획이 추가된 경우 기준계획은 0 으로 Insert
				Select	@li_planqty	= 0,
					@li_changeqty	= 0
		End
	End

	-- 일일 평균화 생산계획 Update
	Execute sp_pisp002u_01_u_03
		@ls_plandate,
		@ps_areacode,
		@ps_divisioncode,
		@ps_workcenter,
		@ps_linecode,
		@ps_itemcode,
		@li_planqty,
		@li_changeqty,
		@ps_empcode,
		@ls_error		output,		-- 에러
		@ls_errortext		output		-- 에러 내역

	If @ls_error = '00'
	Begin
		Select	@ls_error	= '00'
	End
	Else
	Begin
		GoTo Proc_Exit
	End

	Proc_No_Item:	-- 마스터나 기타 데이터가 없어서 계산을 못 할 경우 일로 오자..헤헤

	Select	@ls_plandate	= Convert(Char(10), DateAdd(Day, 1, Convert(DateTime, @ls_plandate)),102)

	If @ls_workgubun = 'W' And @li_lot_sum <> @li_lot_tot
	Begin
		Select	@ln_minus_loop	= @ln_minus_loop + @ln_minus_lot,
			@li_lot_insert	= @li_lot_day
	End
End							-- While Loop End

/*
-- 월간 운영 계획(@pi_changeqty)이 Rack 수용수의 배수가 아닐경우 
-- TMONTHPLAN의 ChangeQty를 Shcduling한 일별운영계획의 Sum으로 Update한다.
Select	@li_devide	= @pi_changeqty / @li_rackqty

If @li_devide * @li_rackqty <> @pi_changeqty
Begin
	Update	TMONTHLYPLAN
	   Set	ChangeQty	= (
				Select	Sum(ChangeQty)
				  From	TDAILYPLAN30
				 Where	PlanMonth	= @ls_planmonth
				   And	DivisionCode	= @ps_divisioncode
				   And	ItemCode	= @ps_itemcode
				  ),
		LastEmp		= @ps_empcode,
		LastDate	= GetDate()
	 Where	PlanMonth	= @ls_planmonth
	   And	DivisionCode	= @ps_divisioncode
	   And	ItemCode	= @ps_itemcode

	Select	@ri_error	= @@Error

	If @ri_error <> 0 Return @ri_error
End
*/

Proc_Exit:

Select	@ps_error	= @ls_error,
	@ps_errortext	= @ls_errortext

Return
End