/*
	File Name	: sp_pisp004u_02_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp004u_02_u
	Description	: 당일 평준화계획을 계산하는 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 18
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp004u_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp004u_02_u]
GO

/*
Execute sp_pisp004u_02_u
	@ps_plandate		= '2002.12.24',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '421J',
	@ps_linecode		= 'A',
	@ps_maxcyclegubun	= 'N',
	@pi_cyclecount		= 2,
	@ps_empcode		= 'IPIS'


select * from tmstline where workcenter = '732P'

select * from tplanday where plandate = '2002.10.23'

select * from tplanrelease order by cycleorder, releaseorder

dbcc opentran

1	511517	25
2	511513	16
3	511514	1
4	511517	25
5	511513	15

D	A	4201	A	511513	0	1400	28	1400	2002.09.24
D	A	4201	A	511514	0	750	15	750	2002.09.24
D	A	4201	A	511517	0	2850	57	2850	2002.09.24
D	A	4201	B	511513	0	2100	42	2100	2002.09.24
D	A	4201	B	511514	0	700	14	700	

*/

Create Procedure sp_pisp004u_02_u
	@ps_plandate		char(10),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1),
	@ps_maxcyclegubun	char(1),
	@pi_cyclecount		int,
	@ps_empcode		varchar(6)
As
Begin

--Select	Error		= '00',
--	ErrorText	= ''

Declare	@ls_workgubun		char(1),
	@ls_itemcode		varchar(12),
	@li_max_cycle		Int,
	@i			Int,
	@j			Int,
	@k			Int,
	@li_plan_kbcount		Int,
	@li_loop_count		Int,
	@li_plan_order		Int,
	@li_original_plan		Int,
	@li_plan_sum		Int,
	@li_minus_plan		Int,
	@li_total_kbcount		Int,
	@li_cum_kbcount		Int,
	@li_space		Int,

	@li_tempkbqty		int,
	@li_cycleorder		int,
	@li_releaseorder		int,
	@ls_error		char(2),
	@ls_errortext		varchar(100)

-- 생산계획수를 간판 매수로 환산한 계획을 생성한다.
Select	@ls_workgubun	= A.WorkGubun
From	tcalendarwork	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ApplyDate	= @ps_plandate
Group By A.WorkGubun

If @ls_workgubun = 'W'
Begin
	Select	Error		= '00',
		ErrorText	= '작업하는 일자입니다.'
	
End
Else
Begin
	Select	Error		= '00',
		ErrorText	= '선택하신 일자는 휴무 입니다.'
	Return
End


-- 제품의 일일 생산계획 간판매수 테이블
Create Table #Tmp_Plan_KBCount
(	PlanOrder	Int IDENTITY(1,1)		Not Null,
	ItemCode	VarChar(12)		Not Null,
	PlanKBCount	Int			Not Null,
	NormalKBCount	Int			Not Null,
	NormalKBQty	Int			Not Null,
	TempKBCount	Int			Not Null,
	TempKBQty	Int			Not Null,
	Constraint PK_TMP_PLAN_KBCOUNT Primary Key
	(
		PlanOrder
	)
)

-- 제품의 평준화 순서 테이블
Create Table #Tmp_Plan
(	PlanOrder	Int IDENTITY(1,1)		Not Null,
	ItemCode	VarChar(12)		Not Null,
	PlanKBCount	Int			Not Null,
	Constraint PK_TMP_PLAN Primary Key
	(
		PlanOrder
	)
)

-- 제품의 평준화 순서를 계산하기 위한 임시 테이블
Create Table #Tmp_Leveling_Plan
(	PlanOrder	Int 		Not Null,
	ItemCode	VarChar(12)	Not Null,
	PlanKBCount	Int		Not Null
	Constraint PK_TMP_LEVELING_PLAN Primary Key
	(
		PlanOrder
	)
)

-- 생산계획수를 간판 매수로 환산한 계획을 생성한다.
Insert	Into #Tmp_Plan_KBCount (ItemCode, PlanKBCount, NormalKBCount, NormalKBQty, TempKBCount, TempKBQty)
Select	ItemCode	= A.ItemCode,
	PlanKBCount	= A.PlanKBCount,
	NormalKBCount	= A.NormalKBCount,
	NormalKBQty	= A.NormalKBQty,
	TempKBCount	= A.TempKBCount,
	TempKBQty	= A.TempKBQty
