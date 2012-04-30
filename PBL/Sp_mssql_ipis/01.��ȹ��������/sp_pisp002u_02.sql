/*
	File Name	: sp_pisp002u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp002u_02
	Description	:일일 생산계획 계산 - 계획분배율을 위한 제품별 라인 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 10
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp002u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_02]
GO


/*
Execute sp_pisp002u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%'

select * from tmstmodelgroup

*/


Create Procedure sp_pisp002u_02
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
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center 명
	LineCode		= A.LineCode,		-- 라인
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,			-- 품번
	ItemName		= A.ItemName,			-- 품명
	ModelID			= A.ModelID,			-- 식별 ID
	MainLineGubun		= Case When A.MainLineGubun = 'M' Then '주라인' Else '부라인' End,	-- 주라인 구분
	DivideRate		= A.DivideRate
  From	vmstkb_line	A,
	tmstmodel	B
 Where	B.AreaCode		= @ps_areacode		And
	B.DivisionCode		= @ps_divisioncode	And
	B.ProductGroup		Like @ps_productgroup	And
	B.ModelGroup		Like @ps_modelgroup	And
	B.ItemCode		Like @ps_itemcode	And
	B.AreaCode		= A.AreaCode		And
	B.DivisionCode		= A.DivisionCode		And
	B.ItemCode		= A.ItemCode		And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,  A.ItemCode, A.ItemName, A.ModelID,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,A.MainLineGubun, A.DivideRate
Order By A.AreaCode, A.DivisionCode, A.ItemCode, A.WorkCenter, A.LineCode

Return

End		-- Procedure End
Go
