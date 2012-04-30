/*
	File Name	: sp_pisp090u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp090u_02
	Description	: ���� ���� ��ȣ ���� ��ȸ�ϴ� ��
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp090u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp090u_02]
GO


/*
Execute sp_pisp090u_02
	@ps_plandate		= '2002.09.25',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@pi_cycleorder		= 4

select * from tplanrelease
where prdflag = 'E'

select * from tkb

dbcc opentran

*/

Create Procedure sp_pisp090u_02
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
	KBReleaseTime		= B.KBReleaseTime,
	KBEndTime		= B.KBEndTime,
	KBStockTime		= B.KBStockTime,
	KBShipTime		= B.KBShipTime
From	tplanrelease	A,
	tkbhis		B
Where	A.PlanDate	= @ps_plandate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.CycleOrder	= @pi_cycleorder		And
	A.PrdFlag	> 'C'			And
--	A.ReleaseGubun	In ('Y', 'T', 'N', 'U')	And
	A.KBNo		= B.KBNo		And
	A.KBReleaseDate	= B.KBReleaseDate	And
	A.KBReleaseSeq	= B.KBReleaseSeq
Group By A.CycleOrder, A.ReleaseOrder, A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.ReleaseKBQty,
	A.TempGubun, A.ReleaseGubun, A.PrdFlag,
	B.KBReleaseTime, B.KBEndTime, B.KBStockTime, B.KBShipTime


Return

End		-- Procedure End

GO
