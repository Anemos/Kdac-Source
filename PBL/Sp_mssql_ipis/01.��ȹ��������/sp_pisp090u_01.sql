/*
	File Name	: sp_pisp090u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp090u_01
	Description	: 조립 지시
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp090u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp090u_01]
GO

/*
Execute sp_pisp090u_01
	@ps_plandate		= '2002.11.04',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp090u_01
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
	RackQty			= A.RackQty
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	CycleOrder		= B.CycleOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,

	KBCount			= Count(B.KBNo),

	PlanNormalKBCount	= Case When B.TempGubun = 'N' Then Sum(B.PlanKBCount) Else 0 End,
	PlanNormalKBQty		= Case When B.TempGubun = 'N' Then Sum(B.PlanKBQty) Else 0 End,
	PlanTempKBCount	= Case When B.TempGubun = 'T' Then Sum(B.PlanKBCount) Else 0 End,
	PlanTempKBQty		= Case When B.TempGubun = 'T' Then Sum(B.PlanKBQty) Else 0 End,

	ReleaseNormalKBCount	= Case When B.TempGubun = 'N' Then Sum(B.ReleaseKBCount) Else 0 End,
	ReleaseNormalKBQty	= Case When B.TempGubun = 'N' Then Sum(B.ReleaseKBQty) Else 0 End,
	ReleaseTempKBCount	= Case When B.TempGubun = 'T' Then Sum(B.ReleaseKBCount) Else 0 End,
	ReleaseTempKBQty	= Case When B.TempGubun = 'T' Then Sum(B.ReleaseKBQty) Else 0 End,

	PrdNormalKBCount	= Case When B.TempGubun = 'N' And B.PrdFlag = 'E' Then Sum(B.ReleaseKBCount) Else 0 End,
	PrdNormalKBQty		= Case When B.TempGubun = 'N' And B.PrdFlag = 'E'  Then Sum(B.ReleaseKBQty) Else 0 End,
	PrdTempKBCount		= Case When B.TempGubun = 'T' And B.PrdFlag = 'E'  Then Sum(B.ReleaseKBCount) Else 0 End,
	PrdTempKBQty		= Case When B.TempGubun = 'T' And B.PrdFlag = 'E'  Then Sum(B.ReleaseKBQty) Else 0 End

Into	#tmp_release
From	#tmp_item		A,
	tplanrelease		B
Where	B.PlanDate	= @ps_plandate	And
	B.AreaCode	= A.AreaCode		And
	B.DivisionCode	= A.DivisionCode		And
	B.WorkCenter	= A.WorkCenter		And
	B.LineCode	= A.LineCode		And
	B.ItemCode	= A.ItemCode	--	And
--	B.ReleaseGubun	In ('C', 'Y', 'T', 'N')
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, B.CycleOrder,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, B.TempGubun, B.PrdFlag

--select * from #tmp_release

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	CycleOrder		= A.CycleOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,

	KBCount			= Sum(A.KBCount),

	PlanNormalKBCount	= Sum(A.PlanNormalKBCount),
	PlanNormalKBQty		= Sum(A.PlanNormalKBQty),
	PlanTempKBCount	= Sum(A.PlanTempKBCount),
	PlanTempKBQty		= Sum(A.PlanTempKBQty),

	ReleaseNormalKBCount	= Sum(A.ReleaseNormalKBCount),
	ReleaseNormalKBQty	= Sum(A.ReleaseNormalKBQty),
	ReleaseTempKBCount	= Sum(A.ReleaseTempKBCount),
	ReleaseTempKBQty	= Sum(A.ReleaseTempKBQty),

	PrdNormalKBCount	= Sum(A.PrdNormalKBCount),
	PrdNormalKBQty		= Sum(A.PrdNormalKBQty),
	PrdTempKBCount		= Sum(A.PrdTempKBCount),
	PrdTempKBQty		= Sum(A.PrdTempKBQty)
From	#tmp_release		A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.CycleOrder,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty

Drop Table #tmp_item
Drop Table #tmp_release

Return

End		-- Procedure End
Go
