/*
	File Name	: sp_pisc_select_item_kb_line.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_item_kb_line
	Description	: ��ǰ �ڵ� DDDW�� ���� ��ȸ
			  ���Ǹ����Ϳ��� ���κ��� ��ǰ �ڵ带 ��ȸ�Ѵ�.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_workcenter, @ps_linecode, @ps_itemcode
	Use Table	: tmstmodelgroup
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_item_kb_line]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_item_kb_line]
GO

/*
Execute sp_pisc_select_item_kb_line 'J', 'S', '%', '%', '%'
select * from tmstmodelgroup

*/

Create Procedure sp_pisc_select_item_kb_line
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_workcenter		varchar(5),	-- ��ǰ��
	@ps_linecode		varchar(1),	-- �𵨱�
	@ps_itemcode		varchar(12)	-- ǰ��
	
As
Begin

Select	AreaCode		= A.AreaCode,			-- �����ڵ�
	AreaName		= A.AreaName,			-- ������
	DivisionCode		= A.DivisionCode,			-- �����ڵ�
	DivisionName		= A.DivisionName,			-- �����
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,			-- ǰ��
	ItemName		= A.ItemName,			-- ǰ��
	ModelID			= A.ModelID,			-- �ĺ� ID
	DisplayName		= A.ItemCode + '(' + A.ItemName + ')'
  From	vmstkb_line	A
 Where	A.AreaCode		= @ps_areacode			And
	A.DivisionCode		Like @ps_divisioncode		And
	A.WorkCenter		Like @ps_workcenter		And
	A.LineCode		Like @ps_linecode		And
	A.ItemCode		Like @ps_itemcode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID
Order By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.SortOrder

Return

End		-- Procedure End
Go
