/*
	File Name	: sp_pisp093u_02_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp093u_02_u
	Description	: 무간판 생산/입고 등록 - 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 30
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp093u_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp093u_02_u]
GO

/*
Execute sp_pisp093u_02_u
	@ps_prddate		= '2002.09.30',
	@ps_lotno		= '2M30A',
	@ps_kbno		= 'DA010101002',
	@ps_codegroup		= 'PNOKB',
	@ps_codeid		= '01',
	@ps_empcode		= 'TEST'

dbcc opentran

select * from tplanrelease
where plandate = '2002.10.01'	and
	itemcode = '511513'

update tplanrelease
set prdflag = 'C'
where plandate = '2002.09.30'	and
releasegubun = 'C'
	itemcode = '511513'

delete tplanrelease
where plandate = '2002.10.01'	

select * from tprdnokb
select * from tprdkb		-- delete tprdkb where workcenter = '4201'
select * from tprd
select * from tprdtime

select * from tinv
select * from tlotnohis

delete tprdnokb

select * from tmstkb
select * from tkb
select * from tkbhis

update tkb
set	kbstatuscode = 'F'
where workcenter = '4201'
kbno = 'DA010101001'

update tkbhis
set	kbstatuscode = 'F'
--delete tkbhis
where workcenter = '4201'
kbno = 'DA010101002' and
	LastLoopFlag	= 'Y'
*/

Create Procedure sp_pisp093u_02_u
	@ps_prddate		char(10),	-- 미준수간판 등록일
	@ps_lotno		char(6),		-- LotNo.
	@ps_kbno		varchar(11),	-- 지시하는 간판 번호
	@ps_codegroup		varchar(10),
	@ps_codeid		varchar(10),
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

	@ls_inspectgubun	char(1),		-- 입고검사 수행 여부
	@ls_stockgubun		char(1),		-- 입고등록 수행 여부

	@ls_timeapplyfrom	char(10),	-- 시간대별 시간 코드 적용 시작일
	@ls_timecode		char(5),		-- 시간대별 시간 코드

	@ls_releasegubun	char(1),		-- 간판 지시 구분
	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시

	@li_kbreleaseseq		int,

	@li_cycleorder		int,
	@li_releaseorder		int,

	@ls_prdkbitemcode	varchar(12),	-- tprdkb 에서 사용
	@li_prdorder		int,		-- tprdkb 에서 사용
	@li_prdkborder		int,		-- tprdkb 에서 사용

	@li_seqno		int,		-- MIS Interface 을 위한 Seq No.

	@ls_error		char(2),
	@ls_errortext		varchar(100)

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

-- 입고 검사 및 입고 등록 여부를 구하자.
Select	@ls_stockgubun		= StockGubun
From	tmstkb
Where	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	WorkCenter	= @ls_workcenter		And
	LineCode	= @ls_linecode		And
	ItemCode	= @ls_itemcode		And
	PrdStopGubun	= 'N'

-- 입고 검사품인지를 구하자.
-- 조립지시하는 날짜로 조회하자...왜냐 낼 부터 입고검사품으로 등록할 수 있으니까...헤헤
If Not exists (	Select	ItemCode
		From	tqcontainqcitem	A
		Where	A.AreaCode	= @ls_areacode		And
			A.DivisionCode	= @ls_divisioncode	And
			A.ItemCode	= @ls_itemcode		And
			A.ApplyDateFrom	<= @ps_prddate		And
			A.ApplyDateTo	> @ps_prddate)
Begin
	Select	@ls_inspectgubun	= 'N'
End
Else
Begin
	Select	@ls_inspectgubun	= 'Y'
End


-- 시간대별 코드를 구하자...무조건 맨 처음 시간대로 처리하자
Select	@ls_timeapplyfrom	= ApplyFrom,
	@ls_timecode		= TimeCode
From	tmsttime
Where	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	ApplyFrom	<= @ps_prddate		And
	ApplyTo		> @ps_prddate		And
	TimeOrder	= 1

