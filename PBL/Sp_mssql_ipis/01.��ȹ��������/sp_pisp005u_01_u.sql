/*
	File Name	: sp_pisp005u_01_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp005u_01_u
	Description	: 지시순서 변경 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 23
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp005u_01_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp005u_01_u]
GO

/*
Execute sp_pisp005u_01_u
	@ps_plandate		= '2002.09.25',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@pi_cycleorder		= 6,
	@pi_plankbcount		= 8,
	@pi_changeorder		= 5,
	@pi_changekbcount	= 8,
	@ps_empcode		= 'IPIS'

select * from tplanday where plandate = '2002.09.25'

select * from tplanrelease
where plandate = '2002.09.25'
 order by plandate, linecode,cycleorder, releaseorder

delete tplanrelease where plandate = '2002.09.25'

dbcc opentran
*/

Create Procedure sp_pisp005u_01_u
	@ps_plandate		char(10),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1),
	@pi_cycleorder		int,
	@pi_plankbcount		int,
	@pi_changeorder		int,
	@pi_changekbcount	int,
	@ps_empcode		varchar(6)
As
Begin

Declare	@li_count		int,
	@ls_error		char(2),
	@ls_errortext		varchar(100)

/*
지시순서가 변경되는 경우는 4가지 이다.
CASE 1		지시간판매수와 변경간판매수가 같고, 지시를 앞으로 이동
CASE 2		지시간판매수와 변경간판매수가 같고, 지시를 뒤로 이동
CASE 3		지시간판매수 중에 일부 매수를 변경하고, 지시를 앞로 이동
CASE 4		지시간판매수 중에 일부 매수를 변경하고, 지시를 뒤로 이동
*/

-- 선택한 지시순번을 제외한 나머지들
Create Table #tmp_plan_cycle
(	PlanDate		char(10)		NOT NULL ,
	AreaCode		char(1)		NOT NULL ,
	DivisionCode		char(1)		NOT NULL ,
	WorkCenter		varchar(5)	NOT NULL ,
	LineCode		char(1)		NOT NULL ,
	CycleOrder		smallint		NOT NULL ,	
	ReleaseOrder		smallint		NOT NULL ,	
	ItemCode		varchar(12)	NOT NULL ,
	KBNo			char(11)		NOT NULL ,
	KBReleaseDate		char(10)		NOT NULL ,
	KBReleaseSeq		smallint	 	NOT NULL ,
	TempGubun		char(1)		NOT NULL,
	ReleaseGubun		char(1)		NOT NULL ,-- 조립지시 구분(C:평준화계획완료,Y:전일지시 완료,T:당일지시 완료,N:무간판)
	PrdFlag			char(1)		NOT NULL ,-- 조립완료/미준수 여부
	PlanKBCount		int		NOT NULL ,
	PlanKBQty		int		NOT NULL ,
	ReleaseKBCount		int		NOT NULL ,
	ReleaseKBQty		int		NOT NULL ,
	LastEmp			varchar(6)	NULL ,
	LastDate			datetime		NULL ,
	Constraint PK_TMP_PLAN_CYCLE Primary Key
	(
		PlanDate,
		AreaCode,
		DivisionCode,
		WorkCenter,
		LineCode,
		CycleOrder,
		ReleaseOrder
	)
)

-- 순서를 변경하려는 순번의 정보
Create Table #tmp_plan_change
(	PlanDate		char(10)		NOT NULL ,
	AreaCode		char(1)		NOT NULL ,
	DivisionCode		char(1)		NOT NULL ,
	WorkCenter		varchar(5)	NOT NULL ,
	LineCode		char(1)		NOT NULL ,
	CycleOrder		smallint		NOT NULL ,	
	ReleaseOrder		smallint		NOT NULL ,	
	ItemCode		varchar(12)	NOT NULL ,
	KBNo			char(11)		NOT NULL ,
	KBReleaseDate		char(10)		NOT NULL ,
	KBReleaseSeq		smallint	 	NOT NULL ,
	TempGubun		char(1)		NOT NULL,
	ReleaseGubun		char(1)		NOT NULL ,-- 조립지시 구분(C:평준화계획완료,Y:전일지시 완료,T:당일지시 완료,N:무간판)
	PrdFlag			char(1)		NOT NULL ,-- 조립완료/미준수 여부
	PlanKBCount		int		NOT NULL ,
	PlanKBQty		int		NOT NULL ,
	ReleaseKBCount		int		NOT NULL ,
	ReleaseKBQty		int		NOT NULL ,
	LastEmp			varchar(6)	NULL ,
	LastDate			datetime		NULL ,
	Constraint PK_TMP_PLAN_CHANGE Primary Key
	(
		PlanDate,
		AreaCode,
		DivisionCode,
		WorkCenter,
		LineCode,
		CycleOrder,
		ReleaseOrder
	)
)

