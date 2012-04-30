/*
	File Name	: sp_pisp002u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp002u_02
	Description	:���� �����ȹ ��� - ��ȹ�й����� ���� ��ǰ�� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 10
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp002u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_02]
GO


/*
Execute sp_pisp002u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%'

select * from tmstmodelgroup

*/


Create Procedure sp_pisp002u_02
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
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- ����
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	ItemCode		= A.ItemCode,			-- ǰ��
	ItemName		= A.ItemName,			-- ǰ��
	ModelID			= A.ModelID,			-- �ĺ� ID
	MainLineGubun		= Case When A.MainLineGubun = 'M' Then '�ֶ���' Else '�ζ���' End,	-- �ֶ��� ����
	DivideRate		= A.DivideRate
  From	vmstkb_line	A,
	tmstmodel	B
 Where	B.AreaCode		= @ps_areacode		And
	B.DivisionCode		= @ps_divisioncode	And
	B.ProductGroup		Like @ps_productgroup	And
	B.ModelGroup		Like @ps_modelgroup	And
	B.ItemCode		Like @ps_itemcode	And
	B.AreaCode		= A.AreaCode		And
	B.DivisionCode		= A.DivisionCode		And
	B.ItemCode		= A.ItemCode		And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,  A.ItemCode, A.ItemName, A.ModelID,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,A.MainLineGubun, A.DivideRate
Order By A.AreaCode, A.DivisionCode, A.ItemCode, A.WorkCenter, A.LineCode

Return

End		-- Procedure End
Go
