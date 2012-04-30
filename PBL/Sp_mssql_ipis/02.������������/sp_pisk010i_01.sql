/*
	File Name	: sp_pisk010i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk010i_01
	Description	: 간판 번호 List
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk010i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk010i_01]
GO

/*
Execute sp_pisk010i_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tkb where itemcode = '0000001'
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisk010i_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

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
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산품'
					When A.ProductGubun = 'R'	Then '후보충생산품'
					Else 'OEM생산품'
				   End,
	ReleaseCount		= Case	When IsNull(B.KBStatusCode, 'X')	= 'A'	Then Count(IsNull(B.KBNo, 0))
					Else 0
				   End,
	StartCount		= Case	When IsNull(B.KBStatusCode, 'X')	= 'B'	Then Count(IsNull(B.KBNo, 0))
					Else 0
				   End,
	EndCount		= Case	When IsNull(B.KBStatusCode, 'X')	= 'C'	Then Count(IsNull(B.KBNo, 0))
					Else 0
				   End,
	StockCount		= Case	When IsNull(B.KBStatusCode, 'X')	= 'D'	Then Count(IsNull(B.KBNo, 0))
					Else 0
				   End,
	ShipCount		= Case	When IsNull(B.KBStatusCode, 'X')	= 'E'	Then Count(IsNull(B.KBNo, 0))
					Else 0
				   End,
	BackCount		= Case	When IsNull(B.KBStatusCode, 'X')	= 'F'	Then Count(IsNull(B.KBNo, 0))
					Else 0
				   End,
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A,
	tkb		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode	
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName,A.ItemCode, A.ItemName,
	A.ModelID, A.ProductGubun, B.KBStatusCode, A.SortOrder

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
	ProductGubunName	= A.ProductGubunName,
	KBCount			= Sum(A.ReleaseCount) + Sum(A.StartCount) + Sum(A.EndCount) +
					Sum(A.StockCount) + Sum(A.ShipCount) + Sum(A.BackCount),
	ReleaseCount		= Sum(A.ReleaseCount),
	StartCount		= Sum(A.StartCount),
	EndCount		= Sum(A.EndCount),
	StockCount		= Sum(A.StockCount),
	ShipCount		= Sum(A.ShipCount),
	BackCount		= Sum(A.BackCount),
	SortOrder		= A.SortOrder
From	#tmp_item	A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName,
	A.ModelID, A.ProductGubun, A.ProductGubunName

drop table #tmp_item

Return

End		-- Procedure End
Go
