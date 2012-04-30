/*
	File Name	: sp_pisp006u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp006u_01
	Description	: ���� ������ ���� ���� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp006u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp006u_01]
GO

/*
Execute sp_pisp006u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '001',
	@ps_tempgubun		= 'T'

select * from tmstkb where itemcode = '001'
select * from tkb where itemcode = '001'

delete tkb where itemcode = '511513' and tempgubun = 'T'

Update	tmstline
Set	MaxCycleGubun	= 'N',
	CycleCount	= 1
*/

Create Procedure sp_pisp006u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_tempgubun		char(1)
As
Begin


Select	AreaCode		= A.AreaCode,		-- �����ڵ�
	DivisionCode		= A.DivisionCode,		-- ����
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,		-- ����
	ItemCode		= A.ItemCode,		-- ǰ��
	ItemName		= C.ItemName,		-- ǰ��
	ModelID			= A.ModelID,		-- ���ȣ
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '��ȹ����'
					When A.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	KBNo			= B.KBNo,
	RackQty			= Case	When B.KBNo Is Null	Then A.RackQty
					Else B.RackQty
				   End,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	KBCount			= Case	When B.KBNo Is Null	Then 0
					Else 1
				   End,
	KBStatusCode		= B.KBStatusCode,
	KBStatusCodeName	= Case	When B.KBActiveGubun = 'A'	Then
						Case	When B.KBStatusCode = 'A'	Then '����'
							When B.KBStatusCode = 'B'	Then '����'
							When B.KBStatusCode = 'C'	Then '�Ϸ�'
							When B.KBStatusCode = 'D'	Then '�԰�'
							When B.KBStatusCode = 'E'	Then '����'
							When b.KBStatusCode = 'F'	Then 'ȸ��'
						Else ''
						End
				   Else ''
				   End
From	tmstkb		A,
	tkb		B,
	tmstitem		C
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= @ps_itemcode		And
	A.PrdStopGubun	= 'N'			And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode		And
	A.ItemCode	*= C.ItemCode		And
	B.TempGubun	= @ps_tempgubun

Return

End		-- Procedure End
Go
