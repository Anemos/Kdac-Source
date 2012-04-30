/*
	File Name	: sp_pisp210u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp210u_01
	Description	: ���� ������ ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 02
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp210u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp210u_01]
GO

/*
Execute sp_pisp210u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_prdstopgubun	= '%'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp210u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_prdstopgubun	char(1)

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
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '��ȹ����'
					When A.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	RackQty			= A.RackQty,
	ApplyFrom		= A.ApplyFrom,
	PrdStopGubun		= A.PrdStopGubun,	-- ���� �ߴ� ����
	PrdStopGubunName	= Case	When A.PrdStopGubun = 'N'	Then '������'
					Else '�����ߴ�'
				   End,
	MainLineGubun		= A.MainLineGubun,	-- �ֶ��� ����
	MainLineGubunName	= Case	When A.MainLineGubun = 'M'	Then '�ֶ���'
					Else '�ζ���'
				   End,
	DivideRate		= A.DivideRate,		-- ��ȹ�й���
	SafetyInvQty		= A.SafetyInvQty,		-- �������
	InspectGubun		=  Case	When B.ItemCode Is Null	Then 'N'
					Else 'Y'
				   End,	-- �԰� �˻� ����
	InspectGubunName	= Case	When B.ItemCode Is Null	Then '���˻��԰�ǰ'
					Else '�԰�˻�ǰ'
				   End,
	StockGubun		= A.StockGubun,		-- �԰� ��� ����
	StockGubunName	= Case	When A.StockGubun = 'Y'	Then 'â���԰���'
					When A.StockGubun = 'N'	Then '�����԰���'
					When A.StockGubun = 'B'	Then '����ȸ��'
					Else ''
				   End,
	SortOrder		= A.SortOrder
From	vmstkb_line	A,
	tqcontainqcitem	B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.PrdStopGubun	Like @ps_prdstopgubun	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode		And
	B.ApplyDateFrom	<= @ls_applydate_close	And
	B.ApplyDateTo	> @ls_applydate_close
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.ApplyFrom, A.PrdStopGubun, A.MainLineGubun, A.DivideRate,
	A.SafetyInvQty, A.StockGubun, B.ItemCode
Order By A.AreaCode, A.DivisionCode, A.WorkCenter,	A.LineCode, A.SortOrder

Return

End		-- Procedure End
Go
