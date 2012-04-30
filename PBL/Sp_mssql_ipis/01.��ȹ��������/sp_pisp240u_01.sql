/*
	File Name	: sp_pisp240u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp240u_01
	Description	: 간판 번호 관리
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 07
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp240u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp240u_01]
GO

/*
Execute sp_pisp240u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'--,
--	@ps_itemcode		= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp240u_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)
--	@ps_itemcode		varchar(12)

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
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	MainLineGubun		= A.MainLineGubun,	-- 주라인 구분
	DivideRate		= A.DivideRate,		-- 계획분배율
	SafetyInvQty		= A.SafetyInvQty,		-- 안전재고
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
--	A.ItemCode	Like @ps_itemcode	And
	A.PrdStopGubun	= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

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
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	RackQty			= A.RackQty,
	NormalKBCount		= Case	When B.TempGubun = 'N'	Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
					Else 0
				   End,
	NormalPrintCount		= Case	When B.TempGubun = 'N'
					Then
						Case When B.PrintCount > 0
							Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
							Else 0
						End
					Else 0
				   End,
	TempKBCount		= Case	When B.TempGubun = 'T'	Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
					Else 0
				   End,
	TempPrintCount		= Case	When B.TempGubun = 'T'
					Then
						Case When B.PrintCount > 0
							Then IsNull(Count(IsNull(B.KBNo, 0)), 0)
							Else 0
						End
					Else 0
				   End,
	MainLineGubun		= A.MainLineGubun,	-- 주라인 구분
	DivideRate		= A.DivideRate,		-- 계획분배율
	SafetyInvQty		= A.SafetyInvQty,		-- 안전재고
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
Into	#tmp_kb
From	#tmp_item	A,
	tkb		B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN, B.TempGubun,B.PrintCount

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
	ApplyFrom		= A.ApplyFrom,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	RackQty			= A.RackQty,
	NormalKBCount		= IsNull(Sum(A.NormalKBCount), 0),
	NormalPrintCount		= IsNull(Sum(A.NormalPrintCount), 0),
	TempKBCount		= IsNull(Sum(A.TempKBCount), 0),
	TempPrintCount		= IsNull(Sum(A.TempPrintCount), 0),
	MainLineGubun		= A.MainLineGubun,	-- 주라인 구분
	MainLineGubunName	= Case	When A.MainLineGubun = 'M'	Then '주라인'
					Else '부라인'
				   End,
	DivideRate		= A.DivideRate,		-- 계획분배율
	SafetyInvQty		= A.SafetyInvQty,		-- 안전재고
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	SortOrder		= A.SortOrder
From	#tmp_kb	A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ApplyFrom, A.ProductGubun, A.RackQty,
	A.MainLineGubun, A.DivideRate, A.SafetyInvQty, A.KBFactor, A.SafetyFactor,
	A.NormalKBSN, A.TempKBSN

Drop Table #tmp_item
Drop Table #tmp_kb

Return

End		-- Procedure End
Go
