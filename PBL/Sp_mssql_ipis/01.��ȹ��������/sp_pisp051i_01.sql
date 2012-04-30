/*
	File Name	: sp_pisp051i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp051i_01
	Description	: 일일 생산 계획(라인별)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp051i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp051i_01]
GO

/*
Execute sp_pisp051i_01
	@ps_todate		= '2002.10.30',
	@ps_plandate01		= '2002.11.01',
	@ps_plandate02		= '2002.11.02',
	@ps_plandate03		= '2002.11.03',
	@ps_plandate04		= '2002.11.04',
	@ps_plandate05		= '2002.11.05',
	@ps_plandate06		= '2002.11.06',
	@ps_plandate07		= '2002.11.07',
	@ps_plandate08		= '2002.11.08',
	@ps_plandate09		= '2002.11.09',
	@ps_plandate10		= '2002.11.10',
	@ps_plandate11		= '2002.11.11',
	@ps_plandate12		= '2002.11.12',
	@ps_plandate13		= '2002.11.13',
	@ps_plandate14		= '2002.11.14',
	@ps_plandate15		= '2002.11.15',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tplanddrs

*/

Create Procedure sp_pisp051i_01
	@ps_todate		char(10),
	@ps_plandate01		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate02		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate03		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate04		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate05		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate06		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate07		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate08		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate09		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate10		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate11		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate12		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate13		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate14		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate15		char(10),	-- 계획일 ('YYYY.MM,DD')

	@ps_areacode		Char(1),		-- 지역 코드
	@ps_divisioncode	Char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1)
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
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End
Into	#tmp_item
From	vmstkb_line	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder,
	A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun


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
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	PlanQty			= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(B.ChangeQty, 0))
Into	#tmp_qty
From	#tmp_item	A,
	tplanday		B
Where	(B.PlanDate	Between @ps_plandate01 and @ps_plandate15)	And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder,
	A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	ChangeQty01		= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty02		= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty03		= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty04		= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty05		= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty06		= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty07		= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty08		= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty09		= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty10		= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty11		= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty12		= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty13		= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty14		= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.ChangeQty, 0) Else 0 End
Into	#tmp_result
From	#tmp_qty		A

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	ChangeQtySum		= Sum(A.ChangeQty01) +  Sum(A.ChangeQty02) + Sum(A.ChangeQty03) +
				Sum(A.ChangeQty04) +  Sum(A.ChangeQty05) + Sum(A.ChangeQty06) +
				Sum(A.ChangeQty07) +  Sum(A.ChangeQty08) + Sum(A.ChangeQty09) +
				Sum(A.ChangeQty10) +  Sum(A.ChangeQty11) + Sum(A.ChangeQty12) +
				Sum(A.ChangeQty13) +  Sum(A.ChangeQty14) + Sum(A.ChangeQty15),
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
	ChangeQty15		= Sum(A.ChangeQty15)
From	#tmp_result	A
Group By AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder,
	A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName

Drop Table #tmp_item
Drop Table #tmp_qty
--Drop Table #tmp_planqty
Drop Table #tmp_result

Return

End		-- Procedure End
Go
