/*
	File Name	: sp_pisp002u_01_u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp002u_01_u_01
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
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u_01]
GO

/*
Declare	@ls_error		varchar(2),	-- Transaction 수행 에러 값
	@ls_errortext		varchar(30)	-- Transaction 수행 에러 내역

Execute sp_pisp002u_01_u_01
	@ps_option		= 'F',
	@ps_planmonth		= '2002.09',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%',
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


Create Procedure sp_pisp002u_01_u_01
	@ps_option		char(1),		-- Scheduling Option('F' : First, 'S' : After First)
	@ps_planmonth		char(7),		-- 계획월 ('YYYY.MM')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_productgroup	varchar(2),	-- 제품군
	@ps_modelgroup		varchar(3),	-- 모델군
	@ps_itemcode		varchar(12),	-- 품번
	@ps_empcode		varchar(6),	-- 최종수정작업자
	@ps_error		varchar(2)	output,		-- 에러
	@ps_errortext		varchar(100)	output		-- 에러 내역

As
Begin

Declare	@ls_plandate		char(10),	-- 계획을 계산하려는 시작일자
	@ls_areacode		char(1),
	@ls_divisioncode		char(1),
	@ls_workcenter		varchar(5),	-- Work Center
	@ls_linecode		char(1),		-- 라인 코드
	@ls_itemcode		varchar(12),	-- 모델 코드
	@ls_last_workday		char(10),
	@ls_tomorrow		char(10),	-- 익일
	@ls_lastday		char(10),	-- Plan Month 의 마지막 일자
	@li_work_count		Int,
	@li_planqty		Int,		-- 기준계획수량
	@li_changeqty		Int,		-- 운영계획수량
	@i			Int,
	@j			Int,
	@k			Int,
	@li_count		Int,
	@li_wc_count		Int,
	@li_line_count		Int,
	@li_item_count		Int,
	@li_divide_rate		smallint,
	@li_rackqty		int,
	@li_generate_plan	Int,
	@li_generate_change	Int,
	@ls_error		varchar(2),	-- Transaction 수행 에러 값
	@ls_errortext		varchar(100)	-- Transaction 수행 에러 내역

-- SQL 6.5 에서는 확인이 아직 안된 사항임
-- 하나의 Stored Procedure문에서 3개 이상 Create Table/Declare Cursor 문을 사용할수 없다.
-- Select Into 문을 사용하여 Table을 만드는것은 상관이 없슴.
-- Compile시에는 Error가 발생하지 않으나 RunTime시 Error 발생
-- 그래서 WorkCenter와 LineCode는 Create Table문장을 이용해 Table을 만들고,
-- ModelCode는 @ls_table_exist로서 Checking후 Select Into 문장을 이용한다.

-- 7.0 에서는 상관없슴.

Create Table #tmp_rate
(
	AreaCode	char(1),
	DivisionCode	char(1),
	WorkCenter	varchar(5),
	LineCode	char(1),
	DivideRate	smallInt
)

Create Table #tmp_workcenter
(
	WorkCenter	varchar(5)
)

Create Table #tmp_line
(
	LineCode	Char(1)
)


-- Scheduling을 수행할 품번 및 월간 Total 기준계획, 운영계획을 구한다.
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	ItemCode	= A.ItemCode,
	PlanQty		= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty	= Sum(IsNull(B.ChangeQty, 0))
Into	#tmp_item_plan
From	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode
	From	tmstkb		A,
		tmstmodel	B
	Where	B.AreaCode	= @ps_areacode		And
		B.DivisionCode	Like @ps_divisioncode	And
		B.ProductGroup	Like @ps_productgroup	And
		B.ModelGroup	Like @ps_modelgroup	And
		B.ItemCode	Like @ps_itemcode	And
		B.AreaCode	= A.AreaCode		And
		B.DivisionCode	= A.DivisionCode		And
		B.ItemCode	= A.ItemCode		And
		A.PrdStopGubun	= 'N'
	Group By A.AreaCode, A.DivisionCode, A.ItemCode)	A,
	tplanmonth	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.ItemCode	= B.ItemCode		And
	B.PlanMonth	= @ps_planmonth		And
	B.ChangeQty	> 0
Group by A.AreaCode, A.DivisionCode, A.ItemCode
Order by A.AreaCode, A.DivisionCode, A.ItemCode

Select	@i = 0, @li_item_count = @@RowCount, @ls_itemcode = ''

--select * from #tmp_item_plan

If @li_item_count < 1
Begin
	Select	Error		= '00',
		ErrorText	= '일일생산계획을 계산할 월간생산게획이 존재하지 않습니다.'
	Return
End

-- select * from #tmp_item_plan

-- 선택된 Item의 수만큼 Loop
While @i < @li_item_count
Begin
	Select	Top 1
		@i		= @i + 1,
		@ls_areacode	= AreaCode,
		@ls_divisioncode	= DivisionCode,
		@ls_itemcode	= ItemCode,
		@li_planqty	= PlanQty,
		@li_changeqty	= ChangeQty	
	  From	#tmp_item_plan
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		ItemCode	> @ls_itemcode

	-- 생산계획을 분배할 Line 및 분배율을 구한다.
	Insert	#tmp_rate
	Select	AreaCode,
		DivisionCode,
		WorkCenter,
		LineCode,
		DivideRate
	  From	tmstkb
	 Where	AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		ItemCode	= @ls_itemcode
	Order By AreaCode, DivisionCode, WorkCenter, LineCode, DivideRate

--select '#tmp_rate'
--select * from #tmp_rate

--	계획분배율이 없다는 것..
--	즉, 간판 마스터에 등록되어 있지 않은 간판이다..
--	이미 위에서 한번 걸렀지만, 다시 한번 걸르자..
	If @@RowCount = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '간판 마스터에 해당 제품 정보가 존재하지 않습니다.'
		GoTo Proc_No_Item
	End

--	WorkCenter을 구하자.
	Insert	#tmp_workcenter
	Select	WorkCenter
	From	#tmp_rate
	Group By WorkCenter
	Order By WorkCenter

	Select	@j = 0, @li_wc_count = @@RowCount, @ls_workcenter	= ''

--	해당 Item 의 구해진 WorkCenter 만큼 Loop
	While @j < @li_wc_count
	Begin
		Select	Top 1
			@j		= @j + 1,
			@ls_workcenter	= WorkCenter
		  From	#tmp_workcenter
		 Where	WorkCenter	> @ls_workcenter

		-- Loop를 수행할 Line을 선택한다.
		Insert	#tmp_line
		Select	LineCode
		From	#tmp_rate
		Where	WorkCenter	= @ls_workcenter
		Group By LineCode
		Order By LineCode

		Select	@k = 0, @li_line_count = @@RowCount, @ls_linecode = ''

--	해당 WorkCenter의 구해진 Line 만큼 Loop
		While @k < @li_line_count
		Begin
			Select	Top 1
				@li_count	= 0,
				@k		= @k + 1,
				@ls_linecode	= LineCode
			  From	#tmp_line
			 Where	LineCode	> @ls_linecode

			-- 계획을 계산하려는 시작일을 구하자.
			If @ps_option = 'F'
			Begin
				Select	@ls_plandate	= @ps_planmonth + '.01'
			End
			Else
			Begin
				Select	@ls_tomorrow	= Convert(char(10), DateAdd(Day, 1, GetDate()), 102),
					@ls_lastday	= Convert(Char(10), DateAdd(Day, -1, Convert(DateTime, Convert(Char(7), 
									  DateAdd(Month, 1, Convert(DateTime, @ps_planmonth + '.01')), 102) + '.01')), 102)
				-- 일단 조립지시가 된 일자까지는 일일생산계획을 건딜면....안되지..
				-- 근데, 라인별로 관리해야 한다.
				-- 왜냐하면, 평준화순서계획이 라인단위로 수립되므로
				-- 라인에 해당하는 제품의 일일생산계획을 바꿔도 그 라인에 제품 하나라도 조립 지시가 되면
				-- 평준화 순서계획은 바꿀수 없다.
				Select	@ls_plandate	= Max(PlanDate),
					@li_count	= Count(PlanDate)
				From	tplanrelease
				Where	PlanDate	Like @ps_planmonth + '.__'	And
					AreaCode	= @ls_areacode			And
					DivisionCode	= @ls_divisioncode		And
					WorkCenter	= @ls_workcenter			And
					LineCode	= @ls_linecode			And
--					ItemCode	= @ls_itemcode			And
					ReleaseGubun	In ('Y', 'T', 'N')

				Select	@ls_plandate = Convert(Char(10), DateAdd(Day, 1, Convert(DateTime, @ls_plandate)), 102)

				If @li_count > 0
				Begin
					If @ls_plandate > @ls_lastday
					Begin
						Select	@ls_error	= '00',
							@ls_errortext	= '월말까지 조립지시가 수행되어 있습니다.'
						GoTo Proc_No_Line
					End
					Else
					Begin
						If @ls_plandate	> @ls_tomorrow
						Begin
							Select	@ls_plandate	= @ls_plandate
						End
						Else
						Begin
							If @ls_tomorrow > @ls_lastday
							Begin
								Select	@ls_error	= '00',
									@ls_errortext	= '월말은 해당월의 일일생산계획 수정이 불가능합니다.'
								GoTo Proc_No_Line
							End
							Else
							Begin
								Select	@ls_plandate	= @ls_tomorrow
							End
						End
					End
				End
				Else
				Begin
					If @ps_planmonth + '.01' > @ls_tomorrow
					Begin
						Select	@ls_plandate	= @ps_planmonth + '.01'
					End
					Else
					Begin
						Select	@ls_plandate	= @ls_tomorrow
					End
				End
			End

			Select	@li_work_count	= 0
			-- Work Calendar 에서 근무일수 등을 구하자.
			Select	@li_work_count		= Count(ApplyDate),
				@ls_last_workday		= Max(ApplyDate)
			  From	tcalendarwork
			 Where	AreaCode		= @ls_areacode		And
				DivisionCode		= @ls_divisioncode	And
				WorkCenter		= @ls_workcenter		And
				LineCode		= @ls_linecode		And
				ApplyMonth		= @ps_planmonth		And
				ApplyDate		>= @ls_plandate		And
				WorkGubun		= 'W'
			If @li_work_count = 0-- Work Calendar가 없으면 Shop Calendar 을 이용하자.
			Begin				
				Select	@li_work_count		= Count(ApplyDate),
					@ls_last_workday		= Max(ApplyDate)
				  From	tcalendarshop
				 Where	AreaCode		= @ls_areacode		And
					DivisionCode		= @ls_divisioncode	And
					ApplyMonth		= @ps_planmonth		And
					ApplyDate		>= @ls_plandate		And
					WorkGubun		= 'W'
				If @li_work_count = 0 -- 어라.. Shop Calendar 도 없네..누굴 조지지...그냥 나가야지..헤헤
				Begin
					Select	@ls_error	= '00',
						@ls_errortext	= 'Shop Calendar의 근무일이 없습니다.'
					GoTo Proc_No_Line
				End
			End

			If @li_work_count < 1 -- 어라.. 근무일수가 없네...놀아야지..
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= 'Work Calendar의 근무일이 없습니다.'
				GoTo Proc_No_Line
			End

			Select	@li_divide_rate	= IsNull(DivideRate, 0)
			  From	#tmp_rate
			 Where	AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				WorkCenter	= @ls_workcenter		And
				LineCode	= @ls_linecode

			If @li_divide_rate = 0 Or @li_divide_rate Is Null
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '계획분배율이 존재하지 않습니다.'
				GoTo Proc_No_Line
			End

			Select	@li_rackqty	= IsNull(RackQty, 0)
			  From	tmstkb
			 Where	AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				WorkCenter	= @ls_workcenter		And
				LineCode	= @ls_linecode		And
				ItemCode	= @ls_itemcode		

			If @li_rackqty = 0 Or @li_rackqty Is Null
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '수용수가 존재하지 않습니다.'
				GoTo Proc_No_Line
			End

			Select	@li_generate_plan	= Ceiling((@li_planqty * @li_divide_rate * 1.0 / 100) / @li_rackqty) * @li_rackqty,
				@li_generate_change	= Ceiling((@li_changeqty * @li_divide_rate * 1.0 / 100) / @li_rackqty) * @li_rackqty

			-- 일일 평균화 생산계획 Compute
			Execute sp_pisp002u_01_u_02
				@ps_option,
				@ps_planmonth,				-- 기준월
				@ls_plandate,				-- 계획 시작 일자
				@ls_areacode,
				@ls_divisioncode,
				@ls_workcenter,
				@ls_linecode,
				@ls_itemcode,
				@li_generate_plan,			-- 월간 기준계획 수량
				@li_generate_change,			-- 월간 운영계획 수량
				@ls_last_workday,
				@li_work_count,				-- 계획 시작 일자 부터의 근무 일수
				@ps_empcode,
				@ls_error		output,		-- 에러
				@ls_errortext		output		-- 에러 내역

			-- Error 값에 따라 Transaction 종료	
			If @ls_error = '00'
			Begin
				Select	@ls_error	= '00'
			End
			Else
			Begin
				GoTo Proc_Exit
			End

			Proc_No_Line:	-- 마스터나 기타 데이터가 없어서 계산을 못 할 경우 일로 오자..헤헤
		End				-- Line Loop End
		-- Loop Table 초기화
		Truncate Table #tmp_line
	End					-- Work Center Loop End
	-- Loop Table 초기화
	Truncate Table #tmp_workcenter

	Proc_No_Item:	-- 마스터나 기타 데이터가 없어서 계산을 못 할 경우 일로 오자..헤헤

	-- Loop Table 초기화
	Truncate Table #tmp_rate
End	-- Item Loop End

Proc_Exit:

Drop Table #tmp_item_plan
Drop Table #tmp_rate
Drop Table #tmp_workcenter
Drop Table #tmp_line

Select	@ps_error	= @ls_error,
	@ps_errortext	= @ls_errortext

Return
End