-- 조립지시 구분을 구하자
Select	@ls_releasegubun	= 'N',
	@ldt_nowtime		= GetDate()

-- 간판번호의 다음 지시 순번을 구하자.
Select	@li_kbreleaseseq		= Max(A.KBReleaseSeq)
From	tkbhis	A
Where	A.KBNo			= @ps_kbno		And
	A.KBReleaseDate		= @ps_prddate		--And
--	A.LastLoopFlag		= 'Y'

If @li_kbreleaseseq = 0 Or @li_kbreleaseseq Is Null
	Select	@li_kbreleaseseq		= 1
Else
	Select	@li_kbreleaseseq		= @li_kbreleaseseq + 1

-- 조립지시를 추가하자
Select	@li_cycleorder	= 0

Select	@li_cycleorder	= Max(CycleOrder)
From	tplanrelease	A
Where	A.PlanDate	= @ps_prddate		And
	A.AreaCode	= @ls_areacode		And
	A.DivisionCode	= @ls_divisioncode	And
	A.WorkCenter	= @ls_workcenter		And
	A.LineCode	= @ls_linecode		And
	A.ItemCode	= @ls_itemcode		And
	A.ReleaseGubun	= 'N'

If @li_cycleorder = 0 Or @li_cycleorder Is Null	-- 무간판 지시된 것이 없으면..새롭게 CycleOrder 추가..
Begin
	Select	@li_cycleorder	= 0
	
	Select	@li_cycleorder	= Max(CycleOrder)
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_prddate		And
		A.AreaCode	= @ls_areacode		And
		A.DivisionCode	= @ls_divisioncode	And
		A.WorkCenter	= @ls_workcenter		And
		A.LineCode	= @ls_linecode		--And
--		A.ItemCode	= @ls_itemcode

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
	-- 어라..이미 무간판 지시된 것이 존재하네..
	-- 이경우 무간판 지시된 cycleorder 에 간판만 추가하자..
	Select	@li_releaseorder	= IsNull(Max(ReleaseOrder), 0)
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_prddate		And
		A.AreaCode	= @ls_areacode		And
		A.DivisionCode	= @ls_divisioncode	And
		A.WorkCenter	= @ls_workcenter		And
		A.LineCode	= @ls_linecode		And
		A.CycleOrder	= @li_cycleorder		And
		A.ItemCode	= @ls_itemcode		And
		A.ReleaseGubun	= 'N'

	Select	@li_cycleorder	= @li_cycleorder,
		@li_releaseorder	= @li_releaseorder + 1
End

--Begin Tran

-- 자..tplanrelease 에 Insert 하자.
Insert	tplanrelease
Select	PlanDate	= @ps_prddate,
	AreaCode	= @ls_areacode,
	DivisionCode	= @ls_divisioncode,
	WorkCenter	= @ls_workcenter,
	LineCode	= @ls_linecode,
	CycleOrder	= @li_cycleorder,
	ReleaseOrder	= @li_releaseorder,
	ItemCode	= @ls_itemcode,
	KBNo		= @ps_kbno,
	KBReleaseDate	= @ps_prddate,
	KBReleaseSeq	= @li_kbreleaseseq,
	TempGubun	= @ls_tempgubun,
	ReleaseGubun	= @ls_releasegubun,
	PrdFlag		= 'E',
	PlanKBCount	= 0,
	PlanKBQty	= 0,
	ReleaseKBCount	= 1,
	ReleaseKBQty	= @li_rackqty,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '조립지시 테이블에 간판의 무간판 생산/입고 등록을 추가하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '조립지시 테이블에 간판의 무간판 생산/입고 등록을 추가하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 및 tkbhis 테이블 변경을 시작하자
