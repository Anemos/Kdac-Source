/*
	File Name	: sp_pisp241u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp241u_01
	Description	: ���� ��ȣ ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp241u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp241u_01]
GO

/*
Execute sp_pisp241u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_printoption		= 'ALL'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp241u_01
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_printoption		varchar(10)

As
Begin

/*
	Select	KBNo		= A.KBNo,
		TempGubun	= A.TempGubun,
		TempGubunName = Case	When A.TempGubun = 'N'	Then '����'
						Else '�ӽ�'
					   End,
		RackQty		= A.RackQty,
		PrintCount	= A.PrintCount,
		KBPrintTime	= A.KBPrintTime
	From	tkb		A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode		And
		A.PrintCount	>= 0
	Group By A.KBNo, A.TempGubun, A.RackQty, A.PrintCount, A.KBPrintTime
	Order By A.PrintCount, A.KBNo
	Return
*/
-- ��ü ���� ��ȸ
If @ps_printoption = 'ALL'
Begin
	Select	KBNo			= A.KBNo,
		TempGubun		= A.TempGubun,
		TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
						Else '�ӽ�'
					   End,
		RackQty			= A.RackQty,
		PrintCount		= A.PrintCount,
		KBPrintTime		= A.KBPrintTime
	From	tkb		A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode		And
		A.PrintCount	>= 0
	Group By A.KBNo, A.TempGubun, A.RackQty, A.PrintCount, A.KBPrintTime
	Order By A.PrintCount, A.KBNo
	Return
End

-- �� ���� ���� ��ȸ
If @ps_printoption = 'NONPRINT'
Begin
	Select	KBNo			= A.KBNo,
		TempGubun		= A.TempGubun,
		TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
						Else '�ӽ�'
					   End,
		RackQty			= A.RackQty,
		PrintCount		= A.PrintCount,
		KBPrintTime		= A.KBPrintTime
	From	tkb		A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode		And
		A.PrintCount	= 0
	Group By A.KBNo, A.TempGubun, A.RackQty, A.PrintCount, A.KBPrintTime
	Order By A.PrintCount, A.KBNo
	Return
End

-- ����� ���� �ִ� ���� ��ȸ
If @ps_printoption = 'PRINT'
Begin
	Select	KBNo			= A.KBNo,
		TempGubun		= A.TempGubun,
		TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
						Else '�ӽ�'
					   End,
		RackQty			= A.RackQty,
		PrintCount		= A.PrintCount,
		KBPrintTime		= A.KBPrintTime
	From	tkb		A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= @ps_itemcode		And
		A.PrintCount	> 0
	Group By A.KBNo, A.TempGubun, A.RackQty, A.PrintCount, A.KBPrintTime
	Order By A.PrintCount, A.KBNo
	Return
End

Return

End		-- Procedure End
Go
