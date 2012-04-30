/*
	File Name	: sp_pisp091u_02_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp091u_02_u
	Description	: ���� �������� ����ϴ� ��..���� - ���� ���ν���
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
	@ps_releasedate		char(10),	-- ��������
	@pi_cycleorder		int,		-- �����ϴ� CycleOrder
	@pi_releaseorder		int,		-- ���� ���� ����
	@ps_kbno		varchar(11),	-- �����ϴ� ���� ��ȣ
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
	@ls_releasegubun	char(1),		-- ���� ���� ����
	@li_rackqty		int,

	@li_plankbcount		int,

	@li_releaseorder_max	int,

	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�

	@ls_error		char(2),
	@ls_errortext		varchar(100)

-- �ϴ� ���� ���� ������ ��������
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

-- �ϴ� �������� ������
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

-- �ϴ� tplanrelease �� �����ϱ�..
-- �������� ������ �ٲ�� �ϹǷ�..����ϴ� ���� �� �ڷ� ������..
/*
	���ؼ� ���ǵ� ��� ����.
	����...���� ���ؼ� ó���� ���� �������� ���..�̳��� ReleaseGubun �� 'U' �̴�..
	�׳�...PlanKBCount = 0 �� ���� ��������� ������ ����...
	��� ���� �� ���� �׳� ���� ����...
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
			@ls_errortext	= '�������� ���̺� ������ ���� �������ø� ����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�������� ���̺� ������ ���� �������ø� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	-- ������ ������ ���������� �ٲ�����
	-- ���� �߰��� �� �ִ� ���� ����� ���
	-- �׳Ѻ��� �ڿ� ���������� �ִ� �ѵ��� �ϳ��� �����..
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
			@ls_errortext	= '�ٸ� ������ �������ü����� �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�ٸ� ������ �������ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
			@ls_errortext	= '�������� ���̺� ������ ��� �������ø� ����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�������� ���̺� ������ ��� �������ø� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
			@ls_errortext	= '�������� ���̺� ������ ��� �������ø� ����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�������� ���̺� ������ ��� �������ø� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	-- CycleOrder �� ���� �ѸŸ� �ִ� ����
	-- ���� CycleOrder�� �ϳ��� �ٿ��� �Ѵ�.
	If Exists (Select	*
		From	tplanrelease
		Where	PlanDate	= @ps_releasedate	And
			AreaCode	= @ls_areacode		And
			DivisionCode	= @ls_divisioncode	And
			WorkCenter	= @ls_workcenter		And
			LineCode	= @ls_linecode		And
			CycleOrder	= @pi_cycleorder)
	Begin
		-- ������ ������ ���������� �ٲ�����
		-- ���� �߰��� �� �ִ� ���� ����� ���
		-- �׳Ѻ��� �ڿ� ���������� �ִ� �ѵ��� �ϳ��� �����..
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
				@ls_errortext	= '�ٸ� ������ �������ü����� �����Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '�ٸ� ������ �������ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End
	End
	Else	-- CycleOrder �� ���̻��� ��ȹ�̳� ���� ������ ���°��
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
				@ls_errortext	= '�ٸ� ��ǰ�� �������ü����� �����Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '�ٸ� ��ǰ�� �������ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End
	End
End

-- �����ؼ����� �������.
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
		@ls_errortext	= '�����ؼ����� ��� �Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�����ؼ����� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End


-- ����ȭ�ؼ����� �������.
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
		@ls_errortext	= '����ȭ�ؼ����� ��� �Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '����ȭ�ؼ����� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End


-- tkb �� tkbhis ���̺� ������ ��������
-- tkbhis �� ��������
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
		@ls_errortext	= '���� �̷��� �������ø� ����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� �̷��� �������ø� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkb �� ��������.
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
		@ls_errortext	= '���� ������ �������ø� ����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ������ �������ø� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
