/*
	File Name	: sp_pisp090u_03_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp090u_03_u
	Description	: 간판을 조립지시 시키는 곳..헤헤 - 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp090u_03_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp090u_03_u]
GO

/*
Execute sp_pisp090u_03_u
	@ps_option		= 'INSERT',
	@ps_releasedate		= '2002.09.28',
	@pi_cycleorder		= 3,
	@ps_kbno		= 'DA010101001',
	@ps_empcode		= 'TEST'

dbcc opentran

select * from tplanrelease
where plandate = '2002.09.30'	and
	itemcode = '511513'

select * from tplanday
where plandate = '2002.09.28'	and
	itemcode = '511513'

2002.09.27	D	A	4201	A	511513	0	1650	35	1750
2002.09.27	D	A	4201	B	511513	0	1550	31	1550


delete tplanrelease
where plandate = '2002.09.30'	and
	tempgubun = 'T'
	itemcode = '511513'


select * from tkb

select * from tkbhis

update tkb
set	kbstatuscode = 'F'
where kbno = 'DA010101002'

update tkbhis
set	kbstatuscode = 'F'
where kbno = 'DA010101002' and
	LastLoopFlag	= 'Y'

*/

Create Procedure sp_pisp090u_03_u
	@ps_option		varchar(10),	-- 지시하는 조건..반드시 아래를 볼것..
	@ps_releasedate		char(10),	-- 지시일자
	@pi_cycleorder		int,		-- 지시하는 CycleOrder
	@ps_kbno		varchar(11),	-- 지시하는 간판 번호
	@ps_empcode		varchar(6)

As
Begin

Declare	@ls_areacode		char(1),
	@ls_divisioncode		char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(12),
	@ls_tempgubun		char(1),
	@li_rackqty		int,

	@li_cycleorder		int,
	@li_releaseorder		int,

	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시
	@ls_applydate_close	char(10),	-- 마감일을 고려한 기준일자
	@ls_releasegubun	char(1),		-- 간판 지시 구분

	@li_kbreleaseseq		int,		-- 최대 지시 순번

	@ls_inspectgubun	char(1),		-- 입고검사 여부

	@li_count		int,

	@ls_error		char(2),
	@ls_errortext		varchar(100)
/*
@ps_option	= 'UPDATE'	이경우 @pi_cycleorder 사용
	=> @pi_cycleorde 에서 조립지시가 않된 가장 큰 ReleaseOrder 에 간판을 덮어쓰면 된다.
@ps_option	= 'INSERT'	이경우 @pi_cycleorder 사용하면 죽음...헤헤
	=> 이게 골때린다..
	    당일 평준화계획이 없는데 조립지시를 추가하는 거다..
	    이 경우 해당 제품의 가장 큰 CycleOrder 을 찾아내서 여기에 간판을 새롭게 지시해야한다.
	    만약, 전일에 지시를 추가하는 경우에는 일일생산계획 및 당일 평준화계획을 증가시켜야 한다...ㅆㅂ
	    그런데, 당일에 지시를 추가하는 경우에는 계획은 건딜면 안된다...지랄
*/

-- 일단 간판 관련 변수를 정의하자
Select	@ls_areacode	= AreaCode,
	@ls_divisioncode	= DivisionCode,
	@ls_workcenter	= WorkCenter,
	@ls_linecode	= LineCode,
	@ls_itemcode	= ItemCode,
	@ls_tempgubun	= TempGubun,
	@li_rackqty	= RackQty
From	tkb
Where	KBNo	= @ps_kbno

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ls_areacode,
	@ps_divisioncode	= @ls_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output

-- 기준일에 따른 조립지시 구분을 구하자
If @ls_applydate_close = @ps_releasedate
	Select	@ls_releasegubun	= 'T'
Else
	Select	@ls_releasegubun	= 'Y'