-- 임시테이블에 지시 정보를 담자...헤헤
-- 경우의 수에 따라 담는 방식이 다르다..
If @pi_plankbcount = @pi_changekbcount
Begin
	Insert	#tmp_plan_cycle
	Select	PlanDate	= A.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		WorkCenter	= A.WorkCenter,
		LineCode	= A.LineCode,
		CycleOrder	= A.CycleOrder,
		ReleaseOrder	= A.ReleaseOrder,	
		ItemCode	= A.ItemCode,
		KBNo		= A.KBNo,
		KBReleaseDate	= A.KBReleaseDate,
		KBReleaseSeq	= A.KBReleaseSeq,
		TempGubun	= A.TempGubun,
		ReleaseGubun	= A.ReleaseGubun,
		PrdFlag		= A.PrdFlag,
		PlanKBCount	= A.PlanKBCount,
		PlanKBQty	= A.PlanKBQty,
		ReleaseKBCount	= A.ReleaseKBCount,
		ReleaseKBQty	= A.ReleaseKBQty,
		LastEmp		= @ps_empcode,
		LastDate		= GetDate()
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	<> @pi_cycleorder
	
	Insert	#tmp_plan_change
	Select	PlanDate	= A.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		WorkCenter	= A.WorkCenter,
		LineCode	= A.LineCode,
		CycleOrder	= A.CycleOrder,
		ReleaseOrder	= A.ReleaseOrder,	
		ItemCode	= A.ItemCode,
		KBNo		= A.KBNo,
		KBReleaseDate	= A.KBReleaseDate,
		KBReleaseSeq	= A.KBReleaseSeq,
		TempGubun	= A.TempGubun,
		ReleaseGubun	= A.ReleaseGubun,
		PrdFlag		= A.PrdFlag,
		PlanKBCount	= A.PlanKBCount,
		PlanKBQty	= A.PlanKBQty,
		ReleaseKBCount	= A.ReleaseKBCount,
		ReleaseKBQty	= A.ReleaseKBQty,
		LastEmp		= @ps_empcode,
		LastDate		= GetDate()
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	= @pi_cycleorder
End
Else
Begin
	Insert	#tmp_plan_cycle
	Select	PlanDate	= A.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		WorkCenter	= A.WorkCenter,
		LineCode	= A.LineCode,
		CycleOrder	= A.CycleOrder,
		ReleaseOrder	= A.ReleaseOrder,	
		ItemCode	= A.ItemCode,
		KBNo		= A.KBNo,
		KBReleaseDate	= A.KBReleaseDate,
		KBReleaseSeq	= A.KBReleaseSeq,
		TempGubun	= A.TempGubun,
		ReleaseGubun	= A.ReleaseGubun,
		PrdFlag		= A.PrdFlag,
		PlanKBCount	= A.PlanKBCount,
		PlanKBQty	= A.PlanKBQty,
		ReleaseKBCount	= A.ReleaseKBCount,
		ReleaseKBQty	= A.ReleaseKBQty,
		LastEmp		= @ps_empcode,
		LastDate		= GetDate()
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	<> @pi_cycleorder

