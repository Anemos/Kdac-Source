/*
	File Name	: sp_pisp060u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp060u_01
	Description	: 일일 생산 계획
			  월간 생산 계획에서 평균화 시킨 일일 생산 계획을 조회하고,
			  직접 수량을 수정할 수 있다.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp060u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp060u_01]
GO

/*
Execute sp_pisp060u_01 '2002.09', 'D', 'A', '%', '%', '%'
*/

Create Procedure sp_pisp060u_01
	@ps_plandate		Char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_areacode		Char(1),		-- 지역 코드
	@ps_divisioncode	Char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),	-- 제품군
	@ps_linecode		varchar(1),	-- 모델군
	@ps_itemcode		varchar(12)
As
Begin

Declare	@ls_planmonth		char(7)

Select	@ls_planmonth	= Left(@ps_plandate, 7)


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
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= IsNull(B.InvQty, 0),
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A,
	tinv		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.SafetyInvQty, B.InvQty, A.SortOrder


Select	PlanDate		= B.PlanDate,
	AreaCode		= A.AreaCode,
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
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	SortOrder		= A.SortOrder,
	PlanQty			= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(B.ChangeQty, 0))
Into	#tmp_planqty
From	#tmp_item	A,
	tplanday		B
Where	B.PlanDate	Like @ls_planmonth + '.__'	And
	B.AreaCode	= A.AreaCode			And
	B.DivisionCode	= A.DivisionCode			And
	B.WorkCenter	= A.WorkCenter			And
	B.LineCode	= A.LineCode			And
	B.ItemCode	= A.ItemCode
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, A.SortOrder



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
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	SortOrder		= A.SortOrder,
	ChangeQty01		= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty02		= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty03		= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty04		= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty05		= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty06		= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty07		= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty08		= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty09		= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty10		= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty11		= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty12		= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty13		= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty14		= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty15		= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty16		= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty17		= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty18		= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty19		= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty20		= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty21		= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty22		= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty23		= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty24		= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty25		= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty26		= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty27		= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty28		= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty29		= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty30		= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty31		= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.ChangeQty, 0) Else 0 End
