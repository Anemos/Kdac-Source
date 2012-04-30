/*
	File Name	: sp_pisp093u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp093u_01
	Description	: ������ ����/�԰� ����� �̷� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 29
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp093u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp093u_01]
GO

/*
Execute sp_pisp093u_01
	@ps_prddate		= '2002.10.01',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_codegroup		= 'PNOKBGUBUN',
	@ps_codeid		= '01'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp093u_01
	@ps_prddate		char(10),	-- ��ȹ�� ('YYYY.MM,DD')
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_codegroup		varchar(10),
	@ps_codeid		varchar(10)

As
Begin

Select	PrdDate			= A.PrdDate,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	WorkCenter		= A.WorkCenter,
	LineCode		= A.LineCode,
	ItemCode		= A.ItemCode,
	ItemName		= B.ItemName,
	ModelID			= B.ModelID,
	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '��ȹ����'
					When B.ProductGubun = 'R'	Then '�ĺ������'
					Else 'OEM����'
				   End,
	KBNo			= A.KBNo,
	KBReleaseDate		= A.KBReleaseDate,
	KBReleaseSeq		= A.KBReleaseSeq,
	RackQty			= A.RackQty,
	KBStatusCode		= C.KBStatusCode,
	KBStatusName		= Case	When C.KBStatusCode = 'A'	Then '��������'
					When C.KBStatusCode = 'B'	Then '��������'
					When C.KBStatusCode = 'C'	Then '�����Ϸ�'
					When C.KBStatusCode = 'D'	Then 'â���԰�'
					When C.KBStatusCode = 'E'	Then 'â������'
					Else 'ȸ��'
				   End,
	CodeGroup		= A.CodeGroup,
	CodeGroupName		= D.CodeGroupName,
	CodeID			= A.CodeID,
	CodeName		= D.CodeName,
	CheckFlag		= 'N',
	SortOrder		= B.SortOrder
From	tprdnokb		A,
	vmstkb_line	B,
	tkbhis		C,
	tmstcode	D
Where	A.NoKBGubun	= 'N'			And	-- ������ ������� ���ؼ� ��� ���� ����(N:������,U:���ؼ�)
	A.PrdDate	= @ps_prddate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode		And
	A.KBNo		= C.KBNo		And
	A.KBReleaseDate	= C.KBReleaseDate		And
	A.KBReleaseSeq	= C.KBReleaseSeq	And
	A.CodeGroup	*= D.CodeGroup		And
	A.CodeID	*= D.CodeID
Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode,
	B.SortOrder, A.ItemCode, B.ItemName, B.ModelID, B.ProductGubun,
	C.KBStatusCode, A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.RackQty,
	A.CodeGroup, D.CodeGroupName, A.CodeID, D.CodeName



Return

End		-- Procedure End
Go