-- 입고 검사품인지를 구하자.
-- 조립지시하는 날짜로 조회하자...왜냐 낼 부터 입고검사품으로 등록할 수 있으니까...헤헤
If Not exists (	Select	ItemCode
		From	tqcontainqcitem	A
		Where	A.AreaCode	= @ls_areacode		And
		A.DivisionCode	= @ls_divisioncode	And
		A.ItemCode	= @ls_itemcode		And
		A.ApplyDateFrom	<= @ps_releasedate	And
		A.ApplyDateTo	> @ps_releasedate)
Begin
	Select	@ls_inspectgubun	= 'N'
End
Else
Begin
	Select	@ls_inspectgubun	= 'Y'
End


-- 간판번호의 다음 지시 순번을 구하자.
Select	@li_kbreleaseseq		= Max(A.KBReleaseSeq)
From	tkbhis	A
Where	A.KBNo			= @ps_kbno		And
	A.KBReleaseDate		= @ps_releasedate	--And
--	A.LastLoopFlag		= 'Y'

If @li_kbreleaseseq = 0 Or @li_kbreleaseseq Is Null
	Select	@li_kbreleaseseq		= 1
Else
	Select	@li_kbreleaseseq		= @li_kbreleaseseq + 1

-- Option에 따라 조립지시 순번을 구하자
If @ps_option = 'UPDATE'
Begin
	If @ls_tempgubun = 'N'
	Begin
		Select	@li_cycleorder	= @pi_cycleorder
	
		Select	@li_releaseorder	= Min(ReleaseOrder)
		From	tplanrelease	A
		Where	A.PlanDate	= @ps_releasedate	And
			A.AreaCode	= @ls_areacode		And
			A.DivisionCode	= @ls_divisioncode	And
			A.WorkCenter	= @ls_workcenter	And
			A.LineCode	= @ls_linecode		And
			A.CycleOrder	= @li_cycleorder		And
			A.TempGubun	= 'N'			And
			A.ReleaseGubun	= 'C'			And	-- 미준수 간판은 그날 다시 지시 못함
			A.PrdFlag	= 'C'	--		And
	--		A.PlanKBQty	= @li_rackqty
	End
	Else
	Begin
		Select	@li_cycleorder	= @pi_cycleorder
	
		Select	@li_releaseorder	= Min(ReleaseOrder)
		From	tplanrelease	A
		Where	A.PlanDate	= @ps_releasedate	And
			A.AreaCode	= @ls_areacode		And
			A.DivisionCode	= @ls_divisioncode	And
			A.WorkCenter	= @ls_workcenter	And
			A.LineCode	= @ls_linecode		And
			A.CycleOrder	= @li_cycleorder		And
			A.TempGubun	= 'T'			And
			A.ReleaseGubun	= 'C'			And	-- 미준수 간판은 그날 다시 지시 못함
			A.PrdFlag	= 'C'			And
			A.PlanKBQty	= @li_rackqty
	End
End
Else
Begin

	Select	@li_cycleorder	= 0

	Select	@li_cycleorder	= Max(CycleOrder)
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_releasedate	And
		A.AreaCode	= @ls_areacode		And
		A.DivisionCode	= @ls_divisioncode	And
		A.WorkCenter	= @ls_workcenter	And
		A.LineCode	= @ls_linecode		And
		A.ItemCode	= @ls_itemcode

	If @li_cycleorder = 0 Or @li_cycleorder Is Null
	Begin
		Select	@li_cycleorder	= 0

		Select	@li_cycleorder	= Max(CycleOrder)
		From	tplanrelease	A
		Where	A.PlanDate	= @ps_releasedate	And
			A.AreaCode	= @ls_areacode		And
			A.DivisionCode	= @ls_divisioncode	And
			A.WorkCenter	= @ls_workcenter		And
			A.LineCode	= @ls_linecode

		If @li_cycleorder = 0 Or @li_cycleorder Is Null
		Begin
			Select	@li_cycleorder	= 1
		End
		Else
		Begin
			Select	@li_cycleorder	= @li_cycleorder + 1
		End

		Select	@li_releaseorder	= 1
	End
	Else
	Begin
		-- ㅆㅂ...조립지시가 된 적이 없는데...
		-- 임시간판의 경우에는 지시대기 간판들 보다 순서를 앞으로 당겨야 한다...
		Select	--@li_releaseorder	= Max(ReleaseOrder) + 1
			@li_releaseorder	= IsNull(Max(ReleaseOrder), 0)
		From	tplanrelease	A
		Where	A.PlanDate	= @ps_releasedate	And
			A.AreaCode	= @ls_areacode		And
			A.DivisionCode	= @ls_divisioncode	And
			A.WorkCenter	= @ls_workcenter		And
			A.LineCode	= @ls_linecode		And
