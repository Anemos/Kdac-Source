/*
	File Name	: sp_pisp091u_02_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp091u_02_u
	Description	: 간판 조립지시 취소하는 것..헤헤 - 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp091u_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp091u_02_u]
GO

/*
Execute sp_pisp091u_02_u
	@ps_releasedate		= '2002.12.03',
	@pi_cycleorder		= 1,
	@pi_releaseorder		= 1,
	@ps_kbno		= 'JS010001001',
	@ps_kbreleasedate	= '2002.12.03',
	@pi_kbreleaseseq	= 1,
	@ps_empcode		= 'N'

dbcc opentran

select * from tplanrelease
where plandate = '2002.09.28'	and
	itemcode = '511513'

select * from tplanday
where plandate = '2002.09.28'	and
	itemcode = '511513'

2002.09.27	D	A	4201	A	511513	0	1650	35	1750
2002.09.27	D	A	4201	B	511513	0	1550	31	1550


delete tplanrelease
where plandate = '2002.09.27'	and
	itemcode = '511513'


select * from tkbhis
 where kbno = 'JS010001001'
itemcode = '512777'

				Select	CycleOrder,
					ReleaseOrder
				From		tplanrelease
				Where		KBNo				= 'JS010001001'
				And		KBReleaseDate	= '2002.12.03'
				And		KBReleaseSeq	= 1
				Using	SQLPIS;

JS010001001

select * from tkbhis

update tkb
set	kbstatuscode = 'F'
where kbno = 'DA010101001'

update tkbhis
set	kbstatuscode = 'A'
--delete tkbhis
where kbno = 'DA010101002' and
	LastLoopFlag	= 'Y'
*/

Create Procedure sp_pisp091u_02_u
	@ps_releasedate		char(10),	-- 지시일자
	@pi_cycleorder		int,		-- 지시하는 CycleOrder
	@pi_releaseorder		int,		-- 간판 지시 순서
	@ps_kbno		varchar(11),	-- 지시하는 간판 번호
	@ps_kbreleasedate	char(10),
	@pi_kbreleaseseq	int,
	@ps_empcode		varchar(6)

As
Begin

Declare	@ls_areacode		char(1),
	@ls_divisioncode		char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(12),
--	@ls_tempgubun		char(1),
	@ls_releasegubun	char(1),		-- 간판 지시 구분
	@li_rackqty		int,

	@li_plankbcount		int,

	@li_releaseorder_max	int,

	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시

	@ls_error		char(2),
	@ls_errortext		varchar(100)

-- 일단 간판 관련 변수를 정의하자
Select	@ls_areacode		= AreaCode,
	@ls_divisioncode		= DivisionCode,
	@ls_workcenter		= WorkCenter,
	@ls_linecode		= LineCode,
	@ls_itemcode		= ItemCode,
--	@ls_tempgubun		= TempGubun,
	@ls_releasegubun	= ReleaseGubun,
	@li_rackqty		= RackQty
From	tkbhis
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

--select  @ls_releasegubun

Select	@li_releaseorder_max	= Max(ReleaseOrder)
From	tplanrelease
Where	PlanDate	= @ps_releasedate	And
	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	WorkCenter	= @ls_workcenter		And
	LineCode	= @ls_linecode		And
	CycleOrder	= @pi_cycleorder		--And
--	ReleaseGubun	In ('Y', 'T')		And
--	PrdFlag		In ('N')		

Select	@li_plankbcount	= IsNull(PlanKBCount, 0)
From	tplanrelease
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

--Begin Tran

-- 일단 tplanrelease 를 변경하구..
-- 조립지시 순서를 바꿔야 하므로..취소하는 넘을 맨 뒤로 보내자..
/*
	미준수 간판도 취소 하자.
	씨불...만약 미준수 처리한 넘을 삭제했을 경우..이넘은 ReleaseGubun 이 'U' 이다..
	그냥...PlanKBCount = 0 인 넘은 긴급지시한 넘으로 보구...
	긴급 지시 한 넘은 그냥 삭제 하자...
*/
If @li_plankbcount > 0
--If @ls_releasegubun = 'Y'
Begin
	Update	tplanrelease
	Set	ReleaseOrder	= @li_releaseorder_max + 1,
		KBNo		= 'A',
		KBReleaseDate	= 'A',
		KBReleaseSeq	= 0,
		ReleaseGubun	= 'C',
		PrdFlag		= 'C',
		ReleaseKBCount	= 0,
		ReleaseKBQty	= 0,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PlanDate	= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		CycleOrder	= @pi_cycleorder		And
		KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_kbreleasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
