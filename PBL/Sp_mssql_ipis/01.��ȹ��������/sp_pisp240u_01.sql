/*
	File Name	: sp_pisp240u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp240u_01
	Description	: ���� ��ȣ ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 07
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp240u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp240u_01]
GO

/*
Execute sp_pisp240u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'--,
--	@ps_itemcode		= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp240u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)
--	@ps_itemcode		varchar(12)

As
Begin

-- vmstkb_line ���� ������ ��
-- ��ȸ������ ��ǰ�� ������.
Select	AreaCode		= A.AreaCode,		-- �����ڵ�
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
	A.DivisionCode	= @ps_divisioncode	And
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
Select	AreaCode		= A.AreaCode,		-- �����ڵ�
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
	NormalKBCount		= Case	When B.TempGubun = 'N'	Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
					Else 0
				   End,
	NormalPrintCount		= Case	When B.TempGubun = 'N'
					Then
						Case When B.PrintCount > 0
							Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
							Else 0
						End
					Else 0
				   End,
	TempKBCount		= Case	When B.TempGubun = 'T'	Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
					Else 0
				   End,
	TempPrintCount		= Case	When B.TempGubun = 'T'
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
Into	#tmp_kb
From	#tmp_item	A,
	tkb		B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN, B.TempGubun,B.PrintCount

Select	AreaCode		= A.AreaCode,		-- �����ڵ�
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
	NormalKBCount		= IsNull(Sum(A.NormalKBCount), 0),
	NormalPrintCount		= IsNull(Sum(A.NormalPrintCount), 0),
	TempKBCount		= IsNull(Sum(A.TempKBCount), 0),
	TempPrintCount		= IsNull(Sum(A.TempPrintCount), 0),
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
From	#tmp_kb	A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

Drop Table #tmp_item
Drop Table #tmp_kb

Return

End		-- Procedure End
Go
