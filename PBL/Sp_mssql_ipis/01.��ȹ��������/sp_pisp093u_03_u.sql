/*
	File Name	: sp_pisp093u_03_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp093u_03_u
	Description	: 무간판 생산/입고 등록 취소 - 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 30
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp093u_03_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp093u_03_u]
GO

/*
Execute sp_pisp093u_03_u
	@ps_prddate		= '2002.10.01',
	@ps_kbno		= 'DA010101003',
	@ps_kbreleasedate	= '2002.10.01',
	@pi_kbreleaseseq	= 1,
	@ps_empcode		= 'TEST'

dbcc opentran

select * from tplanrelease
where plandate = '2002.10.01' and	itemcode = '511513'

update tplanrelease
set prdflag = 'C'
where plandate = '2002.09.30' and releasegubun = 'C' and itemcode = '511513'

delete tplanrelease where plandate = '2002.10.01'	

select * from tprdnokb
select * from tprdkb		-- delete tprdkb where workcenter = '4201'
select * from tprd
select * from tprdtime

select * from tinv
select * from tlotnohis

delete tprdnokb where plandate = '2002.10.01'
delete tprd where prddate = '2002.10.01'
delete tprdtime where prddate = '2002.10.01'


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

Create Procedure sp_pisp093u_03_u
	@ps_prddate		char(10),	-- 미준수간판 등록일
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
	@ls_kbstatuscode	char(1),		-- 취소하려는 간판의 상태
	@ls_lotno		varchar(6),	-- 취소하려는 간판의 Lot No.
	@ls_timeapplyfrom	char(10),	-- 시간대별 시간 코드 적용 시작일
	@ls_timecode		char(5),		-- 시간대별 시간 코드

	@li_rackqty		int,

	@ldt_nowtime		datetime,	-- 기준일을 구하기 위한 현재 일시
	@ls_applydate_close	char(10),	-- 마감일을 고려한 기준일자

	@ls_canceldate		char(10),	-- 기준일을 고려한 취소하는 일자

	@li_cycleorder		int,
	@li_releaseorder		int,

	@li_seqno		int,
	@ls_misflag		char(1),

	@ls_error		char(2),
	@ls_errortext		varchar(100)


-- 일단 간판 관련 변수를 정의하자
Select	@ls_areacode		= AreaCode,
	@ls_divisioncode		= DivisionCode,
	@ls_workcenter		= WorkCenter,
	@ls_linecode		= LineCode,
	@ls_itemcode		= ItemCode,
	@ls_kbstatuscode	= KBStatusCode,
	@ls_lotno		= LotNo,
	@ls_timeapplyfrom	= TimeApplyFrom,
	@ls_timecode		= TimeCode,
	@li_rackqty		= RackQty
From	tkbhis
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ls_areacode,
	@ps_divisioncode	= @ls_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output

-- 기준일에 따른 조립지시 구분을 구하자
If Left(@ls_applydate_close, 7) > Left(@ps_prddate, 7)
	Select	@ls_canceldate	= @ls_applydate_close,	-- 지난달에 등록한 걸 취소하는 경우에는 오널로 취소 처리
		@ls_misflag	= 'A'			-- 지난달걸 삭제할 경우 tstockcancel_interface
Else
	Select	@ls_canceldate	= @ps_prddate,		-- 이번달건 그날자로 취소 처리
		@ls_misflag	= 'D'			-- 이번달걸 삭제할 경우 tstock_interface

--Begin Tran

-- 삭제하고 난 다음에..다른 넘들의 순서를 앞으로 땡기기 위해..
Select	@li_cycleorder	= CycleOrder,
	@li_releaseorder	= ReleaseOrder
From	tplanrelease
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
	ReleaseGubun	= 'N'			And
	PrdFlag		= 'E'

-- 조립지시 테이블에서 삭제 하자.
Delete	tplanrelease
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
	ReleaseGubun	= 'N'			And
	PrdFlag		= 'E'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '조립지시 테이블에 간판의 무간판 생산/입고 등록을 삭제하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '조립지시 테이블에 간판의 무간판 생산/입고 등록을 삭제하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- 나머지 간판의 조립순서를 바꿔주자
-- 만약 중간에 껴 있는 넘을 취소할 경우
-- 그넘보다 뒤에 조립순서로 있는 넘들을 하나씩 당기자..
Update	tplanrelease
Set	ReleaseOrder	= ReleaseOrder - 1,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
Where	PlanDate	= @ps_prddate		And
	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	WorkCenter	= @ls_workcenter		And
	LineCode	= @ls_linecode		And
	CycleOrder	= @li_cycleorder		And
	ReleaseOrder	> @li_releaseorder
If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '다른 간판의  무간판 생산/입고 등록 순서를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '다른 간판의  무간판 생산/입고 등록 순서를 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 및 tkbhis 테이블 변경을 시작하자
-- tkbhis 을 변경하자
Update	tkbhis
Set	KBStatusCode		= 'F',
	ReleaseGubun		= 'U',
	ReleaseCancel		= 'Y',
	PrdFlag			= Null,
	InspectGubun		= Null,
	InspectFlag		= Null,
	StockGubun		= Null,
	StockCancel		= Null,
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
	KBReleaseSeq	= @pi_kbreleaseseq	--And
--	LastLoopFlag	= 'Y'		And
--	KBStatusCode	= 'A'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 이력의  무간판 생산/입고 등록을 취소하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 이력의 무간판 생산/입고 등록을 취소하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 를 변경하자.
Update	tkb
Set	KBStatusCode		= 'F',
	ReleaseGubun		= 'U',
	ReleaseCancel		= 'Y',
	PrdFlag			= Null,
	InspectGubun		= Null,
	InspectFlag		= Null,
	StockGubun		= Null,
	StockCancel		= Null,
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
Where	KBNo		= @ps_kbno	--And
--	KBStatusCode	= 'A'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 상태의 무간판 생산/입고 등록을 취소하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 상태의 무간판 생산/입고 등록을 취소하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- 일단 tprdnokb 에 무간판 생산을 삭제하자...
Delete	tprdnokb
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
	NoKBGubun	= 'N'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '무간판 이력  테이블에 무간판을 삭제하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '무간판 이력  테이블에 무간판을 삭제하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


-- 생산실적을 추가하자
If Not exists (	Select	*
		From	tprd
		Where	PrdDate		= @ls_canceldate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode)
Begin
	Insert	tprd
	Select	PrdDate		= @ls_canceldate,
		AreaCode	= @ls_areacode,
		DivisionCode	= @ls_divisioncode,
		WorkCenter	= @ls_workcenter,
		LineCode	= @ls_linecode,
		ItemCode	= @ls_itemcode,
		PlanQty		= 0,
		PrdQty		= -@li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
End
Else
Begin
	Update	tprd
	Set	PrdQty		= IsNull(PrdQty, 0) - @li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PrdDate		= @ls_canceldate		And
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
		Where	PrdDate		= @ls_canceldate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			ItemCode	= @ls_itemcode		And
			ApplyFrom	= @ls_timeapplyfrom	And
			TimeCode	= @ls_timecode)
Begin
	Insert	tprdtime
	Select	PrdDate		= @ls_canceldate,
		AreaCode	= @ls_areacode,
		DivisionCode	= @ls_divisioncode,
		WorkCenter	= @ls_workcenter,
		LineCode	= @ls_linecode,
		ItemCode	= @ls_itemcode,
		ApplyFrom	= @ls_timeapplyfrom,
		TimeCode	= @ls_timecode,
		PlanQty		= 0,
		PrdQty		= -@li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
End
Else
Begin
	Update	tprdtime
	Set	PrdQty		= IsNull(PrdQty, 0) - @li_rackqty,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	PrdDate		= @ls_canceldate		And
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
Delete	tprdkb
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '무간판 생산/입고 등록을 취소 하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 생산 순서 이력을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End
*/

