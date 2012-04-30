/*
	File Name	: sp_piso_generate_planrelease.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piso_generate_planrelease
	Description	: ���� ���ؼ� �������� ���� �̿�
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 11
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso_generate_planrelease]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso_generate_planrelease]
GO


/*

Execute sp_piso_generate_planrelease '08:00', 'D', 'A'

select * from tplanrelease where releasegubun in ('T', 'Y') and prdflag = 'N'

select * from
update tplanrelease
set releasegubun = 'Y'
where releasegubun = 'U' AND kbno > 'A'
and plandate = '2002.11.09'

delete tplanrelease where plandate = '2002.11.12'

select * from tprdratekb
select * from tprdratecycle

select * from tkbhis where kbreleasedate = '2002.11.12'

select * from tkb where plandate = '2002.11.12'

delete tkbhis where kbreleasedate = '2002.11.12'

select * from tkbhis where kbno in ('DA010001002',
'DA010001003',
'DA010001004',
'DA010001005')


update tkb
set stockgubun = 'N'
where kbno = 'DA010001002'



*/

Create Procedure sp_piso_generate_planrelease
	@ps_generate_time	varchar(5),	-- �ְ� 08:00, �߰� 20:00 ���
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1)
	
As
Begin

Declare	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_applydate		char(10),
	@ls_lastdate		char(10),
	@ls_releasedate		char(10),
	@li_linecount		int,
--	@li_itemcount		int,

	@li_cycleordercount	int,
	@li_cycleorder_old	int,

	@li_kbcount		int,
	@li_cycleorder		int,
	@li_releaseorder		int,
	@ls_areacode		char(1),
	@ls_divisioncode		char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(12),
	@ls_kbno		char(11),
	@ls_kbreleasedate	char(10),
	@li_kbreleaseseq		int,
	@ls_tempgubun		char(1),
	@li_plankbcount		int,
	@li_plankbqty		int,
	@li_releasekbcount	int,
	@li_releasekbqty		int,

	@li_kbreleaseseq_new	int,

	@ls_error		varchar(2),
	@ls_errortext		varchar(100)

-- �ϴ� �������� ������
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ps_areacode,
	@ps_divisioncode	= @ps_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate	output

--Select	@ls_lastdate = Convert(Char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, Left('2002.11.11', 7) + '.01'))), 102)
Select	@ls_lastdate = Convert(Char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, Left(@ls_applydate, 7) + '.01'))), 102)

If @ps_generate_time = '08:00'
Begin
	-- �Ŵ� 2�ϳ��� ��� �������� 1�Ϸ� ������Ƿ�..������ �ϳ� �� �߰�
	If @ls_applydate = Left(@ls_applydate, 7) + '.01' And Right(Convert(char(10), @ldt_nowtime, 102), 2) = '01'
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�ſ� ù���� 08:00 �� ��� �Ұ�'
	
		Select	@ls_error,
			@ls_errortext
		Return
	End
End
Else
Begin
	If @ls_applydate <> @ls_lastdate
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�ſ� ������ �ƴ� ���ڴ� 20:00 �� ��� �Ұ�'
	
		Select	@ls_error,
			@ls_errortext
		Return
	End
End

--select	@ls_applydate	= '2003.01.01'
Select	@ls_releasedate	= Convert(Char(10), DateAdd(DD, 1, Convert(DateTime, @ls_applydate)), 102)


-- ���� �ؼ��� �� ����ȭ���� �ΰ����� �����϶� �Ѵ�.
-- ���� 08:00 ���� �������ø� ������ ������ �����ؼ��� �� ����ȭ���� ��������.
-- �׷��� ���� 08:00 �Ǵ� 20:00 �� ���� ���������� ��������
Delete	tplanrelease_t
Where	PlanDate	= @ls_releasedate
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

Insert	tplanrelease_t
Select	PlanDate		= PlanDate,
	AreaCode		= AreaCode,
	DivisionCode		= DivisionCode,
	WorkCenter		= WorkCenter,
	LineCode		= LineCode,
	CycleOrder		= CycleOrder,
	ReleaseOrder		= ReleaseOrder,
	ItemCode		= ItemCode,
	KBNo			= KBNo,
	KBReleaseDate		= KBReleaseDate,
	KBReleaseSeq		= KBReleaseSeq,
	TempGubun		= TempGubun,
	ReleaseGubun		= ReleaseGubun,
	PrdFlag			= PrdFlag,
	PlanKBCount		= PlanKBCount,
	PlanKBQty		= PlanKBQty,
	ReleaseKBCount		= ReleaseKBCount,
	ReleaseKBQty		= ReleaseKBQty,
	LastEmp			= 'Y',
	LastDate			= @ldt_nowtime