From	(Select	ItemCode	= A.ItemCode,
	--	PlanKBCount	= A.PlanKBCount,
	--	NormalKBCount	= A.NormalKBCount,
	--	NormalKBQty	= A.NormalKBQty / (Case When A.NormalKBCount < 1 Then 1 Else A.NormalKBCount End),
		PlanKBCount	= Round(A.ChangeQty / B.RackQty, 0) + A.TempKBCount,
		NormalKBCount	= Round(A.ChangeQty / B.RackQty, 0),
		NormalKBQty	= B.RackQty,
		TempKBCount	= Case When A.ChangeQty%B.RackQty = 0 Then 0 Else 1 End ,
		TempKBQty	= A.ChangeQty - (Round(A.ChangeQty / B.RackQty, 0) * B.RackQty)
	From	(Select	AreaCode	= A.AreaCode,
			DivisionCode	= A.DivisionCode,
			WorkCenter	= A.WorkCenter,
			LineCode	= A.LineCode,
			ItemCode	= A.ItemCode,
			ChangeQty	= A.ChangeQty,
			NormalKBCount	= A.NormalKBCount,
			NormalKBQty	= A.NormalKBQty,
			TempKBCount	= A.TempKBCount,
			TempKBQty	= A.TempKBQty
		From	tplanday		A
		Where	A.PlanDate	= @ps_plandate		And
			A.AreaCode	= @ps_areacode		And
			A.DivisionCode	= @ps_divisioncode	And
			A.WorkCenter	= @ps_workcenter	And
			A.LineCode	= @ps_linecode		And
			A.ChangeQty	> 0
		Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode, 
			A.ChangeQty, A.NormalKBCount, A.NormalKBQty, A.TempKBCount, A.TempKBQty)	A,
		tmstkb	B
	Where	A.ChangeQty	> 0			And
		A.AreaCode	= B.AreaCode		And
		A.DivisionCode	= B.DivisionCode		And
		A.WorkCenter	= B.WorkCenter		And
		A.LineCode	= B.LineCode		And
		A.ItemCode	= B.ItemCode)	A
Order By A.PlanKBCount Desc

Insert	#Tmp_Plan	(ItemCode,	PlanKBCount)
Select	A.ItemCode,
	A.PlanKBCount
From	#tmp_plan_kbcount	A
Order By A.PlanOrder

-- Loop 횟수(Item 숫자) 및 최대 Cycle 적용 기준을 구한다.
Select	@li_loop_count	= @@RowCount,
	@li_max_cycle 	= Max(PlanKBCount)
  From	#Tmp_Plan

If @li_loop_count < 1
Begin
	Select	Error		= '00',
		ErrorText	= '평준화 순서 계획을 수립할 일일생산계획이 존재하지 않습니다.'

	Drop Table #Tmp_Plan_KBCount
	Drop Table #Tmp_Plan
	Drop Table #Tmp_Leveling_Plan

	Return
End

-- select Sum(PlanKBCount) From #Tmp_Plan
-- select * From #Tmp_Plan

If @pi_cyclecount > @li_max_cycle Or @pi_cyclecount = 0		
Begin								-- 최다 Cycle 적용 시작
	-- 등간격 계산을 위한 임시 Table
	Create Table #Tmp_Leveling_Temp
	(	RowNum		Int IDENTITY(1,1)	Not Null,
		PlanOrder	Int 			Not Null,
		ItemCode	VarChar(12)		Not Null,
		PlanKBCount	Int			Not Null
		Constraint PK_TMP_LEVELING_TEMP Primary Key
		(
			RowNum
		)
	)

	-- 평준화 생산계획을 채울 임시 공간의 갯수를 구한다.
	Select	@i			= 0,
		@li_total_kbcount	= Sum(PlanKBCount)
	  From	#Tmp_Plan
	
	While @i < @li_total_kbcount			-- 순서를 정렬할수 있는 빈 공간을 채운다. 
	Begin						-- 모델은 임의의 모델(A)로 Setting
		Select	@i = @i + 1
		Insert Into #Tmp_Leveling_Plan
		Values(@i, 'A', 1)
	End