--			A.ItemCode	= @ls_itemcode		And
			A.CycleOrder	= @li_cycleorder		And
			A.PrdFlag	In ('N', 'E')

		If @li_releaseorder = 0 Or @li_releaseorder Is Null
		Begin
			Select	@li_releaseorder	= 1
		End
		Else
		Begin
			Select	@li_releaseorder	= @li_releaseorder + 1
		End

	End
End

If @li_cycleorder = 0 Or @li_cycleorder < 0 Or @li_cycleorder is null Or @li_releaseorder = 0 Or @li_releaseorder < 0 Or @li_releaseorder is null
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '지시순서가 이상합니다.'
	GoTo Proc_Exit
End

--select @li_cycleorder, @li_releaseorder

--Begin Tran

-- 자..테이블을 변경하자.
If @ps_option = 'UPDATE'
Begin
	-- 일단 tplanrelease 를 변경하구..
	Update	tplanrelease
	Set	KBNo		= @ps_kbno,
		KBReleaseDate	= @ps_releasedate,
		KBReleaseSeq	= @li_kbreleaseseq,
		ReleaseGubun	= 'Y',			-- 계획이 있는 것이므로 무조건 'Y'
		PrdFlag		= 'N',
		ReleaseKBCount	= ReleaseKBCount + 1,
		ReleaseKBQty	= ReleaseKBQty + @li_rackqty,
		LastEmp		= 'Y', --@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PlanDate	= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		CycleOrder	= @li_cycleorder		And
		ReleaseOrder	= @li_releaseorder
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '조립지시 테이블에 간판의 조립지시를 저장하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조립지시 테이블에 간판을 저장하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End
Else
Begin

	-- 추가하는 것이므로..추가할 넘 보다 뒤에 조립할 넘들을 만들기 위해
	-- 지시순서를 하나씩 늘리자..임시간판을 지시하는데..정규간판은 조립지시가 않됐을 경우 땜시...추가한 것임...
	Update	tplanrelease
	Set	ReleaseOrder	= ReleaseOrder + 1,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PlanDate	= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		CycleOrder	= @li_cycleorder		And
		ReleaseOrder	>= @li_releaseorder
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '지시대기 상태 간판의 지시순서를 변경하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조지시대기 상태 간판의 지시순서를 변경하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End

	-- 젠장...전일 지시일 경우 
	If @ls_releasegubun = 'Y'
	Begin
		-- 일단 tplanrelease 에 새롭게 추가하자...
		Insert	tplanrelease
		Select	PlanDate	= @ps_releasedate,
			AreaCode	= @ls_areacode,
			DivisionCode	= @ls_divisioncode,
			WorkCenter	= @ls_workcenter,
			LineCode	= @ls_linecode,
			CycleOrder	= @li_cycleorder,
			ReleaseOrder	= @li_releaseorder,
			ItemCode	= @ls_itemcode,
			KBNo		= @ps_kbno,
			KBReleaseDate	= @ps_releasedate,
			KBReleaseSeq	= @li_kbreleaseseq,
			TempGubun	= @ls_tempgubun,
			ReleaseGubun	= @ls_releasegubun,
			PrdFlag		= 'N',
			PlanKBCount	= 1,
			PlanKBQty	= @li_rackqty,
			ReleaseKBCount	= 1,
			ReleaseKBQty	= @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
	
		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '조립지시 테이블에 간판의 조립지시를 새롭게 추가하였습니다.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '조립지시 테이블에 간판을 새롭게 추가하는 중에 오류가 발생하였습니다.'
			GoTo Proc_Exit
		End


		Select	@li_count = 0

		Select	@li_count	= Count(ItemCode)
		From	tplanday		A
		Where	A.PlanDate	= @ps_releasedate	And
			A.AreaCode	= @ls_areacode		And
			A.DivisionCode	= @ls_divisioncode	And
			A.WorkCenter	= @ls_workcenter		And
			A.LineCode	= @ls_linecode		And
			A.ItemCode	= @ls_itemcode

		If @li_count > 0
		Begin
			If @ls_tempgubun = 'N'
			Begin
				Update	tplanday
				Set	ChangeQty	= ChangeQty + @li_rackqty,
					NormalKBCount	= NormalKBCount + 1,
					NormalKBQty	= NormalKBQty + @li_rackqty,
					LastEmp		= 'Y',--@ps_empcode,
					LastDate		= @ldt_nowtime
				Where	PlanDate	= @ps_releasedate	And
					AreaCode	= @ls_areacode		And
					DivisionCode	= @ls_divisioncode	And
					WorkCenter	= @ls_workcenter		And
					LineCode	= @ls_linecode		And
					ItemCode	= @ls_itemcode
			End
			Else
			Begin
				Update	tplanday
				Set	ChangeQty	= ChangeQty + @li_rackqty,
					TempKBCount	= TempKBCount + 1,
					TempKBQty	= TempKBQty + @li_rackqty,
					LastEmp		= 'Y',--@ps_empcode,
					LastDate		= @ldt_nowtime
				Where	PlanDate	= @ps_releasedate	And
					AreaCode	= @ls_areacode		And
					DivisionCode	= @ls_divisioncode	And
					WorkCenter	= @ls_workcenter		And
					LineCode	= @ls_linecode		And
					ItemCode	= @ls_itemcode
			End
		End
		Else
		Begin
			If @ls_tempgubun = 'N'
			Begin
				Insert	tplanday
				Select	PlanDate	= @ps_releasedate,
					AreaCode	= @ls_areacode,
					DivisionCode	= @ls_divisioncode,
					WorkCenter	= @ls_workcenter,
					LineCode	= @ls_linecode,
					ItemCode	= @ls_itemcode,
					PlanQty		= 0,
					ChangeQty	= @li_rackqty,	
					NormalKBCount	= 1,
					NormalKBQty	= @li_rackqty,	
					TempKBCount	= 0,
					TempKBQty	= 0,	
					LastEmp		= 'Y',--@ps_empcode,
					LastDate		= @ldt_nowtime
			End
			Else
			Begin
				Insert	tplanday
				Select	PlanDate	= @ps_releasedate,
					AreaCode	= @ls_areacode,
					DivisionCode	= @ls_divisioncode,
					WorkCenter	= @ls_workcenter,
					LineCode	= @ls_linecode,
					ItemCode	= @ls_itemcode,
					PlanQty		= 0,
					ChangeQty	= @li_rackqty,	
					NormalKBCount	= 0,
					NormalKBQty	= 0,	
					TempKBCount	= 1,
					TempKBQty	= @li_rackqty,	
					LastEmp		= 'Y',--@ps_empcode,
					LastDate		= @ldt_nowtime
			End
		End

		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '간판 지시 추가에 따른 일일생산계획을 변경하였습니다.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '간판 지시 추가에 따른 일일생산계획을 변경하는 중에 오류가 발생하였습니다.'
			GoTo Proc_Exit
		End
	End
	Else	-- 당일 지시
	Begin
		-- 일단 tplanrelease 에 새롭게 추가하자...
		-- 긴급지시 이지만, 계획수량도 추가하자...왜 지시순서변경에서 골때려지니까..
		-- 다시 추가하지 말자..지시순서 변경할 때 PlanKBCount 에서 가져오지 말구...Select Count(KBNo) 을 사용하자..시불
		Insert	tplanrelease
		Select	PlanDate	= @ps_releasedate,
			AreaCode	= @ls_areacode,
			DivisionCode	= @ls_divisioncode,
			WorkCenter	= @ls_workcenter,
			LineCode	= @ls_linecode,
			CycleOrder	= @li_cycleorder,
			ReleaseOrder	= @li_releaseorder,
			ItemCode	= @ls_itemcode,
			KBNo		= @ps_kbno,
			KBReleaseDate	= @ps_releasedate,
			KBReleaseSeq	= @li_kbreleaseseq,
			TempGubun	= @ls_tempgubun,
			ReleaseGubun	= @ls_releasegubun,
			PrdFlag		= 'N',
			PlanKBCount	= 0,
			PlanKBQty	= 0,
			ReleaseKBCount	= 1,
			ReleaseKBQty	= @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
	
		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '조립지시 테이블에 간판의 조립지시를 새롭게 추가하였습니다.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '조립지시 테이블에 간판을 새롭게 추가하는 중에 오류가 발생하였습니다.'
			GoTo Proc_Exit
		End
	End
