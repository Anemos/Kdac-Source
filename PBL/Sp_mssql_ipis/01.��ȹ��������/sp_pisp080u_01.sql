/*
	File Name	: sp_pisp080u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp080u_01
	Description	: ����ȭ ���� ��ȹ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp080u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp080u_01]
GO

/*
Execute sp_pisp080u_01
	@ps_plandate		= '2002.12.11',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '422I',
	@ps_linecode		= 'B'

select * from tplanrelease
*/

Create Procedure sp_pisp080u_01
	@ps_plandate		Char(10),	-- ��ȹ�� ('YYYY.MM,DD')
	@ps_areacode		Char(1),		-- ���� �ڵ�
	@ps_divisioncode	Char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)
As
Begin


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '��ȹ����'
					When A.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	RackQty			= A.RackQty
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	CycleOrder		= B.CycleOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,

	KBCount			= Count(B.KBNo),

	PlanKBCount		= Sum(Case When B.ReleaseGubun = 'T'
						Then	B.ReleaseKBCount
						Else	B.PlanKBCount
						End),
	PlanKBQty		= Sum(Case When B.ReleaseGubun = 'T'
						Then	B.ReleaseKBQty
						Else	B.PlanKBQty
						End),
	NormalKBCount		= Case When B.TempGubun = 'N' Then Sum(Case When B.ReleaseGubun = 'T'
										Then	B.ReleaseKBCount
										Else	B.PlanKBCount
									End)
					 Else 0 End,
	NormalKBQty		= Case When B.TempGubun = 'N' Then Sum(Case When B.ReleaseGubun = 'T'
										Then	B.ReleaseKBQty
										Else	B.PlanKBQty
									End)
					 Else 0 End,
	TempKBCount		= Case When B.TempGubun = 'T' Then Sum(Case When B.ReleaseGubun = 'T'
										Then	B.ReleaseKBCount
										Else	B.PlanKBCount
									End)
					 Else 0 End,
	TempKBQty		= Case When B.TempGubun = 'T' Then Sum(Case When B.ReleaseGubun = 'T'
										Then	B.ReleaseKBQty
										Else	B.PlanKBQty
									End)
					 Else 0 End
Into	#tmp_release
From	#tmp_item	A,
	tplanrelease	B
Where	B.PlanDate	= @ps_plandate		And
	B.AreaCode	= A.AreaCode		And
	B.DivisionCode	= A.DivisionCode		And
	B.WorkCenter	= A.WorkCenter		And
	B.LineCode	= A.LineCode		And
	B.ItemCode	= A.ItemCode	--	And
--	B.ReleaseGubun	In ('C', 'Y', 'T', 'N')
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, B.CycleOrder,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, B.TempGubun

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	CycleOrder		= A.CycleOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,

	KBCount			= Sum(A.KBCount),

	PlanKBCount		= Sum(A.PlanKBCount),
	PlanKBQty		= Sum(A.PlanKBQty),
	NormalKBCount		= Sum(A.NormalKBCount),
	NormalKBQty		= Sum(A.NormalKBQty),
	TempKBCount		= Sum(A.TempKBCount),
	TempKBQty		= Sum(A.TempKBQty)
From	#tmp_release		A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.CycleOrder,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty

Drop Table #tmp_item
Drop Table #tmp_release

Return

End		-- Procedure End
Go
