/*
	File Name	: sp_pisp093u_03_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp093u_03_u
	Description	: ������ ����/�԰� ��� ��� - ���� ���ν���
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
	@ps_prddate		char(10),	-- ���ؼ����� �����
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
	@ls_kbstatuscode	char(1),		-- ����Ϸ��� ������ ����
	@ls_lotno		varchar(6),	-- ����Ϸ��� ������ Lot No.
	@ls_timeapplyfrom	char(10),	-- �ð��뺰 �ð� �ڵ� ���� ������
	@ls_timecode		char(5),		-- �ð��뺰 �ð� �ڵ�

	@li_rackqty		int,

	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_applydate_close	char(10),	-- �������� ����� ��������

	@ls_canceldate		char(10),	-- �������� ����� ����ϴ� ����

	@li_cycleorder		int,
	@li_releaseorder		int,

	@li_seqno		int,
	@ls_misflag		char(1),

	@ls_error		char(2),
	@ls_errortext		varchar(100)


-- �ϴ� ���� ���� ������ ��������
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

-- �ϴ� �������� ������
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ls_areacode,
	@ps_divisioncode	= @ls_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output

-- �����Ͽ� ���� �������� ������ ������
If Left(@ls_applydate_close, 7) > Left(@ps_prddate, 7)
	Select	@ls_canceldate	= @ls_applydate_close,	-- �����޿� ����� �� ����ϴ� ��쿡�� ���η� ��� ó��
		@ls_misflag	= 'A'			-- �����ް� ������ ��� tstockcancel_interface
Else
	Select	@ls_canceldate	= @ps_prddate,		-- �̹��ް� �׳��ڷ� ��� ó��
		@ls_misflag	= 'D'			-- �̹��ް� ������ ��� tstock_interface

--Begin Tran

-- �����ϰ� �� ������..�ٸ� �ѵ��� ������ ������ ����� ����..
Select	@li_cycleorder	= CycleOrder,
	@li_releaseorder	= ReleaseOrder
From	tplanrelease
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
	ReleaseGubun	= 'N'			And
	PrdFlag		= 'E'

-- �������� ���̺��� ���� ����.
Delete	tplanrelease
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
	ReleaseGubun	= 'N'			And
	PrdFlag		= 'E'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '�������� ���̺� ������ ������ ����/�԰� ����� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�������� ���̺� ������ ������ ����/�԰� ����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- ������ ������ ���������� �ٲ�����
-- ���� �߰��� �� �ִ� ���� ����� ���
-- �׳Ѻ��� �ڿ� ���������� �ִ� �ѵ��� �ϳ��� �����..
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
		@ls_errortext	= '�ٸ� ������  ������ ����/�԰� ��� ������ �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�ٸ� ������  ������ ����/�԰� ��� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkb �� tkbhis ���̺� ������ ��������
-- tkbhis �� ��������
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
		@ls_errortext	= '���� �̷���  ������ ����/�԰� ����� ����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� �̷��� ������ ����/�԰� ����� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkb �� ��������.
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
		@ls_errortext	= '���� ������ ������ ����/�԰� ����� ����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ������ ������ ����/�԰� ����� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- �ϴ� tprdnokb �� ������ ������ ��������...
Delete	tprdnokb
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
	NoKBGubun	= 'N'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '������ �̷�  ���̺� �������� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '������ �̷�  ���̺� �������� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End


-- ��������� �߰�����
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
		@ls_errortext	= '��������� ��� �Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '��������� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- �ð��뺰 ��������� �߰�����
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
		@ls_errortext	= '�ð��뺰 ��������� ��� �Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�ð��뺰 ��������� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

/*
-- ���� ���� ���� ���̺� => tprdkb ����
Delete	tprdkb
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '������ ����/�԰� ����� ��� �Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ���� ���� �̷��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End
*/

-- ������ʹ� �԰�� �ѵ鸸 ó������.
If @ls_kbstatuscode = 'D'	-- �԰� �� ��
Begin
	-- Lot No. �� �԰� �̷��� ó������
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
			@ls_errortext	= '�԰��̷��� ��� �Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�԰��̷��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	-- ��� ó������
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
			@ls_errortext	= '������ ����/�԰� ����� ��� �Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	-- MIS Interface�� ���� �԰���� ó��
	If @ls_misflag = 'D'	-- �̹��޿� ����� �� ��� ó��
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
				@ls_errortext	= '������ ����/�԰� ����� ���� �Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= 'MIS Interface ������ ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End
	End
	Else			-- �����޿� ����� �� ���ó��
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
				@ls_errortext	= '������ ����/�԰� ����� ���� �Ͽ����ϴ�.'
		End
		Else
		Begin
			Select	@ls_error	= '11',
				@ls_errortext	= 'MIS Interface ������ ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
			GoTo Proc_Exit
		End
	End

End
Else
Begin
	-- Lot No. �� �԰� �̷��� ó������
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
			@ls_errortext	= '������ ����/�԰� ����� ��� �Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�԰��̷��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
