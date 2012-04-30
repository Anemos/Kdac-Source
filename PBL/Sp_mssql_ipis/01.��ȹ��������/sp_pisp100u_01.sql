/*
	File Name	: sp_pisp100i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp100i_01
	Description	: 미준수간판 회수 이력 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 29
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp100i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp100i_01]
GO

/*
Execute sp_pisp100i_01
	@ps_fromdate		= '2002.09.25',
	@ps_todate		= '2002.10.25',
	@ps_areacode		= 'D',
	@ps_divisioncode	= '%',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_codegroup		= '%',
	@ps_codeid		= '%'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp100i_01
	@ps_fromdate		char(10),	-- 조회 시작일 ('YYYY.MM,DD')
	@ps_todate		char(10),	-- 조회 종료일 ('YYYY.MM,DD')
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
	AreaName		= B.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= B.WorkCenterName,
	LineCode		= A.LineCode,
	LineShoftName		= B.LineShortName,
	LineFullName		= B.LineFullName,
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
	SortOrder		= B.SortOrder
From	tprdnokb		A,
	vmstkb_line	B,
	tmstcode	C
Where	A.NoKBGubun	= 'U'			And	-- 무간판 등록인지 미준수 등록 인지 여부(N:무간판,U:미준수)
	(A.PrdDate	Between @ps_fromdate and @ps_todate)	And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.CodeGroup	Like @ps_codegroup	And
	A.CodeID	Like @ps_codeid		And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode		And
	A.CodeGroup	*= C.CodeGroup		And
	A.CodeID	*= C.CodeID
Group By A.PrdDate, A.AreaCode, B.AreaName, A.DivisionCode, B.DivisionName, A.WorkCenter, B.WorkCenterName, 
	A.LineCode, B.LineShortName, B.LineFullName,
	B.SortOrder, A.ItemCode, B.ItemName, B.ModelID, B.ProductGubun,
	A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.RackQty,
	A.CodeGroup, C.CodeGroupName, A.CodeID, C.CodeName
Order By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode



Return

End		-- Procedure End
Go