If @ls_inspectgubun = 'N' And @ls_stockgubun = 'N'	-- 그냥 입고까지 처리하는 넘들...
Begin
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
		KBReleaseDate		= @ps_prddate,
		KBReleaseSeq		= @li_kbreleaseseq,
		LastLoopFlag		= 'Y',
		AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		WorkCenter		= A.WorkCenter,
		LineCode		= A.LineCode,
		ItemCode		= A.ItemCode,
		ApplyFrom		= A.ApplyFrom,
		KBStatusCode		= 'D',
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
		PrdFlag			= 'E',
		InspectGubun		= @ls_inspectgubun,
		InspectFlag		= Null,
		StockGubun		= @ls_stockgubun,
		StockCancel		= Null,
		PlanDate		= @ps_prddate,
		PrdDate			= @ps_prddate,
		PrdAreaCode		= A.AreaCode,
		PrdDivisionCode		= A.DivisionCode,
		PrdWorkCenter		= A.WorkCenter,
		PrdLineCode		= A.LineCode,
		TimeApplyFrom		= @ls_timeapplyfrom,
		TimeCode		= @ls_timecode,
		PrdQty			= @li_rackqty,
		LotNo			= @ps_lotno,
		StockDate		= @ps_prddate,
		StockQty			= @li_rackqty,
		ShipDate		= Null,
		ShipQty			= 0,
		InvGubunFlag		= 'N',
		KBReleaseTime		= @ldt_nowtime,
		KBStartTime		= Null,
		KBEndTime		= @ldt_nowtime,
		KBInspectTime		= Null,
		KBStockTime		= @ldt_nowtime,
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
	Set	KBStatusCode		= 'D',
		RackQty			= @li_rackqty,
		CurrentQty		= @li_rackqty,
		ReleaseGubun		= @ls_releasegubun,
		ReleaseCancel		= Null,
		PrdFlag			= 'E',
		InspectGubun		= @ls_inspectgubun,
		InspectFlag		= Null,
		StockGubun		= @ls_stockgubun,
		StockCancel		= Null,
		PlanDate		= @ps_prddate,
		PrdDate			= @ps_prddate,
		PrdAreaCode		= A.AreaCode,
		PrdDivisionCode		= A.DivisionCode,
		PrdWorkCenter		= A.WorkCenter,
		PrdLineCode		= A.LineCode,
		TimeApplyFrom		= @ls_timeapplyfrom,
		TimeCode		= @ls_timecode,
		PrdQty			= @li_rackqty,
		LotNo			= @ps_lotno,
		StockDate		= @ps_prddate,
		StockQty			= @li_rackqty,
		ShipDate		= Null,
		ShipQty			= 0,
		InvGubunFlag		= 'N',
		KBReleaseTime		= @ldt_nowtime,
		KBStartTime		= Null,
		KBEndTime		= @ldt_nowtime,
		KBInspectTime		= Null,
		KBStockTime		= @ldt_nowtime,
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
	EndEnd