End

-- 간판준수율을 추가하자.
If Not exists (	Select	*
		From	tprdratekb
		Where	PrdDate		= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode)
Begin
	Insert	tprdratekb
	Select	PrdDate		= @ps_releasedate,
		AreaCode	= @ls_areacode,
		DivisionCode	= @ls_divisioncode,
		WorkCenter	= @ls_workcenter,
		LineCode	= @ls_linecode,
		ItemCode	= @ls_itemcode,
		ReleaseCount	= 1,
		PrdCount	= 0,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
End
Else
Begin
	Update	tprdratekb
	Set	ReleaseCount	= IsNull(ReleaseCount, 0) + 1,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PrdDate		= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		ItemCode	= @ls_itemcode
End

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판준수율을 등록 하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판준수율을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


-- 평준화준수율을 추가하자.
If Not exists (	Select	*
		From	tprdratecycle
		Where	PrdDate		= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode)
Begin
	Insert	tprdratecycle
	Select	PrdDate		= @ps_releasedate,
		AreaCode	= @ls_areacode,
		DivisionCode	= @ls_divisioncode,
		WorkCenter	= @ls_workcenter,
		LineCode	= @ls_linecode,
		ItemCode	= @ls_itemcode,
		ReleaseCount	= 1,
		HitCount		= 0,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
