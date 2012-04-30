/*
	File Name	: sp_pisp030i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp030i_01
	Description	: 6개월 Rolling 생산 계획 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp030i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp030i_01]
GO

/*
Execute sp_pisp030i_01 '2002.09', 'D', 'A', '%', '%'
*/

Create Procedure sp_pisp030i_01
	@ps_planmonth		Char(7),		-- 계획월 ('YYYY.MM')
	@ps_areacode		Char(1),		-- 지역 코드
	@ps_divisioncode	Char(1),		-- 공장 코드
	@ps_productgroup	varchar(2),	-- 제품군
	@ps_modelgroup		varchar(3)	-- 모델군
As
Begin

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'		Then '계획생산'
					When A.ProductGubun = 'R'		Then '후보충생산'
					Else 'OEM생산'
				   End,
	PlanQty			= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(B.ChangeQty, 0)),
	PlanQtyM1		= Sum(IsNull(B.PlanQtyM1, 0)),
	PlanQtyM2		= Sum(IsNull(B.PlanQtyM2, 0)),
	PlanQtyM3		= Sum(IsNull(B.PlanQtyM3, 0)),
	PlanQtyM4		= Sum(IsNull(B.PlanQtyM4, 0)),
	PlanQtyM5		= Sum(IsNull(B.PlanQtyM5, 0))
From	(Select	AreaCode		= A.AreaCode,			-- 지역코드
		AreaName		= A.AreaName,			-- 지역명
		DivisionCode		= A.DivisionCode,			-- 공장코드
		DivisionName		= A.DivisionName,			-- 공장명
		ProductGroup		= A.ProductGroup,		-- 제품군
		ProductGroupName	= A.ProductGroupName,		-- 제품군명
		ModelGroup		= A.ModelGroup,			-- 모델군
		ModelGroupName	= A.ModelGroupName,		-- 모델군명
		ItemCode		= A.ItemCode,			-- 품번
		ItemName		= A.ItemName,			-- 품명
		ModelID			= A.ModelID,			-- 식별 ID
		ProductGubun		= A.ProductGubun,
		SortOrder		= 0--A.SortOrder
	  From	vmstkb_model		A
	 Where	A.AreaCode		= @ps_areacode			And
		A.DivisionCode		Like @ps_divisioncode		And
		A.ProductGroup		Like @ps_productgroup		And
		A.ModelGroup		Like @ps_modelgroup
	Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName, A.ModelGroup, A.ModelGroupName,
		A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun)	A,
	tplanmonth	B
Where	B.AreaCode	= A.AreaCode		And
	B.DivisionCode	= A.DivisionCode		And
	B.ItemCode	= A.ItemCode		And
	B.PlanMonth	= @ps_planmonth
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName, A.ModelGroup, A.ModelGroupName,
	A.SortOrder, A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun
Order By A.AreaCode, A.DivisionCode, A.ProductGroup, A.ModelGroup,	A.SortOrder

Return

End		-- Procedure End
Go