Else	-- 입고 검사 또는 입고 등록을 수행하는 제품, 완료까지만 처리하자.
Begin
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
			@ls_errortext	= '간판 이력의 마지막 순번을 변경하였습니다. - 입고검사'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '간판 이력의 마지막 순번을 변경하는 중에 오류가 발생하였습니다. - 입고검사'
		GoTo Proc_Exit
	End
	
	-- tkbhis 에 새로운 지시를 추가하자
	Insert	tkbhis
	Select	KBNo			= A.KBNo,
		KBReleaseDate		= @ps_prddate,
		KBReleaseSeq		= @li_kbreleaseseq,
		LastLoopFlag		= 'Y',
		AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		WorkCenter		= A.WorkCenter,
		LineCode		= A.LineCode,
		ItemCode		= A.ItemCode,
		ApplyFrom		= A.ApplyFrom,
		KBStatusCode		= 'C',
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
		PrdFlag			= 'E',
		InspectGubun		= @ls_inspectgubun,
		InspectFlag		= Null,
		StockGubun		= @ls_stockgubun,
		StockCancel		= Null,
		PlanDate		= @ps_prddate,
		PrdDate			= @ps_prddate,
		PrdAreaCode		= A.AreaCode,
		PrdDivisionCode		= A.DivisionCode,
		PrdWorkCenter		= A.WorkCenter,
		PrdLineCode		= A.LineCode,
		TimeApplyFrom		= @ls_timeapplyfrom,
		TimeCode		= @ls_timecode,
		PrdQty			= @li_rackqty,
		LotNo			= @ps_lotno,
		StockDate		= Null,
		StockQty			= 0,
		ShipDate		= Null,
		ShipQty			= 0,
		InvGubunFlag		= 'N',
		KBReleaseTime		= @ldt_nowtime,
		KBStartTime		= Null,
		KBEndTime		= @ldt_nowtime,
		KBInspectTime		= Null,
		KBStockTime		= @ldt_nowtime,
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
			@ls_errortext	= '간판 이력을 새롭게 추가하였습니다. - 입고검사'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '간판 이력을 새롭게 추가하는 중에 오류가 발생하였습니다. - 입고검사'
		GoTo Proc_Exit
	End
	
	-- tkb 를 변경하자.
	Update	tkb
	Set	KBStatusCode		= 'C',
		RackQty			= @li_rackqty,
		CurrentQty		= @li_rackqty,
		ReleaseGubun		= @ls_releasegubun,
		ReleaseCancel		= Null,
		PrdFlag			= 'E',
		InspectGubun		= @ls_inspectgubun,
		InspectFlag		= Null,
		StockGubun		= @ls_stockgubun,
		StockCancel		= Null,
		PlanDate		= @ps_prddate,
		PrdDate			= @ps_prddate,
		PrdAreaCode		= A.AreaCode,
		PrdDivisionCode		= A.DivisionCode,
		PrdWorkCenter		= A.WorkCenter,
		PrdLineCode		= A.LineCode,
		TimeApplyFrom		= @ls_timeapplyfrom,
		TimeCode		= @ls_timecode,
		PrdQty			= @li_rackqty,
		LotNo			= @ps_lotno,
		StockDate		= Null,
		StockQty			= 0,
		ShipDate		= Null,
		ShipQty			= 0,
		InvGubunFlag		= 'N',
		KBReleaseTime		= @ldt_nowtime,
		KBStartTime		= Null,
		KBEndTime		= @ldt_nowtime,
		KBInspectTime		= Null,
		KBStockTime		= @ldt_nowtime,
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
			@ls_errortext	= '간판 상태 정보를 변경하였습니다. - 입고검사'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '간판 상태 정보를 변경하는 중에 오류가 발생하였습니다. - 입고검사'
		GoTo Proc_Exit
	EndEnd

-- 일단 tprdnokb 에 새롭게 무간판 생산을 추가하자...
Insert	tprdnokb
Select	KBNo		= @ps_kbno,
	KBReleaseDate	= @ps_prddate,
	KBReleaseSeq	= @li_kbreleaseseq,
	NoKBGubun	= 'N',
	PrdDate		= @ps_prddate,
	AreaCode	= @ls_areacode,
	DivisionCode	= @ls_divisioncode,
	WorkCenter	= @ls_workcenter,
	LineCode	= @ls_linecode,
	ItemCode	= @ls_itemcode,
	RackQty		= @li_rackqty,
	CodeGroup	= @ps_codegroup,
	CodeID		= @ps_codeid,
	ReasonDesc	= Null,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '무간판 이력  테이블에 무간판을 새롭게 추가하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '무간판 이력  테이블에 무간판을 새롭게 추가하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


-- 생산실적을 추가하자
If Not exists (	Select	*
		From	tprd
		Where	PrdDate		= @ps_prddate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode)
Begin
	Insert	tprd
	Select	PrdDate		= @ps_prddate,
		AreaCode	= @ls_areacode,
		DivisionCode	= @ls_divisioncode,
		WorkCenter	= @ls_workcenter,
		LineCode	= @ls_linecode,
		ItemCode	= @ls_itemcode,
		PlanQty		= 0,
		PrdQty		= @li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
End
Else
Begin
	Update	tprd
	Set	PrdQty		= IsNull(PrdQty, 0) + @li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PrdDate		= @ps_prddate		And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		ItemCode	= @ls_itemcode
End

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '생산실적을 등록 하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '생산실적을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


