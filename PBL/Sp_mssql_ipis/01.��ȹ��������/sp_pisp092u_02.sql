/*
	File Name	: sp_pisp092u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp092u_02
	Description	: 미준수 간판 등록의 이력 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 29
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp092u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp092u_02]
GO

/*
Execute sp_pisp092u_02
	@ps_prddate		= '2002.09.25',
	@ps_areacode		= 'D',
	@ps_divisioncode	= '%',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_codegroup		= 'PNOKBGUBUN',
	@ps_codeid		= '01'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp092u_02
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
	CodeGroup		= A.CodeGroup,
	CodeGroupName		= C.CodeGroupName,
	CodeID			= A.CodeID,
	CodeName		= C.CodeName,
	CheckFlag		= 'N',
	SortOrder		= B.SortOrder
From	tprdnokb		A,
	vmstkb_line	B,
	tmstcode	C
Where	A.NoKBGubun	= 'U'			And	-- 무간판 등록인지 미준수 등록 인지 여부(N:무간판,U:미준수)
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
	A.CodeGroup	*= C.CodeGroup		And
	A.CodeID	*= C.CodeID
Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode,
	B.SortOrder, A.ItemCode, B.ItemName, B.ModelID, B.ProductGubun,
	A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.RackQty,
	A.CodeGroup, C.CodeGroupName, A.CodeID, C.CodeName



Return

End		-- Procedure End
Go
