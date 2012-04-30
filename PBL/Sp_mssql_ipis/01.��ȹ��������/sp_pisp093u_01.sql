/*
	File Name	: sp_pisp093u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp093u_01
	Description	: 무간판 생산/입고 등록의 이력 조회
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
	@ps_prddate		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
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
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '계획생산'
					When B.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	KBNo			= A.KBNo,
	KBReleaseDate		= A.KBReleaseDate,
	KBReleaseSeq		= A.KBReleaseSeq,
	RackQty			= A.RackQty,
	KBStatusCode		= C.KBStatusCode,
	KBStatusName		= Case	When C.KBStatusCode = 'A'	Then '조립지시'
					When C.KBStatusCode = 'B'	Then '조립착수'
					When C.KBStatusCode = 'C'	Then '조립완료'
					When C.KBStatusCode = 'D'	Then '창고입고'
					When C.KBStatusCode = 'E'	Then '창고출하'
					Else '회수'
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
Where	A.NoKBGubun	= 'N'			And	-- 무간판 등록인지 미준수 등록 인지 여부(N:무간판,U:미준수)
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
