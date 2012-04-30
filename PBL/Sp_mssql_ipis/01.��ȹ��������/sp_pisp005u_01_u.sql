/*
	File Name	: sp_pisp005u_01_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp005u_01_u
	Description	: ���ü��� ���� ���ν���
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
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
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
���ü����� ����Ǵ� ���� 4���� �̴�.
CASE 1		���ð��Ǹż��� ���氣�Ǹż��� ����, ���ø� ������ �̵�
CASE 2		���ð��Ǹż��� ���氣�Ǹż��� ����, ���ø� �ڷ� �̵�
CASE 3		���ð��Ǹż� �߿� �Ϻ� �ż��� �����ϰ�, ���ø� �շ� �̵�
CASE 4		���ð��Ǹż� �߿� �Ϻ� �ż��� �����ϰ�, ���ø� �ڷ� �̵�
*/

-- ������ ���ü����� ������ ��������
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
	ReleaseGubun		char(1)		NOT NULL ,-- �������� ����(C:����ȭ��ȹ�Ϸ�,Y:�������� �Ϸ�,T:�������� �Ϸ�,N:������)
	PrdFlag			char(1)		NOT NULL ,-- �����Ϸ�/���ؼ� ����
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

-- ������ �����Ϸ��� ������ ����
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
	ReleaseGubun		char(1)		NOT NULL ,-- �������� ����(C:����ȭ��ȹ�Ϸ�,Y:�������� �Ϸ�,T:�������� �Ϸ�,N:������)
	PrdFlag			char(1)		NOT NULL ,-- �����Ϸ�/���ؼ� ����
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

-- �ӽ����̺� ���� ������ ����...����
-- ����� ���� ���� ��� ����� �ٸ���..
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

-- ���� �����Ϸ�� ������ ���� ���
-- �Ϸ�� ������ ������ �����ϸ� �ʵȴ�..
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

	-- �������� �ʴ� ����
	-- �����Ϸ�Ȱ�
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

	-- �������� �ʴ� ����
	-- �����Ϸ� ���� ���� ��
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

	-- �����ؾ��� ����
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

-- ���ü����� �����ϱ� ���Ͽ�
-- ��쿡 ���� �ӽ� ���̺��� �����͸� ��������
If @pi_plankbcount = @pi_changekbcount
Begin
	If @pi_changeorder < @pi_cycleorder 	--CASE 1	���ð��Ǹż��� ���氣�Ǹż��� ����, ���ø� ������ �̵�
	Begin
		Update	#tmp_plan_cycle
		Set	CycleOrder	= A.CycleOrder + 1
		From	#tmp_plan_cycle	A
		Where	A.CycleOrder	Between @pi_changeorder And @pi_cycleorder

		Update	#tmp_plan_change
		Set	CycleOrder	= @pi_changeorder
	End
	Else					--CASE 2	���ð��Ǹż��� ���氣�Ǹż��� ����, ���ø� �ڷ� �̵�
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
	If @pi_changeorder < @pi_cycleorder	--CASE 3	���ð��Ǹż� �߿� �Ϻ� �ż��� �����ϰ�, ���ø� �շ� �̵�
	Begin
		Update	#tmp_plan_cycle
		Set	CycleOrder	= A.CycleOrder + 1
		From	#tmp_plan_cycle	A
		Where	A.CycleOrder	>= @pi_changeorder

		Update	#tmp_plan_change
		Set	CycleOrder	= @pi_changeorder
	End
	Else					--CASE 4	���ð��Ǹż� �߿� �Ϻ� �ż��� �����ϰ�, ���ø� �ڷ� �̵�
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

-- �ϴ� ����ȭ ���� ��ȹ�� ������
Delete	tplanrelease
Where	PlanDate	= @ps_plandate		And
	AreaCode	= @ps_areacode		And
	DivisionCode	= @ps_divisioncode	And
	WorkCenter	= @ps_workcenter	And
	LineCode	= @ps_linecode

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '����ȭ ���� ��ȹ�� �ӽ÷� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '����ȭ ���� ��ȹ�� �ӽ÷� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- �������� ���� ���õ��� �߰�����
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
		@ls_errortext	= '������ ���õ��� ������ �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '������ ���õ��� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- �����Ͽ� ������ ���ü����� �߰�����.
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
		@ls_errortext	= '���ü����� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���õ� ������ ���ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