--		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '조립지시 테이블에 간판의 전일 조립지시를 취소하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조립지시 테이블에 간판이 전일 조립지시를 취소하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End

	-- 나머지 간판의 조립순서를 바꿔주자
	-- 만약 중간에 껴 있는 넘을 취소할 경우
	-- 그넘보다 뒤에 조립순서로 있는 넘들을 하나씩 당기자..
	Update	tplanrelease
	Set	ReleaseOrder	= ReleaseOrder - 1,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PlanDate	= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		CycleOrder	= @pi_cycleorder		And
		ReleaseOrder	> @pi_releaseorder
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '다른 간판의 조립지시순서를 변경하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '다른 간판의 조립지시순서를 변경하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End
Else
Begin
/*
	Update	tplanrelease
	Set	ReleaseOrder	= @li_releaseorder_max + 1,
		KBNo		= 'A',
		KBReleaseDate	= 'A',
		KBReleaseSeq	= 0,
		ReleaseGubun	= 'C',
		PrdFlag		= 'C',
		ReleaseKBCount	= 0,
		ReleaseKBQty	= 0,
		LastEmp		= @ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PlanDate	= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		CycleOrder	= @pi_cycleorder		And
		KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_kbreleasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '조립지시 테이블에 간판의 긴급 조립지시를 취소하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조립지시 테이블에 간판이 긴급 조립지시를 취소하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
*/

	Delete	tplanrelease
	Where	PlanDate	= @ps_releasedate	And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		CycleOrder	= @pi_cycleorder		And
--		ReleaseOrder	= @pi_releaseorder	And
		KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_releasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
--		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '조립지시 테이블에 간판의 긴급 조립지시를 취소하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조립지시 테이블에 간판의 긴급 조립지시를 취소하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End

	-- CycleOrder 에 간판 한매만 있는 경우는
	-- 다음 CycleOrder을 하나씩 줄여야 한다.
	If Exists (Select	*
		From	tplanrelease
		Where	PlanDate	= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			CycleOrder	= @pi_cycleorder)
	Begin
		-- 나머지 간판의 조립순서를 바꿔주자
		-- 만약 중간에 껴 있는 넘을 취소할 경우
		-- 그넘보다 뒤에 조립순서로 있는 넘들을 하나씩 당기자..
		Update	tplanrelease
		Set	ReleaseOrder	= ReleaseOrder - 1,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	PlanDate	= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			CycleOrder	= @pi_cycleorder		And
			ReleaseOrder	> @pi_releaseorder
		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '다른 간판의 조립지시순서를 변경하였습니다.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '다른 간판의 조립지시순서를 변경하는 중에 오류가 발생하였습니다.'
			GoTo Proc_Exit
		End
	End
	Else	-- CycleOrder 에 더이상의 계획이나 지시 간판이 없는경우
	Begin
		Update	tplanrelease
		Set	CycleOrder	= CycleOrder - 1,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	PlanDate	= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
-			CycleOrder	> @pi_cycleorder	--	And
--			ReleaseOrder	> @pi_releaseorder
		If @@Error = 0
		Begin
			Select	@ls_error	= '00',
				@ls_errortext	= '다른 제품의 조립지시순서를 변경하였습니다.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '다른 제품의 조립지시순서를 변경하는 중에 오류가 발생하였습니다.'
			GoTo Proc_Exit
		End
	End
End

-- 간판준수율을 취소하자.
If Exists (	Select	*
		From	tprdratekb
		Where	PrdDate		= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode		And
			ReleaseCount	> 0)
Begin
	Update	tprdratekb
	Set	ReleaseCount	= IsNull(ReleaseCount, 0) - 1,
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


-- 평준화준수율을 취소하자.
If Exists (	Select	*
		From	tprdratecycle
		Where	PrdDate		= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode		And
			ReleaseCount	> 0)
Begin
	Update	tprdratecycle
	Set	ReleaseCount	= IsNull(ReleaseCount, 0) - 1,
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
-- tkbhis 을 변경하자
Update	tkbhis
Set	KBStatusCode		= 'F',
	ReleaseGubun		= Null,
	ReleaseCancel		= 'Y',
	PrdFlag			= Null,
--	InspectGubun		= Null,
--	InspectFlag		= Null,
--	StockGubun		= Null,
--	StockCancel		= Null,
	PlanDate		= Null,
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
	KBReleaseTime		= Null,
	KBStartTime		= Null,
	KBEndTime		= Null,
	KBInspectTime		= Null,
	KBStockTime		= Null,
	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
--	LastLoopFlag	= 'Y'		And
	KBStatusCode	= 'A'


If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 이력의 조립지시를 취소하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 이력의 조립지시를 취소하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 를 변경하자.
Update	tkb
Set	KBStatusCode		= 'F',
	ReleaseGubun		= Null,
	ReleaseCancel		= 'Y',
	PrdFlag			= Null,
--	InspectGubun		= Null,
--	InspectFlag		= Null,
--	StockGubun		= Null,
--	StockCancel		= Null,
	PlanDate		= Null,
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
	KBReleaseTime		= Null,
	KBStartTime		= Null,
	KBEndTime		= Null,
	KBInspectTime		= Null,
	KBStockTime		= Null,
	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno	And
	KBStatusCode	= 'A'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 상태의 조립지시를 취소하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 상태의 조립지시를 취소하는 중에 오류가 발생하였습니다.'
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
