/*
	File Name	: sp_pisp230u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp230u_01
	Description	: ���� ���� � �ż� ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 02
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp230u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp230u_01]
GO

/*
Execute sp_pisp230u_01
	@ps_planmonth		= '2002.09',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp230u_01
	@ps_planmonth		char(7),		-- �����
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)
--	@ps_itemcode		varchar(12)

As
Begin

-- vmstkb_line ���� ������ ��
-- ��ȸ������ ��ǰ�� ������.
Select	PlanMonth		= @ps_planmonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
--	A.ItemCode	Like @ps_itemcode	And
	A.PrdStopGubun	= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

-- ���� ���� �ż� ������ ������.
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	KBCount			= Case	When B.TempGubun = 'N'	Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
					Else 0
				   End,
	PrintCount		= Case	When B.TempGubun = 'N'
					Then
						Case When B.PrintCount > 0
							Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
							Else 0
						End
					Else 0
				   End,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_kb_temp
From	#tmp_item	A,
	tkb		B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.PlanMonth, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN, B.TempGubun,B.PrintCount

Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	KBCount			= IsNull(Sum(A.KBCount), 0),
	PrintCount		= IsNull(Sum(A.PrintCount), 0),
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_kb
From	#tmp_kb_temp	A
Group By A.PlanMonth, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

-- �����ȹ�� ������.
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	ChangeQty		= IsNull(Sum(IsNull(B.ChangeQty, 0)), 0),
	KBCount			= A.KBCount,
	PrintCount		= A.PrintCount,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_planqty
From	#tmp_kb	A,
	tplanday		B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode		And
--	A.PlanMonth + '.__'Like B.PlanDate
	B.PlanDate	Like @ps_planmonth + '.__'
Group By A.PlanMonth, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty, A.KBCount, A.PrintCount,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

-- �۾��ϼ��� ������.
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	ChangeQty		= A.ChangeQty,
	WorkCount		= Count(B.ApplyDate),
	KBCount			= A.KBCount,
	PrintCount		= A.PrintCount,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_calendarwork
From	#tmp_planqty	A,
	tcalendarwork	B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.PlanMonth	*= B.ApplyMonth		And
--	B.ApplyMonth	= @ps_planmonth		And
	B.WorkGubun	= 'W'
Group By A.PlanMonth, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty, A.ChangeQty, A.KBCount, A.PrintCount,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

-- ���� �߻� ���� �ż��� ������.
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	ChangeQty		= A.ChangeQty,
	WorkCount		= A.WorkCount,
	PlanKBCount		= Ceiling(Case	When A.ProductGubun = 'P'
						Then Ceiling((Sum(A.ChangeQty)*1.0) / A.RackQty ) + Ceiling((A.SafetyInvQty*1.0) / A.RackQty)
					Else
						Case When A.WorkCount = 0 Or A.WorkCount Is Null
							Then 0
							Else (Sum(A.ChangeQty)*1.0) / (A.RackQty * A.WorkCount) + Ceiling(3.5 + A.SafetyFactor*1.0)
						End
				  End),
	KBCount			= A.KBCount,
	PrintCount		= A.PrintCount,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_result
From	#tmp_calendarwork	A
Group By A.PlanMonth, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty, A.ChangeQty, A.WorkCount, A.KBCount, A.PrintCount,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

-- ����� ������.
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,		-- �����ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- ����
	DivisionName		= A.DivisionName,	-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= A.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '��ȹ����'
					When A.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	RackQty			= A.RackQty,
	ChangeQty		= A.ChangeQty,
	WorkCount		= A.WorkCount,
	PlanKBCount		= A.PlanKBCount,
	KBCount			= A.KBCount,
	CreateKBCount		= A.PlanKBCount - A.KBCount,
	PrintCount		= A.PrintCount,
	CreatePrintCount		= A.PlanKBCount - A.PrintCount,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	MainLineGubunName	= Case	When A.MainLineGubun = 'M'	Then '�ֶ���'
					Else '�ζ���'
				   End,
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
From	#tmp_result	A
Group By A.PlanMonth, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty, A.ChangeQty, A.WorkCount, A.PlanKBCount, A.KBCount, A.PrintCount,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor, A.NormalKBSN, A.TempKBSN

Drop Table #tmp_item
Drop Table #tmp_kb_temp
Drop Table #tmp_kb
Drop Table #tmp_planqty
Drop Table #tmp_calendarwork
Drop Table #tmp_result


Return

End		-- Procedure End
Go