Into	#tmp_result
From	#tmp_planqty	A

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
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	SortOrder		= A.SortOrder,
	ChangeQtySum		= Sum(A.ChangeQty01) +  Sum(A.ChangeQty02) + Sum(A.ChangeQty03) +
				Sum(A.ChangeQty04) +  Sum(A.ChangeQty05) + Sum(A.ChangeQty06) +
				Sum(A.ChangeQty07) +  Sum(A.ChangeQty08) + Sum(A.ChangeQty09) +
				Sum(A.ChangeQty10) +  Sum(A.ChangeQty11) + Sum(A.ChangeQty12) +
				Sum(A.ChangeQty13) +  Sum(A.ChangeQty14) + Sum(A.ChangeQty15) +
				Sum(A.ChangeQty16) +  Sum(A.ChangeQty17) + Sum(A.ChangeQty18) +
				Sum(A.ChangeQty19) +  Sum(A.ChangeQty20) + Sum(A.ChangeQty21) +
				Sum(A.ChangeQty22) +  Sum(A.ChangeQty23) + Sum(A.ChangeQty24) +
				Sum(A.ChangeQty25) +  Sum(A.ChangeQty26) + Sum(A.ChangeQty27) +
				Sum(A.ChangeQty28) +  Sum(A.ChangeQty29) + Sum(A.ChangeQty30) +
				Sum(A.ChangeQty31),
	ChangeQty01		= Sum(A.ChangeQty01),
	ChangeQty02		= Sum(A.ChangeQty02),
	ChangeQty03		= Sum(A.ChangeQty03),
	ChangeQty04		= Sum(A.ChangeQty04),
	ChangeQty05		= Sum(A.ChangeQty05),
	ChangeQty06		= Sum(A.ChangeQty06),
	ChangeQty07		= Sum(A.ChangeQty07),
	ChangeQty08		= Sum(A.ChangeQty08),
	ChangeQty09		= Sum(A.ChangeQty09),
	ChangeQty10		= Sum(A.ChangeQty10),
	ChangeQty11		= Sum(A.ChangeQty11),
	ChangeQty12		= Sum(A.ChangeQty12),
	ChangeQty13		= Sum(A.ChangeQty13),
	ChangeQty14		= Sum(A.ChangeQty14),
	ChangeQty15		= Sum(A.ChangeQty15),
	ChangeQty16		= Sum(A.ChangeQty16),
	ChangeQty17		= Sum(A.ChangeQty17),
	ChangeQty18		= Sum(A.ChangeQty18),
	ChangeQty19		= Sum(A.ChangeQty19),
	ChangeQty20		= Sum(A.ChangeQty20),
	ChangeQty21		= Sum(A.ChangeQty21),
	ChangeQty22		= Sum(A.ChangeQty22),
	ChangeQty23		= Sum(A.ChangeQty23),
	ChangeQty24		= Sum(A.ChangeQty24),
	ChangeQty25		= Sum(A.ChangeQty25),
	ChangeQty26		= Sum(A.ChangeQty26),
	ChangeQty27		= Sum(A.ChangeQty27),
	ChangeQty28		= Sum(A.ChangeQty28),
	ChangeQty29		= Sum(A.ChangeQty29),
	ChangeQty30		= Sum(A.ChangeQty30),
	ChangeQty31		= Sum(A.ChangeQty31),

	DummyQtySum		= Sum(A.ChangeQty01) +  Sum(A.ChangeQty02) + Sum(A.ChangeQty03) +
				Sum(A.ChangeQty04) +  Sum(A.ChangeQty05) + Sum(A.ChangeQty06) +
				Sum(A.ChangeQty07) +  Sum(A.ChangeQty08) + Sum(A.ChangeQty09) +
				Sum(A.ChangeQty10) +  Sum(A.ChangeQty11) + Sum(A.ChangeQty12) +
				Sum(A.ChangeQty13) +  Sum(A.ChangeQty14) + Sum(A.ChangeQty15) +
				Sum(A.ChangeQty16) +  Sum(A.ChangeQty17) + Sum(A.ChangeQty18) +
				Sum(A.ChangeQty19) +  Sum(A.ChangeQty20) + Sum(A.ChangeQty21) +
				Sum(A.ChangeQty22) +  Sum(A.ChangeQty23) + Sum(A.ChangeQty24) +
				Sum(A.ChangeQty25) +  Sum(A.ChangeQty26) + Sum(A.ChangeQty27) +
				Sum(A.ChangeQty28) +  Sum(A.ChangeQty29) + Sum(A.ChangeQty30) +
				Sum(A.ChangeQty31),
	DummyQty01		= Sum(A.ChangeQty01),
	DummyQty02		= Sum(A.ChangeQty02),
	DummyQty03		= Sum(A.ChangeQty03),
	DummyQty04		= Sum(A.ChangeQty04),
	DummyQty05		= Sum(A.ChangeQty05),
	DummyQty06		= Sum(A.ChangeQty06),
	DummyQty07		= Sum(A.ChangeQty07),
	DummyQty08		= Sum(A.ChangeQty08),
	DummyQty09		= Sum(A.ChangeQty09),
	DummyQty10		= Sum(A.ChangeQty10),
	DummyQty11		= Sum(A.ChangeQty11),
	DummyQty12		= Sum(A.ChangeQty12),
	DummyQty13		= Sum(A.ChangeQty13),
	DummyQty14		= Sum(A.ChangeQty14),
	DummyQty15		= Sum(A.ChangeQty15),
	DummyQty16		= Sum(A.ChangeQty16),
	DummyQty17		= Sum(A.ChangeQty17),
	DummyQty18		= Sum(A.ChangeQty18),
	DummyQty19		= Sum(A.ChangeQty19),
	DummyQty20		= Sum(A.ChangeQty20),
	DummyQty21		= Sum(A.ChangeQty21),
	DummyQty22		= Sum(A.ChangeQty22),
	DummyQty23		= Sum(A.ChangeQty23),
	DummyQty24		= Sum(A.ChangeQty24),
	DummyQty25		= Sum(A.ChangeQty25),
	DummyQty26		= Sum(A.ChangeQty26),
	DummyQty27		= Sum(A.ChangeQty27),
	DummyQty28		= Sum(A.ChangeQty28),
	DummyQty29		= Sum(A.ChangeQty29),
	DummyQty30		= Sum(A.ChangeQty30),
	DummyQty31		= Sum(A.ChangeQty31),

	InvQty01			= 0,
	InvQty02			= 0,
	InvQty03			= 0,
	InvQty04			= 0,
	InvQty05			= 0,
	InvQty06			= 0,
	InvQty07			= 0,
	InvQty08			= 0,
	InvQty09			= 0,
	InvQty10			= 0,
	InvQty11			= 0,
	InvQty12			= 0,
	InvQty13			= 0,
	InvQty14			= 0,
	InvQty15			= 0,
	InvQty16			= 0,
	InvQty17			= 0,
	InvQty18			= 0,
	InvQty19			= 0,
	InvQty20			= 0,
	InvQty21			= 0,
	InvQty22			= 0,
	InvQty23			= 0,
	InvQty24			= 0,
	InvQty25			= 0,
	InvQty26			= 0,
	InvQty27			= 0,
	InvQty28			= 0,
	InvQty29			= 0,
	InvQty30			= 0,
	InvQty31			= 0,

	EtcQty01			= 0,
	EtcQty02			= 0,
	EtcQty03			= 0,
	EtcQty04			= 0,
	EtcQty05			= 0,
	EtcQty06			= 0,
	EtcQty07			= 0,
	EtcQty08			= 0,
	EtcQty09			= 0,
	EtcQty10			= 0,
	EtcQty11			= 0,
	EtcQty12			= 0,
	EtcQty13			= 0,
	EtcQty14			= 0,
	EtcQty15			= 0,
	EtcQty16			= 0,
	EtcQty17			= 0,
	EtcQty18			= 0,
	EtcQty19			= 0,
	EtcQty20			= 0,
	EtcQty21			= 0,
	EtcQty22			= 0,
	EtcQty23			= 0,
	EtcQty24			= 0,
	EtcQty25			= 0,
	EtcQty26			= 0,
	EtcQty27			= 0,
	EtcQty28			= 0,
	EtcQty29			= 0,
	EtcQty30			= 0,
	EtcQty31			= 0,

	ChangeFlag		= 'N',
	ChangeFlag01		= 'N',
	ChangeFlag02		= 'N',
	ChangeFlag03		= 'N',
	ChangeFlag04		= 'N',
	ChangeFlag05		= 'N',
	ChangeFlag06		= 'N',
	ChangeFlag07		= 'N',
	ChangeFlag08		= 'N',
	ChangeFlag09		= 'N',
	ChangeFlag10		= 'N',
	ChangeFlag11		= 'N',
	ChangeFlag12		= 'N',
	ChangeFlag13		= 'N',
	ChangeFlag14		= 'N',
	ChangeFlag15		= 'N',
	ChangeFlag16		= 'N',
	ChangeFlag17		= 'N',
	ChangeFlag18		= 'N',
	ChangeFlag19		= 'N',
	ChangeFlag20		= 'N',
	ChangeFlag21		= 'N',
	ChangeFlag22		= 'N',
	ChangeFlag23		= 'N',
	ChangeFlag24		= 'N',
	ChangeFlag25		= 'N',
	ChangeFlag26		= 'N',
	ChangeFlag27		= 'N',
	ChangeFlag28		= 'N',
	ChangeFlag29		= 'N',
	ChangeFlag30		= 'N',
	ChangeFlag31		= 'N'
From	#tmp_result	A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty

Drop Table #tmp_item
Drop Table #tmp_planqty
Drop Table #tmp_result

Return

End		-- Procedure End
Go
