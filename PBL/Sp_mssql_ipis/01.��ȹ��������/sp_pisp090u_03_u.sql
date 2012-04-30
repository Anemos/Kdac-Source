/*
	File Name	: sp_pisp090u_03_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp090u_03_u
	Description	: ������ �������� ��Ű�� ��..���� - ���� ���ν���
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
	@ps_option		varchar(10),	-- �����ϴ� ����..�ݵ�� �Ʒ��� ����..
	@ps_releasedate		char(10),	-- ��������
	@pi_cycleorder		int,		-- �����ϴ� CycleOrder
	@ps_kbno		varchar(11),	-- �����ϴ� ���� ��ȣ
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

	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_applydate_close	char(10),	-- �������� ����� ��������
	@ls_releasegubun	char(1),		-- ���� ���� ����

	@li_kbreleaseseq		int,		-- �ִ� ���� ����

	@ls_inspectgubun	char(1),		-- �԰�˻� ����

	@li_count		int,

	@ls_error		char(2),
	@ls_errortext		varchar(100)
/*
@ps_option	= 'UPDATE'	�̰�� @pi_cycleorder ���
	=> @pi_cycleorde ���� �������ð� �ʵ� ���� ū ReleaseOrder �� ������ ����� �ȴ�.
@ps_option	= 'INSERT'	�̰�� @pi_cycleorder ����ϸ� ����...����
	=> �̰� �񶧸���..
	    ���� ����ȭ��ȹ�� ���µ� �������ø� �߰��ϴ� �Ŵ�..
	    �� ��� �ش� ��ǰ�� ���� ū CycleOrder �� ã�Ƴ��� ���⿡ ������ ���Ӱ� �����ؾ��Ѵ�.
	    ����, ���Ͽ� ���ø� �߰��ϴ� ��쿡�� ���ϻ����ȹ �� ���� ����ȭ��ȹ�� �������Ѿ� �Ѵ�...����
	    �׷���, ���Ͽ� ���ø� �߰��ϴ� ��쿡�� ��ȹ�� �ǵ��� �ȵȴ�...����
*/

-- �ϴ� ���� ���� ������ ��������
Select	@ls_areacode	= AreaCode,
	@ls_divisioncode	= DivisionCode,
	@ls_workcenter	= WorkCenter,
	@ls_linecode	= LineCode,
	@ls_itemcode	= ItemCode,
	@ls_tempgubun	= TempGubun,
	@li_rackqty	= RackQty
From	tkb
Where	KBNo	= @ps_kbno

-- �ϴ� �������� ������
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ls_areacode,
	@ps_divisioncode	= @ls_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output

-- �����Ͽ� ���� �������� ������ ������
If @ls_applydate_close = @ps_releasedate
	Select	@ls_releasegubun	= 'T'
Else
	Select	@ls_releasegubun	= 'Y'

-- �԰� �˻�ǰ������ ������.
-- ���������ϴ� ��¥�� ��ȸ����...�ֳ� �� ���� �԰�˻�ǰ���� ����� �� �����ϱ�...����
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


-- ���ǹ�ȣ�� ���� ���� ������ ������.
Select	@li_kbreleaseseq		= Max(A.KBReleaseSeq)
From	tkbhis	A
Where	A.KBNo			= @ps_kbno		And
	A.KBReleaseDate		= @ps_releasedate	--And
--	A.LastLoopFlag		= 'Y'

If @li_kbreleaseseq = 0 Or @li_kbreleaseseq Is Null
	Select	@li_kbreleaseseq		= 1
Else
	Select	@li_kbreleaseseq		= @li_kbreleaseseq + 1

-- Option�� ���� �������� ������ ������
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
			A.ReleaseGubun	= 'C'			And	-- ���ؼ� ������ �׳� �ٽ� ���� ����
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
			A.ReleaseGubun	= 'C'			And	-- ���ؼ� ������ �׳� �ٽ� ���� ����
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
		-- ����...�������ð� �� ���� ���µ�...
		-- �ӽð����� ��쿡�� ���ô�� ���ǵ� ���� ������ ������ ��ܾ� �Ѵ�...
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
		@ls_errortext	= '���ü����� �̻��մϴ�.'
	GoTo Proc_Exit
End

--select @li_cycleorder, @li_releaseorder

--Begin Tran

-- ��..���̺��� ��������.
If @ps_option = 'UPDATE'
Begin
	-- �ϴ� tplanrelease �� �����ϱ�..
	Update	tplanrelease
	Set	KBNo		= @ps_kbno,
		KBReleaseDate	= @ps_releasedate,
		KBReleaseSeq	= @li_kbreleaseseq,
		ReleaseGubun	= 'Y',			-- ��ȹ�� �ִ� ���̹Ƿ� ������ 'Y'
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
			@ls_errortext	= '�������� ���̺� ������ �������ø� �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�������� ���̺� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End
End
Else
Begin

	-- �߰��ϴ� ���̹Ƿ�..�߰��� �� ���� �ڿ� ������ �ѵ��� ����� ����
	-- ���ü����� �ϳ��� �ø���..�ӽð����� �����ϴµ�..���԰����� �������ð� �ʵ��� ��� ����...�߰��� ����...
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
			@ls_errortext	= '���ô�� ���� ������ ���ü����� �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�����ô�� ���� ������ ���ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	-- ����...���� ������ ��� 
	If @ls_releasegubun = 'Y'
	Begin
		-- �ϴ� tplanrelease �� ���Ӱ� �߰�����...
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
				@ls_errortext	= '�������� ���̺� ������ �������ø� ���Ӱ� �߰��Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '�������� ���̺� ������ ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
				@ls_errortext	= '���� ���� �߰��� ���� ���ϻ����ȹ�� �����Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '���� ���� �߰��� ���� ���ϻ����ȹ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End
	End
	Else	-- ���� ����
	Begin
		-- �ϴ� tplanrelease �� ���Ӱ� �߰�����...
		-- ������� ������, ��ȹ������ �߰�����...�� ���ü������濡�� �񶧷����ϱ�..
		-- �ٽ� �߰����� ����..���ü��� ������ �� PlanKBCount ���� �������� ����...Select Count(KBNo) �� �������..�ú�
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
				@ls_errortext	= '�������� ���̺� ������ �������ø� ���Ӱ� �߰��Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= '�������� ���̺� ������ ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End
	End
End

-- �����ؼ����� �߰�����.
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
Set	LastLoopFlag		= 'N',
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo			= @ps_kbno		And
--		KBReleaseDate		= @ps_releasedate	And
	LastLoopFlag		= 'Y'

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
		@ls_errortext	= '���� ���� ������ �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ���� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
