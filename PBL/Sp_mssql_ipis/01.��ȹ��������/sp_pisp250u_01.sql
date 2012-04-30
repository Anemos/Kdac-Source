/*
	File Name	: sp_pisp250u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp250u_01
	Description	: ���� ���� ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp250u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp250u_01]
GO

/*
Execute sp_pisp250u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_kbactivegubun	= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp250u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_kbactivegubun	char(1)

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
	ProductGubun		= A.ProductGubun,
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.SortOrder

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
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '��ȹ����'
					When A.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	KBNo			= B.KBNo,
	TempGubun		= B.TempGubun,
	TempGubunName	= Case	When B.TempGubun = 'N'	Then '����'
					Else '�ӽ�'
				   End,
	RackQty			= B.RackQty,
	ApplyFrom		= B.ApplyFrom,
	KBActiveGubun		= B.KBActiveGubun,
	KBActiveGubunName	= Case	When B.KBActiveGubun = 'A'	Then 'Active'
					Else 'Sleeping'
				   End,
	KBStatusCode		= B.KBStatusCode,
	KBStatusCodeName	= Case	When B.KBActiveGubun = 'A'	Then
						Case	When B.KBStatusCode = 'A'	Then '����'
							When B.KBStatusCode = 'B'	Then '����'
							When B.KBStatusCode = 'C'	Then '�Ϸ�'
							When B.KBStatusCode = 'D'	Then '�԰�'
							When B.KBStatusCode = 'E'	Then '����'
							When B.KBStatusCode = 'F'	Then 'ȸ��'
						Else ''
						End
				   Else ''
				   End,
	SortOrder		= A.SortOrder
From	#tmp_item	A,
	tkb		B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode		And
	B.KBActiveGubun	Like @ps_kbactivegubun
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, B.KBNo, B.TempGubun, B.RackQty, B.ApplyFrom, B.KBActiveGubun, B.KBStatusCode


Drop Table #tmp_item

Return

End		-- Procedure End
Go
