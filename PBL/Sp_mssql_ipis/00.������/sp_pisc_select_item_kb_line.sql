/*
	File Name	: sp_pisc_select_item_kb_line.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_select_item_kb_line
	Description	: 제품 코드 DDDW을 위한 조회
			  간판마스터에서 라인별로 제품 코드를 조회한다.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_workcenter, @ps_linecode, @ps_itemcode
	Use Table	: tmstmodelgroup
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_item_kb_line]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_item_kb_line]
GO

/*
Execute sp_pisc_select_item_kb_line 'J', 'S', '%', '%', '%'
select * from tmstmodelgroup

*/

Create Procedure sp_pisc_select_item_kb_line
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),		-- 공장
	@ps_workcenter		varchar(5),	-- 제품군
	@ps_linecode		varchar(1),	-- 모델군
	@ps_itemcode		varchar(12)	-- 품번
	
As
Begin

Select	AreaCode		= A.AreaCode,			-- 지역코드
	AreaName		= A.AreaName,			-- 지역명
	DivisionCode		= A.DivisionCode,			-- 공장코드
	DivisionName		= A.DivisionName,			-- 공장명
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center 명
	LineCode		= A.LineCode,		-- 라인
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,			-- 품번
	ItemName		= A.ItemName,			-- 품명
	ModelID			= A.ModelID,			-- 식별 ID
	DisplayName		= A.ItemCode + '(' + A.ItemName + ')'
  From	vmstkb_line	A
 Where	A.AreaCode		= @ps_areacode			And
	A.DivisionCode		Like @ps_divisioncode		And
	A.WorkCenter		Like @ps_workcenter		And
	A.LineCode		Like @ps_linecode		And
	A.ItemCode		Like @ps_itemcode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID
Order By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.SortOrder

Return

End		-- Procedure End
Go
