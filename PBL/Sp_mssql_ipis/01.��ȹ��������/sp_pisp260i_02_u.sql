/*
	File Name	: sp_pisp260i_02_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp260i_02_u
	Description	: ���� ���� - ���� �ʱ�ȭ ���� ���ν���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp260i_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp260i_02_u]
GO

/*
Execute sp_pisp260i_02_u
	@ps_kbno	= 'D',
	@ps_empcode	= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp260i_02_u
	@ps_kbno		varchar(11),
	@ps_empcode		varchar(6)

As
Begin

Declare	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_error		char(2),
	@ls_errortext		varchar(100)

Select	@ldt_nowtime	= GetDate()

-- tkb �� ��������.
Update	tkb
Set	KBStatusCode		= 'F',
--	CurrentQty		= RackQty,
--	ReleaseGubun		= Null,
--	ReleaseCancel		= Null,
--	PrdFlag			= Null,
--	InspectGubun		= Null,
--	InspectFlag		= Null,
--	StockGubun		= Null,
--	StockCancel		= Null,
--	PlanDate		= Null,
--	PrdDate			= Null,
--	PrdAreaCode		= Null,
--	PrdDivisionCode		= Null,
--	PrdWorkCenter		= Null,
--	PrdLineCode		= Null,
--	TimeApplyFrom		= Null,
--	TimeCode		= Null,
--	PrdQty			= 0,
--	LotNo			= Null,
--	StockDate		= Null,
--	StockQty			= 0,
--	ShipDate		= Null,
--	ShipQty			= 0,
--	KBReleaseTime		= Null,
--	KBStartTime		= Null,
--	KBEndTime		= Null,
--	KBInspectTime		= Null,
--	KBStockTime		= Null,
--	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '�������� �ʱ�ȭ�� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�������� �ʱ�ȭ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkbhis �� ��������
Update	tkbhis
Set	KBStatusCode		= 'F',
--	CurrentQty		= RackQty,
--	ReleaseGubun		= Null,
--	ReleaseCancel		= Null,
--	PrdFlag			= Null,
--	InspectGubun		= Null,
--	InspectFlag		= Null,
--	StockGubun		= Null,
--	StockCancel		= Null,
--	PlanDate		= Null,
--	PrdDate			= Null,
--	PrdAreaCode		= Null,
--	PrdDivisionCode		= Null,
--	PrdWorkCenter		= Null,
--	PrdLineCode		= Null,
--	TimeApplyFrom		= Null,
--	TimeCode		= Null,
--	PrdQty			= 0,
--	LotNo			= Null,
--	StockDate		= Null,
--	StockQty			= 0,
--	ShipDate		= Null,
--	ShipQty			= 0,
--	KBReleaseTime		= Null,
--	KBStartTime		= Null,
--	KBEndTime		= Null,
--	KBInspectTime		= Null,
--	KBStockTime		= Null,
--	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno		And
	LastLoopFlag	= 'Y'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '�������� �ʱ�ȭ�� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '�����̷����� �ʱ�ȭ�� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
