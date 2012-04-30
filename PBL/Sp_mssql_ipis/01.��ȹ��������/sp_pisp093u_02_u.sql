/*
	File Name	: sp_pisp093u_02_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp093u_02_u
	Description	: ������ ����/�԰� ��� - ���� ���ν���
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
	@ps_prddate		char(10),	-- ���ؼ����� �����
	@ps_lotno		char(6),		-- LotNo.
	@ps_kbno		varchar(11),	-- �����ϴ� ���� ��ȣ
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

	@ls_inspectgubun	char(1),		-- �԰�˻� ���� ����
	@ls_stockgubun		char(1),		-- �԰��� ���� ����

	@ls_timeapplyfrom	char(10),	-- �ð��뺰 �ð� �ڵ� ���� ������
	@ls_timecode		char(5),		-- �ð��뺰 �ð� �ڵ�

	@ls_releasegubun	char(1),		-- ���� ���� ����
	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�

	@li_kbreleaseseq		int,

	@li_cycleorder		int,
	@li_releaseorder		int,

	@ls_prdkbitemcode	varchar(12),	-- tprdkb ���� ���
	@li_prdorder		int,		-- tprdkb ���� ���
	@li_prdkborder		int,		-- tprdkb ���� ���

	@li_seqno		int,		-- MIS Interface �� ���� Seq No.

	@ls_error		char(2),
	@ls_errortext		varchar(100)

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

-- �԰� �˻� �� �԰� ��� ���θ� ������.
Select	@ls_stockgubun		= StockGubun
From	tmstkb
Where	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	WorkCenter	= @ls_workcenter		And
	LineCode	= @ls_linecode		And
	ItemCode	= @ls_itemcode		And
	PrdStopGubun	= 'N'

-- �԰� �˻�ǰ������ ������.
-- ���������ϴ� ��¥�� ��ȸ����...�ֳ� �� ���� �԰�˻�ǰ���� ����� �� �����ϱ�...����
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


-- �ð��뺰 �ڵ带 ������...������ �� ó�� �ð���� ó������
Select	@ls_timeapplyfrom	= ApplyFrom,
	@ls_timecode		= TimeCode
From	tmsttime
Where	AreaCode	= @ls_areacode		And
	DivisionCode	= @ls_divisioncode	And
	ApplyFrom	<= @ps_prddate		And
	ApplyTo		> @ps_prddate		And
	TimeOrder	= 1

-- �������� ������ ������
Select	@ls_releasegubun	= 'N',
	@ldt_nowtime		= GetDate()

-- ���ǹ�ȣ�� ���� ���� ������ ������.
Select	@li_kbreleaseseq		= Max(A.KBReleaseSeq)
From	tkbhis	A
Where	A.KBNo			= @ps_kbno		And
	A.KBReleaseDate		= @ps_prddate		--And
--	A.LastLoopFlag		= 'Y'

If @li_kbreleaseseq = 0 Or @li_kbreleaseseq Is Null
	Select	@li_kbreleaseseq		= 1
Else
	Select	@li_kbreleaseseq		= @li_kbreleaseseq + 1

-- �������ø� �߰�����
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

If @li_cycleorder = 0 Or @li_cycleorder Is Null	-- ������ ���õ� ���� ������..���Ӱ� CycleOrder �߰�..
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
	-- ���..�̹� ������ ���õ� ���� �����ϳ�..
	-- �̰�� ������ ���õ� cycleorder �� ���Ǹ� �߰�����..
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

-- ��..tplanrelease �� Insert ����.
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
		@ls_errortext	= '�������� ���̺� ������ ������ ����/�԰� ����� �߰��Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�������� ���̺� ������ ������ ����/�԰� ����� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkb �� tkbhis ���̺� ������ ��������
If @ls_inspectgubun = 'N' And @ls_stockgubun = 'N'	-- �׳� �԰���� ó���ϴ� �ѵ�...
Begin
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
			@ls_errortext	= '���� ���� ������ �����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '���� ���� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	EndEnd
Else	-- �԰� �˻� �Ǵ� �԰� ����� �����ϴ� ��ǰ, �Ϸ������ ó������.
Begin
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
			@ls_errortext	= '���� �̷��� ������ ������ �����Ͽ����ϴ�. - �԰�˻�'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '���� �̷��� ������ ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�. - �԰�˻�'
		GoTo Proc_Exit
	End
	
	-- tkbhis �� ���ο� ���ø� �߰�����
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
			@ls_errortext	= '���� �̷��� ���Ӱ� �߰��Ͽ����ϴ�. - �԰�˻�'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '���� �̷��� ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�. - �԰�˻�'
		GoTo Proc_Exit
	End
	
	-- tkb �� ��������.
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
			@ls_errortext	= '���� ���� ������ �����Ͽ����ϴ�. - �԰�˻�'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '���� ���� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�. - �԰�˻�'
		GoTo Proc_Exit
	EndEnd

-- �ϴ� tprdnokb �� ���Ӱ� ������ ������ �߰�����...
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
		@ls_errortext	= '������ �̷�  ���̺� �������� ���Ӱ� �߰��Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '������ �̷�  ���̺� �������� ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End


-- ��������� �߰�����
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
		@ls_errortext	= '������ ����/�԰� ����� ���� �Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ���� ���� �̷��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End
*/

-- ������ʹ� �԰�� �ٷ� ���� �ѵ鸸 ó������.
If @ls_inspectgubun = 'N' And @ls_stockgubun = 'N'	-- �԰� �ϴ� �ѵ�
Begin
	-- Lot No. �� �԰� �̷��� ó������
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
			@ls_errortext	= '������ ����/�԰� ����� ���� �Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End

	-- MIS Interface�� ���� tstock_interface ó��
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
			@ls_errortext	= '������ ����/�԰� ����� ���� �Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= 'MIS Interface ������ ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End
End
Else
Begin
	-- Lot No. �� �԰� �̷��� ó������
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
			@ls_errortext	= '������ ����/�԰� ����� ���� �Ͽ����ϴ�.'
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