End
Else
Begin
	Update	tprdratecycle
	Set	ReleaseCount	= IsNull(ReleaseCount, 0) + 1,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PrdDate		= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		ItemCode	= @ls_itemcode
End

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '평준화준수율을 등록 하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '평준화준수율을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 및 tkbhis 테이블 변경을 시작하자
-- tkbhis 의 마지막 Seq 을 변경하자.
Update	tkbhis
Set	LastLoopFlag		= 'N',
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo			= @ps_kbno		And
--		KBReleaseDate		= @ps_releasedate	And
	LastLoopFlag		= 'Y'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 이력의 마지막 순번을 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 이력의 마지막 순번을 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkbhis 에 새로운 지시를 추가하자
Insert	tkbhis
Select	KBNo			= A.KBNo,
	KBReleaseDate		= @ps_releasedate,
	KBReleaseSeq		= @li_kbreleaseseq,
	LastLoopFlag		= 'Y',
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	WorkCenter		= A.WorkCenter,
	LineCode		= A.LineCode,
	ItemCode		= A.ItemCode,
	ApplyFrom		= A.ApplyFrom,
	KBStatusCode		= 'A',
	TempGubun		= A.TempGubun,
	ASGubun		= A.ASGubun,
	KBActiveGubun		= A.KBActiveGubun,
	KBCreateTime		= A.KBCreateTime,
	KBPrintTime		= A.KBPrintTime,
	PrintCount		= A.PrintCount,
	RackQty			= @li_rackqty,
	CurrentQty		= @li_rackqty,
	ReleaseGubun		= @ls_releasegubun,
	ReleaseCancel		= Null,
	PrdFlag			= 'N',
	InspectGubun		= @ls_inspectgubun,
	InspectFlag		= Null,
	StockGubun		= B.StockGubun,
	StockCancel		= Null,
	PlanDate		= @ps_releasedate,
	PrdDate			= Null,
	PrdAreaCode		= Null,
	PrdDivisionCode		= Null,
	PrdWorkCenter		= Null,
	PrdLineCode		= Null,
	TimeApplyFrom		= Null,
	TimeCode		= Null,
	PrdQty			= 0,
	LotNo			= Null,
	StockDate		= Null,
	StockQty			= 0,
	ShipDate		= Null,
	ShipQty			= 0,
	InvGubunFlag		= 'N',
	KBReleaseTime		= @ldt_nowtime,
	KBStartTime		= Null,
	KBEndTime		= Null,
	KBInspectTime		= Null,
	KBStockTime		= Null,
	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