From	tplanrelease
Where	PlanDate	= @ls_releasedate
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

-- �����ؼ��� ó��
Delete	tprdratekb_t
Where	PrdDate		= @ls_releasedate
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

Insert	tprdratekb_t
Select	PrdDate		= PrdDate,
	AreaCode	= AreaCode,
	DivisionCode	= DivisionCode,
	WorkCenter	= WorkCenter,
	LineCode	= LineCode,
	ItemCode	= ItemCode,
	ReleaseCount	= ReleaseCount,
	PrdCount	= PrdCount,
	LastEmp		= 'Y',
	LastDate		= @ldt_nowtime
From	tprdratekb
Where	PrdDate		= @ls_releasedate
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

-- ����ȭ�� ó��
Delete	tprdratecycle_t
Where	PrdDate		= @ls_releasedate
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

Insert	tprdratecycle_t
Select	PrdDate		= PrdDate,
	AreaCode	= AreaCode,
	DivisionCode	= DivisionCode,
	WorkCenter	= WorkCenter,
	LineCode	= LineCode,
	ItemCode	= ItemCode,
	ReleaseCount	= ReleaseCount,
	HitCount		= HitCount,
	LastEmp		= 'Y',
	LastDate		= @ldt_nowtime
From	tprdratecycle
Where	PrdDate		= @ls_releasedate
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

-- �̿��� ��ȹ�� �ִ��� ��ȸ����
Select	--PlanDate	= @ls_releasedate,
	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	WorkCenter	= A.WorkCenter,
	LineCode	= A.LineCode,
	CycleOrder	= A.CycleOrder,
	ItemCode	= A.ItemCode,
	KBNo		= A.KBNo,
	KBReleaseDate	= A.KBReleaseDate,
	KBReleaseSeq	= A.KBReleaseSeq,
	TempGubun	= A.TempGubun,
	PlanKBCount	= A.PlanKBCount,
	PlanKBQty	= A.PlanKBQty,
	ReleaseKBCount	= A.ReleaseKBCount,
	ReleaseKBQty	= A.ReleaseKBQty
Into	#tmp_release
From	tplanrelease	A
Where	A.PlanDate	< @ls_releasedate	And
	A.AreaCode	like @ps_areacode	And
	A.DivisionCode	like @ps_divisioncode	And
	A.ReleaseGubun	In ('T', 'Y')		And
	A.PrdFlag	= 'N'
Order By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.CycleOrder, A.ItemCode, A.KBNo

-- �̿� ��ų ��ȹ�� ������ �׳� ������
If @@Rowcount < 1
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���ؼ� ������ �����ϴ�.'

	Select	@ls_error,
		@ls_errortext
	Return
End

Create Table #tmp_cycleorder
(
	CycleOrder	int,
	ItemCode	varchar(12)
)

Create Table #tmp_kb
(
	KBNo		char(11),
	KBReleaseDate	char(10),
	KBReleaseSeq	int,
	TempGubun	char(1),
	PlanKBCount	Int,
	PlanKBQty	Int,
	ReleaseKBCount	Int,
	ReleaseKBQty	Int
)

-- �ϴ� ���θ� ��������
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	WorkCenter	= A.WorkCenter,
	LineCode	= A.LineCode
Into	#tmp_line
From	#tmp_release	A
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode

Select	@li_linecount	= @@RowCount

Begin Tran

While @li_linecount > 0
Begin
	Select	Top 1
		@li_cycleordercount	= 0,
		@ls_areacode		= A.AreaCode,
		@ls_divisioncode		= A.DivisionCode,
		@ls_workcenter		= A.WorkCenter,
		@ls_linecode		= A.LineCode
	From	#tmp_line	A

	-- ���ο� �ش��ϴ� ��ǰ�� ��������
	Insert	#tmp_cycleorder
	Select	CycleOrder	= A.CycleOrder,
		ItemCode	= A.ItemCode
	From	#tmp_release	A
	Where	A.AreaCode	= @ls_areacode
	And	A.DivisionCode	= @ls_divisioncode
	And	A.WorkCenter	= @ls_workcenter
	And	A.LineCode	= @ls_linecode
	Group By A.CycleOrder, A.ItemCode

	Select	@li_cycleordercount	= @@RowCount,
		@li_cycleorder		= 0

