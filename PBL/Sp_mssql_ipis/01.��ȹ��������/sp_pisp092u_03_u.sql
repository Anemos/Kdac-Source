/*
	File Name	: sp_pisp092u_03_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp092u_03_u
	Description	: 미준수간판 등록 - 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp092u_03_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp092u_03_u]
GO

/*
Execute sp_pisp092u_03_u
	@ps_prddate		= '2002.09.30',
	@ps_kbno		= 'DA010101001',
	@ps_kbreleasedate	= '2002.09.30',
	@pi_kbreleaseseq	= 2,
	@ps_nokbgubun		= 'U',
	@ps_codegroup		= 'PUNOBSERVE',
	@ps_codeid		= '01',
	@ps_empcode		= 'TEST'

dbcc opentran

select * from tplanrelease
where plandate = '2002.09.30'	and
	itemcode = '511513'

update tplanrelease
set prdflag = 'C'
where plandate = '2002.09.30'	and
releasegubun = 'C'
	itemcode = '511513'

delete tplanrelease
where plandate = '2002.09.30'	

select * from tprdnokb

delete tprdnokb

select * from tkb

select * from tkbhis

update tkb
set	kbstatuscode = 'F'
where workcenter = '4201'
kbno = 'DA010101001'

update tkbhis
set	kbstatuscode = 'A'
--delete tkbhis
where workcenter = '4201'
kbno = 'DA010101002' and
	LastLoopFlag	= 'Y'
*/

Create Procedure sp_pisp092u_03_u
	@ps_prddate		char(10),	-- 미준수간판 등록일
	@ps_kbno		varchar(11),	-- 지시하는 간판 번호
	@ps_kbreleasedate	char(10),
	@pi_kbreleaseseq	int,
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
	@ls_releasegubun	char(1),		-- 간판 지시 구분
	@li_rackqty		int,

	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시

	@ls_error		char(2),
	@ls_errortext		varchar(100)


-- 일단 간판 관련 변수를 정의하자
Select	@ls_areacode		= AreaCode,
	@ls_divisioncode		= DivisionCode,
	@ls_workcenter		= WorkCenter,
	@ls_linecode		= LineCode,
	@ls_itemcode		= ItemCode,
	@ls_releasegubun	= ReleaseGubun,
	@li_rackqty		= RackQty
From	tkbhis
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

--Begin Tran

-- 일단 tprdnokb 에 새롭게 미준수간판을 추가하자...
Insert	tprdnokb
Select	KBNo		= @ps_kbno,
	KBReleaseDate	= @ps_kbreleasedate,
	KBReleaseSeq	= @pi_kbreleaseseq,
	NoKBGubun	= 'U',
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
		@ls_errortext	= '미준수간판 이력  테이블에 미준수간판을 새롭게 추가하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '미준수간판 이력  테이블에 미준수간판을 새롭게 추가하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- 미준수등록을 수행하면
-- 조립지시대기 상태로 전환하자..즉, 지시취소처럼 하자...단, PrdFlag 만 빼고,
-- 조립지시하구.취소하구.미준수처리하구 하는 사이에 로직이 넘 복잡하다..
-- 따라서. 일단 단순하게 처리하자.

-- 일단 tplanrelease 를 변경하구..
If @ls_releasegubun = 'Y'
Begin
	Update	tplanrelease
	Set	ReleaseGubun	= 'U',
		PrdFlag		= 'N',
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_kbreleasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '조립지시 테이블에 전일 조립지시된 간판의 미준수를 등록하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조립지시 테이블에 전일 조립지시된 간판의 미준수를 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End
Else
Begin
	Update	tplanrelease
	Set	ReleaseGubun	= 'U',
		PrdFlag		= 'N',
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_kbreleasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '조립지시 테이블에 긴급 조립지시된 간판의 미준수를 등록하였습니다.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '조립지시 테이블에 긴급 조립지시된 간판의 미준수를 등록하는 중에 오류가 발생하였습니다.'
		GoTo Proc_Exit
	End
End

-- tkb 및 tkbhis 테이블 변경을 시작하자
-- tkbhis 을 변경하자
Update	tkbhis
Set	KBStatusCode		= 'F',
	ReleaseGubun		= 'U',
	PrdFlag			= 'N',
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
		@ls_errortext	= '간판 이력의 미준수간판을 등록하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 이력의 미준수간판을 등록하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkb 를 변경하자.
Update	tkb
Set	KBStatusCode		= 'F',
	ReleaseGubun		= 'U',
	PrdFlag			= 'N',
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno	And
	KBStatusCode	= 'A'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판 상태의 미준수간판을 등록하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 상태의 미준수간판을 등록하는 중에 오류가 발생하였습니다.'
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
