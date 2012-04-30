/*
	File Name	: sp_pisc_select_item_kb_model.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_item_kb_model
	Description	: ��ǰ �ڵ� DDDW�� ���� ��ȸ
			  ���Ǹ����Ϳ��� �𵨱����� ��ǰ �ڵ带 ��ȸ�Ѵ�.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_productgroup, @ps_modelgroup, @ps_itemcode
	Use Table	: tmstmodelgroup
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_item_kb_model]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_item_kb_model]
GO

/*
Execute sp_pisc_select_item_kb_model 'J', '%', '%', '%', '%'
select * from tmstmodelgroup

*/

Create Procedure sp_pisc_select_item_kb_model
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_productgroup	varchar(2),	-- ��ǰ��
	@ps_modelgroup		varchar(3),	-- �𵨱�
	@ps_itemcode		varchar(12)	-- ǰ��
	
As
Begin

Select	AreaCode		= A.AreaCode,			-- �����ڵ�
	AreaName		= A.AreaName,			-- ������
	DivisionCode		= A.DivisionCode,			-- �����ڵ�
	DivisionName		= A.DivisionName,			-- �����
	ProductGroup		= A.ProductGroup,		-- ��ǰ��
	ProductGroupName	= A.ProductGroupName,		-- ��ǰ����
	ModelGroup		= A.ModelGroup,			-- �𵨱�
	ModelGroupName	= A.ModelGroupName,		-- �𵨱���
	ItemCode		= A.ItemCode,			-- ǰ��
	ItemName		= A.ItemName,			-- ǰ��
	ModelID			= A.ModelID,			-- �ĺ� ID
	DisplayName		= A.ItemCode + '(' + A.ItemName + ')'
  From	vmstkb_model	A
 Where	A.AreaCode		= @ps_areacode			And
	A.DivisionCode		Like @ps_divisioncode		And
	A.ProductGroup		Like @ps_productgroup		And
	A.ModelGroup		Like @ps_modelgroup		And
	A.ItemCode		Like @ps_itemcode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName, A.ModelGroup, A.ModelGroupName,
	A.ItemCode, A.ItemName, A.ModelID

Return

End		-- Procedure End
Go