-- 여기부터는 입고된 넘들만 처리하자.
If @ls_kbstatuscode = 'D'	-- 입고 된 넘
Begin
	-- Lot No. 별 입고 이력을 처리하자
	If Not exists (	Select	*
			From	tlotno
			Where	TraceDate	= @ls_canceldate		And
				AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				LotNo		= @ls_lotno		And
				ItemCode	= @ls_itemcode		And
				CustCode	= 'XXXXXX'		And
				ShipGubun	= 'X')
	Begin
		Insert	tlotno
		Select	TraceDate	= @ls_canceldate,
			AreaCode	= @ls_areacode,
			DivisionCode	= @ls_divisioncode,
			LotNo		= @ls_lotno,
			ItemCode	= @ls_itemcode,
			CustCode	= 'XXXXXX',
			ShipGubun	= 'X',
			ShipUsage	= 'X',
			PrdQty		= -@li_rackqty,
			StockQty		= -@li_rackqty,
			ShipQty		= 0,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
	End
	Else
	Begin
		Update	tlotno
		Set	PrdQty		= IsNull(PrdQty, 0) - @li_rackqty,
			StockQty		= IsNull(StockQty, 0) - @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	TraceDate	= @ls_canceldate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			LotNo		= @ls_lotno		And
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
			InvQty			= -@li_rackqty,
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
		Set	InvQty		= IsNull(InvQty, 0) - @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			ItemCode	= @ls_itemcode
	End
	
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '무간판 생산/입고 등록을 취소 하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '재고를 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End

	-- MIS Interface을 위한 입고취소 처리
	If @ls_misflag = 'D'	-- 이번달에 등록한 것 취소 처리
	Begin
		Select	@li_seqno		= Max(A.SeqNo)
		From	tstock_interface	A
		Where	A.KBNo			= @ps_kbno
		And	A.KBReleaseDate		= @ps_kbreleasedate
		And	A.KBReleaseSeq		= @pi_kbreleaseseq
		And	A.MISFlag		= 'A'
	
		If @li_seqno = 0 Or @li_seqno Is Null
			Select	@li_seqno	= 1
		Else
			Select	@li_seqno	= @li_seqno
	
		Insert	tstock_interface
		Select	KBNo			= @ps_kbno,
			KBReleaseDate		= @ps_kbreleasedate,
			KBReleaseSeq		= @pi_kbreleaseseq,
			SeqNo			= @li_seqno,
			MISFlag			= 'D',
			InterfaceFlag		= 'Y',
			StockDate		= @ls_canceldate,
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
	Else			-- 지난달에 등록한 것 취소처리
	Begin
		Select	@li_seqno		= Max(A.SeqNo)
		From	tstockcancel_interface	A
		Where	A.KBNo			= @ps_kbno
		And	A.KBReleaseDate		= @ps_kbreleasedate
		And	A.KBReleaseSeq		= @pi_kbreleaseseq
		And	A.MISFlag		= 'A'
	
		If @li_seqno = 0 Or @li_seqno Is Null
			Select	@li_seqno	= 1
		Else
			Select	@li_seqno	= @li_seqno + 1
	
		Insert	tstockcancel_interface
		Select	KBNo			= @ps_kbno,
			KBReleaseDate		= @ps_kbreleasedate,
			KBReleaseSeq		= @pi_kbreleaseseq,
			SeqNo			= @li_seqno,
			MISFlag			= 'A',
			InterfaceFlag		= 'Y',
			StockDate		= @ls_canceldate,
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