-- ���⿡�� ���� ������ CycleOrder �� @li_itemcount ��ŭ ������Ű��.
	Update	tplanrelease
	Set	CycleOrder	= CycleOrder + @li_cycleordercount,
		LastEmp		= 'Y',
		LastDate		= @ldt_nowtime
	Where	PlanDate	= @ls_releasedate
	And	AreaCode	= @ls_areacode
	And	DivisionCode	= @ls_divisioncode
	And	WorkCenter	= @ls_workcenter
	And	LineCode	= @ls_linecode
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '���� ���������� ���ü����� �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '���� ���������� ���ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	While @li_cycleorder < @li_cycleordercount
	Begin
		Select @li_cycleorder	= @li_cycleorder + 1

		-- �������� ���ø� ������ ��ǰ�� �ϳ��� ������ ó������.
		Select	Top 1
			@li_kbcount		= 0,
			@li_cycleorder_old	= A.CycleOrder,
			@ls_itemcode		= A.ItemCode
		From	#tmp_cycleorder	A

		-- ��ǰ�� �ش��ϴ� ���ǵ��� ��������
		Insert	#tmp_kb
		Select	KBNo		= A.KBNo,
			KBReleaseDate	= A.KBReleaseDate,
			KBReleaseSeq	= A.KBReleaseSeq,
			TempGubun	= A.TempGubun,
			PlanKBCount	= A.PlanKBCount,
			PlanKBQty	= A.PlanKBQty,
			ReleaseKBCount	= A.ReleaseKBCount,
			ReleaseKBQty	= A.ReleaseKBQty
		From	#tmp_release	A
		Where	A.AreaCode	= @ls_areacode
		And	A.DivisionCode	= @ls_divisioncode
		And	A.WorkCenter	= @ls_workcenter
		And	A.LineCode	= @ls_linecode
		And	A.CycleOrder	= @li_cycleorder_old
		And	A.ItemCode	= @ls_itemcode
		Group By A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.TempGubun, 
			A.PlanKBCount, A.PlanKBQty, A.ReleaseKBCount, A.ReleaseKBQty
		Order By A.KBNo

		Select	@li_kbcount	= @@RowCount,
			@li_releaseorder	= 0

		While @li_releaseorder < @li_kbcount
		Begin
			Select @li_releaseorder	= @li_releaseorder + 1

			Select	Top 1
				@ls_kbno		= A.KBNo,
				@ls_kbreleasedate	= A.KBReleaseDate,
				@li_kbreleaseseq		= A.KBReleaseSeq,
				@ls_tempgubun		= A.TempGubun,
				@li_plankbcount		= A.PlanKBCount,
				@li_plankbqty		= A.PlanKBQty,
				@li_releasekbcount	= A.ReleaseKBCount,
				@li_releasekbqty		= A.ReleaseKBQty
			From	#tmp_kb		A

			-- ���ǹ�ȣ�� ���� ���� ������ ������.
			Select	@li_kbreleaseseq_new	= Max(A.KBReleaseSeq)
			From	tkbhis	A
			Where	A.KBNo			= @ls_kbno		And
				A.KBReleaseDate		= @ls_releasedate	--And
			--	A.LastLoopFlag		= 'Y'
			
			If @li_kbreleaseseq_new = 0 Or @li_kbreleaseseq_new Is Null
				Select	@li_kbreleaseseq_new	= 1
			Else
				Select	@li_kbreleaseseq_new	= @li_kbreleaseseq_new + 1


			-- ������ʹ� ���̺���� ��������..
			-- ���Ͽ� ���ؼ� ������ ������ ó������
			Update	tplanrelease
			Set	ReleaseGubun		= 'U',
				PrdFlag			= 'N',
				LastEmp			= 'Y',
				LastDate			= @ldt_nowtime
			Where	PlanDate		< @ls_releasedate
			And	KBNo			= @ls_kbno
			And	KBReleaseDate		= @ls_kbreleasedate
			And	KBReleaseSeq		= @li_kbreleaseseq

			If @@Error = 0
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '������ ���ؼ� ������ �����Ͽ����ϴ�.'
			End
			Else
			Begin
				Select	@ls_error	= '11',
					@ls_errortext	= '������ ���ؼ� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
				GoTo Proc_Exit
			End

			-- ���ο� ���ø� ������.
			Insert	tplanrelease
			Select	PlanDate		= @ls_releasedate,
				AreaCode		= @ls_areacode,
				DivisionCode		= @ls_divisioncode,
				WorkCenter		= @ls_workcenter,
				LineCode		= @ls_linecode,
				CycleOrder		= @li_cycleorder,
				ReleaseOrder		= @li_releaseorder,
				ItemCode		= @ls_itemcode,
				KBNo			= @ls_kbno,
				KBReleaseDate		= @ls_releasedate,
				KBReleaseSeq		= @li_kbreleaseseq_new,
				TempGubun		= @ls_tempgubun,
				ReleaseGubun		= 'T',
				PrdFlag			= 'N',
				PlanKBCount		= 0, --@li_plankbcount,
				PlanKBQty		= 0, --@li_plankbqty,
				ReleaseKBCount		= @li_releasekbcount,
				ReleaseKBQty		= @li_releasekbqty,
				LastEmp			= 'Y',
				LastDate			= @ldt_nowtime

			If @@Error = 0
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '���ؼ� ������ ���� �������� ������ �����Ͽ����ϴ�.'
			End
			Else
			Begin
				Select	@ls_error	= '11',
					@ls_errortext	= '���ؼ� ������ ���� �������� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
				GoTo Proc_Exit
			End


			-- �ϴ� tprdnokb �� ���Ӱ� ���ؼ������� �߰�����...
			Insert	tprdnokb
			Select	KBNo		= @ls_kbno,
				KBReleaseDate	= @ls_kbreleasedate,
				KBReleaseSeq	= @li_kbreleaseseq_new,
				NoKBGubun	= 'U',
				PrdDate		= @ls_releasedate,
				AreaCode	= @ls_areacode,
				DivisionCode	= @ls_divisioncode,
				WorkCenter	= @ls_workcenter,
				LineCode	= @ls_linecode,
				ItemCode	= @ls_itemcode,
				RackQty		= @li_releasekbqty,
				CodeGroup	= 'PUNOBSERVE',
				CodeID		= '02',
				ReasonDesc	= Null,
				LastEmp		= 'Y',--@ps_empcode,
				LastDate		= @ldt_nowtime
			
			If @@Error = 0
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '���ؼ����� �̷�  ���̺� ���ؼ������� ���Ӱ� �߰��Ͽ����ϴ�.'
			End
			Else
			Begin
				Select	@ls_error	= '11',
					@ls_errortext	= '���ؼ����� �̷�  ���̺� ���ؼ������� ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
				GoTo Proc_Exit
			End

			-- �����ؼ����� �߰�����.
			If Not exists (	Select	*
					From	tprdratekb
					Where	PrdDate		= @ls_releasedate	And
						AreaCode	= @ls_areacode		And
						DivisionCode	= @ls_divisioncode	And
						WorkCenter	= @ls_workcenter		And
						LineCode	= @ls_linecode		And
						ItemCode	= @ls_itemcode)
			Begin
				Insert	tprdratekb
				Select	PrdDate		= @ls_releasedate,
					AreaCode	= @ls_areacode,
					DivisionCode	= @ls_divisioncode,
					WorkCenter	= @ls_workcenter,
					LineCode	= @ls_linecode,
					ItemCode	= @ls_itemcode,
					ReleaseCount	= 1,
					PrdCount	= 0,
					LastEmp		= 'Y',
					LastDate		= @ldt_nowtime
			End
			Else
			Begin
				Update	tprdratekb
				Set	ReleaseCount	= IsNull(ReleaseCount, 0) + 1,
					LastEmp		= 'Y',
					LastDate		= @ldt_nowtime
				Where	PrdDate		= @ls_releasedate	And
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
			
			
			-- ����ȭ�ؼ����� �߰�����.
			If Not exists (	Select	*
					From	tprdratecycle
					Where	PrdDate		= @ls_releasedate	And
						AreaCode	= @ls_areacode		And
						DivisionCode	= @ls_divisioncode	And
						WorkCenter	= @ls_workcenter		And
						LineCode	= @ls_linecode		And
						ItemCode	= @ls_itemcode)
			Begin
				Insert	tprdratecycle
				Select	PrdDate		= @ls_releasedate,
					AreaCode	= @ls_areacode,
					DivisionCode	= @ls_divisioncode,
					WorkCenter	= @ls_workcenter,
					LineCode	= @ls_linecode,
					ItemCode	= @ls_itemcode,
					ReleaseCount	= 1,
					HitCount		= 0,
					LastEmp		= 'Y',
					LastDate		= @ldt_nowtime
			End
			Else
			Begin
				Update	tprdratecycle
				Set	ReleaseCount	= IsNull(ReleaseCount, 0) + 1,
					LastEmp		= 'Y',
					LastDate		= @ldt_nowtime
				Where	PrdDate		= @ls_releasedate	And
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
			-- tkbhis �� ������ Seq �� ��������.
			Update	tkbhis
			Set	KBStatusCode		= 'F',
				ReleaseGubun		= 'U',
				PrdFlag			= 'N',
				LastLoopFlag		= 'N',
				LastEmp			= 'Y',
				LastDate			= @ldt_nowtime
			Where	KBNo			= @ls_kbno
			And	KBReleaseDate		= @ls_kbreleasedate
			And	KBReleaseSeq		= @li_kbreleaseseq
