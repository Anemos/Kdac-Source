/*
	File Name	: sp_pisp220i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp220i_01
	Description	: ���� ������ �̷� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 02
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp220i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp220i_01]
GO

/*
Execute sp_pisp220i_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tqcontainqcitem

dbcc opentran

*/

Create Procedure sp_pisp220i_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Declare	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_applydate_close	char(10)	-- �������� ����� ��������

-- �ϴ� �������� ������
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ps_areacode,
	@ps_divisioncode	= @ps_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output


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
	InspectGubun		= Case	When B.ItemCode Is Null	Then 'N'
					Else 'Y'
				   End
Into	#tmp_kb
From	vmstkb_line	A,
	tqcontainqcitem	B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
--	A.PrdStopGubun	Like @ps_prdstopgubun	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode		And
	B.ApplyDateFrom	<= @ls_applydate_close	And
	B.ApplyDateTo	> @ls_applydate_close
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, B.ItemCode


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
	ApplyFrom		= B.ApplyFrom,
	ApplyTo			= B.ApplyTo,
	ModelID			= B.ModelID,
	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '��ȹ����'
					When B.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	RackQty			= B.RackQty,
	PrdStopGubun		= B.PrdStopGubun,	-- ���� �ߴ� ����
	PrdStopGubunName	= Case	When B.PrdStopGubun = 'N'	Then '������'
					Else '�����ߴ�'
				   End,
	MainLineGubun		= B.MainLineGubun,	-- �ֶ��� ����
	MainLineGubunName	= Case	When B.MainLineGubun = 'M'	Then '�ֶ���'
					Else '�ζ���'
				   End,
	DivideRate		= B.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= B.SafetyInvQty,		-- �������
	InspectGubun		= A.InspectGubun,
	InspectGubunName	= Case	When A.InspectGubun = 'N' Then '���˻��԰�ǰ'
					Else '�԰�˻�ǰ'
				   End,
	StockGubun		= B.StockGubun,		-- �԰� ��� ����
	StockGubunName	= Case	When B.StockGubun = 'Y'	Then 'â���԰���'
					When B.StockGubun = 'N'	Then '�����԰���'
					When B.StockGubun = 'B'	Then '����ȸ��'
					Else ''
				   End,
	SortOrder		= B.SortOrder
From	#tmp_kb		A,
	tmstkbhis	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, B.SortOrder, A.ItemCode, A.ItemName,
	B.ApplyFrom, B.ApplyTo, B.ModelID,
	B.ProductGubun, B.RackQty, B.PrdStopGubun, B.MainLineGubun, B.DivideRate,
	B.SafetyInvQty, A.InspectGubun, B.StockGubun
Order By A.AreaCode, A.DivisionCode, A.WorkCenter,	A.LineCode, A.ItemCode, B.ApplyTo Desc


Drop Table #tmp_kb

Return

End		-- Procedure End
Go