From	tkb	A,
	tmstkb	B
Where	A.KBNo		= @ps_kbno	And
	A.KBStatusCode	= 'F'		And
	A.KBActiveGubun	= 'A'		And
	A.AreaCode	= B.AreaCode	And
	A.DivisionCode	= B.DivisionCode	And
	A.WorkCenter	= B.WorkCenter	And
	A.LineCode	= B.LineCode	And
	A.ItemCode	= B.ItemCode	--And
--		B.PrdStopGubun	= 'N'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 이력을 새롭게 추가하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 이력을 새롭게 추가하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 를 변경하자.
Update	tkb
Set	KBStatusCode		= 'A',
	RackQty			= @li_rackqty,
	CurrentQty		= @li_rackqty,
	ReleaseGubun		= @ls_releasegubun,
	ReleaseCancel		= Null,
	PrdFlag			= 'N',
	InspectGubun		= @ls_inspectgubun,
	InspectFlag		= Null,
	StockGubun		= B.StockGubun,
	StockCancel		= Null,
	PlanDate		= @ps_releasedate,
	PrdDate			= Null,
	PrdAreaCode		= Null,
	PrdDivisionCode		= Null,
	PrdWorkCenter		= Null,
	PrdLineCode		= Null,
	TimeApplyFrom		= Null,
	TimeCode		= Null,
	PrdQty			= 0,
	LotNo			= Null,
	StockDate		= Null,
	StockQty			= 0,
	ShipDate		= Null,
	ShipQty			= 0,
	InvGubunFlag		= 'N',
	KBReleaseTime		= @ldt_nowtime,
	KBStartTime		= Null,
	KBEndTime		= Null,
	KBInspectTime		= Null,
	KBStockTime		= Null,
	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
From	tkb	A,
	tmstkb	B
Where	A.KBNo		= @ps_kbno	And
	A.KBStatusCode	= 'F'		And
	A.KBActiveGubun	= 'A'		And
	A.AreaCode	= B.AreaCode	And
	A.DivisionCode	= B.DivisionCode	And
	A.WorkCenter	= B.WorkCenter	And
	A.LineCode	= B.LineCode	And
	A.ItemCode	= B.ItemCode	--And
--		B.PrdStopGubun	= 'N'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 상태 정보를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 상태 정보를 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


Proc_Exit:

/*
If @ls_error = '00'
Begin
	Commit Tran
End
Else
Begin
	RollBack Tran
End
*/

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