End
Else
Begin
	-- Lot No. 별 입고 이력을 처리하자
	If Not exists (	Select	*
			From	tlotno
			Where	TraceDate	= @ls_canceldate		And
				AreaCode	= @ls_areacode		And
				DivisionCode	= @ls_divisioncode	And
				LotNo		= @ls_lotno		And
				ItemCode	= @ls_itemcode		And
				CustCode	= 'XXXXXX'		And
				ShipGubun	= 'X')
	Begin
		Insert	tlotno
		Select	TraceDate	= @ls_canceldate,
			AreaCode	= @ls_areacode,
			DivisionCode	= @ls_divisioncode,
			LotNo		= @ls_lotno,
			ItemCode	= @ls_itemcode,
			CustCode	= 'XXXXXX',
			ShipGubun	= 'X',
			ShipUsage	= 'X',
			PrdQty		= -@li_rackqty,
			StockQty		= 0,
			ShipQty		= 0,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
	End
	Else
	Begin
		Update	tlotno
		Set	PrdQty		= IsNull(PrdQty, 0) - @li_rackqty,
			LastEmp		= 'Y',--@ps_empcode,
			LastDate		= @ldt_nowtime
		Where	TraceDate	= @ls_canceldate		And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			LotNo		= @ls_lotno		And
			ItemCode	= @ls_itemcode		And
			CustCode	= 'XXXXXX'		And
			ShipGubun	= 'X'
	End
	
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '무간판 생산/입고 등록을 취소 하였습니다.'
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
