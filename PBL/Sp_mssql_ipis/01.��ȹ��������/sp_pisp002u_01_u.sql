/*
	File Name	: sp_pisp002u_01_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp002u_01_u
	Description	: 일일 생산 계획 계산
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
	    Where id = object_id(N'[dbo].[sp_pisp002u_01_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_01_u]
GO

/*
Execute sp_pisp002u_01_u
	@ps_option		= 'S',
	@ps_planmonth		= '2002.11',
	@ps_areacode		= 'J',
	@ps_divisioncode	= 'M',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%',
	@ps_empcode		= 'KJS'

select * from tplanday
delete tplanday
select * from tplanmonth

2002.09.02 D    A    4201  A    511513       600         600         IPIS

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

Create Procedure sp_pisp002u_01_u
	@ps_option		char(1),		-- Scheduling Option('F' : First, 'S' : After First)
	@ps_planmonth		char(7),		-- 계획월 ('YYYY.MM')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_productgroup	varchar(2),	-- 제품군
	@ps_modelgroup		varchar(3),	-- 모델군
	@ps_itemcode		varchar(12),	-- 품번
	@ps_empcode		varchar(6)	-- 최종수정작업자

As
Begin

Declare	@ls_tomorrow		char(10),	-- 익일
	@ls_divisioncode		char(1),		-- 공장
	@i			Int,
	@li_loop_count		Int,
	@ls_error		varchar(2),	-- Transaction 수행 에러 값
	@ls_errortext		varchar(100)	-- Transaction 수행 에러 내역

Select	@ls_tomorrow	= Convert(char(10), DateAdd(Day, 1, GetDate()), 102)
				
 -- 이전달 계획을 재계산 할 필요 없다.
If Left(@ls_tomorrow, 7) > @ps_planmonth
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '이전 달의 일일생산계획은 계산하실 수 없습니다.'

	Select	Error		= @ls_error,
		ErrorText	= @ls_errortext

	Return
End

-- 여기 부터 일일생산계획을 구하는 로직 시작...
If @ps_option = 'F'
Begin
	Select	@ps_empcode		= 'IPIS'
End
Else
Begin
	Select	@ps_empcode		= @ps_empcode
End

Select	AreaCode,
	DivisionCode
Into	#tmp_division
From	tmstdivision
Where	AreaCode	= @ps_areacode		And
	DivisionCode	Like @ps_divisioncode
Order By AreaCode, DivisionCode

Select @i = 0, @li_loop_count = @@RowCount, @ls_divisioncode = ''

--select * from #tmp_division

-- Transaction 시작
--Begin Tran

While @i < @li_loop_count
Begin
	Select	Top 1
		@ls_error	= '11',
		@i		= @i + 1,
		@ls_divisioncode	= DivisionCode
	From	#tmp_division
	Where	AreaCode	= @ps_areacode		And
		DivisionCode	> @ls_divisioncode


	Execute sp_pisp002u_01_u_01
		@ps_option,				-- Scheduling Option('F' : First, 'S' : After First)
		@ps_planmonth,				-- 계획월 ('YYYY.MM')
		@ps_areacode,				-- 지역 코드
		@ls_divisioncode,			-- 공장 코드
		@ps_productgroup,			-- 제품군
		@ps_modelgroup,			-- 모델군
		@ps_itemcode,				-- 품번
		@ps_empcode,				-- 최종수정작업자
		@ls_error		output,		-- 에러
		@ls_errortext		output		-- 에러 내역

-- Error 값에 따라 Transaction 종료	
	If @ls_error = '00'
	Begin
		Select @ls_error	= '00'
	End
	Else
	Begin
		GoTo Proc_Exit
	End
End			-- While Loop End

Proc_Exit:

/*
If @ls_error = '00'
	Commit Tran
Else
Begin
	RollBack Tran
End
*/

Drop Table #tmp_division

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return
End