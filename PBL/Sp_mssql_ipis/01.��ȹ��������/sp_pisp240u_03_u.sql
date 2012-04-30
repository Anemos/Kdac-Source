/*
	File Name	: sp_pisp240u_03_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp240u_03_u
	Description	: ���� ��ȣ ���� - ���ǹ�ȣ ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 07
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp240u_03_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp240u_03_u]
GO

/*
Execute sp_pisp240u_03_u
	@ps_normalkbsn		= 'DA010001001',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '511513',
	@ps_applyfrom		= '2002.10.04',
	@pi_rackqty		= 50,
	@ps_empcode		= 'IPIS'

select * from tmstkb
select * from tkb where kbno = 'DA010001001'
select * from tkbhis

delete tkbhis where workcenter = '4201'

update tmstkb
set normalkbsn = 'DA010003000'
where normalkbsn = 'DA0100030B4'

DA01000107A
DA010002000
DA0100030B4


dbcc opentran

*/

Create Procedure sp_pisp240u_03_u
	@ps_kbno		varchar(11),
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_applyfrom		varchar(10),
	@ps_tempgubun		char(1),
	@ps_asgubun		char(1),
	@pi_rackqty		int,
	@ps_empcode		varchar(6)

As
Begin

Declare	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_error		char(2),
	@ls_errortext		varchar(100)

Select	@ldt_nowtime	= GetDate()

--Begin Tran

-- tkb �߰�
Insert	tkb
Select	KBNo			= @ps_kbno,
	AreaCode		= @ps_areacode,
	DivisionCode		= @ps_divisioncode,
	WorkCenter		= @ps_workcenter,
	LineCode		= @ps_linecode,
	ItemCode		= @ps_itemcode,
	ApplyFrom		= @ps_applyfrom,
	KBStatusCode		= 'F',
	TempGubun		= @ps_tempgubun,
	ASGubun		= @ps_asgubun,
	KBActiveGubun		= 'S',
	KBCreateTime		= @ldt_nowtime,
	KBPrintTime		= Null,
	PrintCount		= 0,
	RackQty			= @pi_rackqty,
	CurrentQty		= @pi_rackqty,
	ReleaseGubun		= Null,
	ReleaseCancel		= Null,
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
	InvGubunFlag		= 'N',
	KBReleaseTime		= Null,
	KBStartTime		= Null,
	KBEndTime		= Null,
	KBInspectTime		= Null,
	KBStockTime		= Null,
	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '���� ��ȣ�� ���Ӱ� �߰��Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ��ȣ�� ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End


-- tkbhis �߰�
Insert	tkbhis
Select	KBNo			= @ps_kbno,
	KBReleaseDate		= '0000.00.00',
	KBReleaseSeq		= 0,
	LastLoopFlag		= 'Y',
	AreaCode		= @ps_areacode,
	DivisionCode		= @ps_divisioncode,
	WorkCenter		= @ps_workcenter,
	LineCode		= @ps_linecode,
	ItemCode		= @ps_itemcode,
	ApplyFrom		= @ps_applyfrom,
	KBStatusCode		= 'F',
	TempGubun		= @ps_tempgubun,
	ASGubun		= @ps_asgubun,
	KBActiveGubun		= 'S',
	KBCreateTime		= @ldt_nowtime,
	KBPrintTime		= Null,
	PrintCount		= 0,
	RackQty			= @pi_rackqty,
	CurrentQty		= @pi_rackqty,
	ReleaseGubun		= Null,
	ReleaseCancel		= Null,
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
	InvGubunFlag		= 'N',
	KBReleaseTime		= Null,
	KBStartTime		= Null,
	KBEndTime		= Null,
	KBInspectTime		= Null,
	KBStockTime		= Null,
	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime

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

If @ps_tempgubun = 'N'
Begin
	Update	tmstkb
	Set	NormalKBSN	= @ps_kbno,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	From	tmstkb	A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode
End
Else
Begin
	Update	tmstkb
	Set	TempKBSN	= @ps_kbno,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	From	tmstkb	A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode
End

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '������ ���Ӱ� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� �����Ϳ� ������ ���ǹ�ȣ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

If @ps_tempgubun = 'N'
Begin
	Update	tmstkbhis
	Set	NormalKBSN	= @ps_kbno,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	From	tmstkbhis	A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode		And
		A.ApplyTo	= '9999.12.31'
End
Else
Begin
	Update	tmstkbhis
	Set	TempKBSN	= @ps_kbno,
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	From	tmstkbhis	A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode		And
		A.ApplyTo	= '9999.12.31'
End

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '������ ���Ӱ� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ������ �̷¿� ������ ���ǹ�ȣ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
