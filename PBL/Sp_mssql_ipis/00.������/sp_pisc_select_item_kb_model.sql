/*
	File Name	: sp_pisc_select_item_kb_model.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_select_item_kb_model
	Description	: 제품 코드 DDDW을 위한 조회
			  간판마스터에서 모델군별로 제품 코드를 조회한다.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_productgroup, @ps_modelgroup, @ps_itemcode
	Use Table	: tmstmodelgroup
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_item_kb_model]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_item_kb_model]
GO

/*
Execute sp_pisc_select_item_kb_model 'J', '%', '%', '%', '%'
select * from tmstmodelgroup

*/

Create Procedure sp_pisc_select_item_kb_model
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),		-- 공장
	@ps_productgroup	varchar(2),	-- 제품군
	@ps_modelgroup		varchar(3),	-- 모델군
	@ps_itemcode		varchar(12)	-- 품번
	
As
Begin

Select	AreaCode		= A.AreaCode,			-- 지역코드
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
	DisplayName		= A.ItemCode + '(' + A.ItemName + ')'
  From	vmstkb_model	A
 Where	A.AreaCode		= @ps_areacode			And
	A.DivisionCode		Like @ps_divisioncode		And
	A.ProductGroup		Like @ps_productgroup		And
	A.ModelGroup		Like @ps_modelgroup		And
	A.ItemCode		Like @ps_itemcode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName, A.ModelGroup, A.ModelGroupName,
	A.ItemCode, A.ItemName, A.ModelID

Return

End		-- Procedure End
Go