-- 시간대별 생산실적을 추가하자
If Not exists (	Select	*
		From	tprdtime
		Where	PrdDate		= @ps_prddate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode		And
			ApplyFrom	= @ls_timeapplyfrom	And
			TimeCode	= @ls_timecode)
Begin
	Insert	tprdtime
	Select	PrdDate		= @ps_prddate,
		AreaCode	= @ls_areacode,
		DivisionCode	= @ls_divisioncode,
		WorkCenter	= @ls_workcenter,
		LineCode	= @ls_linecode,
		ItemCode	= @ls_itemcode,
		ApplyFrom	= @ls_timeapplyfrom,
		TimeCode	= @ls_timecode,
		PlanQty		= 0,
		PrdQty		= @li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
End
Else
Begin
	Update	tprdtime
	Set	PrdQty		= IsNull(PrdQty, 0) + @li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PrdDate		= @ps_prddate		And
		AreaCode	= @ls_areacode		And
		DivisionCode	= @ls_divisioncode	And
		WorkCenter	= @ls_workcenter		And
		LineCode	= @ls_linecode		And
		ItemCode	= @ls_itemcode		And
		ApplyFrom	= @ls_timeapplyfrom	And
		TimeCode	= @ls_timecode
End

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '시간대별 생산실적을 등록 하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '시간대별 생산실적을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

/*
-- 간판 생산 순서 테이블 => tprdkb 변경
Select	@ls_prdkbitemcode	= ItemCode,
	@li_prdorder		= Max(PrdOrder)	
From	tprdkb
Where	PrdDate		= @ps_prddate		And
	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	WorkCenter	= @ls_workcenter		And
	LineCode	= @ls_linecode
Group By ItemCode

If @li_prdorder = 0 Or @li_prdorder Is Null
Begin
	Select	@li_prdorder	= 1,
		@li_prdkborder	= 1
End
Else
Begin
	If @ls_prdkbitemcode = @ls_itemcode
	Begin
		Select	@li_prdkborder	= IsNull(Max(PrdKBOrder), 0)
		From	tprdkb
		Where	PrdDate		= @ps_prddate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			PrdOrder	= @li_prdorder

		Select	@li_prdorder	= @li_prdorder,
			@li_prdkborder	= @li_prdkborder + 1
	End
	Else
	Begin
		Select	@li_prdorder	= @li_prdorder + 1,
			@li_prdkborder	= 1
	End
End

Insert	tprdkb
Select	PrdDate		= @ps_prddate,
	AreaCode	= @ls_areacode,
	DivisionCode	= @ls_divisioncode,
	WorkCenter	= @ls_workcenter,
	LineCode	= @ls_linecode,
	PrdOrder	= @li_prdorder,
	PrdKBOrder	= @li_prdkborder,
	ItemCode	= @ls_itemcode,
	KBNo		= @ps_kbno,
	KBReleaseDate	= @ps_prddate,
	KBReleaseSeq	= @li_kbreleaseseq,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '무간판 생산/입고 등록을 저장 하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 생산 순서 이력을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End
*/

