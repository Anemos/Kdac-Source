/*
	File Name	: sp_pisp091u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp091u_01
	Description	: �������� ��� - ���� ��ȣ ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 26
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp091u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp091u_01]
GO


/*
Execute sp_pisp091u_01
	@ps_plandate		= '2002.12.06',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '421C',
	@ps_linecode		= 'A',
	@pi_cycleorder		= 1

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp091u_01
	@ps_plandate		varchar(10),	-- ��ȹ�� ('YYYY.MM,DD')
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@pi_cycleorder		int
As
Begin

Select	CycleOrder		= A.CycleOrder,
	ReleaseOrder		= A.ReleaseOrder,
	KBNo			= A.KBNo,
	KBReleaseDate		= A.KBReleaseDate,
	KBReleaseSeq		= A.KBReleaseSeq,
	RackQty			= A.ReleaseKBQty,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
					Else '�ӽ�'
				   End,
	ReleaseGubun		= A.ReleaseGubun,
	ReleaseGubunName	= Case	When A.ReleaseGubun	= 'N'	Then '�����ǻ���'
					When A.ReleaseGubun	= 'Y'	Then '��������'
					When A.ReleaseGubun	= 'T'	Then '�������'
					When A.ReleaseGubun	= 'U'	Then '���ؼ�'
					Else '���ô��'
				   End,
	PrdFlag			= A.PrdFlag,
	PrdFlagName		= Case	When A.PrdFlag		= 'E'	Then '����Ϸ�'
					When A.PrdFlag		= 'N'	Then '���û���'
					Else '���ô��'
				   End,
	CheckFlag		= 'N'
From	tplanrelease	A,
	tkbhis		B
Where	A.PlanDate	= @ps_plandate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.CycleOrder	= @pi_cycleorder		And
	A.PrdFlag	> 'C'
--	A.ReleaseGubun	In ('Y', 'T', 'N', 'U')	--And
--	A.KBNo		= B.KBNo		And
--	A.KBReleaseDate	= B.KBReleaseDate	And
--	A.KBReleaseSeq	= B.KBReleaseSeq	And
--	B.KBStatusCode	= 'A'
Group By A.CycleOrder, A.ReleaseOrder, A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.ReleaseKBQty,
	A.TempGubun, A.ReleaseGubun, A.PrdFlag

Return

End		-- Procedure End

GO
