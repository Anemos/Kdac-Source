/*
	File Name	: sp_pisp250u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp250u_01
	Description	: 간판 상태 정보
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp250u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp250u_01]
GO

/*
Execute sp_pisp250u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_kbactivegubun	= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp250u_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_kbactivegubun	char(1)

As
Begin

-- vmstkb_line 에서 시작한 것
-- 조회조건의 제품을 구하자.
Select	AreaCode		= A.AreaCode,		-- 지역코드
	AreaName		= A.AreaName,		-- 지역 명
	DivisionCode		= A.DivisionCode,		-- 공장
	DivisionName		= A.DivisionName,	-- 공장명
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center 명
	LineCode		= A.LineCode,		-- 라인
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,		-- 품번
	ItemName		= A.ItemName,		-- 품명
	ModelID			= A.ModelID,		-- 배번호
	ProductGubun		= A.ProductGubun,
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.SortOrder

-- 간판 발행 매수 정보를 구하자.
Select	AreaCode		= A.AreaCode,		-- 지역코드
	AreaName		= A.AreaName,		-- 지역 명
	DivisionCode		= A.DivisionCode,		-- 공장
	DivisionName		= A.DivisionName,	-- 공장명
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center 명
	LineCode		= A.LineCode,		-- 라인
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,		-- 품번
	ItemName		= A.ItemName,		-- 품명
	ModelID			= A.ModelID,		-- 배번호
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	KBNo			= B.KBNo,
	TempGubun		= B.TempGubun,
	TempGubunName	= Case	When B.TempGubun = 'N'	Then '정규'
					Else '임시'
				   End,
	RackQty			= B.RackQty,
	ApplyFrom		= B.ApplyFrom,
	KBActiveGubun		= B.KBActiveGubun,
	KBActiveGubunName	= Case	When B.KBActiveGubun = 'A'	Then 'Active'
					Else 'Sleeping'
				   End,
	KBStatusCode		= B.KBStatusCode,
	KBStatusCodeName	= Case	When B.KBActiveGubun = 'A'	Then
						Case	When B.KBStatusCode = 'A'	Then '지시'
							When B.KBStatusCode = 'B'	Then '착수'
							When B.KBStatusCode = 'C'	Then '완료'
							When B.KBStatusCode = 'D'	Then '입고'
							When B.KBStatusCode = 'E'	Then '출하'
							When B.KBStatusCode = 'F'	Then '회수'
						Else ''
						End
				   Else ''
				   End,
	SortOrder		= A.SortOrder
From	#tmp_item	A,
	tkb		B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode		And
	B.KBActiveGubun	Like @ps_kbactivegubun
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, B.KBNo, B.TempGubun, B.RackQty, B.ApplyFrom, B.KBActiveGubun, B.KBStatusCode


Drop Table #tmp_item

Return

End		-- Procedure End
Go
