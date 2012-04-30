/*
	File Name	: sp_pisp092u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp092u_01
	Description	: 미준수 간판 등록 - 등록 가능 간판 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 29
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp092u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp092u_01]
GO

/*
Execute sp_pisp092u_01
	@ps_plandate		= '2002.09.25',
	@ps_areacode		= 'D',
	@ps_divisioncode	= '%',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp092u_01
	@ps_plandate		varchar(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)
As
Begin

Select	CycleOrder		= A.CycleOrder,
	ReleaseOrder		= A.ReleaseOrder,
	ItemCode		= A.ItemCode,
	ItemName		= B.ItemName,
	ModelID			= B.ModelID,
	KBNo			= A.KBNo,
	KBReleaseDate		= A.KBReleaseDate,
	KBReleaseSeq		= A.KBReleaseSeq,
	RackQty			= A.ReleaseKBQty,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '정규'
					Else '임시'
				   End,
	ReleaseGubun		= A.ReleaseGubun,
	ReleaseGubunName	= Case	When A.ReleaseGubun	= 'N'	Then '무간판생산'
					When A.ReleaseGubun	= 'Y'	Then '정상지시'
					When A.ReleaseGubun	= 'T'	Then '긴급지시'
					When A.ReleaseGubun	= 'U'	Then '미준수'
					Else '지시대기'
				   End,
	PrdFlag			= A.PrdFlag,
	PrdFlagName		= Case	When A.PrdFlag		= 'E'	Then '생산완료'
					When A.PrdFlag		= 'N'	Then '지시상태'
					Else '지시대기'
				   End,
	CheckFlag		= 'N'
From	tplanrelease	A,
	vmstkb_line	B,
	tkbhis		C
Where	A.PlanDate	= @ps_plandate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode		And
	A.ReleaseGubun	In ('Y', 'T')		And
	A.PrdFlag	In ('N')
--	A.ReleaseGubun	In ('Y', 'T', 'N')
Group By A.CycleOrder, A.ReleaseOrder, A.ItemCode, B.ItemName, B.ModelID,
	A.KBNo, A.KBReleaseDate, A.KBReleaseSeq, A.ReleaseKBQty,
	A.TempGubun, A.ReleaseGubun, A.PrdFlag

Return

End		-- Procedure End

GO
