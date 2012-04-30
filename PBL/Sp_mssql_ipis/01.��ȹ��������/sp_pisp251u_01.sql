/*
	File Name	: sp_pisp251u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp251u_01
	Description	: ���� ���� ��ȯ - ��ȯ ������ ���� ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp251u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp251u_01]
GO

/*
Execute sp_pisp251u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '511513',
	@ps_kbactivegubun	= 'A'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp251u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_kbactivegubun	char(1)
As
Begin

Select	AreaCode		= A.AreaCode,		-- �����ڵ�
	DivisionCode		= A.DivisionCode,		-- ����
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,		-- ����
	ItemCode		= A.ItemCode,		-- ǰ��
	KBNo			= A.KBNo,
	KBStatusCode		= A.KBStatusCode,
	KBStatusCodeName	= Case	When A.KBActiveGubun = 'A'	Then
						Case	When A.KBStatusCode = 'A'	Then '����'
							When A.KBStatusCode = 'B'	Then '����'
							When A.KBStatusCode = 'C'	Then '�Ϸ�'
							When A.KBStatusCode = 'D'	Then '�԰�'
							When A.KBStatusCode = 'E'	Then '����'
							When A.KBStatusCode = 'F'	Then 'ȸ��'
						Else ''
						End
				   Else ''
				   End,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
					Else '�ӽ�'
				   End,
	RackQty			= A.RackQty
From	tkb	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= @ps_itemcode		And
	A.KBActiveGubun	= @ps_kbactivegubun

Return

End		-- Procedure End
Go