-- 여기부터는 입고로 바로 가는 넘들만 처리하자.
If @ls_inspectgubun = 'N' And @ls_stockgubun = 'N'	-- 입고 하는 넘들
Begin
	-- Lot No. 별 입고 이력을 처리하자
	If Not exists (	Select	*
			From	tlotno
			Where	TraceDate	= @ps_prddate		And
				AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				LotNo		= @ps_lotno		And
				ItemCode	= @ls_itemcode		And
				CustCode	= 'XXXXXX'		And
				ShipGubun	= 'X')
	Begin
		Insert	tlotno
		Select	TraceDate	= @ps_prddate,
			AreaCode	= @ls_areacode,
			DivisionCode	= @ls_divisioncode,
			LotNo		= @ps_lotno,
			ItemCode	= @ls_itemcode,
			CustCode	= 'XXXXXX',
			ShipGubun	= 'X',
			ShipUsage	= 'X',
			PrdQty		= @li_rackqty,
			StockQty		= @li_rackqty,
			ShipQty		= 0,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
	End
	Else
	Begin
		Update	tlotno
		Set	PrdQty		= IsNull(PrdQty, 0) + @li_rackqty,
			StockQty		= IsNull(StockQty, 0) + @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	TraceDate	= @ps_prddate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			LotNo		= @ps_lotno		And
			ItemCode	= @ls_itemcode		And
			CustCode	= 'XXXXXX'		And
			ShipGubun	= 'X'
	End
	
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '입고이력을 등록 하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '입고이력을 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End

	-- 재고를 처리하자
	If Not exists (	Select	*
			From	tinv
			Where	AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				ItemCode	= @ls_itemcode)
	Begin
		Insert	tinv
		Select	AreaCode		= @ls_areacode,
			DivisionCode		= @ls_divisioncode,
			ItemCode		= @ls_itemcode,
			InvQty			= @li_rackqty,
			RepairQty		= 0,
			DefectQty		= 0,
			MoveInvQty		= 0,
			ShipInvQty		= 0,
			InvCompute		= Null,
			LastEmp			= 'Y',--@ps_empcode,
			LastDate			= @ldt_nowtime
	End
	Else
	Begin
		Update	tinv
		Set	InvQty		= IsNull(InvQty, 0) + @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			ItemCode	= @ls_itemcode
	End
	
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '무간판 생산/입고 등록을 저장 하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '재고를 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End

	-- MIS Interface을 위한 tstock_interface 처리
	Select	@li_seqno		= Max(A.SeqNo)
	From	tstock_interface	A
	Where	A.KBNo			= @ps_kbno
	And	A.KBReleaseDate		= @ps_prddate
	And	A.KBReleaseSeq		= @li_kbreleaseseq
	And	A.MISFlag		= 'A'

	If @li_seqno = 0 Or @li_seqno Is Null
		Select	@li_seqno	= 1
	Else
		Select	@li_seqno	= @li_seqno + 1

	Insert	tstock_interface
	Select	KBNo			= @ps_kbno,
		KBReleaseDate		= @ps_prddate,
		KBReleaseSeq		= @li_kbreleaseseq,
		SeqNo			= @li_seqno,
		MISFlag			= 'A',
		InterfaceFlag		= 'Y',
		StockDate		= @ps_prddate,
		AreaCode		= @ls_areacode,
		DivisionCode		= @ls_divisioncode,
		WorkCenter		= @ls_workcenter,
		LineCode		= @ls_linecode,
		ItemCode		= @ls_itemcode,			
		StockQty			= @li_rackqty,
		LastEmp			= @ps_empcode,
		LastDate			= @ldt_nowtime

	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '무간판 생산/입고 등록을 저장 하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= 'MIS Interface 정보를 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End
Else
Begin
	-- Lot No. 별 입고 이력을 처리하자
	If Not exists (	Select	*
			From	tlotno
			Where	TraceDate	= @ps_prddate		And
				AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				LotNo		= @ps_lotno		And
				ItemCode	= @ls_itemcode		And
				CustCode	= 'XXXXXX'		And
				ShipGubun	= 'X')
	Begin
		Insert	tlotno
		Select	TraceDate	= @ps_prddate,
			AreaCode	= @ls_areacode,
			DivisionCode	= @ls_divisioncode,
			LotNo		= @ps_lotno,
			ItemCode	= @ls_itemcode,
			CustCode	= 'XXXXXX',
			ShipGubun	= 'X',
			ShipUsage	= 'X',
			PrdQty		= @li_rackqty,
			StockQty		= 0,
			ShipQty		= 0,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
	End
	Else
	Begin
		Update	tlotno
		Set	PrdQty		= IsNull(PrdQty, 0) + @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	TraceDate	= @ps_prddate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			LotNo		= @ps_lotno		And
			ItemCode	= @ls_itemcode		And
			CustCode	= 'XXXXXX'		And
			ShipGubun	= 'X'
	End
	
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '무간판 생산/입고 등록을 저장 하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '입고이력을 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
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
