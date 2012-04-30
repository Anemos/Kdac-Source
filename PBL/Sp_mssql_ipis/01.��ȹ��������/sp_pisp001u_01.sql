/*
	File Name	: sp_pisp001u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp001u_01
	Description	: ��ȹ�й����� ���� ��ǰ ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 10
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp001u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp001u_01]
GO


/*
Execute sp_pisp001u_01 'D', 'A', '%'
select * from tmstmodelgroup

*/


Create Procedure sp_pisp001u_01
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
--	@ps_workcenter		varchar(5),	-- ��ǰ��
--	@ps_linecode		varchar(1),	-- �𵨱�
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
  From	vmstkb_line	A
 Where	A.AreaCode		= @ps_areacode			And
	A.DivisionCode		Like @ps_divisioncode		And
--	A.WorkCenter		Like @ps_workcenter		And
--	A.LineCode		Like @ps_linecode		And
	A.ItemCode		Like @ps_itemcode		And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,A.MainLineGubun, A.DivideRate

Return

End		-- Procedure End
Go