-- 만약 조립완료된 간판이 있을 경우
-- 완료된 간판은 순서를 변경하면 않된다..
	Select	@li_count	= 0
	Select	@li_count	= Count(A.PlanDate)
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	= @pi_cycleorder		And
		A.PrdFlag	In ('E')

	-- 변경하지 않는 간판
	-- 조립완료된거
	Insert	#tmp_plan_cycle
	Select	PlanDate	= A.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		WorkCenter	= A.WorkCenter,
		LineCode	= A.LineCode,
		CycleOrder	= A.CycleOrder,
		ReleaseOrder	= A.ReleaseOrder,
		ItemCode	= A.ItemCode,
		KBNo		= A.KBNo,
		KBReleaseDate	= A.KBReleaseDate,
		KBReleaseSeq	= A.KBReleaseSeq,
		TempGubun	= A.TempGubun,
		ReleaseGubun	= A.ReleaseGubun,
		PrdFlag		= A.PrdFlag,
		PlanKBCount	= A.PlanKBCount,
		PlanKBQty	= A.PlanKBQty,
		ReleaseKBCount	= A.ReleaseKBCount,
		ReleaseKBQty	= A.ReleaseKBQty,
		LastEmp		= @ps_empcode,
		LastDate		= GetDate()
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	= @pi_cycleorder		And
		A.PrdFlag	In ('E')

	-- 변경하지 않는 간판
	-- 조립완료 되지 않은 것
	Insert	#tmp_plan_cycle
	Select	PlanDate	= A.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		WorkCenter	= A.WorkCenter,
		LineCode	= A.LineCode,
		CycleOrder	= A.CycleOrder,
		ReleaseOrder	= A.ReleaseOrder - @pi_changekbcount,
		ItemCode	= A.ItemCode,
		KBNo		= A.KBNo,
		KBReleaseDate	= A.KBReleaseDate,
		KBReleaseSeq	= A.KBReleaseSeq,
		TempGubun	= A.TempGubun,
		ReleaseGubun	= A.ReleaseGubun,
		PrdFlag		= A.PrdFlag,
		PlanKBCount	= A.PlanKBCount,
		PlanKBQty	= A.PlanKBQty,
		ReleaseKBCount	= A.ReleaseKBCount,
		ReleaseKBQty	= A.ReleaseKBQty,
		LastEmp		= @ps_empcode,
		LastDate		= GetDate()
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	= @pi_cycleorder		And
		A.ReleaseOrder	> (@pi_changekbcount + @li_count)	And
		A.PrdFlag	In ('N', 'C')

	-- 변경해야할 간판
	Insert	#tmp_plan_change
	Select	PlanDate	= A.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		WorkCenter	= A.WorkCenter,
		LineCode	= A.LineCode,
		CycleOrder	= A.CycleOrder,
		ReleaseOrder	= A.ReleaseOrder - @li_count,	
		ItemCode	= A.ItemCode,
		KBNo		= A.KBNo,
		KBReleaseDate	= A.KBReleaseDate,
		KBReleaseSeq	= A.KBReleaseSeq,
		TempGubun	= A.TempGubun,
		ReleaseGubun	= A.ReleaseGubun,
		PrdFlag		= A.PrdFlag,
		PlanKBCount	= A.PlanKBCount,
		PlanKBQty	= A.PlanKBQty,
		ReleaseKBCount	= A.ReleaseKBCount,
		ReleaseKBQty	= A.ReleaseKBQty,
		LastEmp		= @ps_empcode,
		LastDate		= GetDate()
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_plandate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.CycleOrder	= @pi_cycleorder		And
		A.ReleaseOrder	<= (@pi_changekbcount + @li_count)	And
		A.PrdFlag	In ('N', 'C')
End

-- 지시순서를 변경하기 위하여
-- 경우에 따라 임시 테이블의 데이터를 변경하자
If @pi_plankbcount = @pi_changekbcount
Begin
	If @pi_changeorder < @pi_cycleorder 	--CASE 1	지시간판매수와 변경간판매수가 같고, 지시를 앞으로 이동
	Begin
		Update	#tmp_plan_cycle
		Set	CycleOrder	= A.CycleOrder + 1
		From	#tmp_plan_cycle	A
		Where	A.CycleOrder	Between @pi_changeorder And @pi_cycleorder

		Update	#tmp_plan_change
		Set	CycleOrder	= @pi_changeorder
	End
	Else					--CASE 2	지시간판매수와 변경간판매수가 같고, 지시를 뒤로 이동
	Begin
		Update	#tmp_plan_cycle
		Set	CycleOrder	= A.CycleOrder - 1
		From	#tmp_plan_cycle	A
		Where	A.CycleOrder	Between @pi_cycleorder And @pi_changeorder

		Update	#tmp_plan_change
		Set	CycleOrder	= @pi_changeorder
	End