--			And	LastLoopFlag		= 'Y'
			
			If @@Error = 0
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '���� �̷��� ������ ������ �����Ͽ����ϴ�.'
			End
			Else
			Begin
				Select	@ls_error	= '11',
					@ls_errortext	= '���� �̷��� ������ ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
				GoTo Proc_Exit
			End

			-- tkbhis �� ���ο� ���ø� �߰�����
			Insert	tkbhis
			Select	KBNo			= A.KBNo,
				KBReleaseDate		= @ls_releasedate,
				KBReleaseSeq		= @li_kbreleaseseq_new,
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
				RackQty			= A.RackQty,
				CurrentQty		= A.RackQty,
				ReleaseGubun		= 'T',
				ReleaseCancel		= Null,
				PrdFlag			= 'N',
				InspectGubun		= A.InspectGubun,
				InspectFlag		= Null,
				StockGubun		= A.StockGubun,
				StockCancel		= Null,
				PlanDate		= @ls_releasedate,
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
				LastEmp			= 'Y',
				LastDate			= @ldt_nowtime
			From	tkb	A
			Where	A.KBNo		= @ls_kbno
			
			If @@Error = 0
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '���� �̷��� ���Ӱ� �߰��Ͽ����ϴ�.'
			End
			Else
			Begin
				Select	@ls_error	= '11',
					@ls_errortext	= '���� �̷��� ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
				GoTo Proc_Exit
			End
			
			-- tkb �� ��������.
			Update	tkb
			Set	KBStatusCode		= 'A',
				RackQty			= A.RackQty,
				CurrentQty		= A.RackQty,
				ReleaseGubun		= 'T',
				ReleaseCancel		= Null,
				PrdFlag			= 'N',
				InspectGubun		= A.InspectGubun,
				InspectFlag		= Null,
				StockGubun		= A.StockGubun,
				StockCancel		= Null,
				PlanDate		= @ls_releasedate,
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
				LastEmp			= 'Y',
				LastDate			= @ldt_nowtime
			From	tkb	A
			Where	A.KBNo		= @ls_kbno
			
			If @@Error = 0
			Begin
				Select	@ls_error	= '00',
					@ls_errortext	= '���� ���� ������ �����Ͽ����ϴ�.'
			End
			Else
			Begin
				Select	@ls_error	= '11',
					@ls_errortext	= '���� ���� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
				GoTo Proc_Exit
			End

			Delete	#tmp_kb
			Where	KBNo		= @ls_kbno
			And	KBReleaseDate	= @ls_kbreleasedate
			And	KBReleaseSeq	= @li_kbreleaseseq
		End	

		Delete	#tmp_cycleorder
		Where	CycleOrder	= @li_cycleorder_old
		And	ItemCode	= @ls_itemcode	
	End

	Delete	#tmp_line
	Where	AreaCode	= @ls_areacode
	And	DivisionCode	= @ls_divisioncode
	And	WorkCenter	= @ls_workcenter
	And	LineCode	= @ls_linecode

	Select @li_linecount	= @li_linecount - 1
End

--select * from #tmp_line
--select * from #tmp_release

Proc_Exit:

If @ls_error = '00'
Begin
	Commit Tran
End
Else
Begin
	RollBack Tran
End

Select	@ls_error,
	@ls_errortext

Drop Table #tmp_release
Drop Table #tmp_line
Drop Table #tmp_cycleorder
Drop Table #tmp_kb

Return

End		-- Procedure End
Go
