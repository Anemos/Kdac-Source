/*
	File Name	: sp_pisp070u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp070u_01
	Description	: 당일 생산 계획 - 간판매수.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp070u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp070u_01]
GO

/*
Execute sp_pisp070u_01
	@ps_plandate		= '2002.09.18',
	@ps_areacode		= 'D',
	@ps_divisioncode	= '%',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'
*/

Create Procedure sp_pisp070u_01
	@ps_plandate		Char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_areacode		Char(1),		-- 지역 코드
	@ps_divisioncode	Char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)
As
Begin


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	RackQty			= A.RackQty,
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.PrdStopGubun	= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.SortOrder


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SortOrder		= A.SortOrder,
	PlanKBCount		= Sum(B.NormalKBCount) + Sum(B.TempKBCount),
	PlanKBQty		= Sum(B.NormalKBQty) + Sum(B.TempKBQty),
	NormalKBCount		= Sum(B.NormalKBCount),
	NormalKBQty		= Sum(B.NormalKBQty),
	TempKBCount		= Sum(B.TempKBCount),
	TempKBQty		= Sum(B.TempKBQty)
From	#tmp_item	A,
	tplanday		B
Where	B.PlanDate	= @ps_plandate	And
	B.AreaCode	= A.AreaCode		And
	B.DivisionCode	= A.DivisionCode		And
	B.WorkCenter	= A.WorkCenter		And
	B.LineCode	= A.LineCode		And
	B.ItemCode	= A.ItemCode		And
	B.ChangeQty	> 0
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty

Drop Table #tmp_item

Return

End		-- Procedure End
Go