--select * from #Tmp_Leveling_Plan

	-- 등간격 계산을 위한 임시 태이블에 등간격 배치를 위한 임의의 모델을 설정한다.
	-- 최초에는 생산 수량과 A의 숫자가 같고, Looping을 돌면서 A의 숫자가 줄어든다.
	Insert	Into #Tmp_Leveling_Temp(PlanOrder, ItemCode, PlanKBCount)
	Select	PlanOrder, ItemCode, PlanKBCount
	  From	#Tmp_Leveling_Plan
	 Where	ItemCode	= 'A'

	Select	@i 		= 1,		-- Item Loop를 위한 변수
		@k		= 0,		-- 하나의 아이템이 한번의 Loop로 빈캄을 채우지 못할경우(Celing 처리 떄문)를 위한 Cumulative 변수
		@li_cum_kbcount	= 0
	While @i <= @li_loop_count			-- 순서대로 Loop 돌면서 Item 등간격 배치(@i가 #Tmp_Plan의 Order가 된다(Indentity 이기 때문에)
	Begin						-- Item(Order) Loop 시작
		-- Select	Convert(Char(5), @i) + Convert(Char(5), @li_total_kbcount)
		-- If @i = 2 Select * From #Tmp_Leveling_Plan

		Select	@i			= @i + 1,
			@j			= 1,
			@ls_itemcode		= ItemCode,
			@li_space		= Ceiling(@li_total_kbcount * 1.0 / (PlanKBCount - @li_cum_kbcount)),		-- 등간격 계산
			@li_plan_kbcount		= PlanKBCount									-- 등간격 배치 완료 Check용
		  From	#Tmp_Plan
		 Where	PlanOrder		= @i
--select @li_total_kbcount, @li_cum_kbcount, @li_space
		While @j <= @li_total_kbcount	-- Item 배치 Loop
		Begin				-- Item 배치 Loop 시작
			-- 임의의 모델('A')로 설정된 임시 테이블의 Item을 Update 한다.
			Update	#Tmp_Leveling_Temp
			   Set	ItemCode	= @ls_itemcode
			 Where	RowNum		= @j

			Select	@j = @j + @li_space,		-- 등간격 증가
				@k = @k + 1			-- 배치된 Item 수
		End				-- Item 배치 Loop 종료

		-- 등간격 배치가 끝난 모델을 일괄적으로 Result Set (#Tmp_Leveling_Plan)으로 이동(Update 이용)
		Update	#Tmp_Leveling_Plan
		   Set	ItemCode	= B.ItemCode
		  From	#Tmp_Leveling_Plan A,
			#Tmp_Leveling_Temp B
		 Where	A.PlanOrder	= B.PlanOrder
--select * from #Tmp_Leveling_temp
--select * from #Tmp_Leveling_Plan
		-- 새로운 배치를 위하여 임시 Table 초기화
		Truncate Table #Tmp_Leveling_Temp

		-- 배치가 안된 모델('A') 재 설정
		Insert	Into #Tmp_Leveling_Temp(PlanOrder, ItemCode, PlanKBCount)
		Select	PlanOrder, ItemCode, PlanKBCount
		  From	#Tmp_Leveling_Plan
		 Where	ItemCode	= 'A'

		Select	@li_total_kbcount = @@RowCount

		-- 배치된 Item 수와 해당 Item의 계획수를 비교하여 동일한 경우는 다음 Item의 배치를 시작하고,
		-- 작을 경우 남은 Item 수만큼 등간격 배치를 다시 수행한다.
		-- 이때 최초 다음 Item의 순서를 위해 Setting 한 @i 값을 현재 Item으로 바꾼다.
		Select	@li_cum_kbcount	= @li_cum_kbcount + @k
		If @li_cum_kbcount < @li_plan_kbcount
			Select @i = @i - 1
		Else
			-- Item의 배치가 완전히 끝날을 경우, Cumulative 수량과 Cumulative 변수값을 초기화 한다.
			Select @li_cum_kbcount = 0, @k = 0
	End						-- Item(Order) Loop 종료

	Drop Table #Tmp_Leveling_Temp

	-- Final Resut Set을 설정하기 위하여 임시 Table을 초기화 한다.
	-- 현재까지의 계산은 간판 한장 단위로 최다 Cycle 계산을 했기 때문에, 간판 단위를 Item별 수량(순서를 감안한)으로 재계산 한다.
	Truncate Table #Tmp_Plan

	Select	@i		= 1,
		@j		= 0,
		@li_loop_count	= Max(PlanOrder)
	  From	#Tmp_Leveling_Plan

	While @i <= @li_loop_count
	Begin
		Select	@i		= @i + 1,
			@ls_itemcode	= ItemCode
		  From	#Tmp_Leveling_Plan
		 Where	PlanOrder	= @i

		If Exists (	Select * From #Tmp_Plan
				 Where	PlanOrder	= @j
				   And	ItemCode	= @ls_itemcode)
		Begin
			Update	#Tmp_Plan
			   Set	PlanKBCount	= PlanKBCount + 1
			 Where	PlanOrder	= @j
			   And	ItemCode	= @ls_itemcode
		End
		Else
		Begin
			Insert Into	#Tmp_Plan	(ItemCode,	PlanKBCount)
			Values				(@ls_itemcode,	1)

			Select @j = @j + 1
		End
	End
End								-- 최다 Cycle 적용 종료
Else
Begin								-- Line별 설정 Cycle 적용 시작
	Select	PlanOrder,
		ItemCode,
		PlanKBCount	= Ceiling(PlanKBCount * 1.0 / @pi_cyclecount)
	  Into	#Tmp_Cycle_Plan
	  From	#Tmp_Plan

	Select	@i		= 0,
		@k		= 0,
		@li_loop_count	= @@RowCount

	While @i < @pi_cyclecount				-- Cycle Loop Start (N Cycle일 경우 N번 Loop)
	Begin
		Select	@i	= @i + 1,
			@j	= 0
		While @j < @li_loop_count
		Begin				-- 계획 Model Assign Loop Start
			Select	Top 1
				@j		= @j + 1,
				@k		= @k + 1,
				@ls_itemcode	= ItemCode,
				@li_plan_kbcount	= PlanKBCount
			  From	#Tmp_Cycle_Plan
			 Where	PlanOrder	> @j

			Insert Into #Tmp_Leveling_Plan
			Values(@k, @ls_itemcode, @li_plan_kbcount)
		End				-- 계획 Model Assign Loop End
	End						-- Cycle Loop End

	Drop Table #Tmp_Cycle_Plan

	-- Ceiling 처리된 평준화 생산 계획을 정리한다.
	Select	ItemCode	= A.ItemCode, 
		OriginalPlan	= A.PlanKBCount,
		MinusPlan	= Sum(B.PlanKBCount) - A.PlanKBCount,
		PlanOrder	= Max(B.PlanOrder) + 1
	  Into	#Tmp_Minus
	  From	#Tmp_Plan A,
		#Tmp_Leveling_Plan B
	 Where	A.ItemCode	= B.ItemCode
	Group By A.ItemCode, A.PlanKBCount
	Having	Sum(B.PlanKBCount) - A.PlanKBCount > 0
	Order By A.ItemCode

	Select	@i			= 0,
		@li_loop_count		= @@RowCount,
		@ls_itemcode		= ''

	While @i < @li_loop_count
	Begin					-- Total 계획과 평준화 계획 Sum 이 다른 Item 보정 Item Loop 시작
		Select	Top 1
			@i			= @i + 1,
			@ls_itemcode		= ItemCode,
			@li_plan_order		= PlanOrder,
			@li_original_plan	= OriginalPlan,
			@li_plan_sum		= OriginalPlan + 1,
			@li_minus_plan		= MinusPlan
		  From	#Tmp_Minus
		 Where	ItemCode		> @ls_itemcode

		While @li_original_plan < @li_plan_sum
		Begin
			Select	Top 1
				@li_plan_order		= PlanOrder
			  From	#Tmp_Leveling_Plan
			 Where	ItemCode	= @ls_itemcode
			   And	PlanOrder	< @li_plan_order
			Order By PlanOrder Desc

			Update	#Tmp_Leveling_Plan
			   Set	PlanKBCount	= Case When PlanKBCount - @li_minus_plan < 0 Then 0 Else PlanKBCount - @li_minus_plan End
			 Where	PlanOrder	= @li_plan_order
			   And	ItemCode	= @ls_itemcode

			Select	@li_plan_sum	= Sum(PlanKBCount)
			  From	#Tmp_Leveling_Plan
			 Where	ItemCode	= @ls_itemcode
		End
	End					-- Total 계획과 평준화 계획 Sum 이 다른 Item 보정 Item Loop 시작

	Drop Table #Tmp_Minus

	Truncate Table #Tmp_Plan

	Delete #Tmp_Leveling_Plan
	 Where PlanKBCount	<= 0

	Insert	#Tmp_Plan	(ItemCode,	PlanKBCount)
	Select	A.ItemCode,
		A.PlanKBCount
	From	#Tmp_Leveling_Plan	A
	Order By PlanOrder
End								-- Line별 설정 Cycle 적용 종료

-- 평준화 순서계획은 다 계산했다..
-- 여기부터는 제품별 순서를 다시 간판순서로 쪼개자..
Select	@i		= 0,
	@li_loop_count	= 0,
	@li_plan_kbcount	= 0,
	@li_plan_order	= 0

Select	@li_loop_count	= Count(ItemCode)
From	#tmp_plan

--Begin Tran

-- 일단 해당 일자의 평준화 순서계획을 초기화 하자..헤헤
Delete	tplanrelease
Where	PlanDate		= @ps_plandate		And
	AreaCode		= @ps_areacode		And
	DivisionCode		= @ps_divisioncode	And
	WorkCenter		= @ps_workcenter	And
	LineCode		= @ps_linecode

While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@j			= 1,
		@li_plan_order		= PlanOrder,
		@ls_itemcode		= ItemCode,
		@li_plan_kbcount		= PlanKBCount + 1
	  From	#tmp_plan
	 Where	PlanOrder	> @li_plan_order

	-- 간판 매수 만큼 Looping 을 돌면서 간판 순서를 만들자
	While @j < @li_plan_kbcount
	Begin
		Insert	tplanrelease
		Select	PlanDate		= @ps_plandate,
			AreaCode		= @ps_areacode,
			DivisionCode		= @ps_divisioncode,
			WorkCenter		= @ps_workcenter,
			LineCode		= @ps_linecode,
			CycleOrder		= @li_plan_order,
			ReleaseOrder		= @j,
			ItemCode		= @ls_itemcode,
			KBNo			= 'A',
			KBReleaseDate		= 'A',
			KBReleaseSeq		= 0,
			TempGubun		= 'N',
			ReleaseGubun		= 'C',
			PrdFlag			= 'C',
			PlanKBCount		= 1,
			PlanKBQty		= A.NormalKBQty,
			ReleaseKBCount		= 0,
			ReleaseKBQty		= 0,
			LastEmp			= 'Y', --@ps_empcode,
			LastDate			= GetDate()
		From	#tmp_plan_kbcount	A
		Where	ItemCode	= @ls_itemcode

		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '평준화 순서 계획을 저장하였습니다.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '평준화 순서 계획을 저장하는 중에 오류가 발생하였습니다.'
			GoTo Proc_Exit
		End

		Select	@j	= @j + 1

	End
End

-- 여기 부터는 임시간판을 처리하자.
-- 임시간판은 맨 마지막 생산으로 처리한다.
Delete	#tmp_plan_kbcount
Where	TempKBCount	< 1

Select	@i		= 0,
	@li_loop_count	= Count(ItemCode),
	@li_plan_order	= 0
From	#tmp_plan_kbcount

While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@li_plan_order		= PlanOrder,
		@ls_itemcode		= ItemCode,
		@li_tempkbqty		= TempKBQty
	  From	#tmp_plan_kbcount
	 Where	PlanOrder	> @li_plan_order

	Select	@li_cycleorder	= Max(CycleOrder)
	From	tplanrelease
	Where	PlanDate		= @ps_plandate		And
		AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		ItemCode		= @ls_itemcode

	Select	@li_releaseorder	= Max(ReleaseOrder)
	From	tplanrelease
	Where	PlanDate		= @ps_plandate		And
		AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
--		ItemCode		= @ls_itemcode		And
		CycleOrder		= @li_cycleorder

--select @li_cycleorder, @li_releaseorder

	Update	tplanrelease
	Set	TempGubun		= 'T',
		PlanKBCount		= 1,
		PlanKBQty		= @li_tempkbqty,
		LastEmp			= 'Y', --@ps_empcode,
		LastDate			= GetDate()
	From	tplanrelease
	Where	PlanDate		= @ps_plandate		And
		AreaCode		= @ps_areacode		And
		DivisionCode		= @ps_divisioncode	And
		WorkCenter		= @ps_workcenter	And
		LineCode		= @ps_linecode		And
		CycleOrder		= @li_cycleorder		And
		ReleaseOrder		= @li_releaseorder		

	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '평준화 순서 계획을 저장하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '임시간판의 평준화 순서 계획을 저장하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End

Proc_Exit:

/*
If @ls_error = '00'
	Commit Tran
Else
Begin
	RollBack Tran
End
*/

--select * from #tmp_plan
--select * from #tmp_plan_kbcount

Drop Table #Tmp_Leveling_Plan
Drop Table #Tmp_Plan_KBCount
Drop Table #Tmp_Plan

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