End
Else
Begin
	If @pi_changeorder < @pi_cycleorder	--CASE 3	지시간판매수 중에 일부 매수를 변경하고, 지시를 앞로 이동
	Begin
		Update	#tmp_plan_cycle
		Set	CycleOrder	= A.CycleOrder + 1
		From	#tmp_plan_cycle	A
		Where	A.CycleOrder	>= @pi_changeorder

		Update	#tmp_plan_change
		Set	CycleOrder	= @pi_changeorder
	End
	Else					--CASE 4	지시간판매수 중에 일부 매수를 변경하고, 지시를 뒤로 이동
	Begin
		Update	#tmp_plan_cycle
		Set	CycleOrder	= A.CycleOrder + 1
		From	#tmp_plan_cycle	A
		Where	A.CycleOrder	>= @pi_changeorder

		Update	#tmp_plan_change
		Set	CycleOrder	= @pi_changeorder
	End
End

--select * from #tmp_plan_change
--select * from #tmp_plan_cycle


--Begin Tran

-- 일단 평준화 순서 계획을 지우자
Delete	tplanrelease
Where	PlanDate	= @ps_plandate		And
	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
	WorkCenter	= @ps_workcenter	And
	LineCode	= @ps_linecode

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '평준화 순서 계획을 임시로 삭제하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '평준화 순서 계획을 임시로 삭제하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- 선택하지 않은 지시들을 추가하자
Insert	tplanrelease
Select	PlanDate	= A.PlanDate,
	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	WorkCenter	= A.WorkCenter,
	LineCode	= A.LineCode,
	CycleOrder	= A.CycleOrder,
	ReleaseOrder	= A.ReleaseOrder,	
	ItemCode	= A.ItemCode,
	KBNo		= A.KBNo,
	KBReleaseDate	= A.KBReleaseDate,
	KBReleaseSeq	= A.KBReleaseSeq,
	TempGubun	= A.TempGubun,
	ReleaseGubun	= A.ReleaseGubun,
	PrdFlag		= A.PrdFlag,
	PlanKBCount	= A.PlanKBCount,
	PlanKBQty	= A.PlanKBQty,
	ReleaseKBCount	= A.ReleaseKBCount,
	ReleaseKBQty	= A.ReleaseKBQty,
	LastEmp		= 'Y', --@ps_empcode,
	LastDate		= GetDate()
From	#tmp_plan_cycle	A

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '나머지 지시들의 순서를 저장하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '나머지 지시들의 순서를 저장하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- 선택하여 변경한 지시순서를 추가하자.
Insert	tplanrelease
Select	PlanDate	= A.PlanDate,
	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	WorkCenter	= A.WorkCenter,
	LineCode	= A.LineCode,
	CycleOrder	= A.CycleOrder,
	ReleaseOrder	= A.ReleaseOrder,	
	ItemCode	= A.ItemCode,
	KBNo		= A.KBNo,
	KBReleaseDate	= A.KBReleaseDate,
	KBReleaseSeq	= A.KBReleaseSeq,
	TempGubun	= A.TempGubun,
	ReleaseGubun	= A.ReleaseGubun,
	PrdFlag		= A.PrdFlag,
	PlanKBCount	= A.PlanKBCount,
	PlanKBQty	= A.PlanKBQty,
	ReleaseKBCount	= A.ReleaseKBCount,
	ReleaseKBQty	= A.ReleaseKBQty,
	LastEmp		= 'Y', --@ps_empcode,
	LastDate		= GetDate()
From	#tmp_plan_change	A

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '지시순서를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '선택된 순번의 지시순서를 저장하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
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

Drop Table #tmp_plan_cycle
Drop Table #tmp_plan_change

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